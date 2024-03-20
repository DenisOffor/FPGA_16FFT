module ram_for_signal #(parameter N = 16)
(
	input                       		clk,
	input      [N-1:0] 		data00_r,
	input      [N-1:0] 		data01_r,
	input      [N-1:0] 		data02_r,
	input      [N-1:0] 		data03_r,
	input      [N-1:0] 		data04_r,
	input      [N-1:0] 		data05_r,
	input      [N-1:0] 		data06_r,
	input      [N-1:0] 		data07_r,
	input      [N-1:0] 		data08_r,
	input      [N-1:0] 		data09_r,
	input      [N-1:0] 		data10_r,
	input      [N-1:0] 		data11_r,
	input      [N-1:0] 		data12_r,
	input      [N-1:0] 		data13_r,
	input      [N-1:0] 		data14_r,
	input      [N-1:0] 		data15_r,
						
	input      [N-1:0] 		data00_i,
	input      [N-1:0] 		data01_i,
	input      [N-1:0] 		data02_i,
	input      [N-1:0] 		data03_i,
	input      [N-1:0] 		data04_i,
	input      [N-1:0] 		data05_i,
	input      [N-1:0] 		data06_i,
	input      [N-1:0] 		data07_i,
	input      [N-1:0] 		data08_i,
	input      [N-1:0] 		data09_i,
	input      [N-1:0] 		data10_i,
	input      [N-1:0] 		data11_i,
	input      [N-1:0] 		data12_i,
	input      [N-1:0] 		data13_i,
	input      [N-1:0] 		data14_i,
	input      [N-1:0] 		data15_i,

	output	reg 	[N-1:0]	out0_re,
	output	reg 	[N-1:0]	out0_im,
	output	reg 	[N-1:0]	out1_re,
	output	reg 	[N-1:0]	out1_im,
	output	reg 	[N-1:0]	out2_re,
	output	reg 	[N-1:0]	out2_im,
	output	reg 	[N-1:0]	out3_re,
	output	reg 	[N-1:0]	out3_im,
	output	reg 	[N-1:0]	out4_re,
	output	reg 	[N-1:0]	out4_im,
	output	reg 	[N-1:0]	out5_re,
	output	reg 	[N-1:0]	out5_im,
	output	reg 	[N-1:0]	out6_re,
	output	reg 	[N-1:0]	out6_im,
	output	reg 	[N-1:0]	out7_re,
	output	reg 	[N-1:0]	out7_im,
	output	reg 	[N-1:0]	out8_re,
	output	reg 	[N-1:0]	out8_im,
	output	reg 	[N-1:0]	out9_re,
	output	reg 	[N-1:0]	out9_im,
	output	reg 	[N-1:0]	out10_re,
	output	reg 	[N-1:0]	out10_im,
	output	reg 	[N-1:0]	out11_re,
	output	reg 	[N-1:0]	out11_im,
	output	reg 	[N-1:0]	out12_re,
	output	reg 	[N-1:0]	out12_im,
	output	reg 	[N-1:0]	out13_re,
	output	reg 	[N-1:0]	out13_im,
	output	reg 	[N-1:0]	out14_re,
	output	reg 	[N-1:0]	out14_im,
	output	reg 	[N-1:0]	out15_re,
	output	reg 	[N-1:0]	out15_im
);
	initial begin
		out0_re  <= 0;
		out0_im  <= 0;
		out1_re  <= 0;
		out1_im  <= 0;
		out2_re  <= 0;
		out2_im  <= 0;
		out3_re  <= 0;
		out3_im  <= 0;
		out4_re  <= 0;
		out4_im  <= 0;
		out5_re  <= 0;
		out5_im  <= 0;
		out6_re  <= 0;
		out6_im  <= 0;
		out7_re  <= 0;
		out7_im  <= 0;
		out8_re  <= 0;
		out8_im  <= 0;
		out9_re  <= 0;
		out9_im  <= 0;
		out10_re <= 0;
		out10_im <= 0;
		out11_re <= 0;
		out11_im <= 0;
		out12_re <= 0;
		out12_im <= 0;
		out13_re <= 0;
		out13_im <= 0;
		out14_re <= 0;
		out14_im <= 0;
		out15_re <= 0;
		out15_im <= 0;
	end
	
	always @ (posedge clk) begin
		out0_re  <= (data00_r[N-1] == 0 ? (data00_r >> 4) : (~((~data00_r + 1'b1) >> 4) + 1'b1));
		out0_im  <= (data00_i[N-1] == 0 ? (data00_i >> 4) : (~((~data00_i + 1'b1) >> 4) + 1'b1));
		out1_re  <= (data15_r[N-1] == 0 ? (data15_r >> 4) : (~((~data15_r + 1'b1) >> 4) + 1'b1));
		out1_im  <= (data15_i[N-1] == 0 ? (data15_i >> 4) : (~((~data15_i + 1'b1) >> 4) + 1'b1));
		out2_re  <= (data14_r[N-1] == 0 ? (data14_r >> 4) : (~((~data14_r + 1'b1) >> 4) + 1'b1));
		out2_im  <= (data14_i[N-1] == 0 ? (data14_i >> 4) : (~((~data14_i + 1'b1) >> 4) + 1'b1));
		out3_re  <= (data13_r[N-1] == 0 ? (data13_r >> 4) : (~((~data13_r + 1'b1) >> 4) + 1'b1));
		out3_im  <= (data13_i[N-1] == 0 ? (data13_i >> 4) : (~((~data13_i + 1'b1) >> 4) + 1'b1));
		out4_re  <= (data12_r[N-1] == 0 ? (data12_r >> 4) : (~((~data12_r + 1'b1) >> 4) + 1'b1));
		out4_im  <= (data12_i[N-1] == 0 ? (data12_i >> 4) : (~((~data12_i + 1'b1) >> 4) + 1'b1));
		out5_re  <= (data11_r[N-1] == 0 ? (data11_r >> 4) : (~((~data11_r + 1'b1) >> 4) + 1'b1));
		out5_im  <= (data11_i[N-1] == 0 ? (data11_i >> 4) : (~((~data11_i + 1'b1) >> 4) + 1'b1));
		out6_re  <= (data10_r[N-1] == 0 ? (data10_r >> 4) : (~((~data10_r + 1'b1) >> 4) + 1'b1));
		out6_im  <= (data10_i[N-1] == 0 ? (data10_i >> 4) : (~((~data10_i + 1'b1) >> 4) + 1'b1));
		out7_re  <= (data09_r[N-1] == 0 ? (data09_r >> 4) : (~((~data09_r + 1'b1) >> 4) + 1'b1));
		out7_im  <= (data09_i[N-1] == 0 ? (data09_i >> 4) : (~((~data09_i + 1'b1) >> 4) + 1'b1));
		out8_re  <= (data08_r[N-1] == 0 ? (data08_r >> 4) : (~((~data08_r + 1'b1) >> 4) + 1'b1));
		out8_im  <= (data08_i[N-1] == 0 ? (data08_i >> 4) : (~((~data08_i + 1'b1) >> 4) + 1'b1));
		out9_re  <= (data07_r[N-1] == 0 ? (data07_r >> 4) : (~((~data07_r + 1'b1) >> 4) + 1'b1));
		out9_im  <= (data07_i[N-1] == 0 ? (data07_i >> 4) : (~((~data07_i + 1'b1) >> 4) + 1'b1));
		out10_re <= (data06_r[N-1] == 0 ? (data06_r >> 4) : (~((~data06_r + 1'b1) >> 4) + 1'b1));
		out10_im <= (data06_i[N-1] == 0 ? (data06_i >> 4) : (~((~data06_i + 1'b1) >> 4) + 1'b1));
		out11_re <= (data05_r[N-1] == 0 ? (data05_r >> 4) : (~((~data05_r + 1'b1) >> 4) + 1'b1));
		out11_im <= (data05_i[N-1] == 0 ? (data05_i >> 4) : (~((~data05_i + 1'b1) >> 4) + 1'b1));
		out12_re <= (data04_r[N-1] == 0 ? (data04_r >> 4) : (~((~data04_r + 1'b1) >> 4) + 1'b1));
		out12_im <= (data04_i[N-1] == 0 ? (data04_i >> 4) : (~((~data04_i + 1'b1) >> 4) + 1'b1));
		out13_re <= (data03_r[N-1] == 0 ? (data03_r >> 4) : (~((~data03_r + 1'b1) >> 4) + 1'b1));
		out13_im <= (data03_i[N-1] == 0 ? (data03_i >> 4) : (~((~data03_i + 1'b1) >> 4) + 1'b1));
		out14_re <= (data02_r[N-1] == 0 ? (data02_r >> 4) : (~((~data02_r + 1'b1) >> 4) + 1'b1));
		out14_im <= (data02_i[N-1] == 0 ? (data02_i >> 4) : (~((~data02_i + 1'b1) >> 4) + 1'b1));
		out15_re <= (data01_r[N-1] == 0 ? (data01_r >> 4) : (~((~data01_r + 1'b1) >> 4) + 1'b1));
		out15_im <= (data01_i[N-1] == 0 ? (data01_i >> 4) : (~((~data01_i + 1'b1) >> 4) + 1'b1));
	end

endmodule