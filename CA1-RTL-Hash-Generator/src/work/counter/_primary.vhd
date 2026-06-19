library verilog;
use verilog.vl_types.all;
entity counter is
    generic(
        WIDTH           : integer := 6
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        count           : out    vl_logic_vector;
        done            : out    vl_logic
    );
end counter;
