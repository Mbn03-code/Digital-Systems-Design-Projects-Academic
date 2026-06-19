module shift_register_6 (
    input  wire       clk,
    input  wire       reset,
    input  wire       load,
    input  wire       enable,
    input  wire [5:0] d_in,
    input  wire       shift_in,
    output wire [5:0] q_out
);

    wire [5:0] next_shift;
    wire [5:0] shifted_data;
    
    assign next_shift[0] = shift_in;  
    assign next_shift[5:1] = q_out[4:0]; 
    assign shifted_data[5:1]=d_in[4:0];
    assign shifted_data[0]=shift_in;
    genvar i;
    generate
        for (i=0 ; i<6 ; i=i+1) begin : REG6
            s2 bit_i (
                .D00(q_out[i]),          // HOLD
                .D01(d_in[i]),           // LOAD
                .D10(next_shift[i]),     // SHIFT
                .D11(shifted_data[i]),
                .A1(enable),           
                .B1(1'b0),             
                .A0(load),
                .B0(1'b1),
                .clr(reset),
                .clk(clk),
                .out(q_out[i])
            );
        end
    endgenerate

endmodule

`timescale 1ns/1ps
module tb_shift_register_6;

    reg clk, reset, load, enable, shift_in;
    reg [5:0] d_in;
    wire [5:0] q_out;

    integer gate_count;

    shift_register_6 uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .enable(enable),
        .d_in(d_in),
        .shift_in(shift_in),
        .q_out(q_out)
    );

    initial begin
        gate_count = 0;
        clk = 0; reset = 1; load = 0; enable = 0; shift_in = 0; d_in = 6'b000000;

        #10 reset = 0;

        #10 load = 1; d_in = 6'b110101; 
        #10 load = 0; enable = 1; shift_in = 1; 
        #10 shift_in = 0; 
        #10 enable = 0;

        #10 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t clk=%b reset=%b load=%b enable=%b shift_in=%b d_in=%b q_out=%b",
                 $time, clk, reset, load, enable, shift_in, d_in, q_out);
    end

endmodule
