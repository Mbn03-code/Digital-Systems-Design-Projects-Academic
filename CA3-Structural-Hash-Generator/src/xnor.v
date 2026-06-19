module xnor_gate #(parameter N = 1) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    output wire [N-1:0] xnor_out
);

    wire [N-1:0] xor_res;

    xor_gate #(N) xor_inst (
        .a(a),
        .b(b),
        .xor_out(xor_res)
    );

    not_gate #(N) not_inst (
        .a(xor_res),
        .not_out(xnor_out)
    );

endmodule

`timescale 1ns/1ps
module tb_xnor_gate;

    reg [3:0] a, b;
    wire [3:0] xnor_out;
    integer gate_count;

    xnor_gate #(4) uut (
        .a(a),
        .b(b),
        .xnor_out(xnor_out)
    );

    initial begin
        gate_count = 0;
        a = 4'b0000; b = 4'b0000;

        #10 a = 4'b1010; b = 4'b1100;
        #10 a = 4'b1111; b = 4'b1010;
        #10 a = 4'b0101; b = 4'b0101;

        #10 $finish;
    end

    initial begin
        $monitor("Time=%0t a=%b b=%b xnor_out=%b", $time, a, b, xnor_out);
    end

endmodule
