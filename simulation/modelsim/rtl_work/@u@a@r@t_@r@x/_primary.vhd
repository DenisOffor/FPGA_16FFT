library verilog;
use verilog.vl_types.all;
entity UART_RX is
    generic(
        CLOCK_PER_BIT   : integer := 40
    );
    port(
        i_clk           : in     vl_logic;
        i_RX_bit        : in     vl_logic;
        o_Received_byte : out    vl_logic_vector(7 downto 0);
        o_receive_state : out    vl_logic;
        o_error         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_PER_BIT : constant is 1;
end UART_RX;
