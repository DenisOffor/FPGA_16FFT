module ram_16_byte #(parameter WORD_SIZE = 16)
(
	input						we,
	input				[WORD_SIZE-1:0]	in0_re,
	input				[WORD_SIZE-1:0]	in0_im,
	input				[WORD_SIZE-1:0]	in1_re,
	input				[WORD_SIZE-1:0]	in1_im,
	input				[WORD_SIZE-1:0]	in2_re,
	input				[WORD_SIZE-1:0]	in2_im,
	input				[WORD_SIZE-1:0]	in3_re,
	input				[WORD_SIZE-1:0]	in3_im,
	input				[WORD_SIZE-1:0]	in4_re,
	input				[WORD_SIZE-1:0]	in4_im,
	input				[WORD_SIZE-1:0]	in5_re,
	input				[WORD_SIZE-1:0]	in5_im,
	input				[WORD_SIZE-1:0]	in6_re,
	input				[WORD_SIZE-1:0]	in6_im,
	input				[WORD_SIZE-1:0]	in7_re,
	input				[WORD_SIZE-1:0]	in7_im,
	input				[WORD_SIZE-1:0]	in8_re,
	input				[WORD_SIZE-1:0]	in8_im,
	input				[WORD_SIZE-1:0]	in9_re,
	input				[WORD_SIZE-1:0]	in9_im,
	input				[WORD_SIZE-1:0]	in10_re,
	input				[WORD_SIZE-1:0]	in10_im,
	input				[WORD_SIZE-1:0]	in11_re,
	input				[WORD_SIZE-1:0]	in11_im,
	input				[WORD_SIZE-1:0]	in12_re,
	input				[WORD_SIZE-1:0]	in12_im,
	input				[WORD_SIZE-1:0]	in13_re,
	input				[WORD_SIZE-1:0]	in13_im,
	input				[WORD_SIZE-1:0]	in14_re,
	input				[WORD_SIZE-1:0]	in14_im,
	input				[WORD_SIZE-1:0]	in15_re,
	input				[WORD_SIZE-1:0]	in15_im,
	
	output		reg 	[WORD_SIZE-1:0]	out0_re,
	output		reg 	[WORD_SIZE-1:0]	out0_im,
	output		reg 	[WORD_SIZE-1:0]	out1_re,
	output		reg 	[WORD_SIZE-1:0]	out1_im,
	output		reg 	[WORD_SIZE-1:0]	out2_re,
	output		reg 	[WORD_SIZE-1:0]	out2_im,
	output		reg 	[WORD_SIZE-1:0]	out3_re,
	output		reg 	[WORD_SIZE-1:0]	out3_im,
	output		reg 	[WORD_SIZE-1:0]	out4_re,
	output		reg 	[WORD_SIZE-1:0]	out4_im,
	output		reg 	[WORD_SIZE-1:0]	out5_re,
	output		reg 	[WORD_SIZE-1:0]	out5_im,
	output		reg 	[WORD_SIZE-1:0]	out6_re,
	output		reg 	[WORD_SIZE-1:0]	out6_im,
	output		reg 	[WORD_SIZE-1:0]	out7_re,
	output		reg 	[WORD_SIZE-1:0]	out7_im,
	output		reg 	[WORD_SIZE-1:0]	out8_re,
	output		reg 	[WORD_SIZE-1:0]	out8_im,
	output		reg 	[WORD_SIZE-1:0]	out9_re,
	output		reg 	[WORD_SIZE-1:0]	out9_im,
	output		reg 	[WORD_SIZE-1:0]	out10_re,
	output		reg 	[WORD_SIZE-1:0]	out10_im,
	output		reg 	[WORD_SIZE-1:0]	out11_re,
	output		reg 	[WORD_SIZE-1:0]	out11_im,
	output		reg 	[WORD_SIZE-1:0]	out12_re,
	output		reg 	[WORD_SIZE-1:0]	out12_im,
	output		reg 	[WORD_SIZE-1:0]	out13_re,
	output		reg 	[WORD_SIZE-1:0]	out13_im,
	output		reg 	[WORD_SIZE-1:0]	out14_re,
	output		reg 	[WORD_SIZE-1:0]	out14_im,
	output		reg 	[WORD_SIZE-1:0]	out15_re,
	output		reg 	[WORD_SIZE-1:0]	out15_im
);

	always @(posedge we) begin
		out0_re 	<= in0_re;
		out0_im 	<= in0_im;
		out1_re 	<= in1_re;
		out1_im 	<= in1_im;
		out2_re 	<= in2_re;
		out2_im 	<= in2_im;
		out3_re 	<= in3_re;
		out3_im 	<= in3_im;
		out4_re 	<= in4_re;
		out4_im 	<= in4_im;
		out5_re 	<= in5_re;
		out5_im 	<= in5_im;
		out6_re 	<= in6_re;
		out6_im 	<= in6_im;
		out7_re 	<= in7_re;
		out7_im 	<= in7_im;
		out8_re 	<= in8_re;
		out8_im 	<= in8_im;
		out9_re 	<= in9_re;
		out9_im 	<= in9_im;
		out10_re 	<= in10_re;
		out10_im 	<= in10_im;
		out11_re 	<= in11_re;
		out11_im 	<= in11_im;
		out12_re 	<= in12_re;
		out12_im 	<= in12_im;
		out13_re 	<= in13_re;
		out13_im 	<= in13_im;
		out14_re 	<= in14_re;
		out14_im 	<= in14_im;
		out15_re 	<= in15_re;
		out15_im 	<= in15_im;
	end
endmodule
