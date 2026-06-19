module GH_datapath(
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] data_in,
    input  wire [5:0]  count,

    input  wire        start_prng,
    output wire        prng_done,

    input  wire        stage_load,
    input  wire        load_init,   

    output wire [31:0] data_out
);
    
    wire [7:0] a0 = 8'h01;
    wire [7:0] b0 = 8'h89;
    wire [7:0] c0 = 8'hFE;
    wire [7:0] d0 = 8'h76;


    wire [7:0] constant_value;

    constant_rom ROM (
        .addr(count),
        .data(constant_value)
    );


    wire [1:0] rnd_out;
    wire [7:0] M;
    registerFile RF (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .write_en(1'b1),
        .read_addr(rnd_out),
        .read_data(M)
    );

    
    wire [7:0] A, B, C, D;
    wire [7:0] adder1_out ,adder2_out;  
  


    register A_reg (.clk(clk), .reset(reset),
                    .load(load_init || stage_load),
                    .d_in(load_init ? a0 : D),
                    .q_out(A));
    

    register B_reg (.clk(clk), .reset(reset),
                    .load(load_init || stage_load),
                    .d_in(load_init ? b0 : adder2_out),
                    .q_out(B));

    register C_reg (.clk(clk), .reset(reset),
                    .load(load_init || stage_load),
                    .d_in(load_init ? c0 : B),
                    .q_out(C));

    register D_reg (.clk(clk), .reset(reset),
                    .load(load_init || stage_load),
                    .d_in(load_init ? d0 : C),
                    .q_out(D));


    // --- PRNG ---
    PRNG PRNG_inst (
        .clk(clk),
        .reset(reset),
        .start(start_prng),
        .data_in(count),
        .rnd_out(rnd_out),
        .done(prng_done)
    );

    
    wire [7:0] F_out;
    F_function F_inst (.B(B), .C(C), .D(D),.i(count), .F(F_out));

   
    adder #(
        .WIDTH(8),
        .N(4)
    ) adder1_inst (
        .numbers({
            F_out,
            A,
            M,
            constant_value
        }),
        .sum(adder1_out)
    );

    wire [7:0] mult_result;
    assign mult_result = adder1_out[3:0] * adder1_out[7:4];


    adder #(
        .WIDTH(8),
        .N(2)
    ) adder2_inst (
        .numbers({
            mult_result,
            B
        }),
        .sum(adder2_out)
    );

    assign data_out = {A, B, C, D};
endmodule

