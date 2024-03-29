library verilog;
use verilog.vl_types.all;
entity multiplier is
    generic(
        WORD_SIZE       : integer := 16;
        FRACTION        : integer := 8
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        i_A             : in     vl_logic_vector;
        i_B             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
    attribute mti_svvh_generic_type of FRACTION : constant is 1;
end multiplier;
