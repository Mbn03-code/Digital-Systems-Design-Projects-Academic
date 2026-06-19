`timescale 1ns/1ps
module tb_extractor;
  localparam int MP=16, LANES=4;
  logic [LANES*MP-1:0] a_packed;
  logic [$clog2(MP)-1:0] bit_idx;
  logic [LANES-1:0] bits;
  a_bit_extractor #(.MP(MP),.LANES(LANES)) dut (.a_packed(a_packed),.bit_idx(bit_idx),.bits_out(bits));
  initial begin
    a_packed = {16'hCDEF,16'h89AB,16'h4567,16'h0123};
    for (int i=0;i<MP;i++) begin
      bit_idx = i; #1;
      $display("bit_idx=%0d bits=%b", i, bits);
    end
    $finish;
  end
endmodule