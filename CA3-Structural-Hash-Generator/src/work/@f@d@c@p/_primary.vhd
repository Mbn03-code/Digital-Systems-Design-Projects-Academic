library verilog;
use verilog.vl_types.all;
entity FDCP is
    port(
        clk             : in     vl_logic;
        CLR             : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic
    );
end FDCP;
