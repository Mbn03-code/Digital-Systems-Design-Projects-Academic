module and_gate3 (a, b, c, and_out);
    input a, b, c;
    output and_out;
    c1 andd(.A0(1'b0), .A1(1'b0), .SA(1'b0), .B0(1'b0), .B1(a), .SB(b), .S0(c), .S1(c), .f(and_out));

endmodule