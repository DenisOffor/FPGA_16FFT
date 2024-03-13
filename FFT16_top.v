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
	wire       	[N-1:0]     w_Mux0_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux0_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux0_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux0_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux1_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux1_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux1_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux1_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux2_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux2_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux2_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux2_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux3_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux3_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux3_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux3_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux4_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux4_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux4_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux4_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux5_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux5_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux5_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux5_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux6_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux6_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux6_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux6_out1_im_butterfly_in;

	wire       	[N-1:0]     w_Mux7_out0_re_butterfly_in;
	wire       	[N-1:0]     w_Mux7_out0_im_butterfly_in;
	wire       	[N-1:0]     w_Mux7_out1_re_butterfly_in;
	wire       	[N-1:0]     w_Mux7_out1_im_butterfly_in;
	
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
	wire    		[N-1:0] 		w_Mux0_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux0_out_twiddle_im;

	wire    		[N-1:0] 		w_Mux1_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux1_out_twiddle_im;
					
	wire    		[N-1:0] 		w_Mux2_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux2_out_twiddle_im;
					
	wire    		[N-1:0] 		w_Mux3_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux3_out_twiddle_im;
					
	wire    		[N-1:0] 		w_Mux4_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux4_out_twiddle_im;
					
	wire    		[N-1:0] 		w_Mux5_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux5_out_twiddle_im;
					
	wire    		[N-1:0] 		w_Mux6_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux6_out_twiddle_im;
					
	wire    		[N-1:0] 		w_Mux7_out_twiddle_re;
	wire    		[N-1:0] 		w_Mux7_out_twiddle_im;


	wire Mux_switcher_butterfly_ins;
	wire Mux_switcher_butterfly_twiddles;
	
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
	///////////////////////////////////////
	//muxes for butterfly0/////////////////
	///////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly0_in0_re 
	(
		.a(in0_re),
		.b(w_out0_re_butterfly),
		.c(w_out0_re_butterfly),
		.d(w_out0_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux0_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly0_in0_im
	(
		.a(in0_im),
		.b(w_out0_im_butterfly),
		.c(w_out0_im_butterfly),
		.d(w_out0_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux0_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly0_in1_re
	(
		.a(in8_re),
		.b(w_out2_re_butterfly),
		.c(w_out4_re_butterfly),
		.d(w_out8_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux0_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly0_in1_im
	(
		.a(in8_im),
		.b(w_out2_im_butterfly),
		.c(w_out4_re_butterfly),
		.d(w_out8_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux0_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly0_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle0_re),
		.d(w_twiddle0_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux0_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly0_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle0_im),
		.d(w_twiddle0_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux0_out_twiddle_im)
	);
	/////////////////////////////////////////
	//muxes for butterfly1///////////////////
	/////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly1_in0_re 
	(
		.a(in4_re),
		.b(w_out1_re_butterfly),
		.c(w_out1_re_butterfly),
		.d(w_out1_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux1_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly1_in0_im
	(
		.a(in4_im),
		.b(w_out1_im_butterfly),
		.c(w_out1_im_butterfly),
		.d(w_out1_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux1_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly1_in1_re
	(
		.a(in12_re),
		.b(w_out3_re_butterfly),
		.c(w_out5_re_butterfly),
		.d(w_out9_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux1_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly1_in1_im
	(
		.a(in12_im),
		.b(w_out3_im_butterfly),
		.c(w_out5_re_butterfly),
		.d(w_out9_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux1_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly1_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle2_re),
		.d(w_twiddle1_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux1_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly1_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle2_im),
		.d(w_twiddle1_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux1_out_twiddle_im)
	);
	//////////////////////////////////////////
	//muxes for butterfly2////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly2_in0_re 
	(
		.a(in2_re),
		.b(w_out4_re_butterfly),
		.c(w_out2_re_butterfly),
		.d(w_out2_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux2_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly2_in0_im
	(
		.a(in2_im),
		.b(w_out4_im_butterfly),
		.c(w_out2_im_butterfly),
		.d(w_out2_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux2_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly2_in1_re
	(
		.a(in10_re),
		.b(w_out6_re_butterfly),
		.c(w_out6_re_butterfly),
		.d(w_out10_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux2_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly2_in1_im
	(
		.a(in10_im),
		.b(w_out6_im_butterfly),
		.c(w_out6_re_butterfly),
		.d(w_out10_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux2_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly2_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle4_re),
		.d(w_twiddle2_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux2_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly2_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle4_im),
		.d(w_twiddle2_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux2_out_twiddle_im)
	);
	//////////////////////////////////////////
	//muxes for butterfly3////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly3_in0_re 
	(
		.a(in6_re),
		.b(w_out5_re_butterfly),
		.c(w_out3_re_butterfly),
		.d(w_out3_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux3_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly3_in0_im
	(
		.a(in6_im),
		.b(w_out5_im_butterfly),
		.c(w_out3_im_butterfly),
		.d(w_out3_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux3_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly3_in1_re
	(
		.a(in14_re),
		.b(w_out7_re_butterfly),
		.c(w_out7_re_butterfly),
		.d(w_out11_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux3_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly3_in1_im
	(
		.a(in14_im),
		.b(w_out7_im_butterfly),
		.c(w_out7_re_butterfly),
		.d(w_out11_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux3_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly3_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle6_re),
		.d(w_twiddle3_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux3_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly3_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle6_im),
		.d(w_twiddle3_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux3_out_twiddle_im)
	);
	//////////////////////////////////////////	
	//muxes for butterfly4////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly4_in0_re 
	(
		.a(in1_re),
		.b(w_out8_re_butterfly),
		.c(w_out8_re_butterfly),
		.d(w_out4_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux4_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly4_in0_im
	(
		.a(in1_im),
		.b(w_out8_im_butterfly),
		.c(w_out8_im_butterfly),
		.d(w_out4_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux4_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly4_in1_re
	(
		.a(in9_re),
		.b(w_out10_re_butterfly),
		.c(w_out12_re_butterfly),
		.d(w_out12_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux4_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly4_in1_im
	(
		.a(in9_im),
		.b(w_out10_im_butterfly),
		.c(w_out12_re_butterfly),
		.d(w_out12_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux4_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly4_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle0_re),
		.d(w_twiddle4_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux4_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly4_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle0_im),
		.d(w_twiddle4_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux4_out_twiddle_im)
	);
	//////////////////////////////////////////	
	//muxes for butterfly5////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly5_in0_re 
	(
		.a(in5_re),
		.b(w_out9_re_butterfly),
		.c(w_out9_re_butterfly),
		.d(w_out5_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux5_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly5_in0_im
	(
		.a(in5_im),
		.b(w_out9_im_butterfly),
		.c(w_out9_im_butterfly),
		.d(w_out5_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux5_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly5_in1_re
	(
		.a(in13_re),
		.b(w_out11_re_butterfly),
		.c(w_out13_re_butterfly),
		.d(w_out13_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux5_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly5_in1_im
	(
		.a(in13_im),
		.b(w_out11_im_butterfly),
		.c(w_out13_re_butterfly),
		.d(w_out13_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux5_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly5_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle2_re),
		.d(w_twiddle5_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux5_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly5_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle2_im),
		.d(w_twiddle5_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux5_out_twiddle_im)
	);
	//////////////////////////////////////////	
	//muxes for butterfly6////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly6_in0_re 
	(
		.a(in3_re),
		.b(w_out12_re_butterfly),
		.c(w_out10_re_butterfly),
		.d(w_out6_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux6_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly6_in0_im
	(
		.a(in3_im),
		.b(w_out12_im_butterfly),
		.c(w_out10_im_butterfly),
		.d(w_out6_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux6_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly6_in1_re
	(
		.a(in11_re),
		.b(w_out14_re_butterfly),
		.c(w_out14_re_butterfly),
		.d(w_out14_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux6_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly6_in1_im
	(
		.a(in11_im),
		.b(w_out14_im_butterfly),
		.c(w_out14_re_butterfly),
		.d(w_out14_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux6_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly6_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle4_re),
		.d(w_twiddle6_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux6_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly6_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle4_im),
		.d(w_twiddle6_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux6_out_twiddle_im)
	);
	//////////////////////////////////////////
	//muxes for butterfly7////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.N(N)) mux_butterfly7_in0_re 
	(
		.a(in7_re),
		.b(w_out13_re_butterfly),
		.c(w_out11_re_butterfly),
		.d(w_out7_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux7_out0_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly7_in0_im
	(
		.a(in7_im),
		.b(w_out13_im_butterfly),
		.c(w_out11_im_butterfly),
		.d(w_out7_im_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux7_out0_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly7_in1_re
	(
		.a(in15_re),
		.b(w_out15_re_butterfly),
		.c(w_out15_re_butterfly),
		.d(w_out15_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux7_out1_re_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly7_in1_im
	(
		.a(in15_im),
		.b(w_out15_im_butterfly),
		.c(w_out15_re_butterfly),
		.d(w_out15_re_butterfly),
		.sel(Mux_switcher_butterfly_ins),
		.out(w_Mux7_out1_im_butterfly_in)
	);
	
	mux4in1 #(.N(N)) mux_butterfly7_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle6_re),
		.d(w_twiddle7_re),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux7_out_twiddle_re)
	);
	
	mux4in1 #(.N(N)) mux_butterfly7_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle6_im),
		.d(w_twiddle7_im),
		.sel(Mux_switcher_butterfly_twiddles),
		.out(w_Mux7_out_twiddle_im)
	);
	//////////////////////////////////////////
	//butterflies
	butterfly2 #(.N(N), .Q(Q)) butterfly0
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux0_out0_re_butterfly_in),
		.i_in0_im(w_Mux0_out0_im_butterfly_in),
		.i_in1_re(w_Mux0_out1_re_butterfly_in),
		.i_in1_im(w_Mux0_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux0_out_twiddle_re),
		.i_twiddle_im(w_Mux0_out_twiddle_im),
		
		.o_out0_re(w_out0_re_butterfly),
		.o_out0_im(w_out0_im_butterfly),
		.o_out1_re(w_out1_re_butterfly),
		.o_out1_im(w_out1_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly1
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux1_out0_re_butterfly_in),
		.i_in0_im(w_Mux1_out0_im_butterfly_in),
		.i_in1_re(w_Mux1_out1_re_butterfly_in),
		.i_in1_im(w_Mux1_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux1_out_twiddle_re),
		.i_twiddle_im(w_Mux1_out_twiddle_im),
		
		.o_out0_re(w_out2_re_butterfly),
		.o_out0_im(w_out2_im_butterfly),
		.o_out1_re(w_out3_re_butterfly),
		.o_out1_im(w_out3_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly2
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux2_out0_re_butterfly_in),
		.i_in0_im(w_Mux2_out0_im_butterfly_in),
		.i_in1_re(w_Mux2_out1_re_butterfly_in),
		.i_in1_im(w_Mux2_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux2_out_twiddle_re),
		.i_twiddle_im(w_Mux2_out_twiddle_im),
		
		.o_out0_re(w_out4_re_butterfly),
		.o_out0_im(w_out4_im_butterfly),
		.o_out1_re(w_out5_re_butterfly),
		.o_out1_im(w_out5_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly3
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux3_out0_re_butterfly_in),
		.i_in0_im(w_Mux3_out0_im_butterfly_in),
		.i_in1_re(w_Mux3_out1_re_butterfly_in),
		.i_in1_im(w_Mux3_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux3_out_twiddle_re),
		.i_twiddle_im(w_Mux3_out_twiddle_im),
		
		.o_out0_re(w_out6_re_butterfly),
		.o_out0_im(w_out6_im_butterfly),
		.o_out1_re(w_out7_re_butterfly),
		.o_out1_im(w_out7_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly4
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux4_out0_re_butterfly_in),
		.i_in0_im(w_Mux4_out0_im_butterfly_in),
		.i_in1_re(w_Mux4_out1_re_butterfly_in),
		.i_in1_im(w_Mux4_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux4_out_twiddle_re),
		.i_twiddle_im(w_Mux4_out_twiddle_im),
		
		.o_out0_re(w_out8_re_butterfly),
		.o_out0_im(w_out8_im_butterfly),
		.o_out1_re(w_out9_re_butterfly),
		.o_out1_im(w_out9_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly5
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux4_out0_re_butterfly_in),
		.i_in0_im(w_Mux4_out0_im_butterfly_in),
		.i_in1_re(w_Mux4_out1_re_butterfly_in),
		.i_in1_im(w_Mux4_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux4_out_twiddle_re),
		.i_twiddle_im(w_Mux4_out_twiddle_im),
		
		.o_out0_re(w_out10_re_butterfly),
		.o_out0_im(w_out10_im_butterfly),
		.o_out1_re(w_out11_re_butterfly),
		.o_out1_im(w_out11_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly6
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux6_out0_re_butterfly_in),
		.i_in0_im(w_Mux6_out0_im_butterfly_in),
		.i_in1_re(w_Mux6_out1_re_butterfly_in),
		.i_in1_im(w_Mux6_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux6_out_twiddle_re),
		.i_twiddle_im(w_Mux6_out_twiddle_im),
		
		.o_out0_re(w_out12_re_butterfly),
		.o_out0_im(w_out12_im_butterfly),
		.o_out1_re(w_out13_re_butterfly),
		.o_out1_im(w_out13_im_butterfly)
	);
	
	butterfly2 #(.N(N), .Q(Q)) butterfly7
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux7_out0_re_butterfly_in),
		.i_in0_im(w_Mux7_out0_im_butterfly_in),
		.i_in1_re(w_Mux7_out1_re_butterfly_in),
		.i_in1_im(w_Mux7_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux7_out_twiddle_re),
		.i_twiddle_im(w_Mux7_out_twiddle_im),
		
		.o_out0_re(w_out14_re_butterfly),
		.o_out0_im(w_out14_im_butterfly),
		.o_out1_re(w_out15_re_butterfly),
		.o_out1_im(w_out15_im_butterfly)
	);
	
	ram_16_byte #( .N(N)) ram_out
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.in0_re(w_out0_re_butterfly),
		.in0_im(w_out0_im_butterfly),
		.in1_re(w_out1_re_butterfly),
		.in1_im(w_out1_im_butterfly),
		.in2_re(w_out2_re_butterfly),
		.in2_im(w_out2_im_butterfly),
		.in3_re(w_out3_re_butterfly),
		.in3_im(w_out3_im_butterfly),
		.in4_re(w_out4_re_butterfly),
		.in4_im(w_out4_im_butterfly),
		.in5_re(w_out5_re_butterfly),
		.in5_im(w_out5_im_butterfly),
		.in6_re(w_out6_re_butterfly),
		.in6_im(w_out6_im_butterfly),
		.in7_re(w_out7_re_butterfly),
		.in7_im(w_out7_im_butterfly),
		.in8_re(w_out8_re_butterfly),
		.in8_im(w_out8_im_butterfly),
		.in9_re(w_out9_re_butterfly),
		.in9_im(w_out9_im_butterfly),
		.in10_re(w_out10_re_butterfly),
		.in10_im(w_out10_im_butterfly),
		.in11_re(w_out11_re_butterfly),
		.in11_im(w_out11_im_butterfly),
		.in12_re(w_out12_re_butterfly),
		.in12_im(w_out12_im_butterfly),
		.in13_re(w_out13_re_butterfly),
		.in13_im(w_out13_im_butterfly),
		.in14_re(w_out14_re_butterfly),
		.in14_im(w_out14_im_butterfly),
		.in15_re(w_out15_re_butterfly),
		.in15_im(w_out15_im_butterfly),
		
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
		.out13_re(out13_re),
		.out13_im(out13_im),
		.out14_re(out14_re),
		.out14_im(out14_im),
		.out15_re(out15_re),
		.out15_im(out15_im)
	);

endmodule


