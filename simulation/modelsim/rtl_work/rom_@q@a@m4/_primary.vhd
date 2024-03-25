library verilog;
use verilog.vl_types.all;
entity rom_QAM4 is
    generic(
        WORD_SIZE       : integer := 16
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        o_constellation_point1_re: out    vl_logic_vector;
        o_constellation_point1_im: out    vl_logic_vector;
        o_constellation_point2_re: out    vl_logic_vector;
        o_constellation_point2_im: out    vl_logic_vector;
        o_constellation_point3_re: out    vl_logic_vector;
        o_constellation_point3_im: out    vl_logic_vector;
        o_constellation_point4_re: out    vl_logic_vector;
        o_constellation_point4_im: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
end rom_QAM4;
