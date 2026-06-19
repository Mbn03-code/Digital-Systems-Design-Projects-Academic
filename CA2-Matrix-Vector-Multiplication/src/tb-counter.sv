`timescale 1ns/1ps
module tb_modN_counter;
  localparam int N = 16;
  logic clk=0, rst=1, en=0;
  logic [$clog2(N)-1:0] value;
  logic last;
  modN_counter #(.N(N)) dut (.clk(clk),.rst(rst),.en(en),.value(value),.last(last));
  always #5 clk = ~clk;
  initial begin
    #12 rst=0; en=1;
    repeat (40) @(posedge clk);
    $finish;
  end
  initial $monitor("%t value=%0d last=%b", $time, value, last);
endmodule