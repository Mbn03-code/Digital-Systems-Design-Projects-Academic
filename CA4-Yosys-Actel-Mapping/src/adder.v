module adder #(
    parameter WIDTH = 8,
    parameter N     = 4
)(
    input  wire [WIDTH*N-1:0] numbers,
    output reg  [WIDTH-1:0]   sum
);

    integer i;

    always @(*) begin
        sum = 0;
        for (i = 0; i < N; i = i + 1) begin
            sum = sum + numbers[i*WIDTH +: WIDTH];
        end
    end

endmodule
