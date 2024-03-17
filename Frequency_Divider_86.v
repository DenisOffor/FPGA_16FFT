module Frequency_Divider_86 #(parameter DIVIDE_FACTOR = 43)
(
    input		i_clk,
	 input		i_rst,
    output reg o_clk_devided86
);
	reg [7:0] counter = 0;

	initial begin
		counter <= 0;
		o_clk_devided86 <= 0;
	end
	
	always @(posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			counter <= 0;
			o_clk_devided86 <= 0;
		end
		else begin
			counter <= counter + 1;
			if (counter == DIVIDE_FACTOR - 1) begin
				counter <= 0;
				o_clk_devided86 <= ~o_clk_devided86;
			end
		end
	end
endmodule