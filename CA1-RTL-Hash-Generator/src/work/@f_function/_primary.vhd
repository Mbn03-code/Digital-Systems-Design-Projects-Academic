library verilog;
use verilog.vl_types.all;
entity F_function is
    port(
        i               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        C               : in     vl_logic_vector(31 downto 0);
        D               : in     vl_logic_vector(31 downto 0);
        F               : out    vl_logic_vector(31 downto 0)
    );
end F_function;
