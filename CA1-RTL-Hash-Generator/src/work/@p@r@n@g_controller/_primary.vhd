library verilog;
use verilog.vl_types.all;
entity PRNG_controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        count_done      : in     vl_logic;
        load_reg        : out    vl_logic;
        count_enable    : out    vl_logic
    );
end PRNG_controller;
