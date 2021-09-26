module add2(a, b, sum, ov);

	input [3:0] a, b;
	output [3:0] sum;
	output ov;
	
	assign sum = a + b;
	assign ov = 1'b0;
		
endmodule

