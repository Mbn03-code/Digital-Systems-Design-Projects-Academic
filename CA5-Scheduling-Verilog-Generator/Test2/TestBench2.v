`timescale 1ns/1ns

module tb_top;

  // ------------------------------------------------------------
  // REQUIRED signals 
  // ------------------------------------------------------------
  reg clk, rst, start;

  // Fixed inputs
  reg [31:0] i1, i2, i3, i4;

  // ------------------------------------------------------------
  // Students: Uncomment/edit these parts based on YOUR modules,
  // ports, and signal names. (Left commented for flexibility.)
  // ------------------------------------------------------------
   
  wire [31:0] result;
  wire done;
  top dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .i4(i4),
    .result(result),
    .done(done)
  );


  // ------------------------------------------------------------
  // Clock generation (10ns period)
  // ------------------------------------------------------------
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk   = 0;
    rst   = 1;
    start = 0;

    // Set fixed test values
    i1 = 32'd1;
    i2 = 32'd2;
    i3 = 32'd3;
    i4 = 32'd4;

    // Release reset
    #12 rst = 0;

    // Start pulse
    #10 start = 1;
    #10 start = 0;

    // Run for enough cycles (students can add checks/displays)
    #300;

    $display("TB finished at time %0t", $time);
    $stop;
  end

endmodule
