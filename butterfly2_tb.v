module butterfly2_tb #(parameter WORD_SIZE = 16, FRACTION = 8)
(	
	output 	[WORD_SIZE-1:0]		o_out0_re,
	output 	[WORD_SIZE-1:0]		o_out0_im,
	output 	[WORD_SIZE-1:0]		o_out1_re,
	output 	[WORD_SIZE-1:0]		o_out1_im,
	
	output 					o_butterfly_done,
	output					clk_divided8,
	output					clk_divided16
);
	reg clk = 0;
	reg [WORD_SIZE-1:0] i_in0_re, i_in0_im, i_in1_re, i_in1_im;
	reg [WORD_SIZE-1:0] i_twiddle_re, i_twiddle_im;
	
	initial begin		
		//#0 i_in0_re = 16'b0000000101101010;
		//#0 i_in0_im = 16'b0000000011001001;
	//
		//#0 i_in1_re = 16'b1111111010010110;
		//#0 i_in1_im = 16'b0000000011001001;
	//
		//#0 i_twiddle_re = 16'b0000000100000000;
		//#0 i_twiddle_im = 16'b1111111000000000;
		
		//#640 i_in0_re = 16'b0000000101101010;
		//#0 i_in0_im = 16'b0000000011001001;
	//
		//#0 i_in1_re = 16'b1111111010010110;
		//#0 i_in1_im = 16'b0000000011001001;
	//
		//#0 i_twiddle_re = 16'b0000000100000000;
		//#0 i_twiddle_im = 16'b0000001000000000;
		
		#0 i_in0_re = 16'b0000001000000000;
		#0 i_in0_im = 16'b0000000100000000;
	
		#0 i_in1_re = 16'b0000001100000000;
		#0 i_in1_im = 16'b1111111100000000;
	
		#0 i_twiddle_re = 16'b0000000100000000;
		#0 i_twiddle_im = 16'b0000000000000000;
	end
	
	always @(*)
		#10 clk <= ~clk;
	
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) but2 
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
		.o_butterfly_done(o_butterfly_done),
		.clk_divided8(clk_divided8),
		.clk_divided16(clk_divided16)
	);
endmodule