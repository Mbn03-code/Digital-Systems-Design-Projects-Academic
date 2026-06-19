library verilog;
use verilog.vl_types.all;
entity GH_controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        prng_done       : in     vl_logic;
        count_done      : in     vl_logic;
        start_prng      : out    vl_logic;
        stage_load      : out    vl_logic;
        load_init       : out    vl_logic;
        count_enable    : out    vl_logic;
        done            : out    vl_logic
    );
end GH_controller;
