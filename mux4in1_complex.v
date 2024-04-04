module mux4in1_complex #(parameter WORD_SIZE = 16)
(
    input       [WORD_SIZE-1:0]    a_re,
	 input       [WORD_SIZE-1:0]    a_im,
	 input       [WORD_SIZE-1:0]    b_re,
	 input       [WORD_SIZE-1:0]    b_im,
	 input       [WORD_SIZE-1:0]    c_re,
	 input       [WORD_SIZE-1:0]    c_im,
	 input       [WORD_SIZE-1:0]    d_re,
	 input       [WORD_SIZE-1:0]    d_im,
	 input 		 [1:0]		sel,
    output reg  [WORD_SIZE-1:0]    out_re,
	 output reg  [WORD_SIZE-1:0]    out_im
);

	always @ (*) begin
		case (sel)
		2'b00: begin   
			out_re = a_re;
			out_im = a_im;
		end
		2'b01: begin   
			out_re = b_re;
			out_im = b_im;
		end
		2'b10: begin   
			out_re = c_re;
			out_im = c_im;
		end
		2'b11: begin   
			out_re = d_re;
			out_im = d_im;
		end
		default: begin
			out_re = 0;
			out_im = 0;
		end
		endcase
	end
endmodule