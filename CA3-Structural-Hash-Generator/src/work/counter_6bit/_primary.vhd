library verilog;
use verilog.vl_types.all;
entity counter_6bit is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable          : in     vl_logic;
        \out\           : out    vl_logic_vector(5 downto 0);
        done            : out    vl_logic
    );
end counter_6bit;
