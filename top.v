module top #(parameter FFT_SIZE = 16, WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8, STAGES = 4)
(
	input 			i_clk,
	input 			i_rst,
	input 			i_RX_bit,
			
	output 			o_TX_bit
);
	//reg and wires for UART_RX
	wire 	[DATA_LENGTH - 1:0] 	w_Received_byte;
	wire 							w_receive_state;
	wire 							w_RX_error;

	//reg and wires for UART_TX
	reg 	[DATA_LENGTH - 1:0] 	r_Transmitted_byte;
	reg								r_TX_start;
	reg								r_full_TX_state; //1 - process, 0 - wait
	wire 							w_TX_start;
	wire							w_full_TX_state;
	wire 							w_transfer_state;
	wire 							w_TX_done;
	assign w_TX_start = r_TX_start;
	assign w_full_TX_state = r_full_TX_state;
	
	reg 	[5:0]	    counter_of_sended_bytes;
	
	//wires for out from FFT
	wire	[WORD_SIZE-1:0]			w_FFT_out0_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out0_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out1_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out1_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out2_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out2_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out3_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out3_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out4_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out4_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out5_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out5_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out6_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out6_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out7_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out7_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out8_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out8_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out9_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out9_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out10_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out10_im;
	wire	[WORD_SIZE-1:0]			w_FFT_out11_re;
    wire	[WORD_SIZE-1:0]			w_FFT_out11_im;
    wire	[WORD_SIZE-1:0]			w_FFT_out12_re;
    wire	[WORD_SIZE-1:0]			w_FFT_out12_im;
    wire	[WORD_SIZE-1:0]			w_FFT_out13_re;
    wire	[WORD_SIZE-1:0]			w_FFT_out13_im;
    wire	[WORD_SIZE-1:0]			w_FFT_out14_re;
    wire	[WORD_SIZE-1:0]			w_FFT_out14_im;
    wire	[WORD_SIZE-1:0]			w_FFT_out15_re;
    wire	[WORD_SIZE-1:0]			w_FFT_out15_im;
	wire							w_FFT_cycle_done;
	
	//wire and reg for reset FFT
	reg								r_FFT_rst;
	wire							w_FFT_rst;
	assign w_FFT_rst = r_FFT_rst;
	
	initial begin
		r_FFT_rst  <= 1'b1;
		r_TX_start <= 1'b0;
		r_full_TX_state <= 1'b0;
		counter_of_sended_bytes <= 0;
	end
	
	//manage reset state of FFT
	//if external reset -> then reset fft
	//if FFT cycle done -> reset in order to save data after FFT in ram and FFT cycle not start again
	//if new byte received -> then start new cycle, so reset = 0
	always @(posedge i_clk or posedge w_receive_state or posedge w_FFT_cycle_done or posedge i_rst) begin
		if(i_rst) begin
			r_FFT_rst <= 1'b1;
		end
			else if(w_FFT_cycle_done) begin
				r_FFT_rst <= 1'b1;
			end
				else if(w_receive_state) begin
					r_FFT_rst <= 1'b0;
				end
	end
	
	//reg to start TX when first byte transmitted (start by w_FFT_cycle_done) and other 31 bytes transmitted (start by w_TX_done)
	always @(posedge i_clk or posedge w_FFT_cycle_done or posedge w_TX_done) begin
		if(w_FFT_cycle_done || w_TX_done) begin
			r_TX_start <= 1'b1;
		end
		else begin
			r_TX_start <= 1'b0;
		end
	end
	
	//if w_FFT_cycle_done come so we need to transfer first byte and set r_full_TX_state in "1" to indicate that transfer ongoing
	//if w_TX_done come so trasfer of byte ended -> set next byte
	//if counter count to 32 -> all bytes transfered, r_full_TX_state is "0" (no transfer), counter set to zero
	//wait for next w_TX_start
	always @(posedge w_FFT_cycle_done or posedge w_TX_done) begin
		if(w_FFT_cycle_done == 1'b1) begin
			r_full_TX_state <= 1'b1;
			counter_of_sended_bytes <= 0;
		end
		else begin
			counter_of_sended_bytes <= counter_of_sended_bytes + 1'b1;
			if(counter_of_sended_bytes == 32) begin
				counter_of_sended_bytes <= 0;
				r_full_TX_state <= 1'b0;
			end
		end
	end
	
	FFT_for_OFDM #(.WORD_SIZE(WORD_SIZE),.DATA_LENGTH(DATA_LENGTH), .FRACTION(FRACTION), .STAGES(STAGES)) FFT_for_OFDM
	(
		.i_clk(i_clk),
		.i_rst(w_FFT_rst),
		.i_byte(w_Received_byte),
	
		.out0_re(w_FFT_out0_re),
		.out0_im(w_FFT_out0_im),
		.out1_re(w_FFT_out1_re),
		.out1_im(w_FFT_out1_im),
		.out2_re(w_FFT_out2_re),
		.out2_im(w_FFT_out2_im),
		.out3_re(w_FFT_out3_re),
		.out3_im(w_FFT_out3_im),
		.out4_re(w_FFT_out4_re),
		.out4_im(w_FFT_out4_im),
		.out5_re(w_FFT_out5_re),
		.out5_im(w_FFT_out5_im),
		.out6_re(w_FFT_out6_re),
		.out6_im(w_FFT_out6_im),
		.out7_re(w_FFT_out7_re),
		.out7_im(w_FFT_out7_im),
		.out8_re(w_FFT_out8_re),
		.out8_im(w_FFT_out8_im),
		.out9_re(w_FFT_out9_re),
		.out9_im(w_FFT_out9_im),
		.out10_re(w_FFT_out10_re),
		.out10_im(w_FFT_out10_im),
		.out11_re(w_FFT_out11_re),
		.out11_im(w_FFT_out11_im),
		.out12_re(w_FFT_out12_re),
		.out12_im(w_FFT_out12_im),
		.out13_re(w_FFT_out13_re),
		.out13_im(w_FFT_out13_im),
		.out14_re(w_FFT_out14_re),
		.out14_im(w_FFT_out14_im),
		.out15_re(w_FFT_out15_re),
		.out15_im(w_FFT_out15_im),
		
		.o_FFT_cycle_done(w_FFT_cycle_done)
	);

	UART_RX Receiver 
	(
		.i_clk(i_clk && ~w_full_TX_state), // && in order to cancel receive while FFT for previous data is going  
		.i_RX_bit(i_RX_bit),
		.o_Received_byte(w_Received_byte), 
		.o_receive_state(w_receive_state), 
		.o_error(w_RX_error)
	);
	
	UART_TX Transmitter
	(
		.i_clk(i_clk),
		.i_rst(~r_full_TX_state),
		.i_start(w_TX_start), 
		.i_TX_byte(r_Transmitted_byte),
		.o_TX_bit(o_TX_bit), 
		.o_transfer_state(w_transfer_state), 
		.o_TX_done(w_TX_done)
	);
endmodule
