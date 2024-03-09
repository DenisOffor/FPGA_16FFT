module adder3 #(parameter N = 16)
(
    input                   i_clk,
    input                   i_rst,
    input       [N-1:0]     i_A,
    input       [N-1:0]     i_B,
    input       [N-1:0]     i_C,
    output reg  [N-1:0]     o_sum
);

    always @(posedge i_clk or posedge i_rst) begin
        if(i_rst) begin
            o_sum = 0;
        end
        else begin
            o_sum = i_A + i_B + i_C;
        end
    end
endmodule