module not_gate #(parameter N = 1) (
    input  wire [N-1:0] a,
    output wire [N-1:0] not_out
);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : not_gen
            c1 not_gate (
                .A0(1'b1),
                .A1(1'b1),
                .SA(1'b1),
                .B0(1'b0),
                .B1(1'b0),
                .SB(1'b0),
                .S0(a[i]),
                .S1(a[i]),
                .f(not_out[i])
            );
        end
    endgenerate
endmodule

module not_gate_tb;
    reg [3:0] a;
    wire [3:0] not_out;

    not_gate #(4) uut (
        .a(a),
        .not_out(not_out)
    );

    initial begin

        a = 4'b0000; #10;
        a = 4'b1010; #10;
        a = 4'b1111; #10;

        $finish;
    end
endmodule
