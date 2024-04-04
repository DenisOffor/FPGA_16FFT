module FFT16_top #(parameter WORD_SIZE = 16, parameter FRACTION = 8)
(
	input						i_clk,
	input 						i_rst,
	input				[2:0]		STAGES,
	input       	[WORD_SIZE-1:0]     in0_re,
	input       	[WORD_SIZE-1:0]     in0_im,
	input       	[WORD_SIZE-1:0]     in1_re,
	input       	[WORD_SIZE-1:0]     in1_im,
	input       	[WORD_SIZE-1:0]     in2_re,
	input       	[WORD_SIZE-1:0]     in2_im,
	input       	[WORD_SIZE-1:0]     in3_re,
	input       	[WORD_SIZE-1:0]     in3_im,
	input       	[WORD_SIZE-1:0]     in4_re,
	input       	[WORD_SIZE-1:0]     in4_im,
	input       	[WORD_SIZE-1:0]     in5_re,
	input       	[WORD_SIZE-1:0]     in5_im,
	input       	[WORD_SIZE-1:0]     in6_re,
	input       	[WORD_SIZE-1:0]     in6_im,
	input       	[WORD_SIZE-1:0]     in7_re,
	input       	[WORD_SIZE-1:0]     in7_im,
	input       	[WORD_SIZE-1:0]     in8_re,
	input       	[WORD_SIZE-1:0]     in8_im,
	input       	[WORD_SIZE-1:0]     in9_re,
	input       	[WORD_SIZE-1:0]     in9_im,
	input       	[WORD_SIZE-1:0]     in10_re,
	input       	[WORD_SIZE-1:0]     in10_im,
	input       	[WORD_SIZE-1:0]     in11_re,
	input       	[WORD_SIZE-1:0]     in11_im,
	input       	[WORD_SIZE-1:0]     in12_re,
	input       	[WORD_SIZE-1:0]     in12_im,
	input       	[WORD_SIZE-1:0]     in13_re,
	input       	[WORD_SIZE-1:0]     in13_im,
	input       	[WORD_SIZE-1:0]     in14_re,
	input       	[WORD_SIZE-1:0]     in14_im,
	input       	[WORD_SIZE-1:0]     in15_re,
	input       	[WORD_SIZE-1:0]     in15_im,
	
	output       	[WORD_SIZE-1:0]     out0_re,
	output       	[WORD_SIZE-1:0]     out0_im,
	output       	[WORD_SIZE-1:0]     out1_re,
	output       	[WORD_SIZE-1:0]     out1_im,
	output       	[WORD_SIZE-1:0]     out2_re,
	output       	[WORD_SIZE-1:0]     out2_im,
	output       	[WORD_SIZE-1:0]     out3_re,
	output       	[WORD_SIZE-1:0]     out3_im,
	output       	[WORD_SIZE-1:0]     out4_re,
	output       	[WORD_SIZE-1:0]     out4_im,
	output       	[WORD_SIZE-1:0]     out5_re,
	output       	[WORD_SIZE-1:0]     out5_im,
	output       	[WORD_SIZE-1:0]     out6_re,
	output       	[WORD_SIZE-1:0]     out6_im,
	output       	[WORD_SIZE-1:0]     out7_re,
	output       	[WORD_SIZE-1:0]     out7_im,
	output       	[WORD_SIZE-1:0]     out8_re,
	output       	[WORD_SIZE-1:0]     out8_im,
	output       	[WORD_SIZE-1:0]     out9_re,
	output       	[WORD_SIZE-1:0]     out9_im,
	output       	[WORD_SIZE-1:0]     out10_re,
	output       	[WORD_SIZE-1:0]     out10_im,
	output       	[WORD_SIZE-1:0]     out11_re,
	output       	[WORD_SIZE-1:0]     out11_im,
	output       	[WORD_SIZE-1:0]     out12_re,
	output       	[WORD_SIZE-1:0]     out12_im,
	output       	[WORD_SIZE-1:0]     out13_re,
	output       	[WORD_SIZE-1:0]     out13_im,
	output       	[WORD_SIZE-1:0]     out14_re,
	output       	[WORD_SIZE-1:0]     out14_im,
	output       	[WORD_SIZE-1:0]     out15_re,
	output       	[WORD_SIZE-1:0]     out15_im,
	
	output 						o_FFT_cycle_done,
	output 						o_butterfly_done
);	   
   //wires of twiddle_rom_real & twiddle_rom_imag
	wire        [WORD_SIZE-1:0]     w_twiddle0_re;
	wire        [WORD_SIZE-1:0]     w_twiddle0_im;
	wire        [WORD_SIZE-1:0]     w_twiddle1_re;
	wire        [WORD_SIZE-1:0]     w_twiddle1_im;
	wire        [WORD_SIZE-1:0]     w_twiddle2_re;
	wire        [WORD_SIZE-1:0]     w_twiddle2_im;
	wire        [WORD_SIZE-1:0]     w_twiddle3_re;
	wire        [WORD_SIZE-1:0]     w_twiddle3_im;
	wire        [WORD_SIZE-1:0]     w_twiddle4_re;
	wire        [WORD_SIZE-1:0]     w_twiddle4_im;
	wire        [WORD_SIZE-1:0]     w_twiddle5_re;
	wire        [WORD_SIZE-1:0]     w_twiddle5_im;
	wire        [WORD_SIZE-1:0]     w_twiddle6_re;
	wire        [WORD_SIZE-1:0]     w_twiddle6_im;
	wire        [WORD_SIZE-1:0]     w_twiddle7_re;
	wire        [WORD_SIZE-1:0]     w_twiddle7_im;
	
	//instant of muxes of inputs of mac
	wire       		[WORD_SIZE-1:0]     	w_Mux0_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux0_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux0_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux0_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux1_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux1_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux1_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux1_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux2_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux2_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux2_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux2_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux3_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux3_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux3_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux3_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux4_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux4_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux4_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux4_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux5_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux5_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux5_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux5_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux6_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux6_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux6_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux6_out1_im_butterfly_in;
	
	wire       		[WORD_SIZE-1:0]     	w_Mux7_out0_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux7_out0_im_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux7_out1_re_butterfly_in;
	wire       		[WORD_SIZE-1:0]     	w_Mux7_out1_im_butterfly_in;
	
	//instant of butterfly2
	wire        	[WORD_SIZE-1:0]     	w_out0_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out0_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out1_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out1_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out2_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out2_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out3_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out3_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out4_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out4_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out5_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out5_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out6_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out6_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out7_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out7_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out8_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out8_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out9_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out9_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out10_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out10_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out11_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out11_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out12_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out12_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out13_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out13_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out14_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out14_im_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out15_re_butterfly;
	wire        	[WORD_SIZE-1:0]     	w_out15_im_butterfly;
	
	//instant of muxes of twiddle
	wire    		[WORD_SIZE-1:0] 		w_Mux0_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux0_out_twiddle_im;

	wire    		[WORD_SIZE-1:0] 		w_Mux1_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux1_out_twiddle_im;
				
	wire    		[WORD_SIZE-1:0] 		w_Mux2_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux2_out_twiddle_im;
				
	wire    		[WORD_SIZE-1:0] 		w_Mux3_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux3_out_twiddle_im;
				
	wire    		[WORD_SIZE-1:0] 		w_Mux4_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux4_out_twiddle_im;
				
	wire    		[WORD_SIZE-1:0] 		w_Mux5_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux5_out_twiddle_im;
				
	wire    		[WORD_SIZE-1:0] 		w_Mux6_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux6_out_twiddle_im;
				
	wire    		[WORD_SIZE-1:0] 		w_Mux7_out_twiddle_re;
	wire    		[WORD_SIZE-1:0] 		w_Mux7_out_twiddle_im;


	wire 			[1:0]			Mux_switcher_butterfly;

	reg 							buffer;
	wire 							w_FFT_cycle_done;
	assign 						o_FFT_cycle_done = buffer;
	
	always @(posedge i_clk)
		buffer <= w_FFT_cycle_done;
	
	control_unit my_control_unit 
	(
		.i_clk(o_butterfly_done),    
		.i_rst(i_rst),
		.STAGES(STAGES),
		.o_mux_sel(Mux_switcher_butterfly),
		.o_cycle_done(w_FFT_cycle_done)
	);
	
	
	rom_twiddle #(.WORD_SIZE(WORD_SIZE)) twiddle_rom 
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
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
	////////modules for butterfly0/////////
	///////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly0_in0_re 
	(
		.a(in0_re),
		.b(out0_re),
		.c(out0_re),
		.d(out0_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux0_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly0_in0_im
	(
		.a(in0_im),
		.b(out0_im),
		.c(out0_im),
		.d(out0_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux0_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly0_in1_re
	(
		.a(in8_re),
		.b(out2_re),
		.c(out4_re),
		.d(out8_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux0_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly0_in1_im
	(
		.a(in8_im),
		.b(out2_im),
		.c(out4_im),
		.d(out8_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux0_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly0_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle0_re),
		.d(w_twiddle0_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux0_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly0_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle0_im),
		.d(w_twiddle0_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux0_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly0
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
		.o_out1_im(w_out1_im_butterfly),
		
		.o_butterfly_done(o_butterfly_done)
	);
	/////////////////////////////////////////
	//muxes for butterfly1///////////////////
	/////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly1_in0_re 
	(
		.a(in4_re),
		.b(out1_re),
		.c(out2_re),
		.d(out2_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux1_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly1_in0_im
	(
		.a(in4_im),
		.b(out1_im),
		.c(out2_im),
		.d(out2_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux1_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly1_in1_re
	(
		.a(in12_re),
		.b(out3_re),
		.c(out6_re),
		.d(out10_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux1_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly1_in1_im
	(
		.a(in12_im),
		.b(out3_im),
		.c(out6_im),
		.d(out10_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux1_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly1_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle2_re),
		.d(w_twiddle1_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux1_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly1_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle2_im),
		.d(w_twiddle1_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux1_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly1
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
	//////////////////////////////////////////
	//muxes for butterfly2////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly2_in0_re 
	(
		.a(in2_re),
		.b(out4_re),
		.c(out1_re),
		.d(out4_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux2_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly2_in0_im
	(
		.a(in2_im),
		.b(out4_im),
		.c(out1_im),
		.d(out4_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux2_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly2_in1_re
	(
		.a(in10_re),
		.b(out6_re),
		.c(out5_re),
		.d(out12_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux2_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly2_in1_im
	(
		.a(in10_im),
		.b(out6_im),
		.c(out5_im),
		.d(out12_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux2_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly2_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle4_re),
		.d(w_twiddle2_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux2_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly2_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle4_im),
		.d(w_twiddle2_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux2_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly2
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
	//////////////////////////////////////////
	//muxes for butterfly3////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly3_in0_re 
	(
		.a(in6_re),
		.b(out5_re),
		.c(out3_re),
		.d(out6_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux3_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly3_in0_im
	(
		.a(in6_im),
		.b(out5_im),
		.c(out3_im),
		.d(out6_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux3_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly3_in1_re
	(
		.a(in14_re),
		.b(out7_re),
		.c(out7_re),
		.d(out14_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux3_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly3_in1_im
	(
		.a(in14_im),
		.b(out7_im),
		.c(out7_im),
		.d(out14_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux3_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly3_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle6_re),
		.d(w_twiddle3_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux3_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly3_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle6_im),
		.d(w_twiddle3_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux3_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly3
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
	//////////////////////////////////////////	
	//muxes for butterfly4////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly4_in0_re 
	(
		.a(in1_re),
		.b(out8_re),
		.c(out8_re),
		.d(out1_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux4_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly4_in0_im
	(
		.a(in1_im),
		.b(out8_im),
		.c(out8_im),
		.d(out1_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux4_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly4_in1_re
	(
		.a(in9_re),
		.b(out10_re),
		.c(out12_re),
		.d(out9_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux4_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly4_in1_im
	(
		.a(in9_im),
		.b(out10_im),
		.c(out12_im),
		.d(out9_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux4_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly4_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle0_re),
		.d(w_twiddle4_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux4_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly4_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle0_im),
		.d(w_twiddle4_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux4_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly4
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
	//////////////////////////////////////////	
	//muxes for butterfly5////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly5_in0_re 
	(
		.a(in5_re),
		.b(out9_re),
		.c(out10_re),
		.d(out3_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux5_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly5_in0_im
	(
		.a(in5_im),
		.b(out9_im),
		.c(out10_im),
		.d(out3_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux5_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly5_in1_re
	(
		.a(in13_re),
		.b(out11_re),
		.c(out14_re),
		.d(out11_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux5_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly5_in1_im
	(
		.a(in13_im),
		.b(out11_im),
		.c(out14_im),
		.d(out11_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux5_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly5_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle2_re),
		.d(w_twiddle5_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux5_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly5_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle2_im),
		.d(w_twiddle5_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux5_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly5
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		
		.i_in0_re(w_Mux5_out0_re_butterfly_in),
		.i_in0_im(w_Mux5_out0_im_butterfly_in),
		.i_in1_re(w_Mux5_out1_re_butterfly_in),
		.i_in1_im(w_Mux5_out1_im_butterfly_in),
		
		.i_twiddle_re(w_Mux5_out_twiddle_re),
		.i_twiddle_im(w_Mux5_out_twiddle_im),
		
		.o_out0_re(w_out10_re_butterfly),
		.o_out0_im(w_out10_im_butterfly),
		.o_out1_re(w_out11_re_butterfly),
		.o_out1_im(w_out11_im_butterfly)
	);
	//////////////////////////////////////////	
	//muxes for butterfly6////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly6_in0_re 
	(
		.a(in3_re),
		.b(out12_re),
		.c(out9_re),
		.d(out5_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux6_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly6_in0_im
	(
		.a(in3_im),
		.b(out12_im),
		.c(out9_im),
		.d(out5_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux6_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly6_in1_re
	(
		.a(in11_re),
		.b(out14_re),
		.c(out13_re),
		.d(out13_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux6_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly6_in1_im
	(
		.a(in11_im),
		.b(out14_im),
		.c(out13_im),
		.d(out13_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux6_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly6_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle0_re),
		.c(w_twiddle4_re),
		.d(w_twiddle6_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux6_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly6_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle0_im),
		.c(w_twiddle4_im),
		.d(w_twiddle6_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux6_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly6
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
	//////////////////////////////////////////
	//muxes for butterfly7////////////////////
	//////////////////////////////////////////
	 mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly7_in0_re 
	(
		.a(in7_re),
		.b(out13_re),
		.c(out11_re),
		.d(out7_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux7_out0_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly7_in0_im
	(
		.a(in7_im),
		.b(out13_im),
		.c(out11_im),
		.d(out7_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux7_out0_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly7_in1_re
	(
		.a(in15_re),
		.b(out15_re),
		.c(out15_re),
		.d(out15_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux7_out1_re_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly7_in1_im
	(
		.a(in15_im),
		.b(out15_im),
		.c(out15_im),
		.d(out15_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux7_out1_im_butterfly_in)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly7_twi_re 
	(
		.a(w_twiddle0_re),
		.b(w_twiddle4_re),
		.c(w_twiddle6_re),
		.d(w_twiddle7_re),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux7_out_twiddle_re)
	);
	
	mux4in1 #(.WORD_SIZE(WORD_SIZE)) mux_butterfly7_twi_im
	(
		.a(w_twiddle0_im),
		.b(w_twiddle4_im),
		.c(w_twiddle6_im),
		.d(w_twiddle7_im),
		.sel(Mux_switcher_butterfly),
		.out(w_Mux7_out_twiddle_im)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) butterfly7
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
	//////////////////////////////////////////
	
	ram_16_byte #( .WORD_SIZE(WORD_SIZE)) ram_out
	(
		.we(o_butterfly_done),
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


