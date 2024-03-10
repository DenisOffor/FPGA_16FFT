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
        ena             : out    vl_logic;
        w_out_re0       : out    vl_logic_vector;
        w_out_re1       : out    vl_logic_vector;
        w_out_im0       : out    vl_logic_vector;
        w_out_im1       : out    vl_logic_vector;
        w_out_re0_neg   : out    vl_logic_vector;
        w_out_re1_neg   : out    vl_logic_vector;
        w_out_im0_neg   : out    vl_logic_vector;
        w_out_im1_neg   : out    vl_logic_vector;
        current_factor1 : out    vl_logic_vector;
        current_factor2 : out    vl_logic_vector;
        out_multiplier  : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
end butterfly2;
