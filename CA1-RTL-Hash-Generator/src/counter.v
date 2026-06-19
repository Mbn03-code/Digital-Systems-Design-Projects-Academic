
module counter #(
    parameter WIDTH = 6,
    parameter MAX_VALUE = (1 << WIDTH) - 1
)(
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [WIDTH-1:0] count,
    output reg done
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            done <= 0;
        end 
        else if (enable) begin
            if (count == MAX_VALUE) begin
                done <= 1'b1;  
                count <= 0;     
            end 
            else begin
                done <= 1'b0;
                count <= count + 1'b1;
            end
        end 
        else begin
            done <= 0;
        end
    end

endmodule 