module rom_QAM4 #(parameter WORD_SIZE = 16)
(
	input 									i_clk,
	input									i_rst,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point1_re,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point1_im,	
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point2_re,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point2_im,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point3_re,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point3_im,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point4_re,
	output 		reg 	[WORD_SIZE-1:0]		o_constellation_point4_im
);
	always @ (posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			o_constellation_point1_re  <= 0;
			o_constellation_point1_im  <= 0;
			
			o_constellation_point2_re  <= 0;
			o_constellation_point2_im  <= 0;
			
			o_constellation_point3_re  <= 0;
			o_constellation_point3_im  <= 0;
			
			o_constellation_point4_re  <= 0;
			o_constellation_point4_im  <= 0;
		end
		else begin
			o_constellation_point1_re  <= 16'b0000000101101010; //1.4142
			o_constellation_point1_im  <= 16'b0000000011001001; //0.7854

			o_constellation_point2_re  <= 16'b0000000101101010; //1.4142
			o_constellation_point2_im  <= 16'b1111111100110111; //-0.7854

			o_constellation_point3_re  <= 16'b1111111010010110; //-1.4142
			o_constellation_point3_im  <= 16'b1111111100110111; //-0.7854

			o_constellation_point4_re  <= 16'b1111111010010110; //-1.4142
			o_constellation_point4_im  <= 16'b0000000011001001; //0.7854
		end
	end
endmodule