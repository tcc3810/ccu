`timescale 1ns/1ps

module RCA_16bit(a,b,cin,sum,cout);

    input [15:0] a,b;
    input cin;
    output [15:0] sum;
    output cout;

	wire  c;
    
	//--- Write your design here ---//
	RCA_8bit FA1(a[7:0] , b[7:0] , cin , sum[7:0] , c);
	RCA_8bit FA2(a[15:8] , b[15:8] , c , sum[15:8] , cout);
	//--- Write your design here ---//

endmodule

module RCA_8bit(a,b,cin,sum,cout);

    input [7:0] a,b;
	input cin;
    output [7:0] sum;
	output cout;
	
	wire [7:0] c;
    
	//--- Write your design here ---//
	//assign {cout , sum} = a + b + cin;
	fulladder bit0(a[0] , b[0] , cin , sum[0] , c[0]);
	fulladder bit1(a[1] , b[1] , c[0] , sum[1] , c[1]);
	fulladder bit2(a[2] , b[2] , c[1] , sum[2] , c[2]);
	fulladder bit3(a[3] , b[3] , c[2] , sum[3] , c[3]);
	fulladder bit4(a[4] , b[4] , c[3] , sum[4] , c[4]);
	fulladder bit5(a[5] , b[5] , c[4] , sum[5] , c[5]);
	fulladder bit6(a[6] , b[6] , c[5] , sum[6] , c[6]);
	fulladder bit7(a[7] , b[7] , c[6] , sum[7] , c[7]);
	//--- Write your design here ---//

	assign cout = c[7];

endmodule

module fulladder(a,b,cin,sum,cout);
	
	input a, b, cin;
	output sum,cout;
	wire x,y,z,q;

    //sum = (a ^ b) ^ cin;
    //cout = ((a & b) | ((a | b) & cin));
	
	xorgate xor1 (a,b,x);
	xorgate xor2(x,cin,sum);
	
	andgate and1(a,b,y);
	andgate and2(z,cin,q);
	orgate or1(a,b,z);
	orgate or2(y,q,cout);

endmodule

module andgate (a,b,out);
	
	input a, b;
	output reg out;

	always @ (*)  begin
		#7 out <= a & b;
	end

endmodule

module orgate (a,b,out);
	
	input a, b;
	output reg out;

	always @ (*)  begin
		#4 out <= a | b;
	end

endmodule

module xorgate (a,b,out);
	
	input a,b;
	output out;
	wire x,y,z;

	andgate and1 (a,~b,x);
	andgate and2 (~a,b,y);
	orgate or1 (x,y,out);

endmodule
