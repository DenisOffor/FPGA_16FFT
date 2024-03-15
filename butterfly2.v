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
	
	output					w_mutiplier_done,
	output 					o_butterfly_done
);

	//wires for divided i_clk
	wire 						clk_divided16;
	wire 						clk_divided32;
	//wire for connect "multiple done" with "write_enable" for flash
	//wire 						w_mutiplier_done;
	//current input data chosen for multiply them
	wire 		[N-1:0] 		current_factor1;
	wire 		[N-1:0] 		current_factor2;
	//wire for multiple complex in1 on complex twiddle
	wire		[N-1:0]     out_multiplier;
	//need for get negative 	
	wire		[N-1:0]     out_multiplier_negative;
	//wires fan out from flash to adders 
	wire		[N-1:0]		w_out_re0, w_out_re1, w_out_im0, w_out_im1;
	wire		[N-1:0]		w_out_re0_neg, w_out_re1_neg, w_out_im0_neg, w_out_im1_neg;
	
	reg 		[2:0] 		counter_of_signals_multiplier_done;
	reg  						r_butterfly_done;
	
	assign o_butterfly_done = r_butterfly_done; 
	
	initial begin
		counter_of_signals_multiplier_done <= 0;
		r_butterfly_done <= 0;
	end
	 
	always @(w_mutiplier_done) begin
		if(w_mutiplier_done) begin
			counter_of_signals_multiplier_done <= counter_of_signals_multiplier_done + 1;
			if(counter_of_signals_multiplier_done == 3) begin
				r_butterfly_done <= 1;
				counter_of_signals_multiplier_done <= 0;
			end
		end
		else
			r_butterfly_done <= 0;
	end
	 //////////////////////
	 flash #(.N(N)) flash1
	 ( 
		   .i_clk(i_clk),
		   .i_word(out_multiplier),
		   .write_enable(w_mutiplier_done),
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
		   .write_enable(w_mutiplier_done),
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
		  .o_multipl_done(w_mutiplier_done)
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
		.o_clk_divided2(),
		.o_clk_divided4(),
		.o_clk_divided8(),
		.o_clk_divided16(clk_divided16),
		.o_clk_divided32(clk_divided32),
		.o_clk_divided64()
	);
endmodule