module multiplier #(parameter WORD_SIZE = 16, FRACTION = 8)
(
	input 						i_clk,
	input 						i_rst,
	input 		[WORD_SIZE-1:0] 		i_A,
	input 		[WORD_SIZE-1:0] 		i_B,
	output 		[WORD_SIZE-1:0] 		out
);
	
	reg [2*WORD_SIZE-1:0] 	P;
	reg [WORD_SIZE-1:0]		temp1;
	reg [WORD_SIZE-1:0]		temp2;
	reg [WORD_SIZE-1:0]    temp3;
	
	initial begin
		P <= 0;
		temp1 <= 0;
		temp2 <= 0;
		temp3 <= 0;
	end
	
	
	always @(posedge i_clk or posedge i_rst) begin
		if(i_rst) begin
			case({i_A[WORD_SIZE-1], i_B[WORD_SIZE-1]})
				2'b00:
				begin
					//two positive number
					temp1 <= i_A;
					temp2 <= i_B;
					P <= temp1 * temp2;
					//result of multiplying 2 numbers is 32 bit lengths, so we need to cut it to 16 bit
					//fot that we take 8 bit for int part of number and 8 bit for fractional part of number [23:8] 
					temp3 <= P[WORD_SIZE - 1 + FRACTION:FRACTION];
				end
				
				2'b01:
				begin
					//one positive and one negative number
					temp1 <= i_A;
					//take complement of negative number
					temp2 <= ~i_B + 1'b1;
					//take complement of negative number
					P <= temp1 * temp2;
					temp3 <= ~(P[WORD_SIZE - 1 + FRACTION:FRACTION]) + 1'b1;
				end
				
				2'b10:
				begin
					//one positive and one negative number
					temp1 <= ~i_A + 1'b1;
					temp2 <= i_B;
					P <= temp1 * temp2;
					temp3 <= ~(P[WORD_SIZE - 1 + FRACTION:FRACTION]) + 1'b1;
				end
				
				2'b11:
				begin
					//two negative number
					temp1 <= ~i_A + 1'b1;
					temp2 <= ~i_B + 1'b1;
					P <= temp1 * temp2;
					temp3 <= P[WORD_SIZE - 1 + FRACTION:FRACTION];
				end	
			endcase
		end
		else begin
			temp1 <= 0;
			temp2 <= 0;
			temp3 <= 0;
			P 		<= 0;
		end
	end
	assign out = temp3;
endmodule