module GH_top_tb;
    reg clk, reset, start;
    reg [31:0] data_in;
    wire [31:0] data_out;
    wire done;

    GH_top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .data_out(data_out),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        reset = 1; start = 0; data_in = 32'h3761eded; #20;
        reset = 0; start = 1; #20;
        start = 0;
        wait(done==1);
         
        $finish;
    end
endmodule


