module adder3 #(parameter WORD_SIZE = 16)
(
    input                   i_clk,
    input                   i_rst,
    input       [WORD_SIZE-1:0]     i_A,
    input       [WORD_SIZE-1:0]     i_B,
    input       [WORD_SIZE-1:0]     i_C,
    output reg  [WORD_SIZE-1:0]     o_sum
);
    always @(posedge i_clk or posedge i_rst) begin
        if(i_rst) begin
            o_sum <= i_A + i_B + i_C;
        end
        else begin
		      o_sum <= 0;
        end
    end
endmodule