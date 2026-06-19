module PRNG_controller(
    input  wire clk,
    input  wire reset,
    input  wire start,
    input  wire count_done,
    output wire load_reg,
    output wire count_enable,
    output wire done
);

    wire [3:0] st;
    wire n_start;
    wire n_count_done;

    not_gate #(1) NOT_COUNT_DONE (.a(count_done), .not_out(n_count_done));
    not_gate #(1) NOT_START      (.a(start),      .not_out(n_start));

    wire any_state;
    or_gate #(1) OR_S0S1 (.a(st[0]), .b(st[1]), .or_out(any_state));
    wire any_state_hi;
    or_gate #(1) OR_S2S3 (.a(st[2]), .b(st[3]), .or_out(any_state_hi));
    wire any_state_all;
    or_gate #(1) OR_ANY  (.a(any_state), .b(any_state_hi), .or_out(any_state_all));
    wire none_active;
    not_gate #(1) NOT_ANY (.a(any_state_all), .not_out(none_active));

    wire idle_and_nstart;
    wire done_and_nstart;
    and_gate #(1) AND_IDLE_NSTART (.a(st[0]), .b(n_start), .and_out(idle_and_nstart));
    and_gate #(1) AND_DONE_NSTART (.a(st[3]), .b(n_start), .and_out(done_and_nstart));

    wire IDLE_part;
    or_gate  #(1) OR_IDLE_PART (.a(idle_and_nstart), .b(done_and_nstart), .or_out(IDLE_part));

    wire IDLE_next;
    or_gate  #(1) OR_IDLE_FINAL (.a(none_active), .b(IDLE_part), .or_out(IDLE_next));

    wire LOAD_next;
    and_gate #(1) AND_LOAD (.a(st[0]), .b(start), .and_out(LOAD_next));

    wire shift_and_ncd;
    and_gate #(1) AND_SHIFT_NCD (.a(st[2]), .b(n_count_done), .and_out(shift_and_ncd));

    wire SHIFT_next;
    or_gate  #(1) OR_SHIFT (.a(st[1]), .b(shift_and_ncd), .or_out(SHIFT_next));

    wire DONE_next;
    and_gate #(1) AND_SHIFT_CD (.a(st[2]), .b(count_done), .and_out(DONE_next));

    s2  FF_IDLE (
        .D00(IDLE_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0),
        .clr(reset), .clk(clk), .out(st[0])
    );

    s2  FF_LOAD (
        .D00(LOAD_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0),
        .clr(reset), .clk(clk), .out(st[1])
    );

    s2  FF_SHIFT (
        .D00(SHIFT_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0),
        .clr(reset), .clk(clk), .out(st[2])
    );

    s2  FF_DONE (
        .D00(DONE_next), .D01(1'b0), .D10(1'b0), .D11(1'b0),
        .A1(1'b0), .B1(1'b0), .A0(1'b0), .B0(1'b0),
        .clr(reset), .clk(clk), .out(st[3])
    );

    assign load_reg     = st[1];
    assign count_enable = st[2];
    assign done = st[3];
endmodule


module PRNG_controller_tb;
    reg clk, reset, start, count_done;
    wire load_reg, count_enable, done;

    PRNG_controller uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .count_done(count_done),
        .load_reg(load_reg),
        .count_enable(count_enable),
        .done(done)
    );

    initial begin

        clk = 0; reset = 1; start = 0; count_done = 0; #10;
        reset = 0; #10;

        start = 1; #20;
        start = 0; #20;
        count_done = 1; #20;
        count_done = 0; #20;

        $finish;
    end

    always #5 clk = ~clk;
endmodule
