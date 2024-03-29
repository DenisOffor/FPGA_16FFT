library verilog;
use verilog.vl_types.all;
entity top is
    generic(
        FFT_SIZE        : integer := 16;
        WORD_SIZE       : integer := 16;
        DATA_LENGTH     : integer := 8;
        FRACTION        : integer := 8;
        STAGES          : integer := 4
    );
    port(
        i_clk           : in     vl_logic;
        i_RX_bit        : in     vl_logic;
        o_TX_bit        : out    vl_logic;
        w_led1          : out    vl_logic;
        w_led2          : out    vl_logic;
        w_FFT_cycle_done: out    vl_logic;
        w_TX_done       : out    vl_logic;
        w_FFT_rst       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FFT_SIZE : constant is 1;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
    attribute mti_svvh_generic_type of DATA_LENGTH : constant is 1;
    attribute mti_svvh_generic_type of FRACTION : constant is 1;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end top;
