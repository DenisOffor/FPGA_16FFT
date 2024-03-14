module ram_for_signal #(parameter ADDR_WIDTH = 4, DATA_WIDTH = 16, DEPTH = 16)
(
	input                       		clk,
	input      [ADDR_WIDTH-1:0] 		addr,
	input                       		re,
	input      [DATA_WIDTH-1:0] 		data00_r,
	input      [DATA_WIDTH-1:0] 		data01_r,
	input      [DATA_WIDTH-1:0] 		data02_r,
	input      [DATA_WIDTH-1:0] 		data03_r,
	input      [DATA_WIDTH-1:0] 		data04_r,
	input      [DATA_WIDTH-1:0] 		data05_r,
	input      [DATA_WIDTH-1:0] 		data06_r,
	input      [DATA_WIDTH-1:0] 		data07_r,
	input      [DATA_WIDTH-1:0] 		data08_r,
	input      [DATA_WIDTH-1:0] 		data09_r,
	input      [DATA_WIDTH-1:0] 		data10_r,
	input      [DATA_WIDTH-1:0] 		data11_r,
	input      [DATA_WIDTH-1:0] 		data12_r,
	input      [DATA_WIDTH-1:0] 		data13_r,
	input      [DATA_WIDTH-1:0] 		data14_r,
	input      [DATA_WIDTH-1:0] 		data15_r,
						
	input      [DATA_WIDTH-1:0] 		data00_i,
	input      [DATA_WIDTH-1:0] 		data01_i,
	input      [DATA_WIDTH-1:0] 		data02_i,
	input      [DATA_WIDTH-1:0] 		data03_i,
	input      [DATA_WIDTH-1:0] 		data04_i,
	input      [DATA_WIDTH-1:0] 		data05_i,
	input      [DATA_WIDTH-1:0] 		data06_i,
	input      [DATA_WIDTH-1:0] 		data07_i,
	input      [DATA_WIDTH-1:0] 		data08_i,
	input      [DATA_WIDTH-1:0] 		data09_i,
	input      [DATA_WIDTH-1:0] 		data10_i,
	input      [DATA_WIDTH-1:0] 		data11_i,
	input      [DATA_WIDTH-1:0] 		data12_i,
	input      [DATA_WIDTH-1:0] 		data13_i,
	input      [DATA_WIDTH-1:0] 		data14_i,
	input      [DATA_WIDTH-1:0] 		data15_i,

	output reg [2*DATA_WIDTH-1:0] 	data
);

	reg [2*DATA_WIDTH-1:0]  mem [DEPTH-1:0];
	
	initial begin
		mem[ 0] <= 0;
		mem[ 1] <= 0;
		mem[ 2] <= 0;
		mem[ 3] <= 0;
		mem[ 4] <= 0;
		mem[ 5] <= 0;
		mem[ 6] <= 0;
		mem[ 7] <= 0;
		mem[ 8] <= 0;
		mem[ 9] <= 0;
		mem[ 10] <= 0;
		mem[ 11] <= 0;
		mem[ 12] <= 0;
		mem[ 13] <= 0;
		mem[ 14] <= 0;
		mem[ 15] <= 0;
	end
	
	always @ (posedge clk) begin
		mem[ 0] <= {data00_r, data00_i};
		mem[ 1] <= {data01_r, data01_i};
		mem[ 2] <= {data02_r, data02_i};
		mem[ 3] <= {data03_r, data03_i};
		mem[ 4] <= {data04_r, data04_i};
		mem[ 5] <= {data05_r, data05_i};
		mem[ 6] <= {data06_r, data06_i};
		mem[ 7] <= {data07_r, data07_i};
		mem[ 8] <= {data08_r, data08_i};
		mem[ 9] <= {data09_r, data09_i};
		mem[10] <= {data10_r, data10_i};
		mem[11] <= {data11_r, data11_i};
		mem[12] <= {data12_r, data12_i};
		mem[13] <= {data13_r, data13_i};
		mem[14] <= {data14_r, data14_i};
		mem[15] <= {data15_r, data15_i};
	end
	always @ (posedge clk) begin
		if (re)
			data <= mem[addr];
		else
			data <= 0;
	end

endmodule