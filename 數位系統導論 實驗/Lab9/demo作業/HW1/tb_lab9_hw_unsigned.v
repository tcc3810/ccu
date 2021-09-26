`timescale 1ns/1ps
`include "lab9_hw.v" //這裡要記得改成要測試.v檔

//`define SEED 120
module tb_lab9();


reg [7:0]	in_a;
reg [7:0]	in_b;
reg 		CLK;
reg			reset;

wire [15:0]	out;
wire 		out_valid;
reg [5:0]	count;
reg	[15:0]	correct_ans;
reg 		error;
//integer seed;

reg [7:0]	temp_a;
reg [7:0]	temp_b;

lab9_hw m1(CLK, reset, in_a, in_b, out, out_valid);

initial begin

	$dumpfile("lab9_hw_unsigned.vcd");  // gtkwave
	$dumpvars;
	CLK = 1'b0;
	#20 reset = 1;
		temp_a = 8'd3;
		temp_b = 8'd9;
	#20 reset = 0;


	#700 reset = 1;
		temp_a = 8'd25;
		temp_b = 8'd0;
	#20 reset = 0;


	#700 reset = 1;
		temp_a = 8'd100;
		temp_b = 8'd14;
	#20 reset = 0;

	#700 reset = 1;
		temp_a = 8'd123;
		temp_b = 8'd12;
	#20 reset = 0;

	#700 reset = 1;
		temp_a = 8'd45;
		temp_b = 8'd69;
	#20 reset = 0;


	#20 reset = 0;
	#700 $finish;


end

always #10 CLK = ~CLK;

	always @(posedge CLK or posedge reset)
	begin
		if(reset)
		begin
			count <= 0;
			in_a <= temp_a;
			in_b <= temp_b;
			correct_ans <= 0;
			error <= 0;
		end

		else
		begin
			correct_ans <= in_a * in_b;
			count <= count +1;

			if(out_valid==1)
				if(out != correct_ans)
				begin
					error <=1;
					$display ();
					$display ("//////////");
					$display ("// Fail //");
					$display ("//////////");
					$display ("doing %d * %d ...",temp_a, temp_b);
					$display ("your answer is %d, but correct answer is %d\n",
					out, correct_ans);
					$display ();
				end
				else
				begin
					error <= 0;
					$display ();
					$display ("////////////////");
					$display ("// Successful //");
					$display ("////////////////");
					$display ("doing %d * %d ...",temp_a, temp_b);
					$display ("your answer is %d,  correct answer is %d\n",
					out, correct_ans);
					$display ();
				end
		end
	end

endmodule
