module pe_accum #(
  parameter int WACC = 34
)(
  input  logic                   clk,
  input  logic                   rst,
  input  logic                   i_valid,
  input  logic                   i_is_msb,
  input  logic                   i_is_lsb,
  input  logic signed [WACC-1:0] addend,        
  input  logic signed [WACC-1:0] initial_sum,  
  output logic signed [WACC-1:0] acc
);
always_ff @(posedge clk or posedge rst) begin
  if (rst) acc <= '0;
  else if (i_valid) begin
    logic signed [WACC-1:0] to_add;
    to_add = addend + (i_is_lsb ? initial_sum : '0);
    if (i_is_msb)
      acc <= to_add;
    else
      acc <= (acc <<< 1) + to_add;
  end
end
endmodule