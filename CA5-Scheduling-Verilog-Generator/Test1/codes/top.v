module top(
  input clk,
  input rst,
  input start,
  input [31:0] i1,
  input [31:0] i2,
  input [31:0] i3,
  output [31:0] result,
  output done
);

wire [2:0] alu1_sel1;
wire [2:0] alu1_sel2;
wire [0:0] alu1_op;
wire [2:0] alu2_sel1;
wire [2:0] alu2_sel2;
wire [0:0] alu2_op;
wire [2:0] mul1_sel1;
wire [2:0] mul1_sel2;
wire [1:0] mul1_op;
wire reg_n2_en;
wire reg_n4_en;
wire reg_n5_en;
wire reg_n6_en;
wire reg_n7_en;
wire done_next;
wire result_en;

controller u_ctrl(
  .clk(clk),
  .rst(rst),
  .start(start),
  .alu1_sel1(alu1_sel1),
  .alu1_sel2(alu1_sel2),
  .alu1_op(alu1_op),
  .alu2_sel1(alu2_sel1),
  .alu2_sel2(alu2_sel2),
  .alu2_op(alu2_op),
  .mul1_sel1(mul1_sel1),
  .mul1_sel2(mul1_sel2),
  .mul1_op(mul1_op),
  .reg_n2_en(reg_n2_en),
  .reg_n4_en(reg_n4_en),
  .reg_n5_en(reg_n5_en),
  .reg_n6_en(reg_n6_en),
  .reg_n7_en(reg_n7_en),
  .done_next(done_next),
  .result_en(result_en)
);

datapath u_dp(
  .clk(clk),
  .rst(rst),
  .i1(i1),
  .i2(i2),
  .i3(i3),
  .alu1_sel1(alu1_sel1),
  .alu1_sel2(alu1_sel2),
  .alu1_op(alu1_op),
  .alu2_sel1(alu2_sel1),
  .alu2_sel2(alu2_sel2),
  .alu2_op(alu2_op),
  .mul1_sel1(mul1_sel1),
  .mul1_sel2(mul1_sel2),
  .mul1_op(mul1_op),
  .done_next(done_next),
  .result_en(result_en),
  .reg_n2_en(reg_n2_en),
  .reg_n4_en(reg_n4_en),
  .reg_n5_en(reg_n5_en),
  .reg_n6_en(reg_n6_en),
  .reg_n7_en(reg_n7_en),
  .result(result),
  .done(done)
);

endmodule