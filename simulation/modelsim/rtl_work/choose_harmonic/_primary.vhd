library verilog;
use verilog.vl_types.all;
entity choose_harmonic is
    generic(
        WORD_SIZE       : integer := 16
    );
    port(
        \select\        : in     vl_logic_vector(1 downto 0);
        i_constellation_point1_re: in     vl_logic_vector;
        i_constellation_point1_im: in     vl_logic_vector;
        i_constellation_point2_re: in     vl_logic_vector;
        i_constellation_point2_im: in     vl_logic_vector;
        i_constellation_point3_re: in     vl_logic_vector;
        i_constellation_point3_im: in     vl_logic_vector;
        i_constellation_point4_re: in     vl_logic_vector;
        i_constellation_point4_im: in     vl_logic_vector;
        o_harmonic_re   : out    vl_logic_vector;
        o_harmonic_im   : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
end choose_harmonic;
