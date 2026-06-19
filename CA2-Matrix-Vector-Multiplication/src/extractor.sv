module a_bit_extractor #(
  parameter int MP    = 16,
  parameter int LANES = 4
)(
  input  logic [LANES*MP-1:0]   a_packed,        
  input  logic [$clog2(MP)-1:0] bit_idx,         
  output logic [LANES-1:0]      bits_out        
);
  genvar i;
  for (i = 0; i < LANES; i++) begin : G
    wire [MP-1:0] Ai = a_packed[(i+1)*MP-1 -: MP];   
    assign bits_out[i] = Ai[MP-1 - bit_idx];    
  end
endmodule