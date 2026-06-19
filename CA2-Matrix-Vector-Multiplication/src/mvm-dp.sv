module mvm_datapath_2pe #(
  parameter int MP    = 16,
  parameter int N     = 8,   
  parameter int LANES = 4,    
  parameter int WACC  = 34
)(
  input  logic                       clk,
  input  logic                       rst,
  input  logic [MP-1:0]              mem_rdata_mp,  
  input  logic [7:0]                 load_a,       
  input  logic [3:0]                 load_b0,       
  input  logic [3:0]                 load_b1,      
  input  logic [$clog2(MP)-1:0]      bit_idx,
  input  logic                       run0,         
  input  logic                       run1,         
  input  logic                       is_msb,
  input  logic                       is_lsb,
  output logic signed [WACC-1:0]     row_result
);
  logic [MP-1:0] Areg [7:0];
  for (genvar i = 0; i < 8; i++) begin : g_areg
    reg_en #(.W(MP)) u_areg (.clk(clk), .rst(rst), .en(load_a[i]),
                             .d(mem_rdata_mp), .q(Areg[i]));
  end
  wire [LANES*MP-1:0] A_pack0 = {Areg[3], Areg[2], Areg[1], Areg[0]};
  wire [LANES*MP-1:0] A_pack1 = {Areg[7], Areg[6], Areg[5], Areg[4]};
  wire [LANES-1:0] A_bits0, A_bits1;
  a_bit_extractor #(.MP(MP), .LANES(LANES)) u_ex0 (.a_packed(A_pack0), .bit_idx(bit_idx), .bits_out(A_bits0));
  a_bit_extractor #(.MP(MP), .LANES(LANES)) u_ex1 (.a_packed(A_pack1), .bit_idx(bit_idx), .bits_out(A_bits1));
  logic [MP-1:0] B0 [LANES-1:0];
  logic [MP-1:0] B1 [LANES-1:0];
  for (genvar b = 0; b < LANES; b++) begin : g_b0
    reg_en #(.W(MP)) u_b0 (.clk(clk), .rst(rst), .en(load_b0[b]),
                           .d(mem_rdata_mp), .q(B0[b]));
  end
  for (genvar b = 0; b < LANES; b++) begin : g_b1
    reg_en #(.W(MP)) u_b1 (.clk(clk), .rst(rst), .en(load_b1[b]),
                           .d(mem_rdata_mp), .q(B1[b]));
  end

  wire [LANES*MP-1:0] B_pack0 = {B0[3], B0[2], B0[1], B0[0]};
  wire [LANES*MP-1:0] B_pack1 = {B1[3], B1[2], B1[1], B1[0]};
  logic signed [WACC-1:0] pe1_out, pe2_out; 
  stripes_pe #(.MP(MP), .LANES(LANES), .WACC(WACC)) PE1 (
    .clk(clk), .rst(rst),
    .i_vec_b(B_pack0), .i_vec_a_bits(A_bits0),
    .i_initial_sum('0), .i_valid(run0), .i_is_msb(is_msb), .i_is_lsb(is_lsb),
    .o_dot_product(pe1_out)
  );
  stripes_pe #(.MP(MP), .LANES(LANES), .WACC(WACC)) PE2 (
    .clk(clk), .rst(rst),
    .i_vec_b(B_pack1), .i_vec_a_bits(A_bits1),
    .i_initial_sum(pe1_out), .i_valid(run1), .i_is_msb(is_msb), .i_is_lsb(is_lsb),
    .o_dot_product(pe2_out)
  );
  assign row_result = pe2_out;  
endmodule