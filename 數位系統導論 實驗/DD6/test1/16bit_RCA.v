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
	
	//wire [7:0] c;
    
	//--- Write your design here ---//
	assign {cout , sum} = a + b + cin;
	//--- Write your design here ---//

	//assign cout = c[7];

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
