library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        i1              : in     vl_logic_vector(31 downto 0);
        i2              : in     vl_logic_vector(31 downto 0);
        i3              : in     vl_logic_vector(31 downto 0);
        i4              : in     vl_logic_vector(31 downto 0);
        alu1_sel1       : in     vl_logic_vector(3 downto 0);
        alu1_sel2       : in     vl_logic_vector(3 downto 0);
        alu1_op         : in     vl_logic_vector(0 downto 0);
        alu2_sel1       : in     vl_logic_vector(3 downto 0);
        alu2_sel2       : in     vl_logic_vector(3 downto 0);
        alu2_op         : in     vl_logic_vector(0 downto 0);
        mul1_sel1       : in     vl_logic_vector(3 downto 0);
        mul1_sel2       : in     vl_logic_vector(3 downto 0);
        mul1_op         : in     vl_logic_vector(1 downto 0);
        log1_sel1       : in     vl_logic_vector(3 downto 0);
        log1_sel2       : in     vl_logic_vector(3 downto 0);
        log1_op         : in     vl_logic_vector(1 downto 0);
        done_next       : in     vl_logic;
        result_en       : in     vl_logic;
        reg_n3_en       : in     vl_logic;
        reg_n5_en       : in     vl_logic;
        reg_n6_en       : in     vl_logic;
        reg_n7_en       : in     vl_logic;
        reg_n8_en       : in     vl_logic;
        reg_n9_en       : in     vl_logic;
        reg_n10_en      : in     vl_logic;
        reg_n11_en      : in     vl_logic;
        result          : out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic
    );
end datapath;
