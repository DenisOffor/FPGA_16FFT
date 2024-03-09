module multiplier #(parameter N = 16, Q = 8)
(
	input 						i_clk,
	input 						i_rst,
	input 		[N-1:0] 		i_A,
	input 		[N-1:0] 		i_B,
	output reg	[N-1:0] 		o_C
);
	
	reg [2*N-1:0] 	P;
	reg [N-1:0]		temp1;
	reg [N-1:0]		temp2;
	reg [N-1:0]		temp3;
	
	always @(negedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			o_C = 0;
			P = 0;
			temp1 = 0;
			temp2 = 0;
			temp3 = 0;
		end
		else begin
			if(i_A[N-1] == 0 && i_B[N-1] == 0) begin
				//two positive number
				temp1 = 0;
				temp2 = 0;
				temp3 = 0;
				P = i_A * i_B;
				//result of multiplying 2 numbers is 32 bit lengths, so we need to cut it to 16 bit
				//fot that we take 8 bit for int part of number and 8 bit for fractional part of number [23:8] 
				o_C = P[N - 1 + Q:Q];
			end
			else if (i_A[N-1] == 0 && i_B[N-1] == 1) begin
				//one positive and one negative number
				temp1 = 0;
				//take complement of negative number
				temp2 = ~i_B + 1'b1;
				P = i_A * temp2;
				temp3 = P[N - 1 + Q:Q];
				o_C = ~temp3 + 1'b1;
			end
			else if (i_A[N-1] == 1 && i_B[N-1] == 0) begin
				//one positive and one negative number
				temp1 = ~i_A + 1'b1;
				temp2 = 0;
				P = i_B * temp2;
				temp3 = P[N - 1 + Q:Q];
				o_C = ~temp3 + 1'b1;
			end
			else begin
				//two negative number
				temp1 = ~i_A + 1'b1;
				temp2 = ~i_B + 1'b1;
				temp3 = 0;
				P = i_A * i_B;
				o_C = P[N - 1 + Q:Q];
			end
		end
	end
	
endmodule