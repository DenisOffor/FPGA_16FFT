module FFT_for_OFDM #(parameter WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8)
(
	input 								i_clk,
	input 								i_rst,
	input 			[DATA_LENGTH:0]		i_byte,		
	
	output 			[WORD_SIZE-1:0]     out0_re,
	output 			[WORD_SIZE-1:0]     out0_im,
	output 			[WORD_SIZE-1:0]     out1_re,
	output 			[WORD_SIZE-1:0]     out1_im,
	output 			[WORD_SIZE-1:0]     out2_re,
	output 			[WORD_SIZE-1:0]     out2_im,
	output 			[WORD_SIZE-1:0]     out3_re,
	output 			[WORD_SIZE-1:0]     out3_im,
	output 			[WORD_SIZE-1:0]     out4_re,
	output 			[WORD_SIZE-1:0]     out4_im,
	output 			[WORD_SIZE-1:0]     out5_re,
	output 			[WORD_SIZE-1:0]     out5_im,
	output 			[WORD_SIZE-1:0]     out6_re,
	output 			[WORD_SIZE-1:0]     out6_im,
	output 			[WORD_SIZE-1:0]     out7_re,
	output 			[WORD_SIZE-1:0]     out7_im,
	output 			[WORD_SIZE-1:0]     out8_re,
	output 			[WORD_SIZE-1:0]     out8_im,
	output 			[WORD_SIZE-1:0]     out9_re,
	output 			[WORD_SIZE-1:0]     out9_im,
	output 			[WORD_SIZE-1:0]     out10_re,
	output 			[WORD_SIZE-1:0]     out10_im,
	output 			[WORD_SIZE-1:0]     out11_re,
	output 			[WORD_SIZE-1:0]     out11_im,
	output 			[WORD_SIZE-1:0]     out12_re,
	output 			[WORD_SIZE-1:0]     out12_im,
	output 			[WORD_SIZE-1:0]     out13_re,
	output 			[WORD_SIZE-1:0]     out13_im,
	output 			[WORD_SIZE-1:0]     out14_re,
	output 			[WORD_SIZE-1:0]     out14_im,
	output 			[WORD_SIZE-1:0]     out15_re,
	output 			[WORD_SIZE-1:0]     out15_im,
	output       	[WORD_SIZE-1:0]     out16_re,
	output       	[WORD_SIZE-1:0]     out16_im,
	output       	[WORD_SIZE-1:0]     out17_re,
	output       	[WORD_SIZE-1:0]     out17_im,
	output       	[WORD_SIZE-1:0]     out18_re,
	output       	[WORD_SIZE-1:0]     out18_im,
	output       	[WORD_SIZE-1:0]     out19_re,
	output       	[WORD_SIZE-1:0]     out19_im,
	output       	[WORD_SIZE-1:0]     out20_re,
	output       	[WORD_SIZE-1:0]     out20_im,
	output       	[WORD_SIZE-1:0]     out21_re,
	output       	[WORD_SIZE-1:0]     out21_im,
	output       	[WORD_SIZE-1:0]     out22_re,
	output       	[WORD_SIZE-1:0]     out22_im,
	output       	[WORD_SIZE-1:0]     out23_re,
	output       	[WORD_SIZE-1:0]     out23_im,
	output       	[WORD_SIZE-1:0]     out24_re,
	output       	[WORD_SIZE-1:0]     out24_im,
	output       	[WORD_SIZE-1:0]     out25_re,
	output       	[WORD_SIZE-1:0]     out25_im,
	output       	[WORD_SIZE-1:0]     out26_re,
	output       	[WORD_SIZE-1:0]     out26_im,
	output       	[WORD_SIZE-1:0]     out27_re,
	output       	[WORD_SIZE-1:0]     out27_im,
	output       	[WORD_SIZE-1:0]     out28_re,
	output       	[WORD_SIZE-1:0]     out28_im,
	output       	[WORD_SIZE-1:0]     out29_re,
	output       	[WORD_SIZE-1:0]     out29_im,
	output       	[WORD_SIZE-1:0]     out30_re,
	output       	[WORD_SIZE-1:0]     out30_im,
	output       	[WORD_SIZE-1:0]     out31_re,
	output       	[WORD_SIZE-1:0]     out31_im,
	
	output								o_FFT32_cycle_done
);	
	
	//wires for choosen harmics depends on input byte
	wire 			[WORD_SIZE-1:0]		w_1Hz_re; 
	wire 			[WORD_SIZE-1:0]		w_1Hz_im; 
	wire 			[WORD_SIZE-1:0]		w_2Hz_re; 
	wire 			[WORD_SIZE-1:0]		w_2Hz_im; 
	wire 			[WORD_SIZE-1:0]		w_4Hz_re; 
	wire 			[WORD_SIZE-1:0]		w_4Hz_im; 
	wire 			[WORD_SIZE-1:0]		w_8Hz_re; 
	wire 			[WORD_SIZE-1:0]		w_8Hz_im; 
	
	//wires for QAM4 constatns
	wire 			[WORD_SIZE-1:0]		w_constellation_point1_re;
	wire 			[WORD_SIZE-1:0]		w_constellation_point1_im;
	wire 			[WORD_SIZE-1:0]		w_constellation_point2_re;
	wire 			[WORD_SIZE-1:0]		w_constellation_point2_im;
	wire 			[WORD_SIZE-1:0]		w_constellation_point3_re;
	wire 			[WORD_SIZE-1:0]		w_constellation_point3_im;
	wire 			[WORD_SIZE-1:0]		w_constellation_point4_re;
	wire 			[WORD_SIZE-1:0]		w_constellation_point4_im;
	
	reg 								r_FFT_cycle_done;
	wire								w_FFT32_cycle_done;
	assign							o_FFT32_cycle_done = r_FFT_cycle_done;
	
	always @(posedge i_clk)
		r_FFT_cycle_done <= w_FFT32_cycle_done;
	
	rom_QAM4 #(.WORD_SIZE(WORD_SIZE)) rom_QAM4
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.o_constellation_point1_re(w_constellation_point1_re),
		.o_constellation_point1_im(w_constellation_point1_im),	
		.o_constellation_point2_re(w_constellation_point2_re),
		.o_constellation_point2_im(w_constellation_point2_im),
		.o_constellation_point3_re(w_constellation_point3_re),
		.o_constellation_point3_im(w_constellation_point3_im),
		.o_constellation_point4_re(w_constellation_point4_re),
		.o_constellation_point4_im(w_constellation_point4_im)
	);

	choose_harmonic #(.WORD_SIZE(WORD_SIZE)) choose_1_harmonic
	(
		.select(i_byte[1:0]),
		.i_constellation_point1_re(w_constellation_point1_re),
		.i_constellation_point1_im(w_constellation_point1_im),
		.i_constellation_point2_re(w_constellation_point2_re),
		.i_constellation_point2_im(w_constellation_point2_im),
		.i_constellation_point3_re(w_constellation_point3_re),
		.i_constellation_point3_im(w_constellation_point3_im),
		.i_constellation_point4_re(w_constellation_point4_re),
		.i_constellation_point4_im(w_constellation_point4_im),
		.o_harmonic_re(w_1Hz_re),
		.o_harmonic_im(w_1Hz_im)
	);
	
	choose_harmonic #(.WORD_SIZE(WORD_SIZE)) choose_2_harmonic
	(
		.select(i_byte[3:2]),
		.i_constellation_point1_re(w_constellation_point1_re),
		.i_constellation_point1_im(w_constellation_point1_im),
		.i_constellation_point2_re(w_constellation_point2_re),
		.i_constellation_point2_im(w_constellation_point2_im),
		.i_constellation_point3_re(w_constellation_point3_re),
		.i_constellation_point3_im(w_constellation_point3_im),
		.i_constellation_point4_re(w_constellation_point4_re),
		.i_constellation_point4_im(w_constellation_point4_im),
		.o_harmonic_re(w_2Hz_re),
		.o_harmonic_im(w_2Hz_im)
	);
	
	choose_harmonic #(.WORD_SIZE(WORD_SIZE)) choose_3_harmonic
	(
		.select(i_byte[5:4]),
		.i_constellation_point1_re(w_constellation_point1_re),
		.i_constellation_point1_im(w_constellation_point1_im),
		.i_constellation_point2_re(w_constellation_point2_re),
		.i_constellation_point2_im(w_constellation_point2_im),
		.i_constellation_point3_re(w_constellation_point3_re),
		.i_constellation_point3_im(w_constellation_point3_im),
		.i_constellation_point4_re(w_constellation_point4_re),
		.i_constellation_point4_im(w_constellation_point4_im),
		.o_harmonic_re(w_4Hz_re),
		.o_harmonic_im(w_4Hz_im)
	);
	
	choose_harmonic #(.WORD_SIZE(WORD_SIZE)) choose_4_harmonic
	(
		.select(i_byte[7:6]),
		.i_constellation_point1_re(w_constellation_point1_re),
		.i_constellation_point1_im(w_constellation_point1_im),
		.i_constellation_point2_re(w_constellation_point2_re),
		.i_constellation_point2_im(w_constellation_point2_im),
		.i_constellation_point3_re(w_constellation_point3_re),
		.i_constellation_point3_im(w_constellation_point3_im),
		.i_constellation_point4_re(w_constellation_point4_re),
		.i_constellation_point4_im(w_constellation_point4_im),
		.o_harmonic_re(w_8Hz_re),
		.o_harmonic_im(w_8Hz_im)
	);
	
	FFT32_top #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) my_FFT32_top
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.in0_re(w_1Hz_re),
		.in0_im(w_1Hz_im),
		.in1_re(w_2Hz_re),
		.in1_im(w_2Hz_im),
		.in2_re(0),
		.in2_im(0),
		.in3_re(w_4Hz_re),
		.in3_im(w_4Hz_im),
		.in4_re(0),
		.in4_im(0),
		.in5_re(0),
		.in5_im(0),
		.in6_re(0),
		.in6_im(0),
		.in7_re(w_8Hz_re),
		.in7_im(w_8Hz_im),
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
		.in16_re(0),
		.in16_im(0),
		.in17_re(0),
		.in17_im(0),
		.in18_re(0),
		.in18_im(0),
		.in19_re(0),
		.in19_im(0),
		.in20_re(0),
		.in20_im(0),
		.in21_re(0),
		.in21_im(0),
		.in22_re(0),
		.in22_im(0),
		.in23_re(0),
		.in23_im(0),
		.in24_re(0),
		.in24_im(0),
		.in25_re(0),
		.in25_im(0),
		.in26_re(0),
		.in26_im(0),
		.in27_re(0),
		.in27_im(0),
		.in28_re(0),
		.in28_im(0),
		.in29_re(0),
		.in29_im(0),
		.in30_re(0),
		.in30_im(0),
		.in31_re(0),
		.in31_im(0),
		
		.out0_re(out0_re),
		.out0_im(out0_im),
		.out1_re(out16_re),
		.out1_im(out16_im),
		.out2_re(out31_re),
		.out2_im(out31_im),
		.out3_re(out15_re),
		.out3_im(out15_im),
		.out4_re(out30_re),
		.out4_im(out30_im),
		.out5_re(out14_re),
		.out5_im(out14_im),
		.out6_re(out29_re),
		.out6_im(out29_im),
		.out7_re(out13_re),
		.out7_im(out13_im),
		.out8_re(out28_re),
		.out8_im(out28_im),
		.out9_re(out12_re),
		.out9_im(out12_im),
		.out10_re(out27_re),
		.out10_im(out27_im),
		.out11_re(out11_re),
		.out11_im(out11_im),
		.out12_re(out26_re),
		.out12_im(out26_im),
		.out13_re(out10_re),
		.out13_im(out10_im),
		.out14_re(out25_re),
		.out14_im(out25_im),
		.out15_re(out9_re),
		.out15_im(out9_im),
		.out16_re(out24_re),
		.out16_im(out24_im),
		.out17_re(out8_re),
		.out17_im(out8_im),
		.out18_re(out23_re),
		.out18_im(out23_im),
		.out19_re(out7_re),
		.out19_im(out7_im),
		.out20_re(out22_re),
		.out20_im(out22_im),
		.out21_re(out6_re),
		.out21_im(out6_im),
		.out22_re(out21_re),
		.out22_im(out21_im),
		.out23_re(out5_re),
		.out23_im(out5_im),
		.out24_re(out20_re),
		.out24_im(out20_im),
		.out25_re(out4_re),
		.out25_im(out4_im),
		.out26_re(out19_re),
		.out26_im(out19_im),
		.out27_re(out3_re),
		.out27_im(out3_im),
		.out28_re(out18_re),
		.out28_im(out18_im),
		.out29_re(out2_re),
		.out29_im(out2_im),
		.out30_re(out17_re),
		.out30_im(out17_im),
		.out31_re(out1_re),
		.out31_im(out1_im),
	
		.o_FFT32_cycle_done(w_FFT32_cycle_done)
	); 
endmodule
