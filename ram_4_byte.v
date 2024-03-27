module ram_4_byte #(parameter WORD_SIZE = 16)
(
	input						we,
	input				[WORD_SIZE-1:0]	in0_re,
	input				[WORD_SIZE-1:0]	in0_im,
	input				[WORD_SIZE-1:0]	in1_re,
	input				[WORD_SIZE-1:0]	in1_im,
	
	output		reg 	[WORD_SIZE-1:0]	out0_re,
	output		reg 	[WORD_SIZE-1:0]	out0_im,
	output		reg 	[WORD_SIZE-1:0]	out1_re,
	output		reg 	[WORD_SIZE-1:0]	out1_im
);

	initial begin
		out0_re  <= 0;
		out0_im  <= 0;
		out1_re  <= 0;
		out1_im  <= 0;
	end

	always @(posedge we) begin
		out0_re 	<= in0_re;
		out0_im 	<= in0_im;
		out1_re 	<= in1_re;
		out1_im 	<= in1_im;
	end
endmodule
