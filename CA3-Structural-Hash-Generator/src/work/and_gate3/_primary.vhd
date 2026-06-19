library verilog;
use verilog.vl_types.all;
entity and_gate3 is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        and_out         : out    vl_logic
    );
end and_gate3;
