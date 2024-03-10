module demux1in4 #
(
    parameter N = 16
)
(
    input       [N-1:0]    a,
	 input 		 [1:0]		sel,
	 output reg  [N-1:0]    out0,
    output reg  [N-1:0]    out1,
	 output reg  [N-1:0]    out2,
	 output reg  [N-1:0]    out3
);
	initial begin
		out0 <= 0;
		out1 <= 0;
		out2 <= 0;
		out3 <= 0;
	end

	always @ (*) begin
		case (sel)
			2'b00    :   out0 = a;
			2'b01    :   out1 = a;
			2'b10    :   out2 = a;
			2'b11    :   out3 = a;
			default  :   out0 = a;
		endcase
	end
endmodule