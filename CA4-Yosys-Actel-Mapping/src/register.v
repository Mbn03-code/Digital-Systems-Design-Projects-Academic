module register #(parameter WIDTH =8 )(
input wire clk,
input wire reset,
input wire load,
input wire [WIDTH-1:0] d_in,
output reg [WIDTH-1:0] q_out
);
always @(posedge clk or posedge reset) begin
    if (reset)
        q_out <= {WIDTH{1'b0}};
    else if (load)
        q_out <= d_in;
end
endmodule
