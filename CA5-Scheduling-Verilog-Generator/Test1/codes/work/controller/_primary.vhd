library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        alu1_sel1       : out    vl_logic_vector(2 downto 0);
        alu1_sel2       : out    vl_logic_vector(2 downto 0);
        alu1_op         : out    vl_logic_vector(0 downto 0);
        alu2_sel1       : out    vl_logic_vector(2 downto 0);
        alu2_sel2       : out    vl_logic_vector(2 downto 0);
        alu2_op         : out    vl_logic_vector(0 downto 0);
        mul1_sel1       : out    vl_logic_vector(2 downto 0);
        mul1_sel2       : out    vl_logic_vector(2 downto 0);
        mul1_op         : out    vl_logic_vector(1 downto 0);
        reg_n2_en       : out    vl_logic;
        reg_n4_en       : out    vl_logic;
        reg_n5_en       : out    vl_logic;
        reg_n6_en       : out    vl_logic;
        reg_n7_en       : out    vl_logic;
        done_next       : out    vl_logic;
        result_en       : out    vl_logic
    );
end controller;
