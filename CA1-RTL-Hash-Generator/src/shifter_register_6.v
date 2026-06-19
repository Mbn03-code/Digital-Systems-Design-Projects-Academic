module shift_register_6 (
    input  wire       clk,
    input  wire       reset,
    input  wire       load,
    input  wire       enable,
    input  wire [5:0] d_in,
    input  wire       shift_in,
    output reg  [5:0] q_out = 6'b000000
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q_out <= 6'b0;
        else if (load)
            q_out <= d_in;
        else if (enable)
            q_out <= {q_out[4:0], shift_in};
    end
endmodule
