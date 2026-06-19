module F_function_8bit (
    input  wire [7:0] B,
    input  wire [7:0] C,
    input  wire [7:0] D,
    input  wire [5:0]  i,
    output wire [7:0] F
);

    wire [7:0] notB, notD;
    not_gate #(8) u_notB (.a(B), .not_out(notB));
    not_gate #(8) u_notD (.a(D), .not_out(notD));

    wire [7:0] B_and_C, notB_and_D, F0;
    and_gate #(8) u_and0 (.a(B), .b(C), .and_out(B_and_C));
    and_gate #(8) u_and1 (.a(notB), .b(D), .and_out(notB_and_D));
    or_gate  #(8) u_or0  (.a(B_and_C), .b(notB_and_D), .or_out(F0));

    wire [7:0] D_and_B, notD_and_C, F1;
    and_gate #(8) u_and2 (.a(D), .b(B), .and_out(D_and_B));
    and_gate #(8) u_and3 (.a(notD), .b(C), .and_out(notD_and_C));
    or_gate  #(8) u_or1  (.a(D_and_B), .b(notD_and_C), .or_out(F1));

    wire [7:0] B_xor_C, F2;
    xor_gate #(8) u_xor0 (.a(B), .b(C), .xor_out(B_xor_C));
    xor_gate #(8) u_xor1 (.a(B_xor_C), .b(D), .xor_out(F2));

    wire [7:0] B_or_notD, F3;
    or_gate  #(8) u_or2  (.a(B), .b(notD), .or_out(B_or_notD));
    xor_gate #(8) u_xor2 (.a(C), .b(B_or_notD), .xor_out(F3));

    wire sel1 = i[5];
    wire sel0 = i[4];

    mux4 #(8) u_muxF (
        .a(F0),
        .b(F1),
        .c(F2),
        .d(F3),
        .sel1(sel1),
        .sel2(sel0),
        .mux4_out(F)
    );

endmodule

module F_function_8bit_tb;
    reg [7:0] B, C, D;
    reg [5:0] i;
    wire [7:0] F;

    F_function_8bit uut (
        .B(B),
        .C(C),
        .D(D),
        .i(i),
        .F(F)
    );

    initial begin

        B = 8'h0A; C = 8'h05; D = 8'hFF; i = 6'b000000;
        #10;
        i = 6'b110000;
        #10;
        i = 6'b010000;
        #10;
        B = 8'hAA; C = 8'h55; D = 8'hFF; i = 6'b100000;
        #10;
        $finish;
    end
endmodule
