module GH_top(
    input  wire        clk,
    input  wire        reset,
    input  wire        start,
    input  wire [31:0] data_in,
    output wire [31:0] data_out,
    output wire        done
);
    
    wire [5:0] count;
    wire count_done;
    wire count_enable;

    
    wire start_prng, stage_load, load_init; 
    wire prng_done;



    counter_6bit 
    counter_ins(
        .reset(reset),
        .clk(clk),
        .enable(count_enable),
        .out(count),
        .done(count_done)
    );
    


    GH_datapath datapath (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .count(count),
        .start_prng(start_prng),
        .prng_done(prng_done),
        .stage_load(stage_load),
        .load_init(load_init),   
        .data_out(data_out)
    );


    GH_controller controller (
        .clk(clk),
        .reset(reset),
        .start(start),
        .prng_done(prng_done),
        .count_done(count_done),
        .start_prng(start_prng),
        .stage_load(stage_load),
        .load_init(load_init),   
        .count_enable(count_enable),
        .done(done)
    );
endmodule

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

        reset = 1; start = 0; data_in = 32'hfeecf6da; #20;
        reset = 0; start = 1; #20;
        start = 0;
        wait(done==1);
         #100;
        $finish;
    end
endmodule


