library verilog;
use verilog.vl_types.all;
entity GH_datapath is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data_in         : in     vl_logic_vector(127 downto 0);
        count           : in     vl_logic_vector(5 downto 0);
        start_prng      : in     vl_logic;
        prng_done       : out    vl_logic;
        stage_load      : in     vl_logic;
        stage_sel       : in     vl_logic_vector(2 downto 0);
        load_init       : in     vl_logic;
        data_out        : out    vl_logic_vector(127 downto 0)
    );
end GH_datapath;
