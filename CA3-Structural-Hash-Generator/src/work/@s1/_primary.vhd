library verilog;
use verilog.vl_types.all;
entity S1 is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        D2              : in     vl_logic;
        D3              : in     vl_logic;
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        A0              : in     vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        \out\           : out    vl_logic
    );
end S1;
