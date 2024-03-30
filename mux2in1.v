module mux2in1 #( parameter WORD_SIZE = 16)
(
    input       [WORD_SIZE-1:0]    a,
    input       [WORD_SIZE-1:0]    b,
	 input 		 				sel,
    output reg  [WORD_SIZE-1:0]    out
);

	always @ (*) begin
		case (sel)
		1'b0    :   out = a;
		1'b1    :   out = b;
		default :   out = 0;
		endcase
	end
endmodule