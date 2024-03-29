library verilog;
use verilog.vl_types.all;
entity control_unit is
    generic(
        STAGES          : integer := 4
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        o_mux_sel       : out    vl_logic_vector(1 downto 0);
        o_cycle_done    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STAGES : constant is 1;
end control_unit;
