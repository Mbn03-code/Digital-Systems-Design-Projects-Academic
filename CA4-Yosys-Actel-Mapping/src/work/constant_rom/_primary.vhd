library verilog;
use verilog.vl_types.all;
entity constant_rom is
    port(
        addr            : in     vl_logic_vector(5 downto 0);
        data            : out    vl_logic_vector(7 downto 0)
    );
end constant_rom;
