module stripes_pe #(
  parameter int MP    = 16,  
  parameter int LANES = 4,    
  parameter int WACC  = 34    
)(
  input  logic                       clk,
  input  logic                       rst,
  input  logic [LANES*MP-1:0]        i_vec_b,       
  input  logic [LANES-1:0]           i_vec_a_bits,  
  input  logic signed [WACC-1:0]     i_initial_sum, 
  input  logic                       i_valid,
  input  logic                       i_is_msb,
  input  logic                       i_is_lsb,
  output logic signed [WACC-1:0]     o_dot_product
);
  logic signed [WACC-1:0] Bext [LANES-1:0];
  genvar k;
  for (k = 0; k < LANES; k++) begin : g_bext
    wire [MP-1:0] bk = i_vec_b[(k+1)*MP-1 -: MP];
    assign Bext[k] = {{(WACC-MP){bk[MP-1]}}, bk};
  end
  logic signed [WACC-1:0] add_pos;
  always_comb begin
    add_pos = '0;
    for (int j = 0; j < LANES; j++) begin
      if (i_vec_a_bits[j]) add_pos = add_pos + Bext[j];
    end
  end
  wire logic signed [WACC-1:0] addend = i_is_msb ? -add_pos : add_pos;
  logic signed [WACC-1:0] acc_int;
  pe_accum #(.WACC(WACC)) u_acc (
    .clk(clk), .rst(rst),
    .i_valid(i_valid), .i_is_msb(i_is_msb), .i_is_lsb(i_is_lsb),
    .addend(addend), .initial_sum(i_initial_sum),
    .acc(acc_int)
  );
  assign o_dot_product = acc_int;
endmodule