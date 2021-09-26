module add4(a, b, c, d, sum, ov);

	input [3:0] a, b, c, d;
	output reg [3:0] sum;
	output reg ov;
	output reg s1,s0;
	
	always @(a or b or c or d)begin
		
		case(a)
			4'b1000: sum <= 4'b0011;		//a=8
			4'b1001: sum <= 4'b0011;		//a=9
			default: {s1, s0, sum} = a + b + c + d;
		endcase
		
		ov <= s1|s0;
	end
endmodule


