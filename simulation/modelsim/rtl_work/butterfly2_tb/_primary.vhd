library verilog;
use verilog.vl_types.all;
entity butterfly2_tb is
    generic(
        N               : integer := 16;
        Q               : integer := 8
    );
    port(
        o_out0_re       : out    vl_logic_vector;
        o_out0_im       : out    vl_logic_vector;
        o_out1_re       : out    vl_logic_vector;
        o_out1_im       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of Q : constant is 1;
end butterfly2_tb;
