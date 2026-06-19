library verilog;
use verilog.vl_types.all;
entity counter_3bit is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        \out\           : out    vl_logic_vector(2 downto 0);
        done            : out    vl_logic
    );
end counter_3bit;
