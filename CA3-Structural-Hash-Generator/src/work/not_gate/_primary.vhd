library verilog;
use verilog.vl_types.all;
entity not_gate is
    generic(
        N               : integer := 1
    );
    port(
        a               : in     vl_logic_vector;
        not_out         : out    vl_logic_vector
    );
end not_gate;
