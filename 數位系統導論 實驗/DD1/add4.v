module adder(a, b, c, d, sum, ov);

	input [3:0] a, b, c, d;
	output [3:0] sum;
	output ov;
	wire s5, s4;

	assign {s5, s4, sum} = a + b + c + d;
	assign ov = s5 || s4;
			
endmodule