module add3(a, b, c, sum, ov);

	input [3:0] a, b, c;
	output [3:0] sum;
	output ov;
	wire s5, s4;

	assign {s5, s4, sum} = a + b + c;
	assign ov = s5 || s4;
			
endmodule

