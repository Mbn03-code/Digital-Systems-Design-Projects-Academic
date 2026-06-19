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


    reg [7:0] constant [0:63];
    initial $readmemh("k.mem", constant);

    wire [1:0] rnd_out;
    wire [7:0] M;
    regfile4x8_parallel RF (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .write_en(1'b1),
        .read_addr(rnd_out),
        .read_data(M)
    );

    
    wire [7:0] A, B, C, D;
    wire [7:0] adder2_out;  
    wire [7:0] reg_adder1_out;

    or_gate #(1) OR_A (.a(load_init), .b(stage_load), .or_out(load));


    register A_reg (
    .clk(clk),
    .reset(reset),
    .ld(load),
    .in(load_init ? a0 : D),
    .out(A)
    );

    register B_reg (
        .clk(clk),
        .reset(reset),
        .ld(load),
        .in(load_init ? b0 : adder2_out),
        .out(B)
    );

    register C_reg (
        .clk(clk),
        .reset(reset),
        .ld(load),
        .in(load_init ? c0 : B),
        .out(C)
    );

    register D_reg (
        .clk(clk),
        .reset(reset),
        .ld(load),
        .in(load_init ? d0 : C),
        .out(D)
    );


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
    F_function_8bit F_inst (.B(B), .C(C), .D(D),.i(count), .F(F_out));

    // --- Adder1 ---
    wire [7:0] adder1_out;

    adder4x8 adder1_inst (
        .a(F_out),
        .b(A),
        .c(M),
        .d(constant[count]),
        .sum(adder1_out),
        .cout()
    );


    // --- multiplier ---
    wire [7:0] mult;
    mult4x4 mult1(.A(adder1_out[3:0]) ,.B(adder1_out[7:4]) ,.P(mult));

    
    adder_n #(.N(8)) adder2 (
    .a(mult),
    .b(B),
    .cin(1'b0),
    .sum(adder2_out),
    .cout()
    );

    assign data_out = {A, B, C, D};
endmodule


module GH_datapath_tb;
    reg clk, reset, start_prng, stage_load, load_init;
    reg [31:0] data_in;
    reg [5:0] count;
    wire [31:0] data_out;
    wire prng_done;

    GH_datapath uut (
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

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        reset = 1; data_in = 32'h0000_0000; count = 0;
        start_prng = 0; stage_load = 0; load_init = 0; #10;
        reset = 0; load_init = 1; #10;
        load_init = 0; stage_load = 1; start_prng = 1; count = 6'd1; #10;
        stage_load = 0; start_prng = 0; count = 6'd2; #10;
        start_prng = 1; count = 6'd3; #10;
        start_prng = 0; count = 6'd4; #10;

        $finish;
    end
endmodule
