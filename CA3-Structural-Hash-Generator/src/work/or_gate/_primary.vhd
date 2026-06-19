library verilog;
use verilog.vl_types.all;
entity or_gate is
    generic(
        N               : integer := 1
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        or_out          : out    vl_logic_vector
    );
end or_gate;
