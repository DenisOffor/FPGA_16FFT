module butterfly2 #(parameter WORD_SIZE = 16, FRACTION = 8) 
(
	input 					i_clk,
	input 					i_rst,
	
	//2 complex digits 
	input 	[WORD_SIZE-1:0] 		i_in0_re,
	input 	[WORD_SIZE-1:0] 		i_in0_im,
	input 	[WORD_SIZE-1:0] 		i_in1_re,
	input 	[WORD_SIZE-1:0] 		i_in1_im,
	
	//W^nk
	input 	[WORD_SIZE-1:0] 		i_twiddle_re,
	input 	[WORD_SIZE-1:0] 		i_twiddle_im,
	
	//2 compex digits
	output 	[WORD_SIZE-1:0]			o_out0_re,
	output 	[WORD_SIZE-1:0]			o_out0_im,
	output 	[WORD_SIZE-1:0]			o_out1_re,
	output 	[WORD_SIZE-1:0]			o_out1_im,
	
	output 					o_butterfly_done,
	output					clk_divided8,
	output					clk_divided16
);

	//wires for divided i_clk
	//wire 						clk_divided8;
	//wire 						clk_divided16;
	//wire for connect "multiple done" with "write_enable" for flash
	//wire 						w_mutiplier_done;
	//current input data chosen for multiply them
	wire 		[WORD_SIZE-1:0] 		current_factor1;
	wire 		[WORD_SIZE-1:0] 		current_factor2;
	//wire for multiple complex in1 on complex twiddle
	wire		[WORD_SIZE-1:0]     	out_multiplier;
	//need for get negative 	
	wire		[WORD_SIZE-1:0]     	out_multiplier_negative;
	//wires fan out from flash to adders 
	wire		[WORD_SIZE-1:0]			w_out_re0, w_out_re1, w_out_im0, w_out_im1;
	wire		[WORD_SIZE-1:0]			w_out_re0_neg, w_out_re1_neg, w_out_im0_neg, w_out_im1_neg;
	
	reg  						r_butterfly_done = 0;
	
	assign o_butterfly_done = r_butterfly_done; 

	
	always @(posedge i_rst or negedge clk_divided8 or negedge clk_divided16) begin
		if(i_rst)
			r_butterfly_done <= 1'b0;
		else 
			r_butterfly_done <= (~clk_divided8 && ~clk_divided16);
	end
	 //////////////////////
	 flash #(.WORD_SIZE(WORD_SIZE)) flash1
	 ( 
		.i_clk(i_clk),
		.i_word(out_multiplier),
		.address({clk_divided16, clk_divided8}),
		.o_word0(w_out_re0),
		.o_word1(w_out_im0),
		.o_word2(w_out_im1),
		.o_word3(w_out_re1)
	 );
	 flash #(.WORD_SIZE(WORD_SIZE)) flash2
	 ( 
		.i_clk(i_clk),
		.i_word(out_multiplier_negative),
		.address({clk_divided16, clk_divided8}),
		.o_word0(w_out_re0_neg),
		.o_word1(w_out_im0_neg),
		.o_word2(w_out_im1_neg),
		.o_word3(w_out_re1_neg)
	 );
	  //////////////////////////////
	  mux2in1 #(.WORD_SIZE(WORD_SIZE)) mux1
	 (
		  .a(i_in1_re),
		  .b(i_in1_im),
		  .sel(clk_divided8),
		  .out(current_factor1)
	  );
     mux2in1 #(.WORD_SIZE(WORD_SIZE)) mux2
	 (
		  .a(i_twiddle_re),
		  .b(i_twiddle_im),
		  .sel(clk_divided16),
		  .out(current_factor2)
	  );  
	  ///////////////////////////////
	  multiplier #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) M1
    (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_A(current_factor1),
        .i_B(current_factor2),
        .out(out_multiplier)
    );
	 //make the complement
    get_negative #(.WORD_SIZE(WORD_SIZE)) neg1
    (
        .in(out_multiplier),
        .out(out_multiplier_negative)
    );
	 /////////////////////////////////
	 adder3 #(.WORD_SIZE(WORD_SIZE)) Add1
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_re),
		.i_B(w_out_re0),
		.i_C(w_out_re1_neg),
		.o_sum(o_out0_re)
	 );
	 adder3 #(.WORD_SIZE(WORD_SIZE)) Add2
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_im),
		.i_B(w_out_im0),
		.i_C(w_out_im1),
		.o_sum(o_out0_im)
	 );
	 adder3 #(.WORD_SIZE(WORD_SIZE)) Add3
	 (
		.i_clk(i_clk),
		.i_rst(i_rst),
		.i_A(i_in0_re),
		.i_B(w_out_re0_neg),
		.i_C(w_out_re1),
		.o_sum(o_out1_re)
	 );
	 adder3 #(.WORD_SIZE(WORD_SIZE)) Add4
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
		.o_clk_divided8(clk_divided8),
		.o_clk_divided16(clk_divided16)
	);
endmodule