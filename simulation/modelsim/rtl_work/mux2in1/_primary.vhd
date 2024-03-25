library verilog;
use verilog.vl_types.all;
entity mux2in1 is
    generic(
        N               : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end mux2in1;
