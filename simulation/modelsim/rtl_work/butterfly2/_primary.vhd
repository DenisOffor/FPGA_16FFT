library verilog;
use verilog.vl_types.all;
entity butterfly2 is
    generic(
        N               : integer := 16;
        Q               : integer := 8
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        i_in0_re        : in     vl_logic_vector;
        i_in0_im        : in     vl_logic_vector;
        i_in1_re        : in     vl_logic_vector;
        i_in1_im        : in     vl_logic_vector;
        i_twiddle_re    : in     vl_logic_vector;
        i_twiddle_im    : in     vl_logic_vector;
        o_out0_re       : out    vl_logic_vector;
        o_out0_im       : out    vl_logic_vector;
        o_out1_re       : out    vl_logic_vector;
        o_out1_im       : out    vl_logic_vector;
        o_butterfly_done: out    vl_logic;
        clk_divided8    : out    vl_logic;
        clk_divided16   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
end butterfly2;
