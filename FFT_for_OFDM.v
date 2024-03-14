module FFT_for_OFDM #(parameter N = 16, Q = 8, STAGES = 4)
(
	input 							i_clk,
	input 							i_rst,
	
	input 			[N-1:0]		in_1Hz_re,
	input 			[N-1:0]		in_1Hz_im,
	input 			[N-1:0]		in_2Hz_re,
	input 			[N-1:0]		in_2Hz_im,
	input 			[N-1:0]		in_4Hz_re,
	input 			[N-1:0]		in_4Hz_im,
	input 			[N-1:0]		in_8Hz_re,
	input 			[N-1:0]		in_8Hz_im,
	
	output			[2*N-1:0]	out_instant,
	output							o_FFT_cycle_done
);
	wire 			w_fft_out0_re;
	wire 			w_fft_out0_im;
	wire 			w_fft_out1_re;
	wire 			w_fft_out1_im;
	wire 			w_fft_out2_re;
	wire 			w_fft_out2_im;
	wire 			w_fft_out3_re;
	wire 			w_fft_out3_im;
	wire 			w_fft_out4_re;
	wire 			w_fft_out4_im;
	wire 			w_fft_out5_re;
	wire 			w_fft_out5_im;
	wire 			w_fft_out6_re;
	wire 			w_fft_out6_im;
	wire 			w_fft_out7_re;
	wire 			w_fft_out7_im;
	wire 			w_fft_out8_re;
	wire 			w_fft_out8_im;
	wire 			w_fft_out9_re;
	wire 			w_fft_out9_im;
	wire 			w_fft_out10_re;
	wire 			w_fft_out10_im;
	wire 			w_fft_out11_re;
	wire 			w_fft_out11_im;
	wire 			w_fft_out12_re;
	wire 			w_fft_out12_im;
	wire 			w_fft_out13_re;
	wire 			w_fft_out13_im;
	wire 			w_fft_out14_re;
	wire 			w_fft_out14_im;
	wire 			w_fft_out15_re;
	wire 			w_fft_out15_im;

	wire 			w_re;
	reg [3:0] 	fft_out_switcher;
	
	initial begin
		fft_out_switcher <= 0;
	end
	
	always @(posedge i_clk) begin
	
	end
	
	FFT16_top #(.N(N), .Q(Q), .STAGES(STAGES)) FFT16
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.in0_re(in_1Hz_re),
		.in0_im(in_1Hz_im),
		.in1_re(in_2Hz_re),
		.in1_im(in_2Hz_im),
		.in2_re(0),
		.in2_im(0),
		.in3_re(in_4Hz_re),
		.in3_im(in_4Hz_im),
		.in4_re(0),
		.in4_im(0),
		.in5_re(0),
		.in5_im(0),
		.in6_re(0),
		.in6_im(0),
		.in7_re(in_8Hz_re),
		.in7_im(in_8Hz_im),
		.in8_re(0),
		.in8_im(0),
		.in9_re(0),
		.in9_im(0),
		.in10_re(0),
		.in10_im(0),
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
		
		.out0_re(w_fft_out0_re),
		.out0_im(w_fft_out0_im),
		.out1_re(w_fft_out1_re),
		.out1_im(w_fft_out1_im),
		.out2_re(w_fft_out2_re),
		.out2_im(w_fft_out2_im),
		.out3_re(w_fft_out3_re),
		.out3_im(w_fft_out3_im),
		.out4_re(w_fft_out4_re),
		.out4_im(w_fft_out4_im),
		.out5_re(w_fft_out5_re),
		.out5_im(w_fft_out5_im),
		.out6_re(w_fft_out6_re),
		.out6_im(w_fft_out6_im),
		.out7_re(w_fft_out7_re),
		.out7_im(w_fft_out7_im),
		.out8_re(w_fft_out8_re),
		.out8_im(w_fft_out8_im),
		.out9_re(w_fft_out9_re),
		.out9_im(w_fft_out9_im),
		.out10_re(w_fft_out10_re),
		.out10_im(w_fft_out10_im),
		.out11_re(w_fft_out11_re),
		.out11_im(w_fft_out11_im),
		.out12_re(w_fft_out12_re),
		.out12_im(w_fft_out12_im),
		.out13_re(w_fft_out13_re),
		.out13_im(w_fft_out13_im),
		.out14_re(w_fft_out14_re),
		.out14_im(w_fft_out14_im),
		.out15_re(w_fft_out15_re),
		.out15_im(w_fft_out15_im),

		.o_FFT_cycle_done(o_FFT_cycle_done)
	);
	
	
	ram_for_signal #(.ADDR_WIDTH(STAGES), .DATA_WIDTH(N), .DEPTH(N)) ram_for_signal
	(
		.clk(i_clk),
		.addr(0),
		.re(1),
		.data00_r(w_fft_out0_re),
		.data01_r(w_fft_out1_re),
		.data02_r(w_fft_out2_re),
		.data03_r(w_fft_out3_re),
		.data04_r(w_fft_out4_re),
		.data05_r(w_fft_out5_re),
		.data06_r(w_fft_out6_re),
		.data07_r(w_fft_out7_re),
		.data08_r(w_fft_out8_re),
		.data09_r(w_fft_out9_re),
		.data10_r(w_fft_out10_re),
		.data11_r(w_fft_out11_re),
		.data12_r(w_fft_out12_re),
		.data13_r(w_fft_out13_re),
		.data14_r(w_fft_out14_re),
		.data15_r(w_fft_out15_re),
		
		.data00_i(w_fft_out0_im),
		.data01_i(w_fft_out1_im),
		.data02_i(w_fft_out2_im),
		.data03_i(w_fft_out3_im),
		.data04_i(w_fft_out4_im),
		.data05_i(w_fft_out5_im),
		.data06_i(w_fft_out6_im),
		.data07_i(w_fft_out7_im),
		.data08_i(w_fft_out8_im),
		.data09_i(w_fft_out9_im),
		.data10_i(w_fft_out10_im),
		.data11_i(w_fft_out11_im),
		.data12_i(w_fft_out12_im),
		.data13_i(w_fft_out13_im),
		.data14_i(w_fft_out14_im),
		.data15_i(w_fft_out15_im),
		.data(out_instant)
	);
endmodule
