module mux4in1 #
(
    parameter N = 16
)
(
    input       [N-1:0]    a,
    input       [N-1:0]    b,
	 input       [N-1:0]    c,
	 input       [N-1:0]    d,
	 input 		 [1:0]		sel,
    output reg  [N-1:0]    out
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