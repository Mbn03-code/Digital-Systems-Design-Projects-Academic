library verilog;
use verilog.vl_types.all;
entity rotate is
    port(
        F               : in     vl_logic_vector(31 downto 0);
        i               : in     vl_logic_vector(5 downto 0);
        rotated_f       : out    vl_logic_vector(31 downto 0)
    );
end rotate;
