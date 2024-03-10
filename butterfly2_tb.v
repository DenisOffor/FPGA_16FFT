module butterfly2_tb #(parameter N = 16, Q = 8)
(	
	output 	[N-1:0]		o_out0_re,
	output 	[N-1:0]		o_out0_im,
	output 	[N-1:0]		o_out1_re,
	output 	[N-1:0]		o_out1_im,
	output 					o_clk_divided2,
	output					o_clk_divided4,
	output					o_clk_divided8,
	output					o_clk_divided16,
	output					o_clk_divided32,
	
	output wire 					ena,
	output wire		[N-1:0]		w_out_re0, 
	output wire		[N-1:0]		w_out_re1, 
	output wire		[N-1:0]		w_out_im0,
	output wire		[N-1:0]		w_out_im1,
	output wire		[N-1:0]		w_out_re0_neg, 
	output wire		[N-1:0]		w_out_re1_neg, 
	output wire		[N-1:0]		w_out_im0_neg, 
	output wire		[N-1:0]		w_out_im1_neg,
	output wire 	[N-1:0] 		current_factor1,
	output wire 	[N-1:0] 		current_factor2,
	output wire 	[N-1:0] 		out_multiplier
);
	reg clk = 0;
	reg [N-1:0] i_in0_re, i_in0_im, i_in1_re, i_in1_im;
	reg [N-1:0] i_twiddle_re, i_twiddle_im;
	
	initial begin
		//#0 i_in0_re = 		16'b0000001000000000;
		//#0 i_in0_im = 		16'b0000001100000000;
//
		//#0 i_in1_re = 		16'b1111110000000000;
		//#0 i_in1_im = 		16'b0000001000000000;
//
		//#0 i_twiddle_re = 16'b0000001100000000;
		//#0 i_twiddle_im = 16'b1111111100000000;

		
		#0 i_in0_re = 16'b0000000101101010;
		#0 i_in0_im = 16'b0000000011001001;
	
		#0 i_in1_re = 16'b1111111010010110;
		#0 i_in1_im = 16'b1111111100110111;
	
		#0 i_twiddle_re = 16'b0000000011011100;
		#0 i_twiddle_im = 16'b1111111110100101;
	end
	
	always @(*)
		#2000 clk <= ~clk;
	
	butterfly2 #(.N(N), .Q(Q)) but2 
	(
		.i_clk(clk),
		.i_rst(0),
	 	.i_in0_re(i_in0_re),
	 	.i_in0_im(i_in0_im),
	 	.i_in1_re(i_in1_re),
	 	.i_in1_im(i_in1_im),
	 	.i_twiddle_re(i_twiddle_re),
	 	.i_twiddle_im(i_twiddle_im),
	 	.o_out0_re(o_out0_re),
	 	.o_out0_im(o_out0_im),
	 	.o_out1_re(o_out1_re),
	 	.o_out1_im(o_out1_im),
		.ena(ena),
		.w_out_re0(w_out_re0), 
		.w_out_re1(w_out_re1), 
		.w_out_im0(w_out_im0),
		.w_out_im1(w_out_im1),
		.w_out_re0_neg(w_out_re0_neg), 
		.w_out_re1_neg(w_out_re1_neg), 
		.w_out_im0_neg(w_out_im0_neg), 
		.w_out_im1_neg(w_out_im1_neg),
		.current_factor1(current_factor1),
	   .current_factor2(current_factor2),
		.out_multiplier(out_multiplier)
	);
	
	clock_divider clc_div
	(
		.i_clk(clk),
		.i_rst(0),
		.o_clk_divided2(o_clk_divided2),
		.o_clk_divided4(o_clk_divided4),
		.o_clk_divided8(o_clk_divided8),
		.o_clk_divided16(o_clk_divided16),
		.o_clk_divided32(o_clk_divided32)
	);

endmodule