module top #(parameter WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8, STAGE = 4)
(
	input 			i_clk,
	input 			i_rst,
	input 			i_RX_bit,
			
	output 			o_TX_bit
);
	//reg and wires for UART_RX
	reg 	[DATA_LENGTH - 1:0] 	r_Received_byte;
	wire 							w_receive_state;
	wire 							w_RX_error;

	//reg and wires for UART_TX
	reg 	[DATA_LENGTH - 1:0] 	r_Transmitted_byte;
	wire 							w_TX_start;
	wire 							w_transfer_state;
	wire 							w_TX_done;

	UART_RX Receiver(.i_clk(i_clk), .i_RX_bit(i_RX_bit), .o_Received_byte(r_Received_byte), .o_receive_state(w_receive_state), .o_error(w_RX_error));
	UART_TX Transmitter(.i_clk(i_clk), .i_start(w_TX_start), .i_TX_byte(r_Transmitted_byte), .o_TX_bit(o_TX_bit), .o_transfer_state(w_transfer_state), .o_TX_done(w_TX_done));
endmodule
