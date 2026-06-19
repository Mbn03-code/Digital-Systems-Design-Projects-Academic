library verilog;
use verilog.vl_types.all;
entity adder4x8 is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        c               : in     vl_logic_vector(7 downto 0);
        d               : in     vl_logic_vector(7 downto 0);
        sum             : out    vl_logic_vector(7 downto 0);
        cout            : out    vl_logic
    );
end adder4x8;
