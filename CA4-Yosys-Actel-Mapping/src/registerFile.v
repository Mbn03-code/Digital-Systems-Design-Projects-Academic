module registerFile (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] data_in,
    input  wire        write_en,
    input  wire [1:0]  read_addr,
    output reg  [7:0]  read_data
);

    // 4 registers each 8-bit
    reg [7:0] regfile [0:3];

    integer i;

    // Write logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1)
                regfile[i] <= 8'b0;
        end
        else if (write_en) begin
            regfile[0] <= data_in[31:24];
            regfile[1] <= data_in[23:16];
            regfile[2] <= data_in[15:8];
            regfile[3] <= data_in[7:0];
        end
    end

    // Read logic (combinational)
    always @(*) begin
        case (read_addr)
            2'b00: read_data = regfile[0];
            2'b01: read_data = regfile[1];
            2'b10: read_data = regfile[2];
            2'b11: read_data = regfile[3];
            default: read_data = 8'b0;
        endcase
    end

endmodule
