`timescale 1ns/1ns

module tb_top;

  // ------------------------------------------------------------
  // REQUIRED signals 
  // ------------------------------------------------------------
  reg clk, rst, start;
  reg [31:0] i1, i2, i3;


  wire [31:0] result;
  wire done;

  top dut (
  .clk(clk),
  .rst(rst),
  .start(start),
  .i1(i1),
  .i2(i2),
  .i3(i3),
  .result(result),
  .done(done)
  );

  // ------------------------------------------------------------
  // Clock generation (10ns period)
  // ------------------------------------------------------------
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0;
    rst = 1;
    start = 0;

    // Fixed test values
    i1 = 32'd1;
    i2 = 32'd2;
    i3 = 32'd3;

    // Release reset
    #12 rst = 0;

    // Start pulse
    #10 start = 1;
    #10 start = 0;

    // Let it run a bit (students can add $display checks for their outputs)
    #200;

    $display("TB finished at time %0t", $time);
    $stop;
  end

endmodule
