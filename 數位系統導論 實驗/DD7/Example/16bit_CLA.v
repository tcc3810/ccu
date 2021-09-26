module CLA_16bit(a,b,cin,sum,cout);

    input [15:0] a,b;
    input cin;
    output [15:0] sum;
    output cout;

	//---Write down your design here---//

	wire [15:0] g,p;
	wire [15:0] c;
	wire [3:0] gG,gP;
	wire [3:0] c4_c8_c12;
	
    //generate g & p
	gp_generator gp_generator1(a[3:0] ,b[3:0] ,g[3:0] ,p[3:0]);
	gp_generator gp_generator2(a[7:4] ,b[7:4] ,g[7:4] ,p[7:4]);
	gp_generator gp_generator3(a[11:8] ,b[11:8] ,g[11:8] ,p[11:8]);
	gp_generator gp_generator4(a[15:12],b[15:12],g[15:12],p[15:12]);

	//generate carry c0,c4,c8,c12
	carry_generator carry_generator_c0(g[3:0] ,p[3:0] ,c4_c8_c12[0],c[3:0] ,gG[0],gP[0],);
	carry_generator carry_generator_c4(g[7:4] ,p[7:4] ,c4_c8_c12[1],c[7:4] ,gG[1],gP[1],);
	carry_generator carry_generator_c8(g[11:8] ,p[11:8] ,c4_c8_c12[2],c[11:8] ,gG[2],gP[2],);
	carry_generator carry_generator_c12(g[15:12],p[15:12],c4_c8_c12[3],c[15:12],gG[3],gP[3],);

	//generate all carrys
	carry_generator carry_generator_c(gG[3:0],gP[3:0],cin,c4_c8_c12[3:0],,,cout);

	//generate sum
	sum_geneator generate_sum(a[15:0], b[15:0], c[15:0], sum[15:0]);
	//---------------------------------//

endmodule

module gp_generator(a,b,g,p);

    input [3:0] a,b;
    output [3:0] g,p;
    
    // g = a x b && p = a + b
    assign g = a & b;
    assign p = a | b;

endmodule

module carry_generator(g,p,cin,c,gG,gP,cout);

    input [3:0] g,p;
    input cin;
    output gG,gP;
    output [3:0] c;
    output cout;

    //create gG and gP
    assign gG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	assign gP = p[3] & p[2] & p[1] & p[0];
	
    assign c[0] = cin;
    //create carrys
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

    //cout
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

endmodule

module sum_geneator(a,b,c,sum);

    input [15:0] a,b;
    input [15:0] c;
    output [15:0] sum;

    //sum = a ^ b ^ c;
    assign sum = a ^ b ^ c;

endmodule
