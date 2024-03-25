library verilog;
use verilog.vl_types.all;
entity UART_TX is
    generic(
        CLOCK_PER_BIT   : integer := 40
    );
    port(
        i_clk           : in     vl_logic;
        i_rst           : in     vl_logic;
        i_start         : in     vl_logic;
        i_TX_byte       : in     vl_logic_vector(7 downto 0);
        o_TX_bit        : out    vl_logic;
        o_transfer_state: out    vl_logic;
        o_TX_done       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_PER_BIT : constant is 1;
end UART_TX;
