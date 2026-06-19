module mult4x4 (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [7:0] P
);

    wire [7:0] pp0, pp1, pp2, pp3;
    wire [7:0] sum1, sum2;
    wire c1, c2, c3;

    mux2 #(8) mux0 (
        .a(8'b0),
        .b({4'b0, A}),
        .sel(B[0]),
        .out(pp0)
    );

    mux2 #(8) mux1 (
        .a(8'b0),
        .b({3'b0, A, 1'b0}),
        .sel(B[1]),
        .out(pp1)
    );

    mux2 #(8) mux2 (
        .a(8'b0),
        .b({2'b0, A, 2'b0}),
        .sel(B[2]),
        .out(pp2)
    );

    mux2 #(8) mux3 (
        .a(8'b0),
        .b({1'b0, A, 3'b0}),
        .sel(B[3]),
        .out(pp3)
    );

    adder_n #(8) adder_ab (
        .a(pp0),
        .b(pp1),
        .cin(1'b0),
        .sum(sum1),
        .cout(c1)
    );

    adder_n #(8) adder_abc (
        .a(sum1),
        .b(pp2),
        .cin(c1),
        .sum(sum2),
        .cout(c2)
    );

    adder_n #(8) adder_abcd (
        .a(sum2),
        .b(pp3),
        .cin(c2),
        .sum(P),
        .cout(c3)
    );
   

endmodule


module mult4x4_tb;
    reg [3:0] A, B;
    wire [7:0] P;

    mult4x4 uut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin

        A = 4'b0000; B = 4'b0000; #10;
        A = 4'b0011; B = 4'b0101; #10;
        A = 4'b1111; B = 4'b1111; #10;

        $finish;
    end
endmodule
