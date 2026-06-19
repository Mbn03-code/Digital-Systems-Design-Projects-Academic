module simple_mem_128x34 (
  input  logic         clk,
  input  logic [6:0]   address,
  input  logic [33:0]  w_data,
  input  logic         write,
  output logic [33:0]  r_data
);
  logic [33:0] mem [0:127];

  assign r_data = mem[address];

  always_ff @(posedge clk) if (write) mem[address] <= w_data;
  task automatic init_x();
    for (int i=0; i<128; i++) mem[i] = 34'hx;
  endtask
  task automatic load_hex(input string path);
    init_x();                      
    $display("MEM: loading %s", path);
    $readmemh(path, mem);
  endtask
  task automatic dump_hex_full(input string path);
    int fd;
    fd = $fopen(path, "w");
    if (fd == 0) begin
      $display("MEM: cannot open %s for write", path);
      return;
    end
    $fdisplay(fd, "// memory data file (do not edit the following line - required for mem load use)");
    $fdisplay(fd, "// instance=/MVMPU_TB/memory");
    $fdisplay(fd, "// format=hex addressradix=h dataradix=h version=1.0 wordsperline=1 noaddress");

    for (int i=0; i<128; i++) begin
      if (^mem[i] === 1'bx)  $fdisplay(fd, "xxxxxxxxx");
      else                   $fdisplay(fd, "%09h", mem[i]); // 9-hex-lowercase, zero-padded
    end
    $fclose(fd);
    $display("MEM: dump -> %s", path);
  endtask
  function automatic void poke(input int idx, input logic signed [15:0] val16);
    mem[idx] = {{18{val16[15]}}, val16}; // sign-extend 16→34
  endfunction
  function automatic logic [33:0] peek(input int idx);
    return mem[idx];
  endfunction
endmodule