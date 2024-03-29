library verilog;
use verilog.vl_types.all;
entity adder3 is
    generic(
        WORD_SIZE       : integer := 16
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        i_A             : in     vl_logic_vector;
        i_B             : in     vl_logic_vector;
        i_C             : in     vl_logic_vector;
        o_sum           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
end adder3;
