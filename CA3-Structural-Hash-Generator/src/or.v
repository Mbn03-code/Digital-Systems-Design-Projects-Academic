module or_gate #(
    parameter N = 1
) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    output wire [N-1:0] or_out
);

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : or_bit
            c1 or_inst (
                .A0(a[i]),
                .A1(a[i]),
                .SA(1'b1),
                .B0(1'b1),
                .B1(1'b1),
                .SB(1'b1),
                .S0(b[i]),
                .S1(b[i]),
                .f(or_out[i])
            );
        end
    endgenerate

endmodule


module or_gate_tb;
    reg [3:0] a, b;
    wire [3:0] or_out;

    or_gate #(4) uut (
        .a(a),
        .b(b),
        .or_out(or_out)
    );

    initial begin

        a = 4'b0000; b = 4'b0000; #10;
        a = 4'b1010; b = 4'b0101; #10;
        a = 4'b1111; b = 4'b0001; #10;
        a = 4'b0011; b = 4'b1100; #10;

        $finish;
    end
endmodule
