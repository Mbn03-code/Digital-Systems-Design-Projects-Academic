module register #(
    parameter WIDTH = 16
)(
    input wire clk,
    input wire reset,        // asynchronous reset
    input wire [WIDTH-1:0] sum,
    input wire [WIDTH-1:0] initial_sum,
    input wire i_valid,
    input wire i_is_lsb,
    output reg [WIDTH-1:0] reg_acc
);

always @(posedge clk or posedge reset) begin
    if (reset)
        reg_acc <= {WIDTH{1'b0}};
    else if (i_valid)
        reg_acc <= reg_acc + sum;

    else if(i_is_lsb)
        reg_acc <= reg_acc + initial_sum;
end

endmodule
