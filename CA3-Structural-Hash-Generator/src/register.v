module register #(
    parameter N = 8
) (
    input wire clk,
    input wire reset,
    input wire ld,
    input wire [N-1:0] in,
    output wire [N-1:0] out
);

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : reg_bit
            s2 s2_inst (
                .D00(out[i]),
                .D01(in[i]),
                .D10(1'b0),
                .D11(1'b0),
                .A1(1'b0),
                .B1(1'b0),
                .A0(ld),
                .B0(1'b1),
                .clr(reset),
                .clk(clk),
                .out(out[i])
            );
        end
    endgenerate

endmodule


module register_tb;
    reg clk, reset, ld;
    reg [7:0] in;
    wire [7:0] out;

    register #(8) uut (
        .clk(clk),
        .reset(reset),
        .ld(ld),
        .in(in),
        .out(out)
    );

    initial begin

        clk = 0; reset = 1; ld = 0; in = 8'h00; #10;
        reset = 0; #10;

        ld = 1; in = 8'hA5; #10;
        ld = 0; in = 8'h00; #50;

        $finish;
    end

    always #5 clk = ~clk;
endmodule
