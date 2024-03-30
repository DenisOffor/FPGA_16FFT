module control_unit #(parameter STAGES = 4)
(
	input            i_clk, 
	input            i_rst,
	output   [1:0]   o_mux_sel,
	output 	        o_cycle_done
);
	reg [4:0] counter = 0;
	reg 				  r_cycle_done = 0;
	
	always @ (posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			counter <= 0;
			r_cycle_done <= 0;
		end
		else begin
			counter <= counter + 1'b1;
			if(counter == STAGES - 1) begin
				counter <= 0;
				r_cycle_done <= 1'b1;
			end
		end
	end
	
	assign o_mux_sel = counter [1:0];
	assign o_cycle_done = r_cycle_done;
endmodule