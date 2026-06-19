module controller(
  input clk,
  input rst,
  input start,
  output reg [3:0] alu1_sel1,
  output reg [3:0] alu1_sel2,
  output reg [0:0] alu1_op,
  output reg [3:0] alu2_sel1,
  output reg [3:0] alu2_sel2,
  output reg [0:0] alu2_op,
  output reg [3:0] alu3_sel1,
  output reg [3:0] alu3_sel2,
  output reg [0:0] alu3_op,
  output reg [3:0] mul1_sel1,
  output reg [3:0] mul1_sel2,
  output reg [1:0] mul1_op,
  output reg [3:0] log1_sel1,
  output reg [3:0] log1_sel2,
  output reg [1:0] log1_op,
  output reg [3:0] log2_sel1,
  output reg [3:0] log2_sel2,
  output reg [1:0] log2_op,
  output reg reg_n2_en,
  output reg reg_n4_en,
  output reg reg_n5_en,
  output reg reg_n6_en,
  output reg reg_n7_en,
  output reg reg_n8_en,
  output reg reg_n9_en,
  output reg reg_n10_en,
  output reg reg_n11_en,
  output reg reg_n12_en,
  output reg done_next,
  output reg result_en
);

reg [2:0] state, next_state;
localparam S_IDLE = 0;
localparam S_CYCLE_1 = 1;
localparam S_CYCLE_2 = 2;
localparam S_CYCLE_3 = 3;
localparam S_CYCLE_4 = 4;
localparam S_DONE = 5;

always @(posedge clk or posedge rst) begin
  if (rst) state <= S_IDLE;
  else state <= next_state;
end

always @(*) begin
  next_state = state;
  alu1_sel1 = 4'd0;
  alu1_sel2 = 4'd0;
  alu1_op = 1'd0;
  alu2_sel1 = 4'd0;
  alu2_sel2 = 4'd0;
  alu2_op = 1'd0;
  alu3_sel1 = 4'd0;
  alu3_sel2 = 4'd0;
  alu3_op = 1'd0;
  mul1_sel1 = 4'd0;
  mul1_sel2 = 4'd0;
  mul1_op = 2'd0;
  log1_sel1 = 4'd0;
  log1_sel2 = 4'd0;
  log1_op = 2'd0;
  log2_sel1 = 4'd0;
  log2_sel2 = 4'd0;
  log2_op = 2'd0;
  reg_n2_en = 1'b0;
  reg_n4_en = 1'b0;
  reg_n5_en = 1'b0;
  reg_n6_en = 1'b0;
  reg_n7_en = 1'b0;
  reg_n8_en = 1'b0;
  reg_n9_en = 1'b0;
  reg_n10_en = 1'b0;
  reg_n11_en = 1'b0;
  reg_n12_en = 1'b0;
  done_next = 1'b0;
  result_en = 1'b0;

  case (state)
    S_IDLE: begin
      if (start) next_state = S_CYCLE_1;
    end
    S_CYCLE_1: begin
      alu1_sel1 = 4'd1;
      alu1_sel2 = 4'd2;
      alu1_op = 1'd0;
      reg_n4_en = 1'b1;
      log1_sel1 = 4'd2;
      log1_sel2 = 4'd0;
      log1_op = 2'd1;
      reg_n5_en = 1'b1;
      log2_sel1 = 4'd1;
      log2_sel2 = 4'd2;
      log2_op = 2'd0;
      reg_n9_en = 1'b1;
      next_state = S_CYCLE_2;
    end
    S_CYCLE_2: begin
      alu1_sel1 = 4'd0;
      alu1_sel2 = 4'd1;
      alu1_op = 1'd1;
      reg_n2_en = 1'b1;
      alu2_sel1 = 4'd4;
      alu2_sel2 = 4'd5;
      alu2_op = 1'd1;
      reg_n6_en = 1'b1;
      mul1_sel1 = 4'd2;
      mul1_sel2 = 4'd1;
      mul1_op = 2'd1;
      reg_n8_en = 1'b1;
      alu3_sel1 = 4'd0;
      alu3_sel2 = 4'd9;
      alu3_op = 1'd1;
      reg_n10_en = 1'b1;
      next_state = S_CYCLE_3;
    end
    S_CYCLE_3: begin
      mul1_sel1 = 4'd3;
      mul1_sel2 = 4'd6;
      mul1_op = 2'd1;
      reg_n7_en = 1'b1;
      alu1_sel1 = 4'd8;
      alu1_sel2 = 4'd10;
      alu1_op = 1'd0;
      reg_n11_en = 1'b1;
      next_state = S_CYCLE_4;
    end
    S_CYCLE_4: begin
      alu1_sel1 = 4'd7;
      alu1_sel2 = 4'd11;
      alu1_op = 1'd0;
      reg_n12_en = 1'b1;
      result_en = 1'b1;
      next_state = S_DONE;
    end
    S_DONE: begin
      done_next = 1'b1;
      next_state = S_IDLE;
    end
  endcase
end
endmodule