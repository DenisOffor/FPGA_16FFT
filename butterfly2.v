module butterfly2 #(parameter N = 16, Q = 8) 
(
	input 					i_clk,
	input 					i_rst,
	
	//2 complex digits 
	input 	[N-1:0] 		i_in0_re,
	input 	[N-1:0] 		i_in0_im,
	input 	[N-1:0] 		i_in1_re,
	input 	[N-1:0] 		i_in1_im,
	
	//W^nk
	input 	[N-1:0] 		i_twiddle_re,
	input 	[N-1:0] 		i_twiddle_im,
	
	//2 compex digits
	output 	[N-1:0]		o_out0_re,
	output 	[N-1:0]		o_out0_im,
	output 	[N-1:0]		o_out1_re,
	output 	[N-1:0]		o_out1_im
);

	//wires for multiple complex in1 on complex twiddle
	wire		[N-1:0]     out0_mul_re;
	wire		[N-1:0]     out0_mul_im;
	wire		[N-1:0]     out1_mul_re;
	wire		[N-1:0]     out1_mul_im;
		
	//need for get negative 	
	wire		[N-1:0]     out0_mul_re_negative;
	wire		[N-1:0]     out0_mul_im_negative;
	wire		[N-1:0]     out1_mul_re_negative;
	wire		[N-1:0]     out1_mul_im_negative;

	  // First multipliers
     multiplier #(.N(N), .Q(Q)) M1
    (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_A(i_in1_re),
        .i_B(i_twiddle_re),
        .out(out0_mul_re)
    );

	  multiplier #(.N(N), .Q(Q)) M2
    (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_A(i_in1_im),
        .i_B(i_twiddle_im),
        .out(out1_mul_re)
    );

    multiplier #(.N(N), .Q(Q)) M3
    (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_A(i_in1_re),
        .i_B(i_twiddle_im),
        .out(out0_mul_im)
    );

    multiplier #(.N(N), .Q(Q)) M4
    (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_A(i_in1_im),
        .i_B(i_twiddle_re),
        .out(out1_mul_im)
    );
	 
	// make the complement
    get_negative #(.N(N)) neg1
    (
        .in(out0_mul_re),
        .out(out0_mul_re_negative)
    );
    get_negative #(.N(N)) neg2
    (
        .in(out0_mul_im),
        .out(out0_mul_im_negative)
    );
    get_negative # (.N(N)) neg3
    (
        .in(out1_mul_re),
        .out(out1_mul_re_negative)
    );
    get_negative # (.N(N)) neg4
    (
        .in(out1_mul_im),
        .out(out1_mul_im_negative)  
    );
	 
	 adder3 #(.N(N)) Add1
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_re),
		.i_B(out0_mul_re),
		.i_C(out1_mul_re_negative),
		.o_sum(o_out0_re)
	 );
	 adder3 #(.N(N)) Add2
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_im),
		.i_B(out0_mul_im),
		.i_C(out1_mul_im),
		.o_sum(o_out0_im)
	 );
	 adder3 #(.N(N)) Add3
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_re),
		.i_B(out0_mul_re_negative),
		.i_C(out1_mul_re),
		.o_sum(o_out1_re)
	 );
	 adder3 #(.N(N)) Add4
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_im),
		.i_B(out0_mul_im_negative),
		.i_C(out1_mul_im_negative),
		.o_sum(o_out1_im)
	 );
endmodule