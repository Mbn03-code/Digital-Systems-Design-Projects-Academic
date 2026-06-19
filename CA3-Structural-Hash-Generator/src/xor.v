module xor_gate #(parameter N = 1) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    output wire [N-1:0] xor_out
);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : xor_gen
            c2 xor_gate (
                .D00(1'b0),
                .D01(1'b1),
                .D10(1'b1),
                .D11(1'b0),
                .A1(a[i]),
                .B1(b[i]),
                .A0(a[i]),
                .B0(b[i]),
                .out(xor_out[i])
            );
        end
    endgenerate
endmodule

`timescale 1ns/1ps
module tb_xor_gate;

    reg [3:0] a, b;
    wire [3:0] xor_out;

    xor_gate #(4) uut (
        .a(a),
        .b(b),
        .xor_out(xor_out)
    );

    initial begin
        a = 4'b0000; b = 4'b0000;
        #10 a = 4'b1010; b = 4'b1100;
        #10 a = 4'b1111; b = 4'b1010;
        #10 a = 4'b0101; b = 4'b0101;

        #10 $finish;
    end

    initial begin
        $monitor("Time=%0t a=%b b=%b xor_out=%b", $time, a, b, xor_out);
    end

endmodule
