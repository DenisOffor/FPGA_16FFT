module control_unit_FFT32
(
	input i_clk,
	input i_rst,
	input w_FFT16_cycle_done,
	
	output	[1:0]		o_mux_switcher,
	output				o_address_switcher,
	output				o_FFT16_cycle_rst,
	output	[2:0]		o_STAGES,
	output				o_FFT16_cycle_done_delay,
	output				o_FFT32_cycle_done
);
	reg	[1:0]	r_mux_switcher = 0;
	reg  			r_address_switcher = 0;
	reg  	[1:0]	r_address_switcher_delay = 0;
	reg			r_FFT32_cycle_done = 0;

	assign 		o_mux_switcher = r_mux_switcher;
	assign 		o_address_switcher = r_address_switcher_delay[1];
	assign 		o_FFT32_cycle_done = r_FFT32_cycle_done;
	
	reg			r_rst = 0;
	assign		o_FFT16_cycle_rst = r_rst;
	
	reg	[2:0]	r_STAGES;
	assign 		o_STAGES = r_STAGES;
	
	reg r_FFT16_cycle_done_delay;
	assign o_FFT16_cycle_done_delay = r_FFT16_cycle_done_delay;
	
	always @(posedge o_FFT16_cycle_done_delay or posedge i_rst) begin
		if(i_rst) begin
			r_mux_switcher <= 0;
			r_address_switcher <= 0;
			r_FFT32_cycle_done <= 1'b0;
		end
		else begin
			r_mux_switcher <= r_mux_switcher + 1'b1;
			r_address_switcher <= r_address_switcher ^ 1'b1;
			if(r_mux_switcher == 3) begin
				r_mux_switcher <= 0;
				r_FFT32_cycle_done <= 1'b1;
			end
		end
	end
	
	always @(posedge i_clk or posedge o_FFT16_cycle_done_delay) begin
		if(o_FFT16_cycle_done_delay)
			r_rst <= 1'b1;
		else
			r_rst <= 1'b0;
	end
	
	always @(posedge i_clk) begin
		r_FFT16_cycle_done_delay <= w_FFT16_cycle_done;
		r_address_switcher_delay[1:0] <= {r_address_switcher_delay[0], r_address_switcher};
		if(o_mux_switcher == 0 || o_mux_switcher == 1)
			r_STAGES <= 4;
		else
			r_STAGES <= 1;
	end
endmodule