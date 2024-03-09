module butterfly2_tb #(parameter N = 16, Q = 8)
(	
	output 	[N-1:0]		o_out0_re,
	output 	[N-1:0]		o_out0_im,
	output 	[N-1:0]		o_out1_re,
	output 	[N-1:0]		o_out1_im
);
	reg clk = 0;
	reg [N-1:0] i_in0_re, i_in0_im, i_in1_re, i_in1_im;
	reg [N-1:0] i_twiddle_re, i_twiddle_im;
	
	initial begin
		#0 i_in0_re = 16'b0000001100000000;
		#0 i_in0_im = 16'b1111111000000000;
		#0 i_in1_re = 16'b0000010000000000;
		#0 i_in1_im = 16'b0000010100000000;
		#0 i_twiddle_re = 16'b0000001000000000;
		#0 i_twiddle_im = 16'b1111111100000000;
	end
	
	always @(*)
		#10 clk <= ~clk;
	
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
	 	.o_out1_im(o_out1_im)
	);

endmodule