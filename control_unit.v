module control_unit #(parameter STAGES = 4)
(
	input            i_clk, 
	input            i_rst,
	output   [1:0]   o_mux_sel,
	output 	        o_cycle_done
);
	reg [STAGES-1:0] counter;
	reg 				  r_cycle_done;

	initial begin
		counter <= 0;
		r_cycle_done <= 0;
	end
	
	always @ (posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			counter <= 0;
			r_cycle_done <= 0;
		end
		else if(r_cycle_done == 0) begin
			counter  <= counter + 1;
			if(counter == 4) begin
				counter <= 0;
				r_cycle_done <= 1;
			end
		end
	end
	
	assign o_mux_sel = counter [1:0];
	assign o_cycle_done = r_cycle_done;
endmodule