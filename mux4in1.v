module mux4in1 #(parameter WORD_SIZE = 16)
(
    input       [WORD_SIZE-1:0]    a,
    input       [WORD_SIZE-1:0]    b,
	 input       [WORD_SIZE-1:0]    c,
	 input       [WORD_SIZE-1:0]    d,
	 input 		 [1:0]		sel,
    output reg  [WORD_SIZE-1:0]    out
);
	initial begin
	
	end

	always @ (*) begin
		case (sel)
		2'b00    :   out = a;
		2'b01    :   out = b;
		2'b10    :   out = c;
		2'b11    :   out = d;
		default  :   out = 0;
		endcase
	end
endmodule