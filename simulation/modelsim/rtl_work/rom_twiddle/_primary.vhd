library verilog;
use verilog.vl_types.all;
entity rom_twiddle is
    generic(
        N               : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        reg0_re         : out    vl_logic_vector;
        reg0_im         : out    vl_logic_vector;
        reg1_re         : out    vl_logic_vector;
        reg1_im         : out    vl_logic_vector;
        reg2_re         : out    vl_logic_vector;
        reg2_im         : out    vl_logic_vector;
        reg3_re         : out    vl_logic_vector;
        reg3_im         : out    vl_logic_vector;
        reg4_re         : out    vl_logic_vector;
        reg4_im         : out    vl_logic_vector;
        reg5_re         : out    vl_logic_vector;
        reg5_im         : out    vl_logic_vector;
        reg6_re         : out    vl_logic_vector;
        reg6_im         : out    vl_logic_vector;
        reg7_re         : out    vl_logic_vector;
        reg7_im         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end rom_twiddle;
