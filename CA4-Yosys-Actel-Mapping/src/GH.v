module GH(
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



    counter #(.WIDTH(6) , .MAX_VALUE(6'd63)) 
    counter_ins(
        .clk(clk),
        .reset(reset),
        .enable(count_enable),
        .count(count),
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

