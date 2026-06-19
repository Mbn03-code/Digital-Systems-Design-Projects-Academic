module PRNG (
    input  wire       clk,
    input  wire       reset,
    input  wire       start,
    input  wire [5:0] data_in,
    output wire [1:0] rnd_out,
    output wire       done
);

   
    wire load_reg;
    wire count_enable;
    wire count_done;


    PRNG_controller ctrl_inst (
        .clk(clk),
        .reset(reset),
        .start(start),
        .count_done(count_done),
        .load_reg(load_reg),
        .count_enable(count_enable),
        .done(done)
    );

    
    PRNG_Datapath datapath_inst (
        .clk(clk),
        .reset(reset),
        .load_reg(load_reg),
        .count_enable(count_enable),
        .data_in(data_in),
        .rnd_out(rnd_out),
        .count_done(count_done)
    );

    

endmodule


module PRNG_tb;
    reg clk, reset, start;
    reg [5:0] data_in;
    wire [1:0] rnd_out;
    wire done;

    PRNG uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .data_in(data_in),
        .rnd_out(rnd_out),
        .done(done)
    );

    always #5 clk = ~clk;
    initial begin

        clk = 0; reset = 1; start = 0; data_in = 6'b000000; #10;
        reset = 0; #10;

        start = 1; data_in = 6'b101010; #10;
        start = 0; 

        wait(done==1);
         #20;
        $finish;
    end

   
endmodule
