module mux64in1 #(parameter DATA_LENGTH = 8)
(
	input 			[DATA_LENGTH-1:0]		in0,
	input 			[DATA_LENGTH-1:0]		in1,
	input 			[DATA_LENGTH-1:0]		in2,
	input 			[DATA_LENGTH-1:0]		in3,
	input 			[DATA_LENGTH-1:0]		in4,
	input 			[DATA_LENGTH-1:0]		in5,
	input 			[DATA_LENGTH-1:0]		in6,
	input 			[DATA_LENGTH-1:0]		in7,
	input 			[DATA_LENGTH-1:0]		in8,
	input 			[DATA_LENGTH-1:0]		in9,
	input 			[DATA_LENGTH-1:0]		in10,
	input 			[DATA_LENGTH-1:0]		in11,
	input 			[DATA_LENGTH-1:0]		in12,
	input 			[DATA_LENGTH-1:0]		in13,
	input 			[DATA_LENGTH-1:0]		in14,
	input 			[DATA_LENGTH-1:0]		in15,
	input 			[DATA_LENGTH-1:0]		in16,
	input 			[DATA_LENGTH-1:0]		in17,
	input 			[DATA_LENGTH-1:0]		in18,
	input 			[DATA_LENGTH-1:0]		in19,
	input 			[DATA_LENGTH-1:0]		in20,
	input 			[DATA_LENGTH-1:0]		in21,
	input 			[DATA_LENGTH-1:0]		in22,
	input 			[DATA_LENGTH-1:0]		in23,
	input 			[DATA_LENGTH-1:0]		in24,
	input 			[DATA_LENGTH-1:0]		in25,
	input 			[DATA_LENGTH-1:0]		in26,
	input 			[DATA_LENGTH-1:0]		in27,
	input 			[DATA_LENGTH-1:0]		in28,
	input 			[DATA_LENGTH-1:0]		in29,
	input 			[DATA_LENGTH-1:0]		in30,
	input 			[DATA_LENGTH-1:0]		in31,
	
	input 			[DATA_LENGTH-1:0]		in32,
	input 			[DATA_LENGTH-1:0]		in33,
	input 			[DATA_LENGTH-1:0]		in34,
	input 			[DATA_LENGTH-1:0]		in35,
	input 			[DATA_LENGTH-1:0]		in36,
	input 			[DATA_LENGTH-1:0]		in37,
	input 			[DATA_LENGTH-1:0]		in38,
	input 			[DATA_LENGTH-1:0]		in39,
	input 			[DATA_LENGTH-1:0]		in40,
	input 			[DATA_LENGTH-1:0]		in41,
	input 			[DATA_LENGTH-1:0]		in42,
	input 			[DATA_LENGTH-1:0]		in43,
	input 			[DATA_LENGTH-1:0]		in44,
	input 			[DATA_LENGTH-1:0]		in45,
	input 			[DATA_LENGTH-1:0]		in46,
	input 			[DATA_LENGTH-1:0]		in47,
	input 			[DATA_LENGTH-1:0]		in48,
	input 			[DATA_LENGTH-1:0]		in49,
	input 			[DATA_LENGTH-1:0]		in50,
	input 			[DATA_LENGTH-1:0]		in51,
	input 			[DATA_LENGTH-1:0]		in52,
	input 			[DATA_LENGTH-1:0]		in53,
	input 			[DATA_LENGTH-1:0]		in54,
	input 			[DATA_LENGTH-1:0]		in55,
	input 			[DATA_LENGTH-1:0]		in56,
	input 			[DATA_LENGTH-1:0]		in57,
	input 			[DATA_LENGTH-1:0]		in58,
	input 			[DATA_LENGTH-1:0]		in59,
	input 			[DATA_LENGTH-1:0]		in60,
	input 			[DATA_LENGTH-1:0]		in61,
	input 			[DATA_LENGTH-1:0]		in62,
	input 			[DATA_LENGTH-1:0]		in63,
	
	input   		[6:0]					sel,
	output	reg		[DATA_LENGTH-1:0]		out
);
	always @(*) begin
		case(sel)
			0: begin
				out <= in0;
			end
			1: begin
				out <= in1;
			end
			2: begin
				out <= in2;
			end
			3: begin
				out <= in3;
			end
			4: begin
				out <= in4;
			end
			5: begin
				out <= in5;
			end
			6: begin
				out <= in6;
			end
			7: begin
				out <= in7;
			end
			8: begin
				out <= in8;
			end
			9: begin
				out <= in9;
			end
			10: begin
				out <= in10;
			end
			11: begin
				out <= in11;
			end
			12: begin
				out <= in12;
			end
			13: begin
				out <= in13;
			end
			14: begin
				out <= in14;
			end
			15: begin
				out <= in15;
			end
			16: begin
				out <= in16;
			end
			17: begin
				out <= in17;
			end
			18: begin
				out <= in18;
			end
			19: begin
				out <= in19;
			end
			20: begin
				out <= in20;
			end
			21: begin
				out <= in21;
			end
			22: begin
				out <= in22;
			end
			23: begin
				out <= in23;
			end
			24: begin
				out <= in24;
			end
			25: begin
				out <= in25;
			end
			26: begin
				out <= in26;
			end
			27: begin
				out <= in27;
			end
			28: begin
				out <= in28;
			end
			29: begin
				out <= in29;
			end
			30: begin
				out <= in30;
			end
			31: begin
				out <= in31;
			end
			32: begin
				out <= in32;
			end
			33: begin
				out <= in33;
			end
			34: begin
				out <= in34;
			end
			35: begin
				out <= in35;
			end
			36: begin
				out <= in36;
			end
			37: begin
				out <= in37;
			end
			38: begin
				out <= in38;
			end
			39: begin
				out <= in39;
			end
			40: begin
				out <= in40;
			end
			41: begin
				out <= in41;
			end
			42: begin
				out <= in42;
			end
			43: begin
				out <= in43;
			end
			44: begin
				out <= in44;
			end
			45: begin
				out <= in45;
			end
			46: begin
				out <= in46;
			end
			47: begin
				out <= in47;
			end
			48: begin
				out <= in48;
			end
			49: begin
				out <= in49;
			end
			50: begin
				out <= in50;
			end
			51: begin
				out <= in51;
			end
			52: begin
				out <= in52;
			end
			53: begin
				out <= in53;
			end
			54: begin
				out <= in54;
			end
			55: begin
				out <= in55;
			end
			56: begin
				out <= in56;
			end
			57: begin
				out <= in57;
			end
			58: begin
				out <= in58;
			end
			59: begin
				out <= in59;
			end
			60: begin
				out <= in60;
			end
			61: begin
				out <= in61;
			end
			62: begin
				out <= in62;
			end
			63: begin
				out <= in63;
			end
		endcase
	end
endmodule
