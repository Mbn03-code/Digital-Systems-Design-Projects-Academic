library verilog;
use verilog.vl_types.all;
entity PRNG_controller is
    generic(
        S_IDLE          : integer := 0;
        S_LOAD          : integer := 1;
        S_SHIFT         : integer := 2;
        S_DONE          : integer := 3
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        count_done      : in     vl_logic;
        load_reg        : out    vl_logic;
        count_enable    : out    vl_logic;
        done            : out    vl_logic
    );
end PRNG_controller;
