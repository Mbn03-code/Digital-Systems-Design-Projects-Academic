library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        alu1_sel1       : out    vl_logic_vector(3 downto 0);
        alu1_sel2       : out    vl_logic_vector(3 downto 0);
        alu1_op         : out    vl_logic_vector(0 downto 0);
        alu2_sel1       : out    vl_logic_vector(3 downto 0);
        alu2_sel2       : out    vl_logic_vector(3 downto 0);
        alu2_op         : out    vl_logic_vector(0 downto 0);
        mul1_sel1       : out    vl_logic_vector(3 downto 0);
        mul1_sel2       : out    vl_logic_vector(3 downto 0);
        mul1_op         : out    vl_logic_vector(1 downto 0);
        log1_sel1       : out    vl_logic_vector(3 downto 0);
        log1_sel2       : out    vl_logic_vector(3 downto 0);
        log1_op         : out    vl_logic_vector(1 downto 0);
        reg_n3_en       : out    vl_logic;
        reg_n5_en       : out    vl_logic;
        reg_n6_en       : out    vl_logic;
        reg_n7_en       : out    vl_logic;
        reg_n8_en       : out    vl_logic;
        reg_n9_en       : out    vl_logic;
        reg_n10_en      : out    vl_logic;
        reg_n11_en      : out    vl_logic;
        done_next       : out    vl_logic;
        result_en       : out    vl_logic
    );
end controller;
