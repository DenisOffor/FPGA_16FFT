module FFT16_top_tb #(parameter N = 16, Q = 8, STAGES = 4)
(
	output 		[N-1:0] 		out0_re,
	output 		[N-1:0] 		out0_im,
	output 		[N-1:0] 		out1_re,
	output 		[N-1:0] 		out1_im,
	output 		[N-1:0] 		out2_re,
	output 		[N-1:0] 		out2_im,
	output 		[N-1:0] 		out3_re,
	output 		[N-1:0] 		out3_im,
	output 		[N-1:0] 		out4_re,
	output 		[N-1:0] 		out4_im,
	output 		[N-1:0] 		out5_re,
	output 		[N-1:0] 		out5_im,
	output 		[N-1:0] 		out6_re,
	output 		[N-1:0] 		out6_im,
	output 		[N-1:0] 		out7_re,
	output 		[N-1:0] 		out7_im,
	output 		[N-1:0] 		out8_re,
	output 		[N-1:0] 		out8_im,
	output 		[N-1:0] 		out9_re,
	output 		[N-1:0] 		out9_im,
	output 		[N-1:0] 		out10_re,
	output 		[N-1:0] 		out10_im,
	output 		[N-1:0] 		out11_re,
	output 		[N-1:0] 		out11_im,
	output 		[N-1:0] 		out12_re,
	output 		[N-1:0] 		out12_im,
	//output 		[N-1:0] 		out13_re,
	//output 		[N-1:0] 		out13_im,
	//output 		[N-1:0] 		out14_re,
	//output 		[N-1:0] 		out14_im,
	//output 		[N-1:0] 		out15_re,
	//output 		[N-1:0] 		out15_im,
	
	output						o_FFT_cycle_done,
	output 						o_butterfly_done,
	
	//output 			[N-1:0]		w_Mux0_out0_re_butterfly_in,
	//output         [N-1:0]     w_Mux0_out0_im_butterfly_in,
	//output         [N-1:0]     w_Mux0_out1_re_butterfly_in,
	//output         [N-1:0]     w_Mux0_out1_im_butterfly_in,
	//
	//output         [N-1:0]     w_Mux0_out_twiddle_re,
	//output         [N-1:0]     w_Mux0_out_twiddle_im,
	output 			[1:0]			Mux_switcher_butterfly
);

	reg clk = 0;
	reg [N-1:0] in_1Hz, in_2Hz, in_4Hz, in_8Hz, in_9HZ;
	
	initial begin		
		#930 in_1Hz = 16'b0000000100000000;
		//#0 i_in0_im = 16'b0000000011001001;
	
		#0 in_2Hz = 16'b0000000100000000;
		//#0 i_in1_im = 16'b0000000011001001;
	
		#0 in_4Hz = 16'b0000001100000000;
		//#0 i_twiddle_im = 16'b0000000011001001;
		
		#0 in_8Hz = 16'b0000010000000000;
		
		#0 in_9HZ = 16'b0000010100000000;
	end
	
	always @(*)
		#10 clk <= ~clk;
		
	FFT16_top #(.N(N), .Q(Q), .STAGES(STAGES)) FFT16_top
	(
		.i_clk(clk),
		.i_rst(0),
		.in0_re(in_1Hz),
		.in0_im(16'b0000000000000000),
		.in1_re(in_2Hz),
		.in1_im(16'b0000000000000000),
		.in2_re(16'b0000000000000000),
		.in2_im(16'b0000000000000000),
		.in3_re(16'b0000000000000000),
		.in3_im(16'b0000000000000000),
		.in4_re(16'b0000000000000000),
		.in4_im(16'b0000000000000000),
		.in5_re(16'b0000000000000000),
		.in5_im(16'b0000000000000000),
		.in6_re(16'b0000000000000000),
		.in6_im(16'b0000000000000000),
		.in7_re(16'b0000000000000000),
		.in7_im(16'b0000000000000000),
		.in8_re(16'b0000000000000000),
		.in8_im(16'b0000000000000000),
		.in9_re(16'b0000000000000000),
		.in9_im(16'b0000000000000000),
		.in10_re(16'b0000000000000000),
		.in10_im(16'b0000000000000000),
		.in11_re(16'b0000000000000000),
		.in11_im(16'b0000000000000000),
		.in12_re(16'b0000000000000000),
		.in12_im(16'b0000000000000000),
		.in13_re(16'b0000000000000000),
		.in13_im(16'b0000000000000000),
		.in14_re(16'b0000000000000000),
		.in14_im(16'b0000000000000000),
		.in15_re(16'b0000000000000000),
		.in15_im(16'b0000000000000000),
		
		.out0_re(out0_re),
		.out0_im(out0_im),
		.out1_re(out1_re),
		.out1_im(out1_im),
		.out2_re(out2_re),
		.out2_im(out2_im),
		.out3_re(out3_re),
		.out3_im(out3_im),
		.out4_re(out4_re),
		.out4_im(out4_im),
		.out5_re(out5_re),
		.out5_im(out5_im),
		.out6_re(out6_re),
		.out6_im(out6_im),
		.out7_re(out7_re),
		.out7_im(out7_im),
		.out8_re(out8_re),
		.out8_im(out8_im),
		.out9_re(out9_re),
		.out9_im(out9_im),
		.out10_re(out10_re),
		.out10_im(out10_im),
		.out11_re(out11_re),
		.out11_im(out11_im),
		.out12_re(out12_re),
		.out12_im(out12_im),
		.out13_re(),
		.out13_im(),
		.out14_re(),
		.out14_im(),
		.out15_re(),
		.out15_im(),
		
		.o_FFT_cycle_done(o_FFT_cycle_done),
		.o_butterfly_done(o_butterfly_done),
		
		//.w_Mux0_out0_re_butterfly_in(w_Mux0_out0_re_butterfly_in),
		//.w_Mux0_out0_im_butterfly_in(w_Mux0_out0_im_butterfly_in),
		//.w_Mux0_out1_re_butterfly_in(w_Mux0_out1_re_butterfly_in),
		//.w_Mux0_out1_im_butterfly_in(w_Mux0_out1_im_butterfly_in),
		//
		//.w_Mux0_out_twiddle_re(w_Mux0_out_twiddle_re),
		//.w_Mux0_out_twiddle_im(w_Mux0_out_twiddle_im),
		.Mux_switcher_butterfly(Mux_switcher_butterfly)
	);

endmodule
