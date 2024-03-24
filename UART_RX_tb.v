module UART_RX_tb(output TX_data,output o_transfer_state, output o_TX_done, output receive_state, output error, output [7:0]o_Received_byte);
	reg clk = 0;
	reg start = 0;
	reg [7:0]TX_byte = 8'b10110101;
	
	initial begin
		#200 start <= 1;
		#20 start <= 0;
		#10000 TX_byte = 8'b10000010;
		#200 start <= 1;
		#20 start <= 0;
	end
	
	always
	  #10 clk = ~clk;
	
	UART_TX UART_TX(.i_clk(clk), .i_start(start), .i_TX_byte(TX_byte), .o_TX_bit(TX_data), .o_transfer_state(o_transfer_state), .o_TX_done(o_TX_done));
	UART_RX UART_RX(.i_clk(clk), .i_RX_bit(TX_data), .o_Received_byte(o_Received_byte), .o_receive_state(receive_state), .o_error(error));
endmodule