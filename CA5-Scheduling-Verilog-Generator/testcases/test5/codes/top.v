module top(
  input clk,
  input rst,
  input start,
  input [31:0] i1,
  input [31:0] i10,
  input [31:0] i2,
  input [31:0] i3,
  input [31:0] i4,
  input [31:0] i5,
  input [31:0] i6,
  input [31:0] i7,
  input [31:0] i8,
  input [31:0] i9,
  output [31:0] result,
  output done
);

wire [4:0] alu1_sel1;
wire [4:0] alu1_sel2;
wire [0:0] alu1_op;
wire [4:0] alu2_sel1;
wire [4:0] alu2_sel2;
wire [0:0] alu2_op;
wire [4:0] alu3_sel1;
wire [4:0] alu3_sel2;
wire [0:0] alu3_op;
wire [4:0] mul1_sel1;
wire [4:0] mul1_sel2;
wire [1:0] mul1_op;
wire [4:0] mul2_sel1;
wire [4:0] mul2_sel2;
wire [1:0] mul2_op;
wire [4:0] log1_sel1;
wire [4:0] log1_sel2;
wire [1:0] log1_op;
wire [4:0] log2_sel1;
wire [4:0] log2_sel2;
wire [1:0] log2_op;
wire reg_n2_en;
wire reg_n4_en;
wire reg_n7_en;
wire reg_n9_en;
wire reg_n10_en;
wire reg_n13_en;
wire reg_n16_en;
wire reg_n17_en;
wire reg_n18_en;
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
  .alu3_sel1(alu3_sel1),
  .alu3_sel2(alu3_sel2),
  .alu3_op(alu3_op),
  .mul1_sel1(mul1_sel1),
  .mul1_sel2(mul1_sel2),
  .mul1_op(mul1_op),
  .mul2_sel1(mul2_sel1),
  .mul2_sel2(mul2_sel2),
  .mul2_op(mul2_op),
  .log1_sel1(log1_sel1),
  .log1_sel2(log1_sel2),
  .log1_op(log1_op),
  .log2_sel1(log2_sel1),
  .log2_sel2(log2_sel2),
  .log2_op(log2_op),
  .reg_n2_en(reg_n2_en),
  .reg_n4_en(reg_n4_en),
  .reg_n7_en(reg_n7_en),
  .reg_n9_en(reg_n9_en),
  .reg_n10_en(reg_n10_en),
  .reg_n13_en(reg_n13_en),
  .reg_n16_en(reg_n16_en),
  .reg_n17_en(reg_n17_en),
  .reg_n18_en(reg_n18_en),
  .done_next(done_next),
  .result_en(result_en)
);

datapath u_dp(
  .clk(clk),
  .rst(rst),
  .i1(i1),
  .i10(i10),
  .i2(i2),
  .i3(i3),
  .i4(i4),
  .i5(i5),
  .i6(i6),
  .i7(i7),
  .i8(i8),
  .i9(i9),
  .alu1_sel1(alu1_sel1),
  .alu1_sel2(alu1_sel2),
  .alu1_op(alu1_op),
  .alu2_sel1(alu2_sel1),
  .alu2_sel2(alu2_sel2),
  .alu2_op(alu2_op),
  .alu3_sel1(alu3_sel1),
  .alu3_sel2(alu3_sel2),
  .alu3_op(alu3_op),
  .mul1_sel1(mul1_sel1),
  .mul1_sel2(mul1_sel2),
  .mul1_op(mul1_op),
  .mul2_sel1(mul2_sel1),
  .mul2_sel2(mul2_sel2),
  .mul2_op(mul2_op),
  .log1_sel1(log1_sel1),
  .log1_sel2(log1_sel2),
  .log1_op(log1_op),
  .log2_sel1(log2_sel1),
  .log2_sel2(log2_sel2),
  .log2_op(log2_op),
  .done_next(done_next),
  .result_en(result_en),
  .reg_n2_en(reg_n2_en),
  .reg_n4_en(reg_n4_en),
  .reg_n7_en(reg_n7_en),
  .reg_n9_en(reg_n9_en),
  .reg_n10_en(reg_n10_en),
  .reg_n13_en(reg_n13_en),
  .reg_n16_en(reg_n16_en),
  .reg_n17_en(reg_n17_en),
  .reg_n18_en(reg_n18_en),
  .result(result),
  .done(done)
);

endmodule