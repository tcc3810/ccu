`timescale 1ns / 1ps
module testbench_add2;

reg [3:0] a, b;
wire [3:0] sum;
wire ov;
reg clk;
reg	rst;
reg [3:0] correct_sum;
reg [6:0] test_num;
reg correct_ov;

always #5 clk = ~clk;
always #5 rst = ~rst;

add2 DUT(a, b, sum, ov);

initial
begin
	clk <= 0;
	rst <= 0;
	a <= 0; 
	b <= 0;
	test_num <= 0;
	$dumpfile("add2.vcd");
	$dumpvars;
end

always@(posedge clk or negedge rst)
begin
	if(rst)begin
		if(a <= 15) begin 
			a <= a + 1;
			test_num <= test_num + 1;
		end 
		if(a == 15) begin
			a <= 0;
			b <= b + 1;
		end
	end
	else begin
		{correct_ov, correct_sum} = a + b;
		if({ov, sum} == {correct_ov, correct_sum}) begin
			$display ("Test %d ", test_num);
			$display ("OK!");
			$display ("%d + %d = ?", a, b);
			$display ("your answer: ov = %d, sum = %d", ov, sum);
			$display ("correct answer: ov = %d, sum = %d", ov, sum);
			$display ("\n");
		end
		else begin
			$display ("Test %d ", test_num);
			$display ("/////////////////////");
			$display ("////////Fail!////////");
			$display ("/////////////////////");
			$display ("%d + %d = ?", a, b);
			$display ("your answer: ov = %d, sum = %d", ov, sum);
			$display ("correct answer: ov = %d, sum = %d", correct_ov, correct_sum);
			$display ("\n");
		end
	end
end
initial #1005 $finish;
endmodule



