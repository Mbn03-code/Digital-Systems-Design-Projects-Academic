`timescale 1ns/1ps
module tb_mvm2pe_top;
  localparam int MP=16, N=8, LANES=4, WACC=34;
  logic clk=0, rst=1, start=0;
  logic [6:0]      address;
  logic [WACC-1:0] r_data, w_data;
  logic            write, done;
  mvm2pe_top #(.MP(MP),.N(N),.LANES(LANES),.WACC(WACC),
               .A_BASE(0), .B_BASE(8), .O_BASE(72)) dut (
    .clk(clk), .rst(rst), .start(start),
    .address(address), .r_data(r_data),
    .w_data(w_data), .write(write), .done(done)
  );
  simple_mem_128x34 MEM (.clk(clk), .address(address), .w_data(w_data), .write(write), .r_data(r_data));
  always #5 clk = ~clk;
  function automatic [33:0] sx16(input shortint v);
    sx16 = {{18{v[15]}}, v[15:0]};
  endfunction
  initial begin
    @(posedge clk); @(posedge clk); rst=0;
    MEM.mem[0] = sx16(1);
    MEM.mem[1] = sx16(3);
    MEM.mem[2] = sx16(6);
    MEM.mem[3] = sx16(2);
    MEM.mem[4] = sx16(1);
    MEM.mem[5] = sx16(-4);
    MEM.mem[6] = sx16(6);
    MEM.mem[7] = sx16(3);
    MEM.mem[8 + 0] = sx16(3);
    MEM.mem[8 + 1] = sx16(5);
    MEM.mem[8 + 2] = sx16(5);
    MEM.mem[8 + 3] = sx16(1);
    MEM.mem[8 + 4] = sx16(0);
    MEM.mem[8 + 5] = sx16(0);
    MEM.mem[8 + 6] = sx16(0);
    MEM.mem[8 + 7] = sx16(0);
    for (int c=0;c<4;c++) MEM.mem[16 + c] = sx16(0);
    MEM.mem[16 + 4] = sx16(2);
    MEM.mem[16 + 5] = sx16(6);
    MEM.mem[16 + 6] = sx16(-1);
    MEM.mem[16 + 7] = sx16(7);
    for (int r=2; r<8; r++)
      for (int c=0; c<8; c++)
        MEM.mem[8 + r*8 + c] = sx16(0);
    @(posedge clk); start=1;
    @(posedge clk); start=0;
    wait(done);
    @(posedge clk); 
    $display("o0=%0d (expect 50)",  $signed(MEM.mem[72]));
    $display("o1=%0d (expect -7)",  $signed(MEM.mem[73]));
    for (int i=2;i<8;i++)
      $display("o%0d=%0d (expect 0)", i, $signed(MEM.mem[72+i]));
    #20 $finish;
  end
endmodule