library verilog;
use verilog.vl_types.all;
entity mult4x4 is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        P               : out    vl_logic_vector(7 downto 0)
    );
end mult4x4;
