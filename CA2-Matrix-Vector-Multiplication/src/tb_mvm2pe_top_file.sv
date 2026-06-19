`timescale 1ns/1ps
module tb_mvm2pe_top_file;
  localparam int MP=16, N=8, LANES=4, WACC=34;
  localparam int A_BASE=0, B_BASE=8, O_BASE=72;
  logic clk=0, rst=1, start=0;
  logic [6:0]      address;
  logic [WACC-1:0] r_data, w_data;
  logic            write, done;
  mvm2pe_top #(
    .MP(MP), .N(N), .LANES(LANES), .WACC(WACC),
    .A_BASE(A_BASE), .B_BASE(B_BASE), .O_BASE(O_BASE)
  ) dut (
    .clk(clk), .rst(rst), .start(start),
    .address(address), .r_data(r_data),
    .w_data(w_data), .write(write), .done(done)
  );

  simple_mem_128x34 MEM (
    .clk(clk), .address(address),
    .w_data(w_data), .write(write), .r_data(r_data)
  );
  always #5 clk = ~clk;
  string TC_FILE   = "tc_in.hex";
  string OUT_FILE  = "tc_out.hex";
  string GOLD_FILE = "";

  initial begin
    void'($value$plusargs("TC=%s",     TC_FILE));
    void'($value$plusargs("OUT=%s",    OUT_FILE));
    void'($value$plusargs("GOLDEN=%s", GOLD_FILE));
    $display("TC=%s  OUT=%s  GOLDEN=%s", TC_FILE, OUT_FILE, GOLD_FILE);
  end

  logic [WACC-1:0] golden [0:127];
  bit has_golden = 1'b0;

  int write_cnt = 0;
  always @(posedge clk) if (write) begin
    if (!(address >= O_BASE && address < O_BASE+8))
      $fatal("Write outside output range! addr=%0d", address);
    write_cnt++;
  end

  function automatic bit is_x34(input logic [33:0] v);
    return (^v === 1'bx);
  endfunction

  initial begin
    int i;
    int errors = 0;

    MEM.load_hex(TC_FILE);
    for (i = 0; i < 128; i++) golden[i] = 'x;

    if (GOLD_FILE != "") begin
      $readmemh(GOLD_FILE, golden);
      has_golden = 1'b1;
    end else begin
      $readmemh(TC_FILE, golden);
      has_golden = 1'b1;
      for (i = 0; i < 8; i++)
        if (is_x34(golden[O_BASE + i]))
          has_golden = 1'b0;
    end
    for (i = O_BASE; i < O_BASE + 8; i++)
      MEM.mem[i] = 34'hx;
    @(posedge clk); @(posedge clk); rst = 0;
    @(posedge clk); start = 1;
    @(posedge clk); start = 0;
    wait(done);
    @(posedge clk);
    if (has_golden) begin
      for (i = 0; i < 8; i++) begin
        if (MEM.mem[O_BASE + i] !== golden[O_BASE + i]) begin
          $display("Mismatch o[%0d]: got=%h expected=%h",
                   i, MEM.mem[O_BASE + i], golden[O_BASE + i]);
          errors++;
        end
      end
      if (errors == 0)
        $display("TESTCASE %s : PASS ✅", TC_FILE);
      else
        $fatal(1, "TESTCASE %s : FAIL ❌ (mismatches=%0d)", TC_FILE, errors);
    end else begin
      $display("No golden outputs available -> only dumping results.");
    end
    MEM.dump_hex_full(OUT_FILE);
    #20 $finish;
  end
endmodule