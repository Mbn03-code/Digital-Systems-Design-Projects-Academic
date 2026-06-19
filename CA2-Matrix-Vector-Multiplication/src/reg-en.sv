module reg_en #(
  parameter int W = 16
)(
  input  logic         clk,
  input  logic         rst,
  input  logic         en,
  input  logic [W-1:0] d,
  output logic [W-1:0] q
);
  always_ff @(posedge clk or posedge rst) begin
    if (rst) q <= '0;
    else if (en) q <= d;
  end
endmodule