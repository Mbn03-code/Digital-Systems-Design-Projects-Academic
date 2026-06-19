module mvm2pe_controller #(
  parameter int MP     = 16,
  parameter int N      = 8,
  parameter int LANES  = 4,
  parameter int A_BASE = 0,    
  parameter int B_BASE = 8,    
  parameter int O_BASE = 72   
)(
  input  logic clk, rst, start,
  output logic [7:0]              load_a,
  output logic [3:0]              load_b0,
  output logic [3:0]              load_b1,
  output logic [$clog2(MP)-1:0]   bit_idx,
  output logic                    run0, run1,
  output logic                    is_msb, is_lsb,
  output logic [6:0]              address,
  output logic                    write,

  output logic                    done
);
  typedef enum logic [3:0] {
    IDLE, LOAD_A, LOAD_B0, RUN0, LOAD_B1, RUN1, WRITE_O, NEXTROW, DONE
  } state_t;

  state_t st, nx;
  logic [2:0] row;
  logic [2:0] idxA;
  logic [1:0] idxB;
  logic [$clog2(MP)-1:0] bitcnt;
  always_ff @(posedge clk or posedge rst) begin
    if (rst) bitcnt <= '0;
    else if (st==RUN0 || st==RUN1) begin
      if (bitcnt == MP-1) bitcnt <= '0;
      else                 bitcnt <= bitcnt + 1'b1;
    end else bitcnt <= '0;
  end

  assign bit_idx = bitcnt;
  assign is_msb  = (st==RUN0 || st==RUN1) && (bitcnt=='0);
  assign is_lsb  = (st==RUN0 || st==RUN1) && (bitcnt==MP-1);
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      st   <= IDLE; row <= '0; idxA <= '0; idxB <= '0;
    end else begin
      st <= nx;

      if (st==LOAD_A && idxA!=3'd7) idxA <= idxA + 1'b1;
      else if (st!=LOAD_A)          idxA <= '0;

      if ((st==LOAD_B0 || st==LOAD_B1) && idxB!=2'd3) idxB <= idxB + 1'b1;
      else if (st!=LOAD_B0 && st!=LOAD_B1)            idxB <= '0;

      if (st==NEXTROW)   row <= row + 1'b1;
      else if (st==DONE) row <= '0;  
    end
  end
  always_comb begin
    load_a='0; load_b0='0; load_b1='0;
    run0=0; run1=0; write=0; address='0; done=0; nx=st;

    unique case (st)
      IDLE:      if (start) nx = LOAD_A;

      LOAD_A: begin
        address = A_BASE + idxA;
        load_a[idxA] = 1'b1;
        if (idxA == 3'd7) nx = LOAD_B0;
      end

      LOAD_B0: begin
        address = B_BASE + row*8 + idxB;
        load_b0[idxB] = 1'b1;
        if (idxB == 2'd3) nx = RUN0;
      end

      RUN0: begin
        run0 = 1;
        if (bitcnt == MP-1) nx = LOAD_B1;
      end

      LOAD_B1: begin
        address = B_BASE + row*8 + 4 + idxB;
        load_b1[idxB] = 1'b1;
        if (idxB == 2'd3) nx = RUN1;
      end

      RUN1: begin
        run1 = 1;
        if (bitcnt == MP-1) nx = WRITE_O;
      end

      WRITE_O: begin
        write   = 1;
        address = O_BASE + row;
        nx      = (row == 3'd7) ? DONE : NEXTROW;
      end
      NEXTROW: nx = LOAD_B0;

      DONE: begin
        done = 1;     
        nx   = IDLE;
      end
    endcase
  end
endmodule