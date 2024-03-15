library verilog;
use verilog.vl_types.all;
entity FFT16_top_tb is
    generic(
        N               : integer := 16;
        Q               : integer := 8;
        STAGES          : integer := 4
    );
    port(
        out0re          : out    vl_logic_vector;
        out0im          : out    vl_logic_vector;
        out1re          : out    vl_logic_vector;
        out1im          : out    vl_logic_vector;
        out2re          : out    vl_logic_vector;
        out2im          : out    vl_logic_vector;
        out3re          : out    vl_logic_vector;
        out3im          : out    vl_logic_vector;
        out4re          : out    vl_logic_vector;
        out4im          : out    vl_logic_vector;
        out5re          : out    vl_logic_vector;
        out5im          : out    vl_logic_vector;
        o_FFT_cycle_done: out    vl_logic;
        w_out0_re_butterfly: out    vl_logic_vector;
        w_out0_im_butterfly: out    vl_logic_vector;
        w_out1_re_butterfly: out    vl_logic_vector;
        w_out1_im_butterfly: out    vl_logic_vector;
        w_Mux0_out0_re_butterfly_in: out    vl_logic_vector;
        w_Mux0_out0_im_butterfly_in: out    vl_logic_vector;
        w_Mux0_out1_re_butterfly_in: out    vl_logic_vector;
        w_Mux0_out1_im_butterfly_in: out    vl_logic_vector;
        w_Mux0_out_twiddle_re: out    vl_logic_vector;
        w_Mux0_out_twiddle_im: out    vl_logic_vector;
        o_Mux_switcher_butterfly: out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end FFT16_top_tb;
