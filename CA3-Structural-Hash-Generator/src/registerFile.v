module regfile4x8_parallel (
    input  wire        clk,
   input  wire        reset,
    input  wire [31:0] data_in,
    input  wire        write_en,
    input  wire [1:0]  read_addr,
    output wire [7:0]  read_data
);

    wire [7:0] r0_out, r1_out, r2_out, r3_out;

    register #(8) r0 (
        .clk(clk),
        .reset(reset),
        .ld(write_en),
        .in(data_in[31:24]),
        .out(r0_out)
    );

    register #(8) r1 (
        .clk(clk),
        .reset(reset),
        .ld(write_en),
        .in(data_in[23:16]),
        .out(r1_out)
    );

    register #(8) r2 (
        .clk(clk),
        .reset(reset),
        .ld(write_en),
        .in(data_in[15:8]),
        .out(r2_out)
    );

    register #(8) r3 (
        .clk(clk),
        .reset(reset),
        .ld(write_en),
        .in(data_in[7:0]),
        .out(r3_out)
    );

    mux4 #(8) read_mux (
        .a(r0_out),
        .b(r1_out),
        .c(r2_out),
        .d(r3_out),
        .sel1(read_addr[1]),
        .sel2(read_addr[0]),
        .mux4_out(read_data)
    );

endmodule


module regfile4x8_parallel_tb;
    reg clk, reset, write_en;
    reg [31:0] data_in;
    reg [1:0] read_addr;
    wire [7:0] read_data;

    regfile4x8_parallel uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .write_en(write_en),
        .read_addr(read_addr),
        .read_data(read_data)
    );

    initial begin

        clk = 0; reset = 1; write_en = 0; data_in = 32'h00000000; read_addr = 2'b00; #10;
        reset = 0; #10;

        write_en = 1; data_in = 32'hA1B2C3D4; #10;
        write_en = 0; #10;

        read_addr = 2'b00; #10;
        read_addr = 2'b01; #10;
        read_addr = 2'b10; #10;
        read_addr = 2'b11; #10;

        $finish;
    end

    always #5 clk = ~clk;
endmodule