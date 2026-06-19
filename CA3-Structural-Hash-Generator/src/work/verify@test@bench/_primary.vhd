library verilog;
use verilog.vl_types.all;
entity verifyTestBench is
    generic(
        WIDTH           : integer := 8;
        NUM_WORDS       : integer := 4;
        ITER            : integer := 64;
        NUM_REP         : integer := 6;
        MAX_TESTS       : integer := 100;
        START           : integer := 0
    );
end verifyTestBench;
