module top #(parameter FFT_SIZE = 16, WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8, CLOCK_PER_BIT = 868)
(
	input 			i_clk,
	input 			i_RX_bit,
			
	output 			o_TX_bit
);
	reg 	[2:0] r_STAGES = 4;
	wire	[2:0]	w_STAGES = r_STAGES;
	//reg and wires for UART_RX
	wire 	[DATA_LENGTH - 1:0] 	w_Received_byte;
	wire 							w_receive_state;

	//reg and wires for UART_TX
	wire 	[DATA_LENGTH - 1:0] 	w_Transmitted_byte;
	reg								r_TX_start = 0;
	reg								r_full_TX_state = 0; //1 - process, 0 - wait
	wire 							w_TX_start;
	wire							w_full_TX_state;
	wire 							w_TX_done;
	assign w_TX_start = r_TX_start;
	assign w_full_TX_state = r_full_TX_state;
	reg 	[5:0]	    counter_of_sended_bytes = 0;
	
	//wires for out from FFT
	wire	[WORD_SIZE-1:0]			w_FFT_out0_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out1_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out2_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out3_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out4_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out5_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out6_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out7_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out8_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out9_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out10_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out11_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out12_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out13_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out14_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out15_re;
	wire							w_FFT_cycle_done;
	wire								w_FFT_cycle_done_delay;
	reg 								r_FFT_cycle_done;
	assign w_FFT_cycle_done_delay = r_FFT_cycle_done;
	
	//wire and reg for reset FFT
	reg								r_FFT_rst = 0;
	wire							w_FFT_rst;
	assign w_FFT_rst = ~r_FFT_rst;
	
	//manage reset state of FFT
	//if external reset -> then reset fft
	//if FFT cycle done -> reset in order to save data after FFT in ram and FFT cycle not start again
	//if new byte received -> then start new cycle, so reset = 0
	always @(posedge w_receive_state or posedge w_FFT_cycle_done_delay) begin
			if(w_FFT_cycle_done_delay) begin
				r_FFT_rst <= 1'b0;
			end
				else if(w_receive_state) begin
					r_FFT_rst <= 1'b1;
				end
	end
	
	//reg to start TX when first byte transmitted (start by w_FFT_cycle_done_delay) and other 31 bytes transmitted (start by w_TX_done)
	always @(posedge i_clk or posedge w_FFT_cycle_done_delay or posedge w_TX_done) begin
		r_FFT_cycle_done <= w_FFT_cycle_done;
		if(w_FFT_cycle_done_delay || w_TX_done) begin
			r_TX_start <= 1'b1;
		end
		else begin
			r_TX_start <= 1'b0;
		end
	end
	
	//if w_FFT_cycle_done_delay come so we need to transfer first byte and set r_full_TX_state in "1" to indicate that transfer ongoing
	//if w_TX_done come so trasfer of byte ended -> set next byte
	//if counter count to 32 -> all bytes transfered, r_full_TX_state is "0" (no transfer), counter set to zero
	//wait for next w_TX_start
	always @(posedge w_FFT_cycle_done_delay or posedge w_TX_done) begin
		if(w_FFT_cycle_done_delay == 1'b1) begin
			r_full_TX_state <= 1'b1;
			counter_of_sended_bytes <= 0;
		end
		else begin
			counter_of_sended_bytes <= counter_of_sended_bytes + 1'b1;
			if(counter_of_sended_bytes == 31) begin
				counter_of_sended_bytes <= 0;
				r_full_TX_state <= 1'b0;
			end
		end
	end
	
	mux32in1 #(.DATA_LENGTH(DATA_LENGTH)) mymux
	(
		.in0(w_FFT_out0_re[7:0]),
		.in1(w_FFT_out0_re[15:8]),
		.in2(w_FFT_out1_re[7:0]),
		.in3(w_FFT_out1_re[15:8]),
		.in4(w_FFT_out2_re[7:0]),
		.in5(w_FFT_out2_re[15:8]),
		.in6(w_FFT_out3_re[7:0]),
		.in7(w_FFT_out3_re[15:8]),
		.in8(w_FFT_out4_re[7:0]),
		.in9(w_FFT_out4_re[15:8]),
		.in10(w_FFT_out5_re[7:0]),
		.in11(w_FFT_out5_re[15:8]),
		.in12(w_FFT_out6_re[7:0]),
		.in13(w_FFT_out6_re[15:8]),
		.in14(w_FFT_out7_re[7:0]),
		.in15(w_FFT_out7_re[15:8]),
		.in16(w_FFT_out8_re[7:0]),
		.in17(w_FFT_out8_re[15:8]),
		.in18(w_FFT_out9_re[7:0]),
		.in19(w_FFT_out9_re[15:8]),
		.in20(w_FFT_out10_re[7:0]),
		.in21(w_FFT_out10_re[15:8]),
		.in22(w_FFT_out11_re[7:0]),
		.in23(w_FFT_out11_re[15:8]),
		.in24(w_FFT_out12_re[7:0]),
		.in25(w_FFT_out12_re[15:8]),
		.in26(w_FFT_out13_re[7:0]),
		.in27(w_FFT_out13_re[15:8]),
		.in28(w_FFT_out14_re[7:0]),
		.in29(w_FFT_out14_re[15:8]),
		.in30(w_FFT_out15_re[7:0]),
		.in31(w_FFT_out15_re[15:8]),
		
		.sel(counter_of_sended_bytes),
		.out(w_Transmitted_byte)
	);
	
	
	FFT_for_OFDM #(.WORD_SIZE(WORD_SIZE),.DATA_LENGTH(DATA_LENGTH), .FRACTION(FRACTION)) FFT_for_OFDM
	(
		.i_clk(i_clk),
		.i_rst(w_FFT_rst),
		.STAGES(w_STAGES),
		.i_byte(w_Received_byte),
	
		.out0_re(w_FFT_out0_re),
		.out0_im(),
		.out1_re(w_FFT_out1_re),
		.out1_im(),
		.out2_re(w_FFT_out2_re),
		.out2_im(),
		.out3_re(w_FFT_out3_re),
		.out3_im(),
		.out4_re(w_FFT_out4_re),
		.out4_im(),
		.out5_re(w_FFT_out5_re),
		.out5_im(),
		.out6_re(w_FFT_out6_re),
		.out6_im(),
		.out7_re(w_FFT_out7_re),
		.out7_im(),
		.out8_re(w_FFT_out8_re),
		.out8_im(),
		.out9_re(w_FFT_out9_re),
		.out9_im(),
		.out10_re(w_FFT_out10_re),
		.out10_im(),
		.out11_re(w_FFT_out11_re),
		.out11_im(),
		.out12_re(w_FFT_out12_re),
		.out12_im(),
		.out13_re(w_FFT_out13_re),
		.out13_im(),
		.out14_re(w_FFT_out14_re),
		.out14_im(),
		.out15_re(w_FFT_out15_re),
		.out15_im(),
		
		.o_FFT_cycle_done(w_FFT_cycle_done)
	);

	UART_RX #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) Receiver 
	(
		.i_clk(i_clk), // && in order to cancel receive while FFT for previous data is going  
		.i_RX_bit(i_RX_bit),
		.o_Received_byte(w_Received_byte), 
		.o_receive_state(w_receive_state), 
		.o_error()
	);
	
	UART_TX #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) Transmitter
	(
		.i_clk(i_clk),
		.i_rst(~r_full_TX_state),
		.i_start(w_TX_start), 
		.i_TX_byte(w_Transmitted_byte),
		.o_TX_bit(o_TX_bit), 
		.o_transfer_state(), 
		.o_TX_done(w_TX_done)
	);
endmodule
