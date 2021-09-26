`timescale 1ns / 1ps

module testbench_4bit_adder;

reg [3:0] a, b, c ,d;
wire [3:0] sum;
wire ov;

reg clk = 0;
reg	rst = 0;


adder DUT(a, b, c, d, sum, ov);

initial
begin
	clk <= 0;
	rst <= 0;
	a <= 0; 
	b <= 0; 
	c <= 0; 
	d <= 0;
end


always@(posedge clk or negedge rst)
begin
	
    if(a <= 15) begin 
		a <= a + 1;
	end 
	if(a == 15) begin
		b <= b + 1;
	end
	if(b == 15 && a == 15) begin
		b <= b + 1;
		c <= c + 1;
	end
	d <= {$random} % 16;
end

initial begin
    $monitor("%4dns monitor: a=%d b=%d c=%d d=%d sum=%d ov=%d", $stime, a, b, c, d, sum, ov);
end

always #1 clk = ~clk;
always #1 rst = ~rst;
initial #30 $finish;
endmodule