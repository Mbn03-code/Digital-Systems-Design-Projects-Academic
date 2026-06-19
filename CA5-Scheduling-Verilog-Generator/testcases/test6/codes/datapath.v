module datapath(
  input clk,
  input rst,
  input [31:0] i1,
  input [31:0] i2,
  input [31:0] i3,
  input [3:0] alu1_sel1,
  input [3:0] alu1_sel2,
  input [0:0] alu1_op,
  input [3:0] alu2_sel1,
  input [3:0] alu2_sel2,
  input [0:0] alu2_op,
  input [3:0] alu3_sel1,
  input [3:0] alu3_sel2,
  input [0:0] alu3_op,
  input [3:0] mul1_sel1,
  input [3:0] mul1_sel2,
  input [1:0] mul1_op,
  input [3:0] log1_sel1,
  input [3:0] log1_sel2,
  input [1:0] log1_op,
  input [3:0] log2_sel1,
  input [3:0] log2_sel2,
  input [1:0] log2_op,
  input done_next,
  input result_en,
  input reg_n2_en,
  input reg_n4_en,
  input reg_n5_en,
  input reg_n6_en,
  input reg_n7_en,
  input reg_n8_en,
  input reg_n9_en,
  input reg_n10_en,
  input reg_n11_en,
  input reg_n12_en,
  output reg [31:0] result,
  output reg done
);

reg [31:0] reg_n2;
reg [31:0] reg_n4;
reg [31:0] reg_n5;
reg [31:0] reg_n6;
reg [31:0] reg_n7;
reg [31:0] reg_n8;
reg [31:0] reg_n9;
reg [31:0] reg_n10;
reg [31:0] reg_n11;
reg [31:0] reg_n12;

reg [31:0] alu1_op1_r;
reg [31:0] alu1_op2_r;
wire [31:0] alu1_out;
always @(*) begin
  case (alu1_sel1)
    4'd0: alu1_op1_r = i1;
    4'd1: alu1_op1_r = i2;
    4'd2: alu1_op1_r = i3;
    4'd3: alu1_op1_r = reg_n2;
    4'd4: alu1_op1_r = reg_n4;
    4'd5: alu1_op1_r = reg_n5;
    4'd6: alu1_op1_r = reg_n6;
    4'd7: alu1_op1_r = reg_n7;
    4'd8: alu1_op1_r = reg_n8;
    4'd9: alu1_op1_r = reg_n9;
    4'd10: alu1_op1_r = reg_n10;
    4'd11: alu1_op1_r = reg_n11;
    4'd12: alu1_op1_r = reg_n12;
    default: alu1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu1_sel2)
    4'd0: alu1_op2_r = i1;
    4'd1: alu1_op2_r = i2;
    4'd2: alu1_op2_r = i3;
    4'd3: alu1_op2_r = reg_n2;
    4'd4: alu1_op2_r = reg_n4;
    4'd5: alu1_op2_r = reg_n5;
    4'd6: alu1_op2_r = reg_n6;
    4'd7: alu1_op2_r = reg_n7;
    4'd8: alu1_op2_r = reg_n8;
    4'd9: alu1_op2_r = reg_n9;
    4'd10: alu1_op2_r = reg_n10;
    4'd11: alu1_op2_r = reg_n11;
    4'd12: alu1_op2_r = reg_n12;
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
    4'd0: alu2_op1_r = i1;
    4'd1: alu2_op1_r = i2;
    4'd2: alu2_op1_r = i3;
    4'd3: alu2_op1_r = reg_n2;
    4'd4: alu2_op1_r = reg_n4;
    4'd5: alu2_op1_r = reg_n5;
    4'd6: alu2_op1_r = reg_n6;
    4'd7: alu2_op1_r = reg_n7;
    4'd8: alu2_op1_r = reg_n8;
    4'd9: alu2_op1_r = reg_n9;
    4'd10: alu2_op1_r = reg_n10;
    4'd11: alu2_op1_r = reg_n11;
    4'd12: alu2_op1_r = reg_n12;
    default: alu2_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu2_sel2)
    4'd0: alu2_op2_r = i1;
    4'd1: alu2_op2_r = i2;
    4'd2: alu2_op2_r = i3;
    4'd3: alu2_op2_r = reg_n2;
    4'd4: alu2_op2_r = reg_n4;
    4'd5: alu2_op2_r = reg_n5;
    4'd6: alu2_op2_r = reg_n6;
    4'd7: alu2_op2_r = reg_n7;
    4'd8: alu2_op2_r = reg_n8;
    4'd9: alu2_op2_r = reg_n9;
    4'd10: alu2_op2_r = reg_n10;
    4'd11: alu2_op2_r = reg_n11;
    4'd12: alu2_op2_r = reg_n12;
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
    4'd0: alu3_op1_r = i1;
    4'd1: alu3_op1_r = i2;
    4'd2: alu3_op1_r = i3;
    4'd3: alu3_op1_r = reg_n2;
    4'd4: alu3_op1_r = reg_n4;
    4'd5: alu3_op1_r = reg_n5;
    4'd6: alu3_op1_r = reg_n6;
    4'd7: alu3_op1_r = reg_n7;
    4'd8: alu3_op1_r = reg_n8;
    4'd9: alu3_op1_r = reg_n9;
    4'd10: alu3_op1_r = reg_n10;
    4'd11: alu3_op1_r = reg_n11;
    4'd12: alu3_op1_r = reg_n12;
    default: alu3_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (alu3_sel2)
    4'd0: alu3_op2_r = i1;
    4'd1: alu3_op2_r = i2;
    4'd2: alu3_op2_r = i3;
    4'd3: alu3_op2_r = reg_n2;
    4'd4: alu3_op2_r = reg_n4;
    4'd5: alu3_op2_r = reg_n5;
    4'd6: alu3_op2_r = reg_n6;
    4'd7: alu3_op2_r = reg_n7;
    4'd8: alu3_op2_r = reg_n8;
    4'd9: alu3_op2_r = reg_n9;
    4'd10: alu3_op2_r = reg_n10;
    4'd11: alu3_op2_r = reg_n11;
    4'd12: alu3_op2_r = reg_n12;
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
    4'd0: mul1_op1_r = i1;
    4'd1: mul1_op1_r = i2;
    4'd2: mul1_op1_r = i3;
    4'd3: mul1_op1_r = reg_n2;
    4'd4: mul1_op1_r = reg_n4;
    4'd5: mul1_op1_r = reg_n5;
    4'd6: mul1_op1_r = reg_n6;
    4'd7: mul1_op1_r = reg_n7;
    4'd8: mul1_op1_r = reg_n8;
    4'd9: mul1_op1_r = reg_n9;
    4'd10: mul1_op1_r = reg_n10;
    4'd11: mul1_op1_r = reg_n11;
    4'd12: mul1_op1_r = reg_n12;
    default: mul1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (mul1_sel2)
    4'd0: mul1_op2_r = i1;
    4'd1: mul1_op2_r = i2;
    4'd2: mul1_op2_r = i3;
    4'd3: mul1_op2_r = reg_n2;
    4'd4: mul1_op2_r = reg_n4;
    4'd5: mul1_op2_r = reg_n5;
    4'd6: mul1_op2_r = reg_n6;
    4'd7: mul1_op2_r = reg_n7;
    4'd8: mul1_op2_r = reg_n8;
    4'd9: mul1_op2_r = reg_n9;
    4'd10: mul1_op2_r = reg_n10;
    4'd11: mul1_op2_r = reg_n11;
    4'd12: mul1_op2_r = reg_n12;
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
reg [31:0] log1_op1_r;
reg [31:0] log1_op2_r;
wire [31:0] log1_out;
always @(*) begin
  case (log1_sel1)
    4'd0: log1_op1_r = i1;
    4'd1: log1_op1_r = i2;
    4'd2: log1_op1_r = i3;
    4'd3: log1_op1_r = reg_n2;
    4'd4: log1_op1_r = reg_n4;
    4'd5: log1_op1_r = reg_n5;
    4'd6: log1_op1_r = reg_n6;
    4'd7: log1_op1_r = reg_n7;
    4'd8: log1_op1_r = reg_n8;
    4'd9: log1_op1_r = reg_n9;
    4'd10: log1_op1_r = reg_n10;
    4'd11: log1_op1_r = reg_n11;
    4'd12: log1_op1_r = reg_n12;
    default: log1_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (log1_sel2)
    4'd0: log1_op2_r = i1;
    4'd1: log1_op2_r = i2;
    4'd2: log1_op2_r = i3;
    4'd3: log1_op2_r = reg_n2;
    4'd4: log1_op2_r = reg_n4;
    4'd5: log1_op2_r = reg_n5;
    4'd6: log1_op2_r = reg_n6;
    4'd7: log1_op2_r = reg_n7;
    4'd8: log1_op2_r = reg_n8;
    4'd9: log1_op2_r = reg_n9;
    4'd10: log1_op2_r = reg_n10;
    4'd11: log1_op2_r = reg_n11;
    4'd12: log1_op2_r = reg_n12;
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
    4'd0: log2_op1_r = i1;
    4'd1: log2_op1_r = i2;
    4'd2: log2_op1_r = i3;
    4'd3: log2_op1_r = reg_n2;
    4'd4: log2_op1_r = reg_n4;
    4'd5: log2_op1_r = reg_n5;
    4'd6: log2_op1_r = reg_n6;
    4'd7: log2_op1_r = reg_n7;
    4'd8: log2_op1_r = reg_n8;
    4'd9: log2_op1_r = reg_n9;
    4'd10: log2_op1_r = reg_n10;
    4'd11: log2_op1_r = reg_n11;
    4'd12: log2_op1_r = reg_n12;
    default: log2_op1_r = 32'd0;
  endcase
end
always @(*) begin
  case (log2_sel2)
    4'd0: log2_op2_r = i1;
    4'd1: log2_op2_r = i2;
    4'd2: log2_op2_r = i3;
    4'd3: log2_op2_r = reg_n2;
    4'd4: log2_op2_r = reg_n4;
    4'd5: log2_op2_r = reg_n5;
    4'd6: log2_op2_r = reg_n6;
    4'd7: log2_op2_r = reg_n7;
    4'd8: log2_op2_r = reg_n8;
    4'd9: log2_op2_r = reg_n9;
    4'd10: log2_op2_r = reg_n10;
    4'd11: log2_op2_r = reg_n11;
    4'd12: log2_op2_r = reg_n12;
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
    reg_n5 <= 32'd0;
    reg_n6 <= 32'd0;
    reg_n7 <= 32'd0;
    reg_n8 <= 32'd0;
    reg_n9 <= 32'd0;
    reg_n10 <= 32'd0;
    reg_n11 <= 32'd0;
    reg_n12 <= 32'd0;
    result <= 32'd0;
    done <= 1'b0;
  end else begin
    done <= done_next;
    if (reg_n2_en) reg_n2 <= alu1_out;
    if (reg_n4_en) reg_n4 <= alu1_out;
    if (reg_n5_en) reg_n5 <= log1_out;
    if (reg_n6_en) reg_n6 <= alu2_out;
    if (reg_n7_en) reg_n7 <= mul1_out;
    if (reg_n8_en) reg_n8 <= mul1_out;
    if (reg_n9_en) reg_n9 <= log2_out;
    if (reg_n10_en) reg_n10 <= alu3_out;
    if (reg_n11_en) reg_n11 <= alu1_out;
    if (reg_n12_en) reg_n12 <= alu1_out;
    if (result_en) result <= alu1_out;
  end
end

endmodule