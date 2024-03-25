module top_tb #(parameter FFT_SIZE = 16, WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8, STAGES = 4)
(	
	output	o_TX_bit,
	output 	[DATA_LENGTH-1:0] 	o_received_byte,
	output	o_receive_state
);
	reg clk = 0;
	reg rst = 0;
	reg [DATA_LENGTH-1:0] byte;
	reg r_tx_start = 0;
	wire w_tx_start;
	assign w_tx_start = r_tx_start;
	wire w_TX_bit_tb;
	
	initial begin		
		#10 rst = 1;
		#50 rst = 0;
		#0 r_tx_start = 1'b1;
		#0 byte = 8'b00000000;
		#20 r_tx_start = 1'b0;
	end
	
	always @(*)
		#10 clk <= ~clk;



	top #(.FFT_SIZE(FFT_SIZE), .WORD_SIZE(WORD_SIZE), .DATA_LENGTH(DATA_LENGTH),.FRACTION(FRACTION), .STAGES(STAGES)) tb_top
	(
		.i_clk(clk),
		.i_rst(rst),
		.i_RX_bit(w_TX_bit_tb),
		
		.o_TX_bit(o_TX_bit)
	);

	UART_TX tb_Transmitter
	(
		.i_clk(clk),
		.i_rst(0),
		.i_start(w_tx_start), 
		.i_TX_byte(byte),
		.o_TX_bit(w_TX_bit_tb), 
		.o_transfer_state(), 
		.o_TX_done()
	);
	
	UART_RX tb_Receiver 
	(
		.i_clk(clk),
		.i_RX_bit(o_TX_bit),
		.o_Received_byte(o_received_byte), 
		.o_receive_state(o_receive_state), 
		.o_error()
	);
	
endmodule
