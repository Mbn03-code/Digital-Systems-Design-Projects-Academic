module adder #(
    parameter WIDTH = 32,
    parameter N     = 4
)(
    input  wire [WIDTH*N-1:0] numbers, 
    output reg  [WIDTH-1:0]   SUM      
);

    integer i;
    reg [WIDTH-1:0] temp;
    reg [WIDTH-1:0] arr [0:N-1]; 

    always @(*) begin
          for (i = 0; i < N; i = i + 1) begin
              arr[i] = numbers[WIDTH*(N-i)-1 -: WIDTH];
          end

        
          temp = 0;
          for (i = 0; i < N; i = i + 1) begin
              temp = temp + arr[i];
          end

          SUM = temp;
          end

endmodule


