library verilog;
use verilog.vl_types.all;
entity flash is
    generic(
        N               : integer := 16
    );
    port(
        i_clk           : in     vl_logic;
        i_word          : in     vl_logic_vector;
        address         : in     vl_logic_vector(1 downto 0);
        o_word0         : out    vl_logic_vector;
        o_word1         : out    vl_logic_vector;
        o_word2         : out    vl_logic_vector;
        o_word3         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end flash;
