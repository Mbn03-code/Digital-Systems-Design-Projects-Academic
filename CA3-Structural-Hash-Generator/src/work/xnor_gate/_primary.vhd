library verilog;
use verilog.vl_types.all;
entity xnor_gate is
    generic(
        N               : integer := 1
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        xnor_out        : out    vl_logic_vector
    );
end xnor_gate;
