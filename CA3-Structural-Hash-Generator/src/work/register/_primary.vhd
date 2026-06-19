library verilog;
use verilog.vl_types.all;
entity \register\ is
    generic(
        N               : integer := 8
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        ld              : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
end \register\;
