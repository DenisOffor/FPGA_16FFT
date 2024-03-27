module UART_RX #(parameter CLOCK_PER_BIT = 434)
(
	input 			i_clk, 
	input 			i_RX_bit, 
	output	[7:0]	o_Received_byte, 
	output			o_receive_state, 
	output			o_error
);

	reg i_RX_bit_switch[1:0];
	reg [10:0]r_rx_counter;
	reg [2:0]r_receive_task;
	
	reg [7:0]r_RX_byte;
	reg [2:0]r_bits_num;
	reg r_RX_state;
	reg r_error_state;
	
	parameter IDLE_STATE = 3'b000;
	parameter CHECK_START_BIT = 3'b001;
	parameter RECEIVE_BYTE = 3'b010;
	parameter CHECK_STOP_BIT = 3'b011;
	parameter CLEAR_STATE = 3'b100;
	
	initial begin
		r_RX_byte <= 0;
		r_error_state <= 0;
		r_RX_state <= 0;
	end
	
	always @(posedge i_clk)
	begin
		i_RX_bit_switch[0] <= i_RX_bit;
		i_RX_bit_switch[1] <= i_RX_bit_switch[0];
	end
	
	always @(posedge i_clk)
	begin
		case(r_receive_task)
		IDLE_STATE:
		begin
			r_rx_counter <= 0;
			r_bits_num <= 0;
			r_RX_state <= 0;
			r_error_state <= 0;
			
			if(i_RX_bit_switch[1] == 1'b0)
				r_receive_task <= CHECK_START_BIT;
			else
				r_receive_task <= IDLE_STATE;
		end
		
		CHECK_START_BIT:
		begin
			if(r_rx_counter > ((CLOCK_PER_BIT - 1)/2))
			begin
				if(i_RX_bit_switch[1] == 1'b0)
				begin
					r_receive_task <= RECEIVE_BYTE;
					r_rx_counter <= 0;
				end
				else
					r_receive_task <= IDLE_STATE;
			end
			else
			begin
				r_rx_counter <= r_rx_counter + 1;
				r_receive_task <= CHECK_START_BIT;
			end
		end
		
		RECEIVE_BYTE:
		begin
			if(r_rx_counter > (CLOCK_PER_BIT - 1))
			begin
				r_RX_byte[r_bits_num] <= i_RX_bit_switch[1];
				r_rx_counter <= 0;
				if(r_bits_num < 7)
				begin
					r_bits_num <= r_bits_num + 1;
					r_receive_task <= RECEIVE_BYTE;
				end
				else
				begin
					r_bits_num <= 0;
					r_receive_task <= CHECK_STOP_BIT;
				end
			end
			else
			begin
				r_rx_counter <= r_rx_counter + 1;
				r_receive_task <= RECEIVE_BYTE;
			end
		end
		
		CHECK_STOP_BIT:
		begin 
			if(r_rx_counter > (CLOCK_PER_BIT - 1))
			begin
				if(i_RX_bit_switch[1] == 1'b0)
				begin
					r_receive_task <= CLEAR_STATE;
					r_error_state <= 1'b1;
					r_rx_counter <= 0;
				end
				else
				begin
					r_receive_task <= CLEAR_STATE;
					r_RX_state <= 1'b1;
					r_rx_counter <= 0;
				end
			end
			else
			begin
				r_rx_counter <= r_rx_counter + 1;
				r_receive_task <= CHECK_STOP_BIT;
			end
		end
		
		CLEAR_STATE:
		begin
			r_receive_task <= IDLE_STATE;
			r_RX_state <= 1'b0;
			r_error_state <= 1'b0;
		end
		
		default: r_receive_task <= IDLE_STATE;
		endcase
	end
	
	assign o_receive_state = r_RX_state;
	assign o_Received_byte = r_RX_byte;
	assign o_error = r_error_state;
endmodule