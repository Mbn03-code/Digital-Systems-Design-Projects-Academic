library verilog;
use verilog.vl_types.all;
entity PRNG is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        data_in         : in     vl_logic_vector(5 downto 0);
        rnd_out         : out    vl_logic_vector(1 downto 0);
        done            : out    vl_logic
    );
end PRNG;
