module datapath(
  input clk,
  input rst,
  input [31:0] i1,
  input [31:0] i2,
  input [31:0] i3,
  input [2:0] alu1_sel1,
  input [2:0] alu1_sel2,
  input [0:0] alu1_op,
  input [2:0] alu2_sel1,
  input [2:0] alu2_sel2,
  input [0:0] alu2_op,
  input [2:0] mul1_sel1,
  input [2:0] mul1_sel2,
  input [1:0] mul1_op,
  input done_next,
  input result_en,
  input reg_n2_en,
  input reg_n4_en,
  input reg_n5_en,
  input reg_n6_en,
  input reg_n7_en,
  output reg [31:0] result,
  output reg done
);

reg [31:0] reg_n2;
reg [31:0] reg_n4;
reg [31:0] reg_n5;
reg [31:0] reg_n6;
reg [31:0] reg_n7;

reg [31:0] alu1_op1_r;
reg [31:0] alu1_op2_r;
wire [31:0] alu1_out;
always @(*) begin
  case (alu1_sel1)
    3'd0: alu1_op1_r = i1;
    3'd1: alu1_op1_r = i2;
    3'd2: alu1_op1_r = i3;
    3'd3: alu1_op1_r = reg_n2;
    3'd4: alu1_op1_r = reg_n4;
    3'd5: alu1_op1_r = reg_n5;
    3'd6: alu1_op1_r = reg_n6;
    3'd7: alu1_op1_r = reg_n7;
    default: alu1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu1_sel2)
    3'd0: alu1_op2_r = i1;
    3'd1: alu1_op2_r = i2;
    3'd2: alu1_op2_r = i3;
    3'd3: alu1_op2_r = reg_n2;
    3'd4: alu1_op2_r = reg_n4;
    3'd5: alu1_op2_r = reg_n5;
    3'd6: alu1_op2_r = reg_n6;
    3'd7: alu1_op2_r = reg_n7;
    default: alu1_op2_r = 32'd0;
  endcase
end
reg [31:0] alu1_out_r;
always @(*) begin
  case (alu1_op)
    1'd0: alu1_out_r = alu1_op1_r + alu1_op2_r;
    1'd1: alu1_out_r = alu1_op1_r - alu1_op2_r;
    default: alu1_out_r = 32'd0;
  endcase
end
assign alu1_out = alu1_out_r;
reg [31:0] alu2_op1_r;
reg [31:0] alu2_op2_r;
wire [31:0] alu2_out;
always @(*) begin
  case (alu2_sel1)
    3'd0: alu2_op1_r = i1;
    3'd1: alu2_op1_r = i2;
    3'd2: alu2_op1_r = i3;
    3'd3: alu2_op1_r = reg_n2;
    3'd4: alu2_op1_r = reg_n4;
    3'd5: alu2_op1_r = reg_n5;
    3'd6: alu2_op1_r = reg_n6;
    3'd7: alu2_op1_r = reg_n7;
    default: alu2_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu2_sel2)
    3'd0: alu2_op2_r = i1;
    3'd1: alu2_op2_r = i2;
    3'd2: alu2_op2_r = i3;
    3'd3: alu2_op2_r = reg_n2;
    3'd4: alu2_op2_r = reg_n4;
    3'd5: alu2_op2_r = reg_n5;
    3'd6: alu2_op2_r = reg_n6;
    3'd7: alu2_op2_r = reg_n7;
    default: alu2_op2_r = 32'd0;
  endcase
end
reg [31:0] alu2_out_r;
always @(*) begin
  case (alu2_op)
    1'd0: alu2_out_r = alu2_op1_r + alu2_op2_r;
    1'd1: alu2_out_r = alu2_op1_r - alu2_op2_r;
    default: alu2_out_r = 32'd0;
  endcase
end
assign alu2_out = alu2_out_r;
reg [31:0] mul1_op1_r;
reg [31:0] mul1_op2_r;
wire [31:0] mul1_out;
always @(*) begin
  case (mul1_sel1)
    3'd0: mul1_op1_r = i1;
    3'd1: mul1_op1_r = i2;
    3'd2: mul1_op1_r = i3;
    3'd3: mul1_op1_r = reg_n2;
    3'd4: mul1_op1_r = reg_n4;
    3'd5: mul1_op1_r = reg_n5;
    3'd6: mul1_op1_r = reg_n6;
    3'd7: mul1_op1_r = reg_n7;
    default: mul1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (mul1_sel2)
    3'd0: mul1_op2_r = i1;
    3'd1: mul1_op2_r = i2;
    3'd2: mul1_op2_r = i3;
    3'd3: mul1_op2_r = reg_n2;
    3'd4: mul1_op2_r = reg_n4;
    3'd5: mul1_op2_r = reg_n5;
    3'd6: mul1_op2_r = reg_n6;
    3'd7: mul1_op2_r = reg_n7;
    default: mul1_op2_r = 32'd0;
  endcase
end
reg [31:0] mul1_out_r;
always @(*) begin
  case (mul1_op)
    2'd0: mul1_out_r = mul1_op1_r * mul1_op2_r;
    2'd1: mul1_out_r = (mul1_op2_r==0) ? 32'd0 : (mul1_op1_r / mul1_op2_r);
    2'd2: mul1_out_r = (mul1_op2_r==0) ? 32'd0 : (mul1_op1_r % mul1_op2_r);
    default: mul1_out_r = 32'd0;
  endcase
end
assign mul1_out = mul1_out_r;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    reg_n2 <= 32'd0;
    reg_n4 <= 32'd0;
    reg_n5 <= 32'd0;
    reg_n6 <= 32'd0;
    reg_n7 <= 32'd0;
    result <= 32'd0;
    done <= 1'b0;
  end else begin
    done <= done_next;
    if (reg_n2_en) reg_n2 <= alu1_out;
    if (reg_n4_en) reg_n4 <= alu1_out;
    if (reg_n5_en) reg_n5 <= alu2_out;
    if (reg_n6_en) reg_n6 <= mul1_out;
    if (reg_n7_en) reg_n7 <= mul1_out;
    if (result_en) result <= mul1_out;
  end
end

endmodule