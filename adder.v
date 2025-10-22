module adder #(
    parameter WIDTH = 16,
    parameter LENGTH = 8
)(
    input  wire [WIDTH*LENGTH-1:0] numbers,  // flatten array input
    output reg  [WIDTH-1:0]        sum
);

integer i;
reg [WIDTH-1:0] temp;

always @(*) begin
    temp = {WIDTH{1'b0}};
    for (i = 0; i < LENGTH; i = i + 1) begin
        temp = temp + numbers[i*WIDTH +: WIDTH];  // slice هر عدد
    end
    sum = temp;
end

endmodule
