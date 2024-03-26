module get_negative #(parameter WORD_SIZE = 16)
(
	input 	[WORD_SIZE-1:0] in,
	output 	[WORD_SIZE-1:0] out
);
	assign out = ~in + 1'b1;
endmodule
