module butterfly2_tb #(parameter WORD_SIZE = 16, FRACTION = 8, DATA_LENGTH = 8)
(	
	input 					i_clk,
	input						i_btn,
	output					o_TX_bit,
	output					w_rst
);
	reg 									r_rst;
	//wire									w_rst;
	assign 								w_rst = ~r_rst;
	
	reg 	r_start = 0;
	wire	w_start;
	assign w_start = r_start;
	
	reg   [WORD_SIZE-1:0] 			i_in0_re, i_in0_im, i_in1_re, i_in1_im;
	reg   [WORD_SIZE-1:0] 			i_twiddle_re, i_twiddle_im;
		
	wire 	[WORD_SIZE-1:0]			o_out0_re;
	wire 	[WORD_SIZE-1:0]			o_out0_im;
	wire 	[WORD_SIZE-1:0]			o_out1_re;
	wire 	[WORD_SIZE-1:0]			o_out1_im;
	
	wire  [WORD_SIZE-1:0]			w_out0_re;
	wire  [WORD_SIZE-1:0]			w_out0_im;
	wire  [WORD_SIZE-1:0]			w_out1_re;
	wire  [WORD_SIZE-1:0]			w_out1_im;

	wire 	[8-1:0] 						w_Transmitted_byte;
	wire									w_TX_done;
	wire									w_btn_state;
	reg 	[5:0]	   				   counter_of_sended_bytes = 0;
	
			
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
	
	always @(posedge i_clk or posedge w_rst) begin
		if(w_rst) begin
			i_in0_re <= 0;
			i_in0_im <= 0;
			i_in1_re <= 0;
			i_in1_im <= 0;
			i_twiddle_re <= 0;
			i_twiddle_im <= 0;
		end
		else begin
			i_in0_re <= 16'b0000001000000000;
			i_in0_im <= 16'b0000000100000000;

			i_in1_re <= 16'b0000001100000000;
			i_in1_im <= 16'b1111111100000000;

			i_twiddle_re <= 16'b0000000100000000;
			i_twiddle_im <= 16'b0000000000000000;
		end
	end
	
	always @(posedge w_btn_state) begin
		r_rst <= r_rst ^ 1'b1;
	end
	
	always @(posedge i_clk or posedge w_TX_done) begin
		if(w_TX_done) begin
			r_start <= 1'b1;
		end
		else begin
			r_start <= 1'b0;
		end
	end
		
	always @(posedge w_TX_done) begin
		counter_of_sended_bytes <= counter_of_sended_bytes + 1'b1;
		if(counter_of_sended_bytes == 7) begin
			counter_of_sended_bytes <= 0;
		end
	end
	
	debouncer my_debouncer(
		.clk(i_clk), 
		.button(~i_btn), 
		.button_state(w_btn_state)
	);
	
	ram_4_byte #(.WORD_SIZE(WORD_SIZE)) ram_4_byte_my
	(
		.we(o_butterfly_done),
		.in0_re(o_out0_re),
		.in0_im(o_out0_im),
		.in1_re(o_out1_re),
		.in1_im(o_out1_im),
	
		.out0_re(w_out0_re),
		.out0_im(w_out0_im),
		.out1_re(w_out1_re),
		.out1_im(w_out1_im)
	);

	mux32in1 #(.DATA_LENGTH(DATA_LENGTH)) mymux
	(
		.in0(w_out0_re[7:0]),
		.in1(w_out0_re[15:8]),
		.in2(w_out0_im[7:0]),
		.in3(w_out0_im[15:8]),
		.in4(w_out1_re[7:0]),
		.in5(w_out1_re[15:8]),
		.in6(w_out1_im[7:0]),
		.in7(w_out1_im[15:8]),
		.in8(),
		.in9(),
		.in10(),
		.in11(),
		.in12(),
		.in13(),
		.in14(),
		.in15(),
		.in16(),
		.in17(),
		.in18(),
		.in19(),
		.in20(),
		.in21(),
		.in22(),
		.in23(),
		.in24(),
		.in25(),
		.in26(),
		.in27(),
		.in28(),
		.in29(),
		.in30(),
		.in31(),
		
		.sel(counter_of_sended_bytes),
		.out(w_Transmitted_byte)
	);
	
	butterfly2 #(.WORD_SIZE(WORD_SIZE), .FRACTION(FRACTION)) but2 
	(
		.i_clk(i_clk),
		.i_rst(w_rst),
		
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
		.o_butterfly_done(o_butterfly_done)
	);
	
	UART_TX Transmitter
	(
		.i_clk(i_clk),
		.i_rst(w_rst),
		.i_start(o_butterfly_done || w_start), 
		.i_TX_byte(w_Transmitted_byte),
		.o_TX_bit(o_TX_bit), 
		.o_transfer_state(), 
		.o_TX_done(w_TX_done)
	);
endmodule