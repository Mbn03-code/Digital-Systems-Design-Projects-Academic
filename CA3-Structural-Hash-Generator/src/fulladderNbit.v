module adder_n #(parameter N=8)(
    input wire [N-1:0] a,
    input wire [N-1:0] b,
    input wire cin,
    output wire [N-1:0] sum,
    output wire cout
);
    wire [N:0] carry;
    wire [N-1:0] sum_c;

    assign carry[0] = cin;

    genvar i;
    generate
        for(i=0; i<N; i=i+1) begin:fa_gen
            fulladder1bit fa(
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum_c[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate
    assign sum =sum_c;
    assign cout = carry[N];
endmodule



module adder_n_tb;
    reg  [7:0] a, b;
    reg        cin;
    wire [7:0] sum;
    wire       cout;

    adder_n #(8) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin

        a = 8'h00; b = 8'h00; cin = 0; #10;
        a = 8'h01; b = 8'h02; cin = 0; #10;
        a = 8'hFF; b = 8'h01; cin = 0; #10;
        a = 8'hAA; b = 8'h55; cin = 1; #10;
        a = 8'h80; b = 8'h80; cin = 1; #10;

        $finish;
    end
endmodule
