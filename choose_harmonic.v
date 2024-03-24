module choose_harmonic #(parameter WORD_SIZE = 16)
(
	input	[1:0]				select,
	
	input	[WORD_SIZE-1:0]		i_constellation_point1_re,
	input	[WORD_SIZE-1:0]		i_constellation_point1_im,
	input	[WORD_SIZE-1:0]		i_constellation_point2_re,
	input	[WORD_SIZE-1:0]		i_constellation_point2_im,
	input	[WORD_SIZE-1:0]		i_constellation_point3_re,
	input	[WORD_SIZE-1:0]		i_constellation_point3_im,
	input	[WORD_SIZE-1:0]		i_constellation_point4_re,
	input	[WORD_SIZE-1:0]		i_constellation_point4_im,

	output 	[WORD_SIZE-1:0]		o_harmonic_re,
	output 	[WORD_SIZE-1:0]		o_harmonic_im
);
	reg 	[WORD_SIZE-1:0] 	r_harmonic_re;
	reg 	[WORD_SIZE-1:0] 	r_harmonic_im;

	always @(*) begin
		case(select)
			2'b00: begin
				r_harmonic_re <= i_constellation_point1_re;
				r_harmonic_im <= i_constellation_point1_im;
			end
			
			2'b01: begin
				r_harmonic_re <= i_constellation_point2_re;
				r_harmonic_im <= i_constellation_point2_im;
			end
			
			2'b10: begin
				r_harmonic_re <= i_constellation_point3_re;
				r_harmonic_im <= i_constellation_point3_im;
			end
			
			2'b11: begin
				r_harmonic_re <= i_constellation_point4_re;
				r_harmonic_im <= i_constellation_point4_im;
			end
		endcase
	end
	
	assign o_harmonic_re = r_harmonic_re;
	assign o_harmonic_im = r_harmonic_im;
endmodule
