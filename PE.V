
module PE (
   parameter MP =16,
   parameter W = 34,
   parameter L = 4
)(

   input wire clk, 
   input wire reset,
   
   input wire [(MP * L) -1 : 0] i_vec_B,
   input wire [L -1 : 0] i_vec_A_bits,
   
   input wire [W -1 :0] initial_sum,
   
   input wire i_valid,
   input wire i_is_msb,
   input wire i_is_lsb,

   output reg [W-1 :0] o_dot_product
);

    integer i;
    reg [MP -1 :0] B [L-1:0];
    generate
        for (i=0 ;i<L ; i++){
            if(a[i])
                 B[i] = i_vec_B[i*MP :i*MP + MP]

            else if(a[i] and i_is_msb)
                B[i] = ~i_vec_B[i*MP :i*MP + MP]+1
             else
                 B[i] = MP'd0;
        }
    end generate

    wire [0:16]sum_B;
    .adder add_B(
        .numbers(B),
        .sum(sum_B)
    )

    reg [W-1:0]reg_acc;
    .register acc_register(
        .clk(clk)
        .reset(reset),
        .sum(sum_B),
        .initial_sum(initial_sum),
        .i_valid(i_valid),
        .i_is_lsb(i_is_lsb),
        .reg_acc(reg_acc)
    )


endmodule