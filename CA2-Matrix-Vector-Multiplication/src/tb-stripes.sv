`timescale 1ns/1ps
module tb_stripes_pe;
  localparam int MP=16, LANES=4, WACC=34;
  logic clk=0, rst=1;
  logic [LANES*MP-1:0] vecB;
  logic [LANES*MP-1:0] Avec;      
  logic [LANES-1:0]    a_bits;
  logic [WACC-1:0]     init_sum;
  logic                 vld, is_msb, is_lsb;
  logic signed [WACC-1:0] dot;
  stripes_pe #(.MP(MP),.LANES(LANES),.WACC(WACC)) dut (
    .clk(clk), .rst(rst),
    .i_vec_b(vecB), .i_vec_a_bits(a_bits),
    .i_initial_sum(init_sum), .i_valid(vld),
    .i_is_msb(is_msb), .i_is_lsb(is_lsb),
    .o_dot_product(dot)
  );
  logic [$clog2(MP)-1:0] bit_idx;
  a_bit_extractor #(.MP(MP),.LANES(LANES)) u_ex (.a_packed(Avec), .bit_idx(bit_idx), .bits_out(a_bits));
  always #5 clk = ~clk;
  task run_case(input shortint a0,a1,a2,a3, input shortint b0,b1,b2,b3, input integer expected);
    begin
      Avec = { {16{a3[15]}}, a3[15:0] } ; 
      Avec = {16'(a3),16'(a2),16'(a1),16'(a0)};
      vecB = {16'(b3),16'(b2),16'(b1),16'(b0)};
      init_sum = '0;
      vld = 1;
      for (int i=0;i<MP;i++) begin
        bit_idx = i;
        is_msb  = (i==0);
        is_lsb  = (i==MP-1);
        @(posedge clk);
      end
      vld=0; @(posedge clk);
      $display("A=(%0d,%0d,%0d,%0d) · B=(%0d,%0d,%0d,%0d) => %0d (exp=%0d)",
               a0,a1,a2,a3,b0,b1,b2,b3, dot, expected);
    end
  endtask
  initial begin
    repeat(3) @(posedge clk);
    rst=0;
    run_case(1,3,6,2, 3,5,5,1, 50);
    run_case(1,-4,6,3, 2,6,-1,7, -7);
    $finish;
  end
endmodule