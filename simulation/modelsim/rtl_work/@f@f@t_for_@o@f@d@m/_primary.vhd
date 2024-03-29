library verilog;
use verilog.vl_types.all;
entity FFT_for_OFDM is
    generic(
        WORD_SIZE       : integer := 16;
        DATA_LENGTH     : integer := 8;
        FRACTION        : integer := 8;
        STAGES          : integer := 4
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        i_byte          : in     vl_logic_vector;
        out0_re         : out    vl_logic_vector;
        out0_im         : out    vl_logic_vector;
        out1_re         : out    vl_logic_vector;
        out1_im         : out    vl_logic_vector;
        out2_re         : out    vl_logic_vector;
        out2_im         : out    vl_logic_vector;
        out3_re         : out    vl_logic_vector;
        out3_im         : out    vl_logic_vector;
        out4_re         : out    vl_logic_vector;
        out4_im         : out    vl_logic_vector;
        out5_re         : out    vl_logic_vector;
        out5_im         : out    vl_logic_vector;
        out6_re         : out    vl_logic_vector;
        out6_im         : out    vl_logic_vector;
        out7_re         : out    vl_logic_vector;
        out7_im         : out    vl_logic_vector;
        out8_re         : out    vl_logic_vector;
        out8_im         : out    vl_logic_vector;
        out9_re         : out    vl_logic_vector;
        out9_im         : out    vl_logic_vector;
        out10_re        : out    vl_logic_vector;
        out10_im        : out    vl_logic_vector;
        out11_re        : out    vl_logic_vector;
        out11_im        : out    vl_logic_vector;
        out12_re        : out    vl_logic_vector;
        out12_im        : out    vl_logic_vector;
        out13_re        : out    vl_logic_vector;
        out13_im        : out    vl_logic_vector;
        out14_re        : out    vl_logic_vector;
        out14_im        : out    vl_logic_vector;
        out15_re        : out    vl_logic_vector;
        out15_im        : out    vl_logic_vector;
        o_FFT_cycle_done: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
    attribute mti_svvh_generic_type of DATA_LENGTH : constant is 1;
    attribute mti_svvh_generic_type of FRACTION : constant is 1;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end FFT_for_OFDM;
