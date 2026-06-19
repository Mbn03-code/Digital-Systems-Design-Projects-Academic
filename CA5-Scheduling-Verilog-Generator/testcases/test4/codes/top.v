module top(
  input clk,
  input rst,
  input start,
  input [31:0] i1,
  input [31:0] i2,
  input [31:0] i3,
  input [31:0] i4,
  input [31:0] i5,
  input [31:0] i6,
  input [31:0] i7,
  input [31:0] i8,
  output [31:0] result,
  output done
);

wire [3:0] alu1_sel1;
wire [3:0] alu1_sel2;
wire [0:0] alu1_op;
wire [3:0] mul1_sel1;
wire [3:0] mul1_sel2;
wire [1:0] mul1_op;
wire reg_n2_en;
wire reg_n4_en;
wire reg_n6_en;
wire reg_n8_en;
wire reg_n10_en;
wire reg_n12_en;
wire reg_n14_en;
wire done_next;
wire result_en;

controller u_ctrl(
  .clk(clk),
  .rst(rst),
  .start(start),
  .alu1_sel1(alu1_sel1),
  .alu1_sel2(alu1_sel2),
  .alu1_op(alu1_op),
  .mul1_sel1(mul1_sel1),
  .mul1_sel2(mul1_sel2),
  .mul1_op(mul1_op),
  .reg_n2_en(reg_n2_en),
  .reg_n4_en(reg_n4_en),
  .reg_n6_en(reg_n6_en),
  .reg_n8_en(reg_n8_en),
  .reg_n10_en(reg_n10_en),
  .reg_n12_en(reg_n12_en),
  .reg_n14_en(reg_n14_en),
  .done_next(done_next),
  .result_en(result_en)
);

datapath u_dp(
  .clk(clk),
  .rst(rst),
  .i1(i1),
  .i2(i2),
  .i3(i3),
  .i4(i4),
  .i5(i5),
  .i6(i6),
  .i7(i7),
  .i8(i8),
  .alu1_sel1(alu1_sel1),
  .alu1_sel2(alu1_sel2),
  .alu1_op(alu1_op),
  .mul1_sel1(mul1_sel1),
  .mul1_sel2(mul1_sel2),
  .mul1_op(mul1_op),
  .done_next(done_next),
  .result_en(result_en),
  .reg_n2_en(reg_n2_en),
  .reg_n4_en(reg_n4_en),
  .reg_n6_en(reg_n6_en),
  .reg_n8_en(reg_n8_en),
  .reg_n10_en(reg_n10_en),
  .reg_n12_en(reg_n12_en),
  .reg_n14_en(reg_n14_en),
  .result(result),
  .done(done)
);

endmodule