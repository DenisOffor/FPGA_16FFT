library verilog;
use verilog.vl_types.all;
entity mux4in1 is
    generic(
        WORD_SIZE       : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        c               : in     vl_logic_vector;
        d               : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_SIZE : constant is 1;
end mux4in1;
