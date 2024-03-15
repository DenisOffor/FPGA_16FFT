module FFT16_top_tb #(parameter N = 16, Q = 8, STAGES = 4)
(
	output 		[N-1:0] 		out0re,
	output 		[N-1:0] 		out0im,
	output 		[N-1:0] 		out1re,
	output 		[N-1:0] 		out1im,
	output 		[N-1:0] 		out2re,
	output 		[N-1:0] 		out2im,
	output 		[N-1:0] 		out3re,
	output 		[N-1:0] 		out3im,
	output 		[N-1:0] 		out4re,
	output 		[N-1:0] 		out4im,
	output 		[N-1:0] 		out5re,
	output 		[N-1:0] 		out5im,
	
	output						o_FFT_cycle_done,
	
	output 			[N-1:0]		w_out0_re_butterfly,
	output 			[N-1:0]     w_out0_im_butterfly,
	output 			[N-1:0]     w_out1_re_butterfly,
	output 			[N-1:0]     w_out1_im_butterfly,
	
	output 			[N-1:0]		w_Mux0_out0_re_butterfly_in,
	output 			[N-1:0]     w_Mux0_out0_im_butterfly_in,
	output 			[N-1:0]     w_Mux0_out1_re_butterfly_in,
	output 			[N-1:0]     w_Mux0_out1_im_butterfly_in,
	
	output 			[N-1:0]		w_Mux0_out_twiddle_re,
	output 			[N-1:0]     w_Mux0_out_twiddle_im,
	output			[1:0]			o_Mux_switcher_butterfly,
	output 							o_butterfly_done,
	output							w_mutiplier_done
);

	reg clk = 0;
	reg [N-1:0] in_1Hz, in_2Hz, in_4Hz, in_8Hz, in_9HZ;
	
	initial begin		
		#0 in_1Hz = 16'b0000000100000000;
		//#0 i_in0_im = 16'b0000000011001001;
	
		#0 in_2Hz = 16'b0000001000000000;
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
		.in0_im(0),
		.in1_re(in_2Hz),
		.in1_im(0),
		.in2_re(0),
		.in2_im(0),
		.in3_re(in_4Hz),
		.in3_im(0),
		.in4_re(0),
		.in4_im(0),
		.in5_re(),
		.in5_im(0),
		.in6_re(0),
		.in6_im(0),
		.in7_re(in_8Hz),
		.in7_im(0),
		.in8_re(in_9HZ),
		.in8_im(0),
		.in9_re(0),
		.in9_im(0),
		.in10_re(0),
		.in10_im(),
		.in11_re(0),
		.in11_im(0),
		.in12_re(0),
		.in12_im(0),
		.in13_re(0),
		.in13_im(0),
		.in14_re(0),
		.in14_im(0),
		.in15_re(0),
		.in15_im(0),
		
		.out0_re(out0re),
		.out0_im(out0im),
		.out1_re(out1re),
		.out1_im(out1im),
		.out2_re(out2re),
		.out2_im(out2im),
		.out3_re(out3re),
		.out3_im(out3im),
		.out4_re(out4re),
		.out4_im(out4im),
		.out5_re(out5re),
		.out5_im(out5im),
		.out6_re(),
		.out6_im(),
		.out7_re(),
		.out7_im(),
		.out8_re(),
		.out8_im(),
		.out9_re(),
		.out9_im(),
		.out10_re(),
		.out10_im(),
		.out11_re(),
		.out11_im(),
		.out12_re(),
		.out12_im(),
		.out13_re(),
		.out13_im(),
		.out14_re(),
		.out14_im(),
		.out15_re(),
		.out15_im(),
		
		.o_FFT_cycle_done(o_FFT_cycle_done),
		
		.w_out0_re_butterfly(w_out0_re_butterfly),
		.w_out0_im_butterfly(w_out0_im_butterfly),
		.w_out1_re_butterfly(w_out1_re_butterfly),
		.w_out1_im_butterfly(w_out1_im_butterfly),
		
		.w_Mux0_out0_re_butterfly_in(w_Mux0_out0_re_butterfly_in),
		.w_Mux0_out0_im_butterfly_in(w_Mux0_out0_im_butterfly_in),
		.w_Mux0_out1_re_butterfly_in(w_Mux0_out1_re_butterfly_in),
		.w_Mux0_out1_im_butterfly_in(w_Mux0_out1_im_butterfly_in),
		
		.w_Mux0_out_twiddle_re(w_Mux0_out_twiddle_re),
		.w_Mux0_out_twiddle_im(w_Mux0_out_twiddle_im),
		.o_Mux_switcher_butterfly(o_Mux_switcher_butterfly),
		.o_butterfly_done(o_butterfly_done),
		.w_mutiplier_done(w_mutiplier_done)
	);

endmodule
