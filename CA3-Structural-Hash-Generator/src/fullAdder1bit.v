module fulladder1bit (input a, b, cin, output sum, cout);
    wire not_cin;
    not_gate not_g (.a(cin), .not_out(not_cin));
    c1 sum_carry1 (.A0(1'b0), .A1(b), .SA(a), .B0(a), .B1(1'b1), .SB(b), .S0(cin), .S1(cin), .f(cout));
    c2 sum_carry2 (.D00(cin), .D01(not_cin), .D10(not_cin), .D11(cin), .A1(b), .B1(1'b0), .A0(a), .B0(1'b1), .out(sum));
endmodule

module fulladder1bit_tb;
    reg a, b, cin;
    wire sum, cout;

    fulladder1bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin

        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 1; #10;
        $finish;
    end
endmodule
