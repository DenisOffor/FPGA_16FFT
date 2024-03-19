library verilog;
use verilog.vl_types.all;
entity FFT_for_OFDM_tb is
    generic(
        N               : integer := 16;
        Q               : integer := 8;
        STAGES          : integer := 4
    );
    port(
        out_instant     : out    vl_logic_vector;
        o_FFT_cycle_done: out    vl_logic;
        fft_out_switcher: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end FFT_for_OFDM_tb;
