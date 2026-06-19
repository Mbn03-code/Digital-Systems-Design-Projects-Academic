library verilog;
use verilog.vl_types.all;
entity shift_register_6 is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic;
        enable          : in     vl_logic;
        d_in            : in     vl_logic_vector(5 downto 0);
        shift_in        : in     vl_logic;
        q_out           : out    vl_logic_vector(5 downto 0)
    );
end shift_register_6;
