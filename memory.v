module memory(
    parameter WW = 34,
    parameter D=128
)(
    input wire clk,
    input wire reset,
    input wire [$clog2(D)-1:0]address,
    input wire [WW-1:0]w_data,
    input wire write,

    output wire [WW-1:0]r_data
);

    reg [WW-1 :0] MEM [0: D-1];

    integer i;

    always @(posedge clk negedge reset) begin 
        if (reset) begin
            for( i=0 ; i< N ;i++)
                MEM [i] <= {w{1'b0}};
        end
        else if(write) begin 
            mem[address] <= w_data;
        end
    end


    always @(posedge clk negedge reset) begin
        r_data <= mem[address];
    end
endmodule