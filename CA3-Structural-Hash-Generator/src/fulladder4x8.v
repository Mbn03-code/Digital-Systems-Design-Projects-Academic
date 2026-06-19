module adder4x8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [7:0] c,
    input  wire [7:0] d,
    output wire [7:0] sum,
    output wire       cout
);
    wire [7:0] sum1, sum2;
    wire       c1, c2;

   
    adder_n #(8) adder_ab (
        .a(a),
        .b(b),
        .cin(1'b0),
        .sum(sum1),
        .cout(c1)
    );

    adder_n #(8) adder_abc (
        .a(sum1),
        .b(c),
        .cin(1'b0),
        .sum(sum2),
        .cout(c2)
    );

    adder_n #(8) adder_abcd (
        .a(sum2),
        .b(d),
        .cin(1'b0),
        .sum(sum),
        .cout(cout)
    );
endmodule

module adder4x8_tb;
    reg  [7:0] a, b, c, d;
    wire [7:0] sum;
    wire cout;

    adder4x8 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sum(sum),
        .cout(cout)
    );

    initial begin

        a = 8'h01; b = 8'h02; c = 8'h03; d = 8'h04; #10;
        a = 8'hFF; b = 8'h01; c = 8'h00; d = 8'h00; #10;
        a = 8'hAA; b = 8'h55; c = 8'hAA; d = 8'h55; #10;
        a = 8'h00; b = 8'h00; c = 8'h00; d = 8'h00; #10;

        $finish;
    end
endmodule
