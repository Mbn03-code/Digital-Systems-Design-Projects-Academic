module controller(
  input clk,
  input rst,
  input start,
  output reg [4:0] alu1_sel1,
  output reg [4:0] alu1_sel2,
  output reg [0:0] alu1_op,
  output reg [4:0] mul1_sel1,
  output reg [4:0] mul1_sel2,
  output reg [1:0] mul1_op,
  output reg [4:0] log1_sel1,
  output reg [4:0] log1_sel2,
  output reg [1:0] log1_op,
  output reg [4:0] log2_sel1,
  output reg [4:0] log2_sel2,
  output reg [1:0] log2_op,
  output reg [4:0] log3_sel1,
  output reg [4:0] log3_sel2,
  output reg [1:0] log3_op,
  output reg reg_n2_en,
  output reg reg_n5_en,
  output reg reg_n6_en,
  output reg reg_n9_en,
  output reg reg_n12_en,
  output reg reg_n13_en,
  output reg reg_n14_en,
  output reg reg_n17_en,
  output reg reg_n18_en,
  output reg done_next,
  output reg result_en
);

reg [2:0] state, next_state;
localparam S_IDLE = 0;
localparam S_CYCLE_1 = 1;
localparam S_CYCLE_2 = 2;
localparam S_CYCLE_3 = 3;
localparam S_CYCLE_4 = 4;
localparam S_CYCLE_5 = 5;
localparam S_DONE = 6;

always @(posedge clk or posedge rst) begin
  if (rst) state <= S_IDLE;
  else state <= next_state;
end

always @(*) begin
  next_state = state;
  alu1_sel1 = 5'd0;
  alu1_sel2 = 5'd0;
  alu1_op = 1'd0;
  mul1_sel1 = 5'd0;
  mul1_sel2 = 5'd0;
  mul1_op = 2'd0;
  log1_sel1 = 5'd0;
  log1_sel2 = 5'd0;
  log1_op = 2'd0;
  log2_sel1 = 5'd0;
  log2_sel2 = 5'd0;
  log2_op = 2'd0;
  log3_sel1 = 5'd0;
  log3_sel2 = 5'd0;
  log3_op = 2'd0;
  reg_n2_en = 1'b0;
  reg_n5_en = 1'b0;
  reg_n6_en = 1'b0;
  reg_n9_en = 1'b0;
  reg_n12_en = 1'b0;
  reg_n13_en = 1'b0;
  reg_n14_en = 1'b0;
  reg_n17_en = 1'b0;
  reg_n18_en = 1'b0;
  done_next = 1'b0;
  result_en = 1'b0;

  case (state)
    S_IDLE: begin
      if (start) next_state = S_CYCLE_1;
    end
    S_CYCLE_1: begin
      log1_sel1 = 5'd0;
      log1_sel2 = 5'd2;
      log1_op = 2'd0;
      reg_n2_en = 1'b1;
      log2_sel1 = 5'd3;
      log2_sel2 = 5'd4;
      log2_op = 2'd1;
      reg_n5_en = 1'b1;
      log3_sel1 = 5'd5;
      log3_sel2 = 5'd6;
      log3_op = 2'd1;
      reg_n9_en = 1'b1;
      mul1_sel1 = 5'd9;
      mul1_sel2 = 5'd1;
      mul1_op = 2'd0;
      reg_n17_en = 1'b1;
      next_state = S_CYCLE_2;
    end
    S_CYCLE_2: begin
      alu1_sel1 = 5'd10;
      alu1_sel2 = 5'd11;
      alu1_op = 1'd0;
      reg_n6_en = 1'b1;
      log1_sel1 = 5'd7;
      log1_sel2 = 5'd8;
      log1_op = 2'd0;
      reg_n12_en = 1'b1;
      next_state = S_CYCLE_3;
    end
    S_CYCLE_3: begin
      alu1_sel1 = 5'd13;
      alu1_sel2 = 5'd14;
      alu1_op = 1'd1;
      reg_n13_en = 1'b1;
      next_state = S_CYCLE_4;
    end
    S_CYCLE_4: begin
      mul1_sel1 = 5'd12;
      mul1_sel2 = 5'd15;
      mul1_op = 2'd0;
      reg_n14_en = 1'b1;
      next_state = S_CYCLE_5;
    end
    S_CYCLE_5: begin
      alu1_sel1 = 5'd16;
      alu1_sel2 = 5'd17;
      alu1_op = 1'd0;
      reg_n18_en = 1'b1;
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