module top_control_unit
(
	input 							i_clk,
	input								i_FFT32_cycle_done,
	input								i_receive_state,
	input								i_TX_done,
							
	output							o_FFT_rst,
	output							o_TX_start,
	output							o_full_TX_state,
	output 	[6:0]					o_counter_of_sended_bytes
);

	reg 								r_full_TX_state = 0;
	reg								r_TX_start = 0;
	reg 		[6:0]	    			counter_of_sended_bytes = 0;
	assign 							o_TX_start = r_TX_start;
	assign 							o_full_TX_state = r_full_TX_state;
	assign							o_counter_of_sended_bytes = counter_of_sended_bytes;
	
	//wire and reg for reset FFT
	reg								r_FFT_rst = 0;
	assign 							o_FFT_rst = ~r_FFT_rst;
	
	//manage reset state of FFT
	//if external reset -> then reset fft
	//if FFT cycle done -> reset in order to save data after FFT in ram and FFT cycle not start again
	//if new byte received -> then start new cycle, so reset = 0
	always @(posedge i_receive_state or posedge i_FFT32_cycle_done) begin
			if(i_FFT32_cycle_done) begin
				r_FFT_rst <= 1'b0;
			end
			else if(i_receive_state) begin
				r_FFT_rst <= 1'b1;
			end
	end
	
	//reg to start TX when first byte transmitted (start by i_FFT32_cycle_done) and other 31 bytes transmitted (start by i_TX_done)
	always @(posedge i_clk or posedge i_FFT32_cycle_done or posedge i_TX_done) begin
		if(i_FFT32_cycle_done || i_TX_done) begin
			r_TX_start <= 1'b1;
		end
		else begin
			r_TX_start <= 1'b0;
		end
	end
	
	//if i_FFT32_cycle_done come so we need to transfer first byte and set r_full_TX_state in "1" to indicate that transfer ongoing
	//if i_TX_done come so trasfer of byte ended -> set next byte
	//if counter count to 32 -> all bytes transfered, r_full_TX_state is "0" (no transfer), counter set to zero
	//wait for next w_TX_start
	always @(posedge i_FFT32_cycle_done or posedge i_TX_done) begin
		if(i_FFT32_cycle_done == 1'b1) begin
			r_full_TX_state <= 1'b1;
			counter_of_sended_bytes <= 0;
		end
		else begin
			counter_of_sended_bytes <= counter_of_sended_bytes + 1'b1;
			if(counter_of_sended_bytes == 63) begin
				counter_of_sended_bytes <= 0;
				r_full_TX_state <= 1'b0;
			end
		end
	end
	
endmodule
