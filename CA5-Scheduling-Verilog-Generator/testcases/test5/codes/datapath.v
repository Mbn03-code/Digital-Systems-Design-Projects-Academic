module datapath(
  input clk,
  input rst,
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
  input [4:0] alu1_sel1,
  input [4:0] alu1_sel2,
  input [0:0] alu1_op,
  input [4:0] alu2_sel1,
  input [4:0] alu2_sel2,
  input [0:0] alu2_op,
  input [4:0] alu3_sel1,
  input [4:0] alu3_sel2,
  input [0:0] alu3_op,
  input [4:0] mul1_sel1,
  input [4:0] mul1_sel2,
  input [1:0] mul1_op,
  input [4:0] mul2_sel1,
  input [4:0] mul2_sel2,
  input [1:0] mul2_op,
  input [4:0] log1_sel1,
  input [4:0] log1_sel2,
  input [1:0] log1_op,
  input [4:0] log2_sel1,
  input [4:0] log2_sel2,
  input [1:0] log2_op,
  input done_next,
  input result_en,
  input reg_n2_en,
  input reg_n4_en,
  input reg_n7_en,
  input reg_n9_en,
  input reg_n10_en,
  input reg_n13_en,
  input reg_n16_en,
  input reg_n17_en,
  input reg_n18_en,
  output reg [31:0] result,
  output reg done
);

reg [31:0] reg_n2;
reg [31:0] reg_n4;
reg [31:0] reg_n7;
reg [31:0] reg_n9;
reg [31:0] reg_n10;
reg [31:0] reg_n13;
reg [31:0] reg_n16;
reg [31:0] reg_n17;
reg [31:0] reg_n18;

reg [31:0] alu1_op1_r;
reg [31:0] alu1_op2_r;
wire [31:0] alu1_out;
always @(*) begin
  case (alu1_sel1)
    5'd0: alu1_op1_r = i1;
    5'd1: alu1_op1_r = i10;
    5'd2: alu1_op1_r = i2;
    5'd3: alu1_op1_r = i3;
    5'd4: alu1_op1_r = i4;
    5'd5: alu1_op1_r = i5;
    5'd6: alu1_op1_r = i6;
    5'd7: alu1_op1_r = i7;
    5'd8: alu1_op1_r = i8;
    5'd9: alu1_op1_r = i9;
    5'd10: alu1_op1_r = reg_n2;
    5'd11: alu1_op1_r = reg_n4;
    5'd12: alu1_op1_r = reg_n7;
    5'd13: alu1_op1_r = reg_n9;
    5'd14: alu1_op1_r = reg_n10;
    5'd15: alu1_op1_r = reg_n13;
    5'd16: alu1_op1_r = reg_n16;
    5'd17: alu1_op1_r = reg_n17;
    5'd18: alu1_op1_r = reg_n18;
    default: alu1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu1_sel2)
    5'd0: alu1_op2_r = i1;
    5'd1: alu1_op2_r = i10;
    5'd2: alu1_op2_r = i2;
    5'd3: alu1_op2_r = i3;
    5'd4: alu1_op2_r = i4;
    5'd5: alu1_op2_r = i5;
    5'd6: alu1_op2_r = i6;
    5'd7: alu1_op2_r = i7;
    5'd8: alu1_op2_r = i8;
    5'd9: alu1_op2_r = i9;
    5'd10: alu1_op2_r = reg_n2;
    5'd11: alu1_op2_r = reg_n4;
    5'd12: alu1_op2_r = reg_n7;
    5'd13: alu1_op2_r = reg_n9;
    5'd14: alu1_op2_r = reg_n10;
    5'd15: alu1_op2_r = reg_n13;
    5'd16: alu1_op2_r = reg_n16;
    5'd17: alu1_op2_r = reg_n17;
    5'd18: alu1_op2_r = reg_n18;
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
    5'd0: alu2_op1_r = i1;
    5'd1: alu2_op1_r = i10;
    5'd2: alu2_op1_r = i2;
    5'd3: alu2_op1_r = i3;
    5'd4: alu2_op1_r = i4;
    5'd5: alu2_op1_r = i5;
    5'd6: alu2_op1_r = i6;
    5'd7: alu2_op1_r = i7;
    5'd8: alu2_op1_r = i8;
    5'd9: alu2_op1_r = i9;
    5'd10: alu2_op1_r = reg_n2;
    5'd11: alu2_op1_r = reg_n4;
    5'd12: alu2_op1_r = reg_n7;
    5'd13: alu2_op1_r = reg_n9;
    5'd14: alu2_op1_r = reg_n10;
    5'd15: alu2_op1_r = reg_n13;
    5'd16: alu2_op1_r = reg_n16;
    5'd17: alu2_op1_r = reg_n17;
    5'd18: alu2_op1_r = reg_n18;
    default: alu2_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu2_sel2)
    5'd0: alu2_op2_r = i1;
    5'd1: alu2_op2_r = i10;
    5'd2: alu2_op2_r = i2;
    5'd3: alu2_op2_r = i3;
    5'd4: alu2_op2_r = i4;
    5'd5: alu2_op2_r = i5;
    5'd6: alu2_op2_r = i6;
    5'd7: alu2_op2_r = i7;
    5'd8: alu2_op2_r = i8;
    5'd9: alu2_op2_r = i9;
    5'd10: alu2_op2_r = reg_n2;
    5'd11: alu2_op2_r = reg_n4;
    5'd12: alu2_op2_r = reg_n7;
    5'd13: alu2_op2_r = reg_n9;
    5'd14: alu2_op2_r = reg_n10;
    5'd15: alu2_op2_r = reg_n13;
    5'd16: alu2_op2_r = reg_n16;
    5'd17: alu2_op2_r = reg_n17;
    5'd18: alu2_op2_r = reg_n18;
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
reg [31:0] alu3_op1_r;
reg [31:0] alu3_op2_r;
wire [31:0] alu3_out;
always @(*) begin
  case (alu3_sel1)
    5'd0: alu3_op1_r = i1;
    5'd1: alu3_op1_r = i10;
    5'd2: alu3_op1_r = i2;
    5'd3: alu3_op1_r = i3;
    5'd4: alu3_op1_r = i4;
    5'd5: alu3_op1_r = i5;
    5'd6: alu3_op1_r = i6;
    5'd7: alu3_op1_r = i7;
    5'd8: alu3_op1_r = i8;
    5'd9: alu3_op1_r = i9;
    5'd10: alu3_op1_r = reg_n2;
    5'd11: alu3_op1_r = reg_n4;
    5'd12: alu3_op1_r = reg_n7;
    5'd13: alu3_op1_r = reg_n9;
    5'd14: alu3_op1_r = reg_n10;
    5'd15: alu3_op1_r = reg_n13;
    5'd16: alu3_op1_r = reg_n16;
    5'd17: alu3_op1_r = reg_n17;
    5'd18: alu3_op1_r = reg_n18;
    default: alu3_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu3_sel2)
    5'd0: alu3_op2_r = i1;
    5'd1: alu3_op2_r = i10;
    5'd2: alu3_op2_r = i2;
    5'd3: alu3_op2_r = i3;
    5'd4: alu3_op2_r = i4;
    5'd5: alu3_op2_r = i5;
    5'd6: alu3_op2_r = i6;
    5'd7: alu3_op2_r = i7;
    5'd8: alu3_op2_r = i8;
    5'd9: alu3_op2_r = i9;
    5'd10: alu3_op2_r = reg_n2;
    5'd11: alu3_op2_r = reg_n4;
    5'd12: alu3_op2_r = reg_n7;
    5'd13: alu3_op2_r = reg_n9;
    5'd14: alu3_op2_r = reg_n10;
    5'd15: alu3_op2_r = reg_n13;
    5'd16: alu3_op2_r = reg_n16;
    5'd17: alu3_op2_r = reg_n17;
    5'd18: alu3_op2_r = reg_n18;
    default: alu3_op2_r = 32'd0;
  endcase
end
reg [31:0] alu3_out_r;
always @(*) begin
  case (alu3_op)
    1'd0: alu3_out_r = alu3_op1_r + alu3_op2_r;
    1'd1: alu3_out_r = alu3_op1_r - alu3_op2_r;
    default: alu3_out_r = 32'd0;
  endcase
end
assign alu3_out = alu3_out_r;
reg [31:0] mul1_op1_r;
reg [31:0] mul1_op2_r;
wire [31:0] mul1_out;
always @(*) begin
  case (mul1_sel1)
    5'd0: mul1_op1_r = i1;
    5'd1: mul1_op1_r = i10;
    5'd2: mul1_op1_r = i2;
    5'd3: mul1_op1_r = i3;
    5'd4: mul1_op1_r = i4;
    5'd5: mul1_op1_r = i5;
    5'd6: mul1_op1_r = i6;
    5'd7: mul1_op1_r = i7;
    5'd8: mul1_op1_r = i8;
    5'd9: mul1_op1_r = i9;
    5'd10: mul1_op1_r = reg_n2;
    5'd11: mul1_op1_r = reg_n4;
    5'd12: mul1_op1_r = reg_n7;
    5'd13: mul1_op1_r = reg_n9;
    5'd14: mul1_op1_r = reg_n10;
    5'd15: mul1_op1_r = reg_n13;
    5'd16: mul1_op1_r = reg_n16;
    5'd17: mul1_op1_r = reg_n17;
    5'd18: mul1_op1_r = reg_n18;
    default: mul1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (mul1_sel2)
    5'd0: mul1_op2_r = i1;
    5'd1: mul1_op2_r = i10;
    5'd2: mul1_op2_r = i2;
    5'd3: mul1_op2_r = i3;
    5'd4: mul1_op2_r = i4;
    5'd5: mul1_op2_r = i5;
    5'd6: mul1_op2_r = i6;
    5'd7: mul1_op2_r = i7;
    5'd8: mul1_op2_r = i8;
    5'd9: mul1_op2_r = i9;
    5'd10: mul1_op2_r = reg_n2;
    5'd11: mul1_op2_r = reg_n4;
    5'd12: mul1_op2_r = reg_n7;
    5'd13: mul1_op2_r = reg_n9;
    5'd14: mul1_op2_r = reg_n10;
    5'd15: mul1_op2_r = reg_n13;
    5'd16: mul1_op2_r = reg_n16;
    5'd17: mul1_op2_r = reg_n17;
    5'd18: mul1_op2_r = reg_n18;
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
reg [31:0] mul2_op1_r;
reg [31:0] mul2_op2_r;
wire [31:0] mul2_out;
always @(*) begin
  case (mul2_sel1)
    5'd0: mul2_op1_r = i1;
    5'd1: mul2_op1_r = i10;
    5'd2: mul2_op1_r = i2;
    5'd3: mul2_op1_r = i3;
    5'd4: mul2_op1_r = i4;
    5'd5: mul2_op1_r = i5;
    5'd6: mul2_op1_r = i6;
    5'd7: mul2_op1_r = i7;
    5'd8: mul2_op1_r = i8;
    5'd9: mul2_op1_r = i9;
    5'd10: mul2_op1_r = reg_n2;
    5'd11: mul2_op1_r = reg_n4;
    5'd12: mul2_op1_r = reg_n7;
    5'd13: mul2_op1_r = reg_n9;
    5'd14: mul2_op1_r = reg_n10;
    5'd15: mul2_op1_r = reg_n13;
    5'd16: mul2_op1_r = reg_n16;
    5'd17: mul2_op1_r = reg_n17;
    5'd18: mul2_op1_r = reg_n18;
    default: mul2_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (mul2_sel2)
    5'd0: mul2_op2_r = i1;
    5'd1: mul2_op2_r = i10;
    5'd2: mul2_op2_r = i2;
    5'd3: mul2_op2_r = i3;
    5'd4: mul2_op2_r = i4;
    5'd5: mul2_op2_r = i5;
    5'd6: mul2_op2_r = i6;
    5'd7: mul2_op2_r = i7;
    5'd8: mul2_op2_r = i8;
    5'd9: mul2_op2_r = i9;
    5'd10: mul2_op2_r = reg_n2;
    5'd11: mul2_op2_r = reg_n4;
    5'd12: mul2_op2_r = reg_n7;
    5'd13: mul2_op2_r = reg_n9;
    5'd14: mul2_op2_r = reg_n10;
    5'd15: mul2_op2_r = reg_n13;
    5'd16: mul2_op2_r = reg_n16;
    5'd17: mul2_op2_r = reg_n17;
    5'd18: mul2_op2_r = reg_n18;
    default: mul2_op2_r = 32'd0;
  endcase
end
reg [31:0] mul2_out_r;
always @(*) begin
  case (mul2_op)
    2'd0: mul2_out_r = mul2_op1_r * mul2_op2_r;
    2'd1: mul2_out_r = (mul2_op2_r==0) ? 32'd0 : (mul2_op1_r / mul2_op2_r);
    2'd2: mul2_out_r = (mul2_op2_r==0) ? 32'd0 : (mul2_op1_r % mul2_op2_r);
    default: mul2_out_r = 32'd0;
  endcase
end
assign mul2_out = mul2_out_r;
reg [31:0] log1_op1_r;
reg [31:0] log1_op2_r;
wire [31:0] log1_out;
always @(*) begin
  case (log1_sel1)
    5'd0: log1_op1_r = i1;
    5'd1: log1_op1_r = i10;
    5'd2: log1_op1_r = i2;
    5'd3: log1_op1_r = i3;
    5'd4: log1_op1_r = i4;
    5'd5: log1_op1_r = i5;
    5'd6: log1_op1_r = i6;
    5'd7: log1_op1_r = i7;
    5'd8: log1_op1_r = i8;
    5'd9: log1_op1_r = i9;
    5'd10: log1_op1_r = reg_n2;
    5'd11: log1_op1_r = reg_n4;
    5'd12: log1_op1_r = reg_n7;
    5'd13: log1_op1_r = reg_n9;
    5'd14: log1_op1_r = reg_n10;
    5'd15: log1_op1_r = reg_n13;
    5'd16: log1_op1_r = reg_n16;
    5'd17: log1_op1_r = reg_n17;
    5'd18: log1_op1_r = reg_n18;
    default: log1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (log1_sel2)
    5'd0: log1_op2_r = i1;
    5'd1: log1_op2_r = i10;
    5'd2: log1_op2_r = i2;
    5'd3: log1_op2_r = i3;
    5'd4: log1_op2_r = i4;
    5'd5: log1_op2_r = i5;
    5'd6: log1_op2_r = i6;
    5'd7: log1_op2_r = i7;
    5'd8: log1_op2_r = i8;
    5'd9: log1_op2_r = i9;
    5'd10: log1_op2_r = reg_n2;
    5'd11: log1_op2_r = reg_n4;
    5'd12: log1_op2_r = reg_n7;
    5'd13: log1_op2_r = reg_n9;
    5'd14: log1_op2_r = reg_n10;
    5'd15: log1_op2_r = reg_n13;
    5'd16: log1_op2_r = reg_n16;
    5'd17: log1_op2_r = reg_n17;
    5'd18: log1_op2_r = reg_n18;
    default: log1_op2_r = 32'd0;
  endcase
end
reg [31:0] log1_out_r;
always @(*) begin
  case (log1_op)
    2'd0: log1_out_r = log1_op1_r & log1_op2_r;
    2'd1: log1_out_r = log1_op1_r | log1_op2_r;
    2'd2: log1_out_r = log1_op1_r ^ log1_op2_r;
    default: log1_out_r = 32'd0;
  endcase
end
assign log1_out = log1_out_r;
reg [31:0] log2_op1_r;
reg [31:0] log2_op2_r;
wire [31:0] log2_out;
always @(*) begin
  case (log2_sel1)
    5'd0: log2_op1_r = i1;
    5'd1: log2_op1_r = i10;
    5'd2: log2_op1_r = i2;
    5'd3: log2_op1_r = i3;
    5'd4: log2_op1_r = i4;
    5'd5: log2_op1_r = i5;
    5'd6: log2_op1_r = i6;
    5'd7: log2_op1_r = i7;
    5'd8: log2_op1_r = i8;
    5'd9: log2_op1_r = i9;
    5'd10: log2_op1_r = reg_n2;
    5'd11: log2_op1_r = reg_n4;
    5'd12: log2_op1_r = reg_n7;
    5'd13: log2_op1_r = reg_n9;
    5'd14: log2_op1_r = reg_n10;
    5'd15: log2_op1_r = reg_n13;
    5'd16: log2_op1_r = reg_n16;
    5'd17: log2_op1_r = reg_n17;
    5'd18: log2_op1_r = reg_n18;
    default: log2_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (log2_sel2)
    5'd0: log2_op2_r = i1;
    5'd1: log2_op2_r = i10;
    5'd2: log2_op2_r = i2;
    5'd3: log2_op2_r = i3;
    5'd4: log2_op2_r = i4;
    5'd5: log2_op2_r = i5;
    5'd6: log2_op2_r = i6;
    5'd7: log2_op2_r = i7;
    5'd8: log2_op2_r = i8;
    5'd9: log2_op2_r = i9;
    5'd10: log2_op2_r = reg_n2;
    5'd11: log2_op2_r = reg_n4;
    5'd12: log2_op2_r = reg_n7;
    5'd13: log2_op2_r = reg_n9;
    5'd14: log2_op2_r = reg_n10;
    5'd15: log2_op2_r = reg_n13;
    5'd16: log2_op2_r = reg_n16;
    5'd17: log2_op2_r = reg_n17;
    5'd18: log2_op2_r = reg_n18;
    default: log2_op2_r = 32'd0;
  endcase
end
reg [31:0] log2_out_r;
always @(*) begin
  case (log2_op)
    2'd0: log2_out_r = log2_op1_r & log2_op2_r;
    2'd1: log2_out_r = log2_op1_r | log2_op2_r;
    2'd2: log2_out_r = log2_op1_r ^ log2_op2_r;
    default: log2_out_r = 32'd0;
  endcase
end
assign log2_out = log2_out_r;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    reg_n2 <= 32'd0;
    reg_n4 <= 32'd0;
    reg_n7 <= 32'd0;
    reg_n9 <= 32'd0;
    reg_n10 <= 32'd0;
    reg_n13 <= 32'd0;
    reg_n16 <= 32'd0;
    reg_n17 <= 32'd0;
    reg_n18 <= 32'd0;
    result <= 32'd0;
    done <= 1'b0;
  end else begin
    done <= done_next;
    if (reg_n2_en) reg_n2 <= mul1_out;
    if (reg_n4_en) reg_n4 <= alu1_out;
    if (reg_n7_en) reg_n7 <= mul2_out;
    if (reg_n9_en) reg_n9 <= alu2_out;
    if (reg_n10_en) reg_n10 <= log1_out;
    if (reg_n13_en) reg_n13 <= alu3_out;
    if (reg_n16_en) reg_n16 <= mul1_out;
    if (reg_n17_en) reg_n17 <= log2_out;
    if (reg_n18_en) reg_n18 <= mul1_out;
    if (result_en) result <= mul1_out;
  end
end

endmodule