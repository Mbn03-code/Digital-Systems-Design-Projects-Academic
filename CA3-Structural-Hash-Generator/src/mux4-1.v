module mux4 #(parameter N = 1) (
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire [N-1:0] c,
    input  wire [N-1:0] d,
    input  wire  sel1,
    input  wire  sel2,
    output wire [N-1:0] mux4_out
);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : mux4_gen
            c2 mux4_gate (
                .D00(a[i]),
                .D01(b[i]),
                .D10(c[i]),
                .D11(d[i]),
                .A1(1'b0),
                .B1(sel1),
                .A0(1'b1),
                .B0(sel2),
                .out(mux4_out[i])
            );
        end
    endgenerate
endmodule

module mux4_tb;
    reg [3:0] a, b, c, d;
    reg sel1, sel2;
    wire [3:0] mux4_out;

    mux4 #(4) uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel1(sel1),
        .sel2(sel2),
        .mux4_out(mux4_out)
    );

    initial begin

        a = 4'b0001; b = 4'b0010; c = 4'b0100; d = 4'b1000;
        sel1 = 0; sel2 = 0; #10;
        sel1 = 0; sel2 = 1; #10;
        sel1 = 1; sel2 = 0; #10;
        sel1 = 1; sel2 = 1; #10;

        $finish;
    end
endmodule
