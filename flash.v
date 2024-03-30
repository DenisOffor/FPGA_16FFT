module flash #(parameter WORD_SIZE = 16)
(
	input 						i_clk,
	input 			[WORD_SIZE-1:0] 	i_word,
	input				[1:0]		address,
	output 	reg 	[WORD_SIZE-1:0]	o_word0,
	output 	reg 	[WORD_SIZE-1:0]	o_word1,
	output 	reg 	[WORD_SIZE-1:0]	o_word2,
	output 	reg 	[WORD_SIZE-1:0]	o_word3
);
	reg [WORD_SIZE-1:0] mem [3:0];
	
	always @(*) begin
		mem[address] <= i_word; 
	end
	
	always @(*) begin
		o_word0 <= mem[0];
		o_word1 <= mem[1];
		o_word2 <= mem[2];
		o_word3 <= mem[3];
	end
endmodule
