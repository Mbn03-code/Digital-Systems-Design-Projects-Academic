module F_function (
    input [5:0] i,        
    input [7:0] B,       
    input [7:0] C,      
    input [7:0] D,      
    output reg [7:0] F   
);

always @(*) begin
    
       if (i >= 0 && i <= 15) begin
           F = (B & C) | ((~B) & D);
       end
       else if (i >= 16 && i <= 31) begin
           F = (D & B) | ((~D) & C);
       end
       else if (i >= 32 && i <= 47) begin
           F = B ^ C ^ D;
       end
       else if (i >= 48 && i <= 63) begin
           F = C ^ (B | (~D));
       end
       else F = 32'b0;

end

endmodule
