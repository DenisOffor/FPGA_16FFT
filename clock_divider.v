module clock_divider
(
	input 	i_clk,
	input 	i_rst,
	output	o_clk_divided2,
	output	o_clk_divided4,
	output	o_clk_divided8,
	output	o_clk_divided16
);
	reg[6:0] counter;
	
	always @(posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			counter <= 0;
		end
		else begin
			counter <= counter + 1'b1;
		end
	end

	assign o_clk_divided2 	= counter[0];
	assign o_clk_divided4 	= counter[1];
	assign o_clk_divided8 	= counter[2];
	assign o_clk_divided16 	= counter[3];
endmodule