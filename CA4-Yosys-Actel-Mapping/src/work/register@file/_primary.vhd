library verilog;
use verilog.vl_types.all;
entity registerFile is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data_in         : in     vl_logic_vector(31 downto 0);
        write_en        : in     vl_logic;
        read_addr       : in     vl_logic_vector(1 downto 0);
        read_data       : out    vl_logic_vector(7 downto 0)
    );
end registerFile;
