library verilog;
use verilog.vl_types.all;
entity adder is
    generic(
        WIDTH           : integer := 8;
        N               : integer := 4
    );
    port(
        numbers         : in     vl_logic_vector;
        sum             : out    vl_logic_vector
    );
end adder;
