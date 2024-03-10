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
	output 	[N-1:0]		o_out1_im,
	
	output wire ena,
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
	output wire		[N-1:0]     out_multiplier
);

	//wires for divided i_clk
	wire 						clk_divided2;
	wire 						clk_divided4;
	wire 						clk_divided8;
	wire 						clk_divided16;
	wire 						clk_divided32;
	wire 						clk_divided64;
	
	//current input data chosen for multiply them
	
	//wire for multiple complex in1 on complex twiddle
	//wire		[N-1:0]     out_multiplier;
	//need for get negative 	
	wire		[N-1:0]     out_multiplier_negative;
	//memory for 8 digits: 2 real, 2 real negative, 2 im, 2 im negative
	
	 //////////////////////
	 flash #(.N(N)) flash1
	 ( 
		   .i_clk(i_clk),
		   .i_word(out_multiplier),
		   .ena(ena),
		   .address({clk_divided32, clk_divided16}),
		   .o_word0(w_out_re0),
		   .o_word1(w_out_im0),
		   .o_word2(w_out_im1),
		   .o_word3(w_out_re1)
	 );
	 flash #(.N(N)) flash2
	 ( 
		   .i_clk(i_clk),
		   .i_word(out_multiplier_negative),
		   .ena(ena),
		   .address({clk_divided32, clk_divided16}),
		   .o_word0(w_out_re0_neg),
		   .o_word1(w_out_im0_neg),
		   .o_word2(w_out_im1_neg),
		   .o_word3(w_out_re1_neg)
	 );
	  //////////////////////////////
	  mux2in1 #(.N(N)) mux1
	 (
		  .a(i_in1_re),
		  .b(i_in1_im),
		  .sel(clk_divided16),
		  .out(current_factor1)
	  );
     mux2in1 #(.N(N)) mux2
	 (
		  .a(i_twiddle_re),
		  .b(i_twiddle_im),
		  .sel(clk_divided32),
		  .out(current_factor2)
	  );  
	  ///////////////////////////////
	  multiplier #(.N(N), .Q(Q)) M1
    (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_A(current_factor1),
        .i_B(current_factor2),
        .out(out_multiplier),
		  .o_multipl_done(ena)
    );
	 //make the complement
    get_negative #(.N(N)) neg1
    (
        .in(out_multiplier),
        .out(out_multiplier_negative)
    );
	 /////////////////////////////////
	 adder3 #(.N(N)) Add1
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_re),
		.i_B(w_out_re0),
		.i_C(w_out_re1_neg),
		.o_sum(o_out0_re)
	 );
	 adder3 #(.N(N)) Add2
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_im),
		.i_B(w_out_im0),
		.i_C(w_out_im1),
		.o_sum(o_out0_im)
	 );
	 adder3 #(.N(N)) Add3
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_re),
		.i_B(w_out_re0_neg),
		.i_C(w_out_re1),
		.o_sum(o_out1_re)
	 );
	 adder3 #(.N(N)) Add4
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_im),
		.i_B(w_out_im0_neg),
		.i_C(w_out_im1_neg),
		.o_sum(o_out1_im)
	 );
	 
	 	clock_divider clc_div
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.o_clk_divided2(clk_divided2),
		.o_clk_divided4(clk_divided4),
		.o_clk_divided8(clk_divided8),
		.o_clk_divided16(clk_divided16),
		.o_clk_divided32(clk_divided32)
	);
endmodule