module top_tb #(parameter FFT_SIZE = 16, WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8, STAGES = 4, CLOCK_PER_BIT = 20)
(	
	output	o_TX_bit,
	output 	[DATA_LENGTH-1:0] 	o_received_byte,
	output	o_receive_state,
	output	w_full_TX_state,
	output 			w_led1,
	output         w_led2,
	output 			w_FFT_cycle_done,
	output			w_TX_done,
	output			w_FFT_rst
);
	reg clk = 0;
	reg rst = 0;
	reg [DATA_LENGTH-1:0] byte;
	reg r_tx_start = 0;
	wire w_tx_start;
	assign w_tx_start = r_tx_start;
	wire w_TX_bit_tb;
	
	initial begin		
		//#0 r_tx_start = 1'b1;
		//#0 byte = 8'b00110001;
		//#20 r_tx_start = 1'b0;
		#3200 r_tx_start = 1'b1;
		#0 byte = 8'b11000100;
		#20 r_tx_start = 1'b0;
		
		#410000 r_tx_start = 1'b1;
		#0 byte = 8'b00000000;
		#20 r_tx_start = 1'b0;
	end
	
	always @(*)
		#10 clk <= ~clk;



	top #(.FFT_SIZE(FFT_SIZE), .WORD_SIZE(WORD_SIZE), .DATA_LENGTH(DATA_LENGTH),.FRACTION(FRACTION), .CLOCK_PER_BIT(CLOCK_PER_BIT)) tb_top
	(
		.i_clk(clk),
		.i_RX_bit(w_TX_bit_tb),
		
		.o_TX_bit(o_TX_bit)
	);

	UART_TX #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) tb_Transmitter
	(
		.i_clk(clk),
		.i_rst(0),
		.i_start(w_tx_start), 
		.i_TX_byte(byte),
		.o_TX_bit(w_TX_bit_tb), 
		.o_transfer_state(), 
		.o_TX_done()
	);
	
	UART_RX #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) tb_Receiver 
	(
		.i_clk(clk),
		.i_RX_bit(o_TX_bit),
		.o_Received_byte(o_received_byte), 
		.o_receive_state(o_receive_state), 
		.o_error()
	);
	
endmodule
