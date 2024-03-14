library verilog;
use verilog.vl_types.all;
entity ram_for_signal is
    generic(
        ADDR_WIDTH      : integer := 4;
        DATA_WIDTH      : integer := 16;
        DEPTH           : integer := 16
    );
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector;
        re              : in     vl_logic;
        data00_r        : in     vl_logic_vector;
        data01_r        : in     vl_logic_vector;
        data02_r        : in     vl_logic_vector;
        data03_r        : in     vl_logic_vector;
        data04_r        : in     vl_logic_vector;
        data05_r        : in     vl_logic_vector;
        data06_r        : in     vl_logic_vector;
        data07_r        : in     vl_logic_vector;
        data08_r        : in     vl_logic_vector;
        data09_r        : in     vl_logic_vector;
        data10_r        : in     vl_logic_vector;
        data11_r        : in     vl_logic_vector;
        data12_r        : in     vl_logic_vector;
        data13_r        : in     vl_logic_vector;
        data14_r        : in     vl_logic_vector;
        data15_r        : in     vl_logic_vector;
        data00_i        : in     vl_logic_vector;
        data01_i        : in     vl_logic_vector;
        data02_i        : in     vl_logic_vector;
        data03_i        : in     vl_logic_vector;
        data04_i        : in     vl_logic_vector;
        data05_i        : in     vl_logic_vector;
        data06_i        : in     vl_logic_vector;
        data07_i        : in     vl_logic_vector;
        data08_i        : in     vl_logic_vector;
        data09_i        : in     vl_logic_vector;
        data10_i        : in     vl_logic_vector;
        data11_i        : in     vl_logic_vector;
        data12_i        : in     vl_logic_vector;
        data13_i        : in     vl_logic_vector;
        data14_i        : in     vl_logic_vector;
        data15_i        : in     vl_logic_vector;
        data            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 1;
end ram_for_signal;
