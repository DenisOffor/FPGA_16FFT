library verilog;
use verilog.vl_types.all;
entity clock_divider is
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        o_clk_divided2  : out    vl_logic;
        o_clk_divided4  : out    vl_logic;
        o_clk_divided8  : out    vl_logic;
        o_clk_divided16 : out    vl_logic;
        o_clk_divided32 : out    vl_logic;
        o_clk_divided64 : out    vl_logic
    );
end clock_divider;
