`timescale 1ns / 1ps

module testbench_cont_4bit_adder;

reg [3:0] a, b, c;
wire [3:0] sum;
wire ov;

reg clk = 0;
reg	rst = 0;

/*選擇要驗證cont_4bit_adder、proc_4bit_adder還是stru_4bit_adder*/
add3 DUT(a, b, c, sum, ov);

initial
begin
	clk <= 0;
	rst <= 0;
	a <= 0; 
	b <= 0; 
	c <= 0; 
end


always@(posedge clk or negedge rst)
begin
    if(a <= 15) begin 
		a <= a + 1;
	end 
	if(a == 15) begin
		b <= b + 1;
	end
	if(a == 15 && b == 15) begin
		b <= b + 1;
		c <= c + 1;
	end

end

initial begin
    $monitor("%4dns monitor: a=%d b=%d c=%d sum=%d ov=%d", $stime, a, b, c, sum, ov);
end

always #1 clk = ~clk;
always #1 rst = ~rst;
initial #4095 $finish;/*經過15ns後結束程式*/
endmodule