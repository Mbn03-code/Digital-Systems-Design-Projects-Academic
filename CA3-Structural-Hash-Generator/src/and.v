module and_gate #(parameter N = 1) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    output wire [N-1:0] and_out
);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : and_gen
            c1 and_gate (
                .A0(1'b0),
                .A1(1'b0),
                .SA(1'b0),
                .B0(1'b0),
                .B1(a[i]),
                .SB(1'b1),
                .S0(b[i]),
                .S1(b[i]),
                .f(and_out[i])
            );
        end
    endgenerate
endmodule

module and_gate_tb;
    reg [0:0] a, b;
    wire [0:0] and_out;

    and_gate #(1) uut (
        .a(a),
        .b(b),
        .and_out(and_out)
    );

   

    initial begin
        a = 1'b0; b = 1'b0; #10;
        a = 1'b0; b = 1'b1; #10;
        a = 1'b1; b = 1'b0; #10;
        a = 1'b1; b = 1'b1; #10;
        $finish;
    end
endmodule