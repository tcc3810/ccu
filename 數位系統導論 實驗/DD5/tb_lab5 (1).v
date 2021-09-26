`timescale 1ns/1ps
`include "lab5.v"

module tb_lab5;
	reg clk;
	reg rst;
	reg clk_2hz;				
	reg [20:0] cnt_2hz;		//1KHz counter
	reg [2:0] cnt;
	wire [6:0] seg_data;
	wire [3:0] birth_num;

lab5_birth lab5(cnt, birth_num, seg_data);

	always #5 clk = ~clk;

always@ (posedge clk or negedge rst) begin
	if (~rst) begin
		cnt_2hz <= 21'b0;
		clk_2hz <= 1'b0;
	end
	else begin
		if (cnt_2hz >= 12499) begin
			cnt_2hz <= 21'b0;
			clk_2hz <= ~clk_2hz;
		end
		else begin
			cnt_2hz <= cnt_2hz + 1;
			clk_2hz <= clk_2hz;
		end
	end
end

always@ (posedge clk_2hz or negedge rst) begin
	if (~rst)
		cnt <= 3'b0;
	else 
		cnt <= cnt + 3'b1;
end

	always @ (posedge clk)
	begin
		#250000	$display ($time, "  cnt = %d, ,birth = %d, output = %b", cnt, birth_num, seg_data); //5個單位時間後顯示敘述
	end	

	initial begin	//僅執行一次
		$dumpfile("lab5.fsdb");  //產生波形檔
		$dumpvars; //產生波形檔
		clk = 0;
		rst = 0;
		@(posedge clk) rst = 1;

		#5000000 $finish; //模擬於160ns結束
	end
endmodule