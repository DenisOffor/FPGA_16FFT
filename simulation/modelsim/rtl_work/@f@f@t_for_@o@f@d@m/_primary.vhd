library verilog;
use verilog.vl_types.all;
entity FFT_for_OFDM is
    generic(
        N               : integer := 16;
        Q               : integer := 8;
        STAGES          : integer := 4
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        in_1Hz_re       : in     vl_logic_vector;
        in_1Hz_im       : in     vl_logic_vector;
        in_2Hz_re       : in     vl_logic_vector;
        in_2Hz_im       : in     vl_logic_vector;
        in_4Hz_re       : in     vl_logic_vector;
        in_4Hz_im       : in     vl_logic_vector;
        in_8Hz_re       : in     vl_logic_vector;
        in_8Hz_im       : in     vl_logic_vector;
        out_instant     : out    vl_logic_vector;
        o_FFT_cycle_done: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end FFT_for_OFDM;
