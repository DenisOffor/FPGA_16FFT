module top #(parameter FFT_SIZE = 32, WORD_SIZE = 16, DATA_LENGTH = 8, FRACTION = 8, CLOCK_PER_BIT = 434)
(
	input 			i_clk,
	input 			i_RX_bit,
			
	output 			o_TX_bit,
	output	[23:0]	o_counter_of_clk
);
	
	//wires for out from FFT
	wire	[WORD_SIZE-1:0]			w_FFT_out0_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out1_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out2_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out3_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out4_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out5_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out6_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out7_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out8_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out9_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out10_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out11_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out12_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out13_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out14_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out15_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out16_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out17_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out18_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out19_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out20_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out21_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out22_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out23_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out24_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out25_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out26_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out27_re;	
	wire	[WORD_SIZE-1:0]			w_FFT_out28_re;
	wire	[WORD_SIZE-1:0]			w_FFT_out29_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out30_re;
   wire	[WORD_SIZE-1:0]			w_FFT_out31_re;

	//reg and wires for UART_RX
	wire 	[DATA_LENGTH - 1:0] 	w_Received_byte;
	wire 								w_receive_state;

	//reg and wires for UART_TX
	wire 	[DATA_LENGTH - 1:0] 	w_Transmitted_byte;
	wire 								w_TX_done;
	wire 								w_TX_start;
	wire								w_full_TX_state;

	wire								w_FFT_rst;
	wire								w_FFT32_cycle_done;
	wire	[6:0]						w_counter_of_sended_bytes;
	
	reg [23:0] counter_of_clk = 0;
	assign o_counter_of_clk = counter_of_clk;
	
	always @(posedge i_clk) begin
		if(~w_FFT_rst) begin
			counter_of_clk <= counter_of_clk + 1'b1;
		end 
	end
	
	top_control_unit my_top_control_unit
	(
		.i_clk(i_clk),
		.i_FFT32_cycle_done(w_FFT32_cycle_done),
		.i_receive_state(w_receive_state),
		.i_TX_done(w_TX_done),
		
		.o_FFT_rst(w_FFT_rst),
		.o_TX_start(w_TX_start),
		.o_full_TX_state(w_full_TX_state),
		.o_counter_of_sended_bytes(w_counter_of_sended_bytes)
	);

	
	mux64in1 #(.DATA_LENGTH(DATA_LENGTH)) my_mux64in1
	(
		.in0(w_FFT_out0_re[7:0]),
		.in1(w_FFT_out0_re[15:8]),
		.in2(w_FFT_out1_re[7:0]),
		.in3(w_FFT_out1_re[15:8]),
		.in4(w_FFT_out2_re[7:0]),
		.in5(w_FFT_out2_re[15:8]),
		.in6(w_FFT_out3_re[7:0]),
		.in7(w_FFT_out3_re[15:8]),
		.in8(w_FFT_out4_re[7:0]),
		.in9(w_FFT_out4_re[15:8]),
		.in10(w_FFT_out5_re[7:0]),
		.in11(w_FFT_out5_re[15:8]),
		.in12(w_FFT_out6_re[7:0]),
		.in13(w_FFT_out6_re[15:8]),
		.in14(w_FFT_out7_re[7:0]),
		.in15(w_FFT_out7_re[15:8]),
		.in16(w_FFT_out8_re[7:0]),
		.in17(w_FFT_out8_re[15:8]),
		.in18(w_FFT_out9_re[7:0]),
		.in19(w_FFT_out9_re[15:8]),
		.in20(w_FFT_out10_re[7:0]),
		.in21(w_FFT_out10_re[15:8]),
		.in22(w_FFT_out11_re[7:0]),
		.in23(w_FFT_out11_re[15:8]),
		.in24(w_FFT_out12_re[7:0]),
		.in25(w_FFT_out12_re[15:8]),
		.in26(w_FFT_out13_re[7:0]),
		.in27(w_FFT_out13_re[15:8]),
		.in28(w_FFT_out14_re[7:0]),
		.in29(w_FFT_out14_re[15:8]),
		.in30(w_FFT_out15_re[7:0]),
		.in31(w_FFT_out15_re[15:8]),
		
		.in32(w_FFT_out16_re[7:0]),
		.in33(w_FFT_out16_re[15:8]),
		.in34(w_FFT_out17_re[7:0]),
		.in35(w_FFT_out17_re[15:8]),
		.in36(w_FFT_out18_re[7:0]),
		.in37(w_FFT_out18_re[15:8]),
		.in38(w_FFT_out19_re[7:0]),
		.in39(w_FFT_out19_re[15:8]),
		.in40(w_FFT_out20_re[7:0]),
		.in41(w_FFT_out20_re[15:8]),
		.in42(w_FFT_out21_re[7:0]),
		.in43(w_FFT_out21_re[15:8]),
		.in44(w_FFT_out22_re[7:0]),
		.in45(w_FFT_out22_re[15:8]),
		.in46(w_FFT_out23_re[7:0]),
		.in47(w_FFT_out23_re[15:8]),
		.in48(w_FFT_out24_re[7:0]),
		.in49(w_FFT_out24_re[15:8]),
		.in50(w_FFT_out25_re[7:0]),
		.in51(w_FFT_out25_re[15:8]),
		.in52(w_FFT_out26_re[7:0]),
		.in53(w_FFT_out26_re[15:8]),
		.in54(w_FFT_out27_re[7:0]),
		.in55(w_FFT_out27_re[15:8]),
		.in56(w_FFT_out28_re[7:0]),
		.in57(w_FFT_out28_re[15:8]),
		.in58(w_FFT_out29_re[7:0]),
		.in59(w_FFT_out29_re[15:8]),
		.in60(w_FFT_out30_re[7:0]),
		.in61(w_FFT_out30_re[15:8]),
		.in62(w_FFT_out31_re[7:0]),
		.in63(w_FFT_out31_re[15:8]),
		
		.sel(w_counter_of_sended_bytes),
		.out(w_Transmitted_byte)
	);
	
	
	FFT_for_OFDM #(.WORD_SIZE(WORD_SIZE),.DATA_LENGTH(DATA_LENGTH), .FRACTION(FRACTION)) FFT_for_OFDM
	(
		.i_clk(i_clk),
		.i_rst(w_FFT_rst),
		.i_byte(w_Received_byte),
	
		.out0_re(w_FFT_out0_re),
		.out0_im(),
		.out1_re(w_FFT_out1_re),
		.out1_im(),
		.out2_re(w_FFT_out2_re),
		.out2_im(),
		.out3_re(w_FFT_out3_re),
		.out3_im(),
		.out4_re(w_FFT_out4_re),
		.out4_im(),
		.out5_re(w_FFT_out5_re),
		.out5_im(),
		.out6_re(w_FFT_out6_re),
		.out6_im(),
		.out7_re(w_FFT_out7_re),
		.out7_im(),
		.out8_re(w_FFT_out8_re),
		.out8_im(),
		.out9_re(w_FFT_out9_re),
		.out9_im(),
		.out10_re(w_FFT_out10_re),
		.out10_im(),
		.out11_re(w_FFT_out11_re),
		.out11_im(),
		.out12_re(w_FFT_out12_re),
		.out12_im(),
		.out13_re(w_FFT_out13_re),
		.out13_im(),
		.out14_re(w_FFT_out14_re),
		.out14_im(),
		.out15_re(w_FFT_out15_re),
		.out15_im(),
		.out16_re(w_FFT_out16_re),
		.out16_im(),
		.out17_re(w_FFT_out17_re),
		.out17_im(),
		.out18_re(w_FFT_out18_re),
		.out18_im(),
		.out19_re(w_FFT_out19_re),
		.out19_im(),
		.out20_re(w_FFT_out20_re),
		.out20_im(),
		.out21_re(w_FFT_out21_re),
		.out21_im(),
		.out22_re(w_FFT_out22_re),
		.out22_im(),
		.out23_re(w_FFT_out23_re),
		.out23_im(),
		.out24_re(w_FFT_out24_re),
		.out24_im(),
		.out25_re(w_FFT_out25_re),
		.out25_im(),
		.out26_re(w_FFT_out26_re),
		.out26_im(),
		.out27_re(w_FFT_out27_re),
		.out27_im(),
		.out28_re(w_FFT_out28_re),
		.out28_im(),
		.out29_re(w_FFT_out29_re),
		.out29_im(),
		.out30_re(w_FFT_out30_re),
		.out30_im(),
		.out31_re(w_FFT_out31_re),
		.out31_im(),
		
		.o_FFT32_cycle_done(w_FFT32_cycle_done)
	);

	UART_RX #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) Receiver 
	(
		.i_clk(i_clk && ~r_full_TX_state), // && in order to cancel receive while FFT for previous data is going  
		.i_RX_bit(i_RX_bit),
		.o_Received_byte(w_Received_byte), 
		.o_receive_state(w_receive_state), 
		.o_error()
	);
	
	UART_TX #(.CLOCK_PER_BIT(CLOCK_PER_BIT)) Transmitter
	(
		.i_clk(i_clk),
		.i_rst(~w_full_TX_state),
		.i_start(w_TX_start), 
		.i_TX_byte(w_Transmitted_byte),
		.o_TX_bit(o_TX_bit), 
		.o_transfer_state(), 
		.o_TX_done(w_TX_done)
	);
endmodule
