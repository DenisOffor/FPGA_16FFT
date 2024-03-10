module mux2in1 #
(
    parameter N = 16
)
(
    input       [N-1:0]    a,
    input       [N-1:0]    b,
	 input 		 				sel,
    output reg  [N-1:0]    out
);
	initial begin
	
	end

	always @ (*) begin
		case (sel)
		1'b0    :   out = a;
		1'b1    :   out = b;
		default :   out = 0;
		endcase
	end
endmodule