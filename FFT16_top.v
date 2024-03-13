module FFT16_top #(parameter N = 16, parameter Q = 8, parameter STAGES = 4)
(
	input							 	i_clk,
	input 							i_rst,
	input       	[N-1:0]     in0_re,
	input       	[N-1:0]     in0_im,
	input       	[N-1:0]     in1_re,
	input       	[N-1:0]     in1_im,
	//input       	[N-1:0]     in2_re,
	//input       	[N-1:0]     in2_im,
	//input       	[N-1:0]     in3_re,
	//input       	[N-1:0]     in3_im,
	//input       	[N-1:0]     in4_re,
	//input       	[N-1:0]     in4_im,
	//input       	[N-1:0]     in5_re,
	//input       	[N-1:0]     in5_im,
	//input       	[N-1:0]     in6_re,
	//input       	[N-1:0]     in6_im,
	//input       	[N-1:0]     in7_re,
	//input       	[N-1:0]     in7_im,
	//input       	[N-1:0]     in8_re,
	//input       	[N-1:0]     in8_im,
	//input       	[N-1:0]     in9_re,
	//input       	[N-1:0]     in9_im,
	//input       	[N-1:0]     in10_re,
	//input       	[N-1:0]     in10_im,
	//input       	[N-1:0]     in11_re,
	//input       	[N-1:0]     in11_im,
	//input       	[N-1:0]     in12_re,
	//input       	[N-1:0]     in12_im,
	//input       	[N-1:0]     in13_re,
	//input       	[N-1:0]     in13_im,
	//input       	[N-1:0]     in14_re,
	//input       	[N-1:0]     in14_im,
	//input       	[N-1:0]     in15_re,
	//input       	[N-1:0]     in15_im,
	
	output       	[N-1:0]     out0_re,
	output       	[N-1:0]     out0_im,
	output       	[N-1:0]     out1_re,
	output       	[N-1:0]     out1_im
	//output       	[N-1:0]     out2_re,
	//output       	[N-1:0]     out2_im,
	//output       	[N-1:0]     out3_re,
	//output       	[N-1:0]     out3_im,
	//output       	[N-1:0]     out4_re,
	//output       	[N-1:0]     out4_im,
	//output       	[N-1:0]     out5_re,
	//output       	[N-1:0]     out5_im,
	//output       	[N-1:0]     out6_re,
	//output       	[N-1:0]     out6_im,
	//output       	[N-1:0]     out7_re,
	//output       	[N-1:0]     out7_im,
	//output       	[N-1:0]     out8_re,
	//output       	[N-1:0]     out8_im,
	//output       	[N-1:0]     out9_re,
	//output       	[N-1:0]     out9_im,
	//output       	[N-1:0]     out10_re,
	//output       	[N-1:0]     out10_im,
	//output       	[N-1:0]     out11_re,
	//output       	[N-1:0]     out11_im,
	//output       	[N-1:0]     out12_re,
	//output       	[N-1:0]     out12_im,
	//output       	[N-1:0]     out13_re,
	//output       	[N-1:0]     out13_im,
	//output       	[N-1:0]     out14_re,
	//output       	[N-1:0]     out14_im,
	//output       	[N-1:0]     out15_re,
	//output       	[N-1:0]     out15_im
);
   //wires of butterfly_2
	wire        [N-1:0]     w_butterfly2_in0_re;
	wire        [N-1:0]     w_butterfly2_in0_im;
	wire        [N-1:0]     w_butterfly2_in1_re;
	wire        [N-1:0]     w_butterfly2_in1_im;
	wire        [N-1:0]     w_butterfly2_in2_re;
	wire        [N-1:0]     w_butterfly2_in2_im;
	wire        [N-1:0]     w_butterfly2_in3_re;
	wire        [N-1:0]     w_butterfly2_in3_im;
	wire        [N-1:0]     w_butterfly2_in4_re;
	wire        [N-1:0]     w_butterfly2_in4_im;
	wire        [N-1:0]     w_butterfly2_in5_re;
	wire        [N-1:0]     w_butterfly2_in5_im;
	wire        [N-1:0]     w_butterfly2_in6_re;
	wire        [N-1:0]     w_butterfly2_in6_im;
	wire        [N-1:0]     w_butterfly2_in7_re;
	wire        [N-1:0]     w_butterfly2_in7_im;
	wire        [N-1:0]     w_butterfly2_in8_re;
	wire        [N-1:0]     w_butterfly2_in8_im;
	wire        [N-1:0]     w_butterfly2_in9_re;
	wire        [N-1:0]     w_butterfly2_in9_im;
	wire        [N-1:0]     w_butterfly2_in10_re;
	wire        [N-1:0]     w_butterfly2_in10_im;
	wire        [N-1:0]     w_butterfly2_in11_re;
	wire        [N-1:0]     w_butterfly2_in11_im;
	wire        [N-1:0]     w_butterfly2_in12_re;
	wire        [N-1:0]     w_butterfly2_in12_im;
	wire        [N-1:0]     w_butterfly2_in13_re;
	wire        [N-1:0]     w_butterfly2_in13_im;
	wire        [N-1:0]     w_butterfly2_in14_re;
	wire        [N-1:0]     w_butterfly2_in14_im;
	wire        [N-1:0]     w_butterfly2_in15_re;
	wire        [N-1:0]     w_butterfly2_in15_im;
	
   //wires of twiddle_rom_real & twiddle_rom_imag
	wire        [N-1:0]     w_twiddle0_re;
	wire        [N-1:0]     w_twiddle0_im;
	wire        [N-1:0]     w_twiddle1_re;
	wire        [N-1:0]     w_twiddle1_im;
	wire        [N-1:0]     w_twiddle2_re;
	wire        [N-1:0]     w_twiddle2_im;
	wire        [N-1:0]     w_twiddle3_re;
	wire        [N-1:0]     w_twiddle3_im;
	wire        [N-1:0]     w_twiddle4_re;
	wire        [N-1:0]     w_twiddle4_im;
	wire        [N-1:0]     w_twiddle5_re;
	wire        [N-1:0]     w_twiddle5_im;
	wire        [N-1:0]     w_twiddle6_re;
	wire        [N-1:0]     w_twiddle6_im;
	wire        [N-1:0]     w_twiddle7_re;
	wire        [N-1:0]     w_twiddle7_im;
	
	//instant of muxes of inputs of mac
	wire       	[N-1:0]     w_Mux1_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux1_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux1_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux1_out2_im_butterfly_in;

	wire       	[N-1:0]     w_Mux2_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux2_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux2_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux2_out2_im_butterfly_in;

	wire       	[N-1:0]     w_Mux3_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux3_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux3_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux3_out2_im_butterfly_in;

	wire       	[N-1:0]     w_Mux4_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux4_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux4_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux4_out2_im_butterfly_in;

	wire       	[N-1:0]     w_Mux5_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux5_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux5_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux5_out2_im_butterfly_in;

	wire       	[N-1:0]     w_Mux6_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux6_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux6_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux6_out2_im_butterfly_in;

	wire       	[N-1:0]     w_Mux7_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux7_out1_im_butterfly_in;
	wire       	[N-1:0]     w_Mux7_out2_re_butterfly_in;
	wire       	[N-1:0]     w_Mux7_out2_im_butterfly_in;
	
	//instant of butterfly2
	wire        [N-1:0]     w_out0_re_butterfly;
	wire        [N-1:0]     w_out0_im_butterfly;
	wire        [N-1:0]     w_out1_re_butterfly;
	wire        [N-1:0]     w_out1_im_butterfly;
	wire        [N-1:0]     w_out2_re_butterfly;
	wire        [N-1:0]     w_out2_im_butterfly;
	wire        [N-1:0]     w_out3_re_butterfly;
	wire        [N-1:0]     w_out3_im_butterfly;
	wire        [N-1:0]     w_out4_re_butterfly;
	wire        [N-1:0]     w_out4_im_butterfly;
	wire        [N-1:0]     w_out5_re_butterfly;
	wire        [N-1:0]     w_out5_im_butterfly;
	wire        [N-1:0]     w_out6_re_butterfly;
	wire        [N-1:0]     w_out6_im_butterfly;
	wire        [N-1:0]     w_out7_re_butterfly;
	wire        [N-1:0]     w_out7_im_butterfly;
	wire        [N-1:0]     w_out8_re_butterfly;
	wire        [N-1:0]     w_out8_im_butterfly;
	wire        [N-1:0]     w_out9_re_butterfly;
	wire        [N-1:0]     w_out9_im_butterfly;
	wire        [N-1:0]     w_out10_re_butterfly;
	wire        [N-1:0]     w_out10_im_butterfly;
	wire        [N-1:0]     w_out11_re_butterfly;
	wire        [N-1:0]     w_out11_im_butterfly;
	wire        [N-1:0]     w_out12_re_butterfly;
	wire        [N-1:0]     w_out12_im_butterfly;
	wire        [N-1:0]     w_out13_re_butterfly;
	wire        [N-1:0]     w_out13_im_butterfly;
	wire        [N-1:0]     w_out14_re_butterfly;
	wire        [N-1:0]     w_out14_im_butterfly;
	wire        [N-1:0]     w_out15_re_butterfly;
	wire        [N-1:0]     w_out15_im_butterfly;
	
	//instant of muxes of twiddle
	wire    		[N-1:0] 		Mux1_out_twiddle_re;
	wire    		[N-1:0] 		Mux1_out_twiddle_im;
					
	wire    		[N-1:0] 		Mux2_out_twiddle_re;
	wire    		[N-1:0] 		Mux2_out_twiddle_im;
					
	wire    		[N-1:0] 		Mux3_out_twiddle_re;
	wire    		[N-1:0] 		Mux3_out_twiddle_im;
					
	wire    		[N-1:0] 		Mux4_out_twiddle_re;
	wire    		[N-1:0] 		Mux4_out_twiddle_im;
					
	wire    		[N-1:0] 		Mux5_out_twiddle_re;
	wire    		[N-1:0] 		Mux5_out_twiddle_im;
					
	wire    		[N-1:0] 		Mux6_out_twiddle_re;
	wire    		[N-1:0] 		Mux6_out_twiddle_im;
					
	wire    		[N-1:0] 		Mux7_out_twiddle_re;
	wire    		[N-1:0] 		Mux7_out_twiddle_im;


	rom_twiddle #(.N(N)) twiddle_rom 
	(
		.clk(i_clk),
		.rst(i_rst),
		.reg0_re(w_twiddle0_re),
		.reg0_im(w_twiddle0_im),	
		.reg1_re(w_twiddle1_re),
		.reg1_im(w_twiddle1_im),
		.reg2_re(w_twiddle2_re),
		.reg2_im(w_twiddle2_im),
		.reg3_re(w_twiddle3_re),
		.reg3_im(w_twiddle3_im),
		.reg4_re(w_twiddle4_re),
		.reg4_im(w_twiddle4_im),
		.reg5_re(w_twiddle5_re),
		.reg5_im(w_twiddle5_im),
		.reg6_re(w_twiddle6_re),
		.reg6_im(w_twiddle6_im),
		.reg7_re(w_twiddle7_re),
		.reg7_im(w_twiddle7_im)
	);
	
endmodule


