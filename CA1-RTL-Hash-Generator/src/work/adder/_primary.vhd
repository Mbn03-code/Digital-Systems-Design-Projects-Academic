library verilog;
use verilog.vl_types.all;
entity adder is
    generic(
        WIDTH           : integer := 32;
        N               : integer := 4
    );
    port(
        numbers         : in     vl_logic_vector;
        SUM             : out    vl_logic_vector
    );
end adder;
