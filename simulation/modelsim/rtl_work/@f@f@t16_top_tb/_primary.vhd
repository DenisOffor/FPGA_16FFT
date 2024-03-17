library verilog;
use verilog.vl_types.all;
entity FFT16_top_tb is
    generic(
        N               : integer := 16;
        Q               : integer := 8;
        STAGES          : integer := 4
    );
    port(
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
        o_FFT_cycle_done: out    vl_logic;
        o_butterfly_done: out    vl_logic;
        Mux_switcher_butterfly: out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end FFT16_top_tb;
