module counter_6bit (
    input  reset,
    input  clk,
    input  enable,
    output [5:0] out,
    output  done
);

    wire and01;
    and_gate #(1) a01 (.a(out[0]), .b(out[1]), .and_out(and01));

    wire and012;
    and_gate #(1) a012 (.a(and01), .b(out[2]), .and_out(and012));

    wire and0123;
    and_gate #(1) a0123 (.a(and012), .b(out[3]), .and_out(and0123));

    wire and01234;
    and_gate #(1) a01234 (.a(and0123), .b(out[4]), .and_out(and01234));

    s2 counter0 (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(1'b0), .B1(out[0]),
        .A0(1'b1), .B0(enable),
        .clr(reset), .clk(clk),
        .out(out[0])
    );

    s2 counter1 (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(1'b0), .B1(out[1]),
        .A0(out[0]), .B0(enable),
        .clr(reset), .clk(clk),
        .out(out[1])
    );

    s2 counter2 (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(1'b0), .B1(out[2]),
        .A0(and01), .B0(enable),
        .clr(reset), .clk(clk),
        .out(out[2])
    );

    s2 counter3 (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(1'b0), .B1(out[3]),
        .A0(and012), .B0(enable),
        .clr(reset), .clk(clk),
        .out(out[3])
    );

    s2 counter4 (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(1'b0), .B1(out[4]),
        .A0(and0123), .B0(enable),
        .clr(reset), .clk(clk),
        .out(out[4])
    );

    s2 counter5 (
        .D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b0),
        .A1(1'b0), .B1(out[5]),
        .A0(and01234), .B0(enable),
        .clr(reset), .clk(clk),
        .out(out[5])
    );

    wire  done_comb;

    
    and_gate #(1) a4 (.a(and01234), .b(out[5]), .and_out(done_comb));

    FDCP doneS(
        .clk(clk),
        .CLR(reset),
        .D(done_comb),
        .Q(done)
    );

endmodule


module counter_6bit_tb;
    reg clk, reset, enable;
    wire [5:0] out;
    wire done;

    counter_6bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .out(out),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        reset = 1;
        enable = 0;
        #10;
        reset = 0;
        enable = 1;

        wait(done==1);
        #40;
        $finish;
    end
endmodule
