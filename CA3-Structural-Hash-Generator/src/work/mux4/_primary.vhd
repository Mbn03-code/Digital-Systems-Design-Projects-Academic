library verilog;
use verilog.vl_types.all;
entity mux4 is
    generic(
        N               : integer := 1
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        c               : in     vl_logic_vector;
        d               : in     vl_logic_vector;
        sel1            : in     vl_logic;
        sel2            : in     vl_logic;
        mux4_out        : out    vl_logic_vector
    );
end mux4;
