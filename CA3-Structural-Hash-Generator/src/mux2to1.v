module mux2 #(parameter N = 1)(
    input  wire [N-1:0] a,
    input  wire [N-1:0] b,
    input  wire         sel,
    output wire [N-1:0] out
);
    genvar i;
    generate
        for(i = 0; i < N; i = i + 1) begin : mux2_gen
            c1 u_c1(
                .A0(a[i]),
                .A1(b[i]),
                .SA(sel),
                .B0(1'b0),
                .B1(1'b0),
                .SB(1'b0),
                .S0(1'b0),
                .S1(1'b0),
                .f(out[i])
            );
        end
    endgenerate
endmodule


module mux2_tb;
    reg [3:0] a, b;
    reg sel;
    wire [3:0] out;

    mux2 #(4) uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin

        a = 4'b0000; b = 4'b1111; sel = 0; #10;
        sel = 1; #10;
        a = 4'b1010; b = 4'b0101; sel = 0; #10;
        sel = 1; #10;

        $finish;
    end
endmodule
