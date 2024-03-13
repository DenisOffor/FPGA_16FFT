module rom_twiddle #(parameter N = 16)
(
	input				clk,
	input				rst,
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
	always @ (posedge clk or posedge rst) begin
		if(rst) begin
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
			reg0_re  <= 16'b0000000000000000;
			reg0_im  <= 16'b0000000000000000;
			reg1_re  <= 16'b0000000000110001;
			reg1_im  <= 16'b0000000000110001;
			reg2_re  <= 16'b0000000001100010;
			reg2_im  <= 16'b0000000001100010;
			reg3_re  <= 16'b0000000010001110;
			reg3_im  <= 16'b0000000010001110;
			reg4_re  <= 16'b0000000010110100;
			reg4_im  <= 16'b0000000010110100;
			reg5_re  <= 16'b0000000011010100;
			reg5_im  <= 16'b0000000011010100;
			reg6_re  <= 16'b0000000011101100;
			reg6_im  <= 16'b0000000011101100;
			reg7_re  <= 16'b0000000011111011;
			reg7_im  <= 16'b0000000011111011;
		end
	end
endmodule