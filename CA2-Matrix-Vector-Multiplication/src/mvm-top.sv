module mvm2pe_top #(
  parameter int MP     = 16,
  parameter int N      = 8,
  parameter int LANES  = 4,
  parameter int WACC   = 34,
  parameter int A_BASE = 0,
  parameter int B_BASE = 8,
  parameter int O_BASE = 72
)(
  input  logic                 clk,
  input  logic                 rst,
  input  logic                 start,
  output logic [6:0]           address,
  input  logic [WACC-1:0]      r_data,
  output logic [WACC-1:0]      w_data,
  output logic                 write,
  output logic                 done
);
  logic [7:0]            load_a;
  logic [3:0]            load_b0, load_b1;
  logic [$clog2(MP)-1:0] bit_idx;
  logic                  run0, run1, is_msb, is_lsb;
  mvm2pe_controller #(
    .MP(MP), .N(N), .LANES(LANES),
    .A_BASE(A_BASE), .B_BASE(B_BASE), .O_BASE(O_BASE)
  ) u_ctrl (
    .clk(clk), .rst(rst), .start(start),
    .load_a(load_a), .load_b0(load_b0), .load_b1(load_b1),
    .bit_idx(bit_idx), .run0(run0), .run1(run1),
    .is_msb(is_msb), .is_lsb(is_lsb),
    .address(address), .write(write),
    .done(done)
  );
  logic signed [WACC-1:0] row_result;
  wire [MP-1:0] r_data_mp = r_data[MP-1:0];
  mvm_datapath_2pe #(.MP(MP),.N(N),.LANES(LANES),.WACC(WACC)) u_dp (
    .clk(clk), .rst(rst),
    .mem_rdata_mp(r_data_mp),
    .load_a(load_a), .load_b0(load_b0), .load_b1(load_b1),
    .bit_idx(bit_idx), .run0(run0), .run1(run1),
    .is_msb(is_msb), .is_lsb(is_lsb),
    .row_result(row_result)
  );
  assign w_data = row_result;
endmodule
