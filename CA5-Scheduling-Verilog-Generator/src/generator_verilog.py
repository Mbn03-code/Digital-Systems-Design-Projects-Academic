import ast
from dataclasses import dataclass
from typing import List, Dict, Tuple, Set
from .scheduler import ScheduledNodeInfo
from .dfg_creator import OperatorNode, IdentifierNode, BaseNode

def _opcodes(node: OperatorNode) -> Tuple[str, int]:
    """
    Returns (unit_type, opcode_int) where opcode meaning depends on unit:
      ALU: 0 add, 1 sub
      MUL: 0 mul, 1 div, 2 mod
      LOG: 0 and, 1 or, 2 xor
    """
    op = node.op
    if node.op_type == "ALU":
        if isinstance(op, ast.Add): return ("ALU", 0)
        if isinstance(op, ast.Sub): return ("ALU", 1)
        return ("ALU", 0)

    if node.op_type == "MUL":
        if isinstance(op, ast.Mult): return ("MUL", 0)
        if isinstance(op, ast.Div):  return ("MUL", 1)
        if isinstance(op, ast.Mod):  return ("MUL", 2)
        return ("MUL", 0)

    if node.op_type == "LOG":
        if isinstance(op, ast.BitAnd): return ("LOG", 0)
        if isinstance(op, ast.BitOr):  return ("LOG", 1)
        if isinstance(op, ast.BitXor): return ("LOG", 2)
        return ("LOG", 0)

    return (node.op_type, 0)

@dataclass
class OpSched:
    node: OperatorNode
    t: int
    r: int  

class generator_verilog:
    def __init__(self, schedule_info: List[ScheduledNodeInfo]):
        self.schedule_info = schedule_info
        self.ops: List[OpSched] = [OpSched(s.node, s.scheduled_time, s.resource_num) for s in schedule_info]
        self.max_t = max((s.scheduled_time for s in schedule_info), default=0)

        self.all_op_nodes: Dict[int, OperatorNode] = {s.node.id: s.node for s in schedule_info}
        self.id_nodes: Dict[str, IdentifierNode] = {}
        for s in schedule_info:
            self._collect_identifiers(s.node)

        self.inputs = sorted(self.id_nodes.keys())

        self.reg_ids = sorted(self.all_op_nodes.keys())

        self.src_sel_map: Dict[Tuple[str, int], int] = {}  
        sel = 0
        for i in range(len(self.inputs)):
            self.src_sel_map[("in", i)] = sel
            sel += 1
        for node_id in self.reg_ids:
            self.src_sel_map[("reg", node_id)] = sel
            sel += 1

        self.sel_width = max(1, (sel - 1).bit_length())

        self.res_count = {"ALU": 0, "MUL": 0, "LOG": 0}
        for s in self.ops:
            self.res_count[s.node.op_type] = max(self.res_count[s.node.op_type], s.r)

        self.root_id = self._find_root_operator_id()

    def _collect_identifiers(self, n: BaseNode):
        if isinstance(n, IdentifierNode):
            self.id_nodes[n.name] = n
            return
        if isinstance(n, OperatorNode):
            for ch in n.operands:
                self._collect_identifiers(ch)

    def _find_root_operator_id(self) -> int:
        used: Set[int] = set()
        for n in self.all_op_nodes.values():
            for ch in n.operands:
                if isinstance(ch, OperatorNode):
                    used.add(ch.id)
        roots = [nid for nid in self.all_op_nodes.keys() if nid not in used]
        return roots[0] if roots else (self.reg_ids[-1] if self.reg_ids else 0)

    def _src_sel(self, operand: BaseNode) -> int:
        if isinstance(operand, IdentifierNode):
            idx = self.inputs.index(operand.name)
            return self.src_sel_map[("in", idx)]
        if isinstance(operand, OperatorNode):
            return self.src_sel_map[("reg", operand.id)]
        return 0

    def emit_datapath(self) -> str:
        in_port_lines = [f"input [31:0] {name}" for name in self.inputs]

        ctrl_port_lines: List[str] = []
        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                ctrl_port_lines.append(f"input [{self.sel_width-1}:0] {typ.lower()}{r}_sel1")
                ctrl_port_lines.append(f"input [{self.sel_width-1}:0] {typ.lower()}{r}_sel2")
                if typ == "ALU":
                    ctrl_port_lines.append(f"input [0:0] {typ.lower()}{r}_op")
                else:
                    ctrl_port_lines.append(f"input [1:0] {typ.lower()}{r}_op")

        reg_en_lines = [f"input reg_n{nid}_en" for nid in self.reg_ids]

        ports: List[str] = []
        ports.append("input clk")
        ports.append("input rst")
        ports.extend(in_port_lines)
        ports.extend(ctrl_port_lines)
        ports.append("input done_next")
        ports.append("input result_en")
        ports.extend(reg_en_lines)
        ports.append("output reg [31:0] result")
        ports.append("output reg done")

        module_header = "module datapath(\n  " + ",\n  ".join(ports) + "\n);"
        sources = []
        for i, name in enumerate(self.inputs):
            sources.append((self.src_sel_map[("in", i)], name))
        for nid in self.reg_ids:
            sources.append((self.src_sel_map[("reg", nid)], f"reg_n{nid}"))
        sources = sorted(sources, key=lambda x: x[0])

        def mux_block(sel_sig: str, out_sig: str) -> str:
            lines = ["always @(*) begin", f"  case ({sel_sig})"]
            for code, src in sources:
                lines.append(f"    {self.sel_width}'d{code}: {out_sig} = {src};")
            lines.append(f"    default: {out_sig} = 32'd0;")
            lines.append("  endcase")
            lines.append("end")
            return "\n".join(lines)
        reg_decls = "\n".join([f"reg [31:0] reg_n{nid};" for nid in self.reg_ids])

        fu_blocks: List[str] = []
        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                op1r = f"{typ.lower()}{r}_op1_r"
                op2r = f"{typ.lower()}{r}_op2_r"
                out  = f"{typ.lower()}{r}_out"

                fu_blocks.append(f"reg [31:0] {op1r};")
                fu_blocks.append(f"reg [31:0] {op2r};")
                fu_blocks.append(f"wire [31:0] {out};")
                fu_blocks.append(mux_block(f"{typ.lower()}{r}_sel1", op1r))
                fu_blocks.append(mux_block(f"{typ.lower()}{r}_sel2", op2r))

                if typ == "ALU":
                    fu_blocks.append("\n".join([
                        f"reg [31:0] {out}_r;",
                        "always @(*) begin",
                        f"  case ({typ.lower()}{r}_op)",
                        f"    1'd0: {out}_r = {op1r} + {op2r};",
                        f"    1'd1: {out}_r = {op1r} - {op2r};",
                        f"    default: {out}_r = 32'd0;",
                        "  endcase",
                        "end",
                        f"assign {out} = {out}_r;"
                    ]))
                elif typ == "MUL":
                    fu_blocks.append("\n".join([
                        f"reg [31:0] {out}_r;",
                        "always @(*) begin",
                        f"  case ({typ.lower()}{r}_op)",
                        f"    2'd0: {out}_r = {op1r} * {op2r};",
                        f"    2'd1: {out}_r = ({op2r}==0) ? 32'd0 : ({op1r} / {op2r});",
                        f"    2'd2: {out}_r = ({op2r}==0) ? 32'd0 : ({op1r} % {op2r});",
                        f"    default: {out}_r = 32'd0;",
                        "  endcase",
                        "end",
                        f"assign {out} = {out}_r;"
                    ]))
                else:  
                    fu_blocks.append("\n".join([
                        f"reg [31:0] {out}_r;",
                        "always @(*) begin",
                        f"  case ({typ.lower()}{r}_op)",
                        f"    2'd0: {out}_r = {op1r} & {op2r};",
                        f"    2'd1: {out}_r = {op1r} | {op2r};",
                        f"    2'd2: {out}_r = {op1r} ^ {op2r};",
                        f"    default: {out}_r = 32'd0;",
                        "  endcase",
                        "end",
                        f"assign {out} = {out}_r;"
                    ]))

        reg_write_lines = [
            "always @(posedge clk or posedge rst) begin",
            "  if (rst) begin"
        ]
        for nid in self.reg_ids:
            reg_write_lines.append(f"    reg_n{nid} <= 32'd0;")
        reg_write_lines.extend([
            "    result <= 32'd0;",
            "    done <= 1'b0;",
            "  end else begin",
            "    done <= done_next;"
        ])

        for s in self.ops:
            typ = s.node.op_type
            r = s.r
            fu_out = f"{typ.lower()}{r}_out"
            reg_write_lines.append(f"    if (reg_n{s.node.id}_en) reg_n{s.node.id} <= {fu_out};")

        root_op = next(s for s in self.ops if s.node.id == self.root_id)
        root_fu_out = f"{root_op.node.op_type.lower()}{root_op.r}_out"
        reg_write_lines.append(f"    if (result_en) result <= {root_fu_out};")

        reg_write_lines.append("  end")
        reg_write_lines.append("end")

        return "\n".join([
            module_header,
            "",
            reg_decls,
            "",
            "\n".join(fu_blocks),
            "",
            "\n".join(reg_write_lines),
            "",
            "endmodule"
        ])

    def emit_controller(self) -> str:
        L = self.max_t

        by_t: Dict[int, List[OpSched]] = {t: [] for t in range(1, L + 1)}
        for s in self.ops:
            by_t[s.t].append(s)

        ports: List[str] = []
        ports.append("input clk")
        ports.append("input rst")
        ports.append("input start")

        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                ports.append(f"output reg [{self.sel_width-1}:0] {typ.lower()}{r}_sel1")
                ports.append(f"output reg [{self.sel_width-1}:0] {typ.lower()}{r}_sel2")
                if typ == "ALU":
                    ports.append(f"output reg [0:0] {typ.lower()}{r}_op")
                else:
                    ports.append(f"output reg [1:0] {typ.lower()}{r}_op")

        for nid in self.reg_ids:
            ports.append(f"output reg reg_n{nid}_en")

        ports.append("output reg done_next")
        ports.append("output reg result_en")

        header = "module controller(\n  " + ",\n  ".join(ports) + "\n);"

        lines: List[str] = []
        lines.append(header)
        lines.append("")

        state_bits = max(1, (L + 2).bit_length())
        lines.append(f"reg [{state_bits-1}:0] state, next_state;")
        lines.append("localparam S_IDLE = 0;")
        for t in range(1, L + 1):
            lines.append(f"localparam S_CYCLE_{t} = {t};")
        lines.append(f"localparam S_DONE = {L+1};")
        lines.append("")

        lines.append("always @(posedge clk or posedge rst) begin")
        lines.append("  if (rst) state <= S_IDLE;")
        lines.append("  else state <= next_state;")
        lines.append("end")
        lines.append("")
        lines.append("always @(*) begin")
        lines.append("  next_state = state;")

        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                lines.append(f"  {typ.lower()}{r}_sel1 = {self.sel_width}'d0;")
                lines.append(f"  {typ.lower()}{r}_sel2 = {self.sel_width}'d0;")
                if typ == "ALU":
                    lines.append(f"  {typ.lower()}{r}_op = 1'd0;")
                else:
                    lines.append(f"  {typ.lower()}{r}_op = 2'd0;")

        for nid in self.reg_ids:
            lines.append(f"  reg_n{nid}_en = 1'b0;")

        lines.append("  done_next = 1'b0;")
        lines.append("  result_en = 1'b0;")
        lines.append("")
        lines.append("  case (state)")
        lines.append("    S_IDLE: begin")
        lines.append("      if (start) next_state = S_CYCLE_1;")
        lines.append("    end")

        for t in range(1, L + 1):
            lines.append(f"    S_CYCLE_{t}: begin")
            for s in by_t.get(t, []):
                typ = s.node.op_type
                r = s.r
                op1 = s.node.operands[0]
                op2 = s.node.operands[1]
                sel1 = self._src_sel(op1)
                sel2 = self._src_sel(op2)
                _unit, opc = _opcodes(s.node)

                lines.append(f"      {typ.lower()}{r}_sel1 = {self.sel_width}'d{sel1};")
                lines.append(f"      {typ.lower()}{r}_sel2 = {self.sel_width}'d{sel2};")
                if typ == "ALU":
                    lines.append(f"      {typ.lower()}{r}_op = 1'd{opc};")
                else:
                    lines.append(f"      {typ.lower()}{r}_op = 2'd{opc};")
                lines.append(f"      reg_n{s.node.id}_en = 1'b1;")

            if t < L:
                lines.append(f"      next_state = S_CYCLE_{t+1};")
            else:
                lines.append("      result_en = 1'b1;")
                lines.append("      next_state = S_DONE;")
            lines.append("    end")

        lines.append("    S_DONE: begin")
        lines.append("      done_next = 1'b1;")
        lines.append("      next_state = S_IDLE;")
        lines.append("    end")
        lines.append("  endcase")
        lines.append("end")
        lines.append("endmodule")

        return "\n".join(lines)


    def emit_top(self) -> str:
        wires: List[str] = []
        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                wires.append(f"wire [{self.sel_width-1}:0] {typ.lower()}{r}_sel1;")
                wires.append(f"wire [{self.sel_width-1}:0] {typ.lower()}{r}_sel2;")
                if typ == "ALU":
                    wires.append(f"wire [0:0] {typ.lower()}{r}_op;")
                else:
                    wires.append(f"wire [1:0] {typ.lower()}{r}_op;")

        for nid in self.reg_ids:
            wires.append(f"wire reg_n{nid}_en;")

        wires.append("wire done_next;")
        wires.append("wire result_en;")

        ports: List[str] = []
        ports.append("input clk")
        ports.append("input rst")
        ports.append("input start")
        for name in self.inputs:
            ports.append(f"input [31:0] {name}")
        ports.append("output [31:0] result")
        ports.append("output done")

        lines: List[str] = []
        lines.append("module top(")
        lines.append("  " + ",\n  ".join(ports))
        lines.append(");")
        lines.append("")
        lines.append("\n".join(wires))
        lines.append("")
        ctrl_conn: List[str] = []
        ctrl_conn.append("  .clk(clk),")
        ctrl_conn.append("  .rst(rst),")
        ctrl_conn.append("  .start(start),")
        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                ctrl_conn.append(f"  .{typ.lower()}{r}_sel1({typ.lower()}{r}_sel1),")
                ctrl_conn.append(f"  .{typ.lower()}{r}_sel2({typ.lower()}{r}_sel2),")
                ctrl_conn.append(f"  .{typ.lower()}{r}_op({typ.lower()}{r}_op),")
        for nid in self.reg_ids:
            ctrl_conn.append(f"  .reg_n{nid}_en(reg_n{nid}_en),")
        ctrl_conn.append("  .done_next(done_next),")
        ctrl_conn.append("  .result_en(result_en)")

        lines.append("controller u_ctrl(")
        lines.append("\n".join(ctrl_conn))
        lines.append(");")
        lines.append("")
        dp_conn: List[str] = []
        dp_conn.append("  .clk(clk),")
        dp_conn.append("  .rst(rst),")
        for name in self.inputs:
            dp_conn.append(f"  .{name}({name}),")
        for typ in ["ALU", "MUL", "LOG"]:
            for r in range(1, self.res_count[typ] + 1):
                dp_conn.append(f"  .{typ.lower()}{r}_sel1({typ.lower()}{r}_sel1),")
                dp_conn.append(f"  .{typ.lower()}{r}_sel2({typ.lower()}{r}_sel2),")
                dp_conn.append(f"  .{typ.lower()}{r}_op({typ.lower()}{r}_op),")
        dp_conn.append("  .done_next(done_next),")
        dp_conn.append("  .result_en(result_en),")
        for nid in self.reg_ids:
            dp_conn.append(f"  .reg_n{nid}_en(reg_n{nid}_en),")
        dp_conn.append("  .result(result),")
        dp_conn.append("  .done(done)")

        lines.append("datapath u_dp(")
        lines.append("\n".join(dp_conn))
        lines.append(");")
        lines.append("")
        lines.append("endmodule")

        return "\n".join(lines)
    def emit_controller_and_top(self) -> str:
        return self.emit_controller()