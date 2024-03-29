library verilog;
use verilog.vl_types.all;
entity mux32in1 is
    generic(
        DATA_LENGTH     : integer := 8
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        in3             : in     vl_logic_vector;
        in4             : in     vl_logic_vector;
        in5             : in     vl_logic_vector;
        in6             : in     vl_logic_vector;
        in7             : in     vl_logic_vector;
        in8             : in     vl_logic_vector;
        in9             : in     vl_logic_vector;
        in10            : in     vl_logic_vector;
        in11            : in     vl_logic_vector;
        in12            : in     vl_logic_vector;
        in13            : in     vl_logic_vector;
        in14            : in     vl_logic_vector;
        in15            : in     vl_logic_vector;
        in16            : in     vl_logic_vector;
        in17            : in     vl_logic_vector;
        in18            : in     vl_logic_vector;
        in19            : in     vl_logic_vector;
        in20            : in     vl_logic_vector;
        in21            : in     vl_logic_vector;
        in22            : in     vl_logic_vector;
        in23            : in     vl_logic_vector;
        in24            : in     vl_logic_vector;
        in25            : in     vl_logic_vector;
        in26            : in     vl_logic_vector;
        in27            : in     vl_logic_vector;
        in28            : in     vl_logic_vector;
        in29            : in     vl_logic_vector;
        in30            : in     vl_logic_vector;
        in31            : in     vl_logic_vector;
        sel             : in     vl_logic_vector(5 downto 0);
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_LENGTH : constant is 1;
end mux32in1;
