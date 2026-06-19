module PRNG_Datapath (
    input  wire       clk,
    input  wire       reset,
    input  wire       load_reg,
    input  wire       count_enable,
    input  wire [5:0] data_in,
    output wire [1:0] rnd_out,
    output wire       count_done
);
    
    wire [5:0] shift_q;
    wire feedback_bit;
    wire [2:0] count;

    
    assign feedback_bit = shift_q[5] ^ shift_q[3] ^ shift_q[1];

    
    shift_register_6 shift_reg_inst (
        .clk(clk),
        .reset(reset),
        .load(load_reg),
        .enable(count_enable),
        .d_in(data_in),
        .shift_in(feedback_bit),
        .q_out(shift_q)
    );

    
    counter #(
       .WIDTH(3),
       .MAX_VALUE(3'd6)  
    ) counter_inst (
       .clk(clk),
       .reset(reset),
       .enable(count_enable),
       .count(count),
       .done(count_done)
    );


   
    assign rnd_out = shift_q[5:4];

endmodule
