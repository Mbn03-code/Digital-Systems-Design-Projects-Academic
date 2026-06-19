library verilog;
use verilog.vl_types.all;
entity mux2 is
    generic(
        N               : integer := 1
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
end mux2;
