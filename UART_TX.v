module UART_TX #(parameter CLOCK_PER_BIT = 434)
(
	input 				i_clk, 
	input					i_rst,
	input 				i_start,
	input 		 [7:0]	i_TX_byte,
	output	reg 		o_TX_bit, 
	output		 		o_transfer_state, 
	output		 		o_TX_done
);

	parameter 			IDLE_STATE = 3'b000;
	parameter 			TX_START_BIT = 3'b001;
	parameter 			TX_TRANSFER_DATA = 3'b010;
	parameter 			TX_STOP_BIT= 3'b011;
	parameter 			CLEAR_STATE = 3'b100;
	
	reg 		[7:0]	r_TX_byte;
	reg 		[10:0]	r_TX_counter;
	reg 				r_TX_data;
	reg 				r_transfer_state;
	reg 				r_TX_done;
	reg 		[2:0]	r_bits_num;
	reg 		[2:0]	r_transfer_task;
	
	initial begin
		r_TX_counter <= 0;
		r_bits_num <= 0;
		o_TX_bit <= 1;
		r_transfer_state <= 0;
		r_TX_done <= 0;
	end
	
	always @(posedge i_clk or posedge i_rst)
	begin
		if(i_rst)
			r_transfer_task <= IDLE_STATE;
		else begin
			case(r_transfer_task)
				IDLE_STATE:
				begin
					r_TX_counter <= 0;
					r_bits_num <= 0;
					o_TX_bit <= 1;
					r_transfer_state <= 0;
					r_TX_done <= 0;
					
					if(i_start == 1'b1)
					begin
						r_transfer_state <= 1;
						r_transfer_task <= TX_START_BIT;
						r_TX_byte <= i_TX_byte;
					end
					else
						r_transfer_task <= IDLE_STATE;
				end
			
				TX_START_BIT:
				begin 
					o_TX_bit <= 1'b0;
					
					if(r_TX_counter > CLOCK_PER_BIT - 1)
					begin
						r_TX_counter <= 0;
						r_transfer_task <= TX_TRANSFER_DATA;
					end
					else
					begin
						r_TX_counter <= r_TX_counter + 1;
						r_transfer_task <= TX_START_BIT;
					end
				end
			
				TX_TRANSFER_DATA:
				begin 
					o_TX_bit <= r_TX_byte[r_bits_num];
					if(r_TX_counter > CLOCK_PER_BIT - 1)
					begin
						r_TX_counter <= 0;
						if(r_bits_num < 7)
						begin
							r_bits_num <= r_bits_num + 1;
							r_transfer_task <= TX_TRANSFER_DATA;
						end
						else
						begin
							r_bits_num <= 0;
							r_transfer_task <= TX_STOP_BIT;
						end
					end
					else
					begin
						r_TX_counter <= r_TX_counter + 1;
						r_transfer_task <= TX_TRANSFER_DATA;
					end
				end
			
				TX_STOP_BIT:
				begin
					o_TX_bit <= 1'b1;
					
					if(r_TX_counter > CLOCK_PER_BIT - 1)
					begin
						r_TX_counter <= 0;
						r_transfer_task <= CLEAR_STATE;
						r_transfer_state <= 1'b0;
						r_TX_done <= 1'b1;
					end
					else
					begin
						r_TX_counter <= r_TX_counter + 1;
						r_transfer_task <= TX_STOP_BIT;
					end
				end
				
				CLEAR_STATE:
				begin
					r_transfer_task <= IDLE_STATE;
					r_TX_done <= 1'b0;
				end
				default: r_transfer_task <= IDLE_STATE;
			endcase
		end
	end
	
	assign o_transfer_state = r_transfer_state;
	assign o_TX_done = r_TX_done;
endmodule