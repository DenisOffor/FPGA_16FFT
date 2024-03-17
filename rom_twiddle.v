module rom_twiddle #(parameter N = 16)
(
	input 					i_clk,
	input						i_rst,
	output reg [N-1:0]	reg0_re,
	output reg [N-1:0]	reg0_im,	
	output reg [N-1:0]	reg1_re,
	output reg [N-1:0]	reg1_im,
	output reg [N-1:0]	reg2_re,
	output reg [N-1:0]	reg2_im,
	output reg [N-1:0]	reg3_re,
	output reg [N-1:0]	reg3_im,
	output reg [N-1:0]	reg4_re,
	output reg [N-1:0]	reg4_im,
	output reg [N-1:0]	reg5_re,
	output reg [N-1:0]	reg5_im,
	output reg [N-1:0]	reg6_re,
	output reg [N-1:0]	reg6_im,
	output reg [N-1:0]	reg7_re,
	output reg [N-1:0]	reg7_im
);
	always @ (posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			reg0_re  <= 0;
			reg0_im  <= 0;
			reg1_re  <= 0;
			reg1_im  <= 0;
			reg2_re  <= 0;
			reg2_im  <= 0;
			reg3_re  <= 0;
			reg3_im  <= 0;
			reg4_re  <= 0;
			reg4_im  <= 0;
			reg5_re  <= 0;
			reg5_im  <= 0;
			reg6_re  <= 0;
			reg6_im  <= 0;
			reg7_re  <= 0;
			reg7_im  <= 0;
		end
		else begin
			reg0_re  <= 16'b0000000100000000; //1
			reg0_im  <= 16'b0000000000000000; //0

			reg1_re  <= 16'b0000000011101101; //0.9239
			reg1_im  <= 16'b0000000001100010; //0.3827

			reg2_re  <= 16'b0000000010110101; //0.7071
			reg2_im  <= 16'b0000000010110101; //0.7071

			reg3_re  <= 16'b0000000001100010; //0.3827
			reg3_im  <= 16'b0000000011101101; //0.9239

			reg4_re  <= 16'b0000000000000000; //0
			reg4_im  <= 16'b0000000100000000; //1

			reg5_re  <= 16'b1111111110011110; //-0.3827
			reg5_im  <= 16'b0000000011101101; //0.9239

			reg6_re  <= 16'b1111111101001011; //-0.7071
			reg6_im  <= 16'b0000000010110101; //0.7071

			reg7_re  <= 16'b1111111100010011; //-0.9239
			reg7_im  <= 16'b0000000001100010; //0.3827
		end
	end
endmodule