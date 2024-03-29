library verilog;
use verilog.vl_types.all;
entity get_negative is
    generic(
        WORD_SIZE       : integer := 16
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
end get_negative;
