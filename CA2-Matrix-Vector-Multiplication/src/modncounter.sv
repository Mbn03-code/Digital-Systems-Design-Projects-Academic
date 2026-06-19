module modN_counter #(
  parameter int N = 16
) (
  input  logic clk,
  input  logic rst,
  input  logic en,
  output logic [$clog2(N)-1:0] value,   
  output logic                 last    
);
  always_ff @(posedge clk or posedge rst) begin
    if (rst) value <= '0;
    else if (en) begin
      if (value == N-1) value <= '0;
      else               value <= value + 1'b1;
    end
  end
  assign last = en && (value == N-1);
endmodule