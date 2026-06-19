library verilog;
use verilog.vl_types.all;
entity \register\ is
    generic(
        WIDTH           : integer := 8
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic;
        d_in            : in     vl_logic_vector;
        q_out           : out    vl_logic_vector
    );
end \register\;
