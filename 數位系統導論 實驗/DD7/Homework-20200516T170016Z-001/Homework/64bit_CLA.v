`timescale 1ns/1ps
module CLA_64bit(a,b,cin,sum,cout);
    input [63:0] a,b;
    input cin;
    output [63:0] sum;
    output cout;
    
    //---Write down your design here---//
	wire [63:0] g,p;
	wire [63:0] c;
	wire [15:0] gG4,gP4;
	wire [3:0] gG16,gP16;
	wire [15:0] c4;
	wire [3:0] c16;
	
    //generate g & p
	gp_generator gp_generator1(4'b1111 , b[3:0] , g[3:0] , p[3:0]);
	gp_generator gp_generator2(a[7:4] , b[7:4] , g[7:4] , p[7:4]);
	gp_generator gp_generator3(a[11:8] , b[11:8] , g[11:8] , p[11:8]);
	gp_generator gp_generator4(a[15:12] , b[15:12] , g[15:12] , p[15:12]);
	
	gp_generator gp_generator5(a[19:16] , b[19:16] , g[19:16] , p[19:16]);
	gp_generator gp_generator6(a[23:20] , b[23:20] , g[23:20] , p[23:20]);
	gp_generator gp_generator7(a[27:24] , b[27:24] , g[27:24] , p[27:24]);
	gp_generator gp_generator8(a[31:28] , b[31:28] , g[31:28] , p[31:28]);
	
	gp_generator gp_generator9(a[35:32] , b[35:32] ,g[35:32] , p[35:32]);
	gp_generator gp_generator10(a[39:36] , b[39:36] ,g[39:36] , p[39:36]);
	gp_generator gp_generator11(a[43:40] , b[43:40] ,g[43:40] , p[43:40]);
	gp_generator gp_generator12(a[47:44] , b[47:44] , g[47:44] , p[47:44]);

	gp_generator gp_generator13(a[51:48] ,b[51:48] ,g[51:48] ,p[51:48]);
	gp_generator gp_generator14(a[55:52] ,b[55:52] ,g[55:52] ,p[55:52]);
	gp_generator gp_generator15(a[59:56] ,b[59:56] ,g[59:56] ,p[59:56]);
	gp_generator gp_generator16(a[63:60],b[63:60],g[63:60],p[63:60]);
	
	//generate P & G
	carry_generator GP_generator_c4(g[3:0] , p[3:0] , c4[0] , c[3:0] , gG4[0] , gP4[0] ,);
	carry_generator GP_generator_c8(g[7:4] , p[7:4] , c4[1] , c[7:4] , gG4[1] , gP4[1] ,);
	carry_generator GP_generator_c12(g[11:8] , p[11:8] , c4[2] , c[11:8] , gG4[2] , gP4[2] ,);
	carry_generator GP_generator_c16(g[15:12] , p[15:12] , c4[3] , c[15:12] ,  gG4[3] , gP4[3] ,);
	
	carry_generator GP_generator_c20(g[19:16] , p[19:16] , c4[4] , c[19:16] ,  gG4[4] , gP4[4] ,);
	carry_generator GP_generator_c24(g[23:20] , p[23:20] , c4[5] , c[23:20] ,  gG4[5] , gP4[5] ,);
	carry_generator GP_generator_c28(g[27:24] , p[27:24] , c4[6] , c[27:24] ,  gG4[6] , gP4[6] ,);
	carry_generator GP_generator_c32(g[31:28] , p[31:28] , c4[7] , c[31:28] ,  gG4[7] , gP4[7] ,);
	
	carry_generator GP_generator_c36(g[35:32] , p[35:32] , c4[8] , c[35:32] ,  gG4[8],gP4[8] ,);
	carry_generator GP_generator_c40(g[39:36] , p[39:36] , c4[9] , c[39:36] , gG4[9],gP4[9] ,);
	carry_generator GP_generator_c44(g[43:40] , p[43:40] , c4[10] , c[43:40] , gG4[10],gP4[10] ,);
	carry_generator GP_generator_c48(g[47:44] , p[47:44] , c4[11] , c[47:44] , gG4[11],gP4[11] ,);

	carry_generator GP_generator_c52(g[51:48] , p[51:48] , c4[12] , c[51:48] , gG4[12] , gP4[12] ,);
	carry_generator GP_generator_c56(g[55:52] , p[55:52] , c4[13] , c[55:52] , gG4[13] , gP4[13] ,);
	carry_generator GP_generator_c60(g[59:56] , p[59:56] , c4[14] , c[59:56] ,  gG4[14] , gP4[14] ,);
	carry_generator GP_generator_c64(g[63:60] , p[63:60] , c4[15] , c[63:60] ,  gG4[15] , gP4[15] ,);
	
	//generate carry c16
	carry_generator carry_generator_c0(gG4[3:0] , gP4[3:0] , c16[0] , c4[3:0] , gG16[0] , gP16[0] ,);
	carry_generator carry_generator_c16(gG4[7:4] , gP4[7:4] , c16[1] , c4[7:4] , gG16[1] , gP16[1] ,);
	carry_generator carry_generator_c32(gG4[11:8] , gP4[11:8] , c16[2] , c4[11:8] , gG16[2] , gP16[2] ,);
	carry_generator carry_generator_c48(gG4[15:12] , gP4[15:12] , c16[3] , c4[15:12] , gG16[3] , gP16[3] ,);

	//generate all carrys
	carry_generator carry_generator_c(gG16[3:0] , gP16[3:0] , cin , c16[3:0] , , , cout);

	//generate sum
	sum_geneator generate_sum({a[63:4],4'b1111} , b[63:0] , c[63:0] , sum[63:0]);
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

    input [63:0] a,b;
    input [63:0] c;
    output [63:0] sum;

    //sum = a ^ b ^ c;
    assign sum = a ^ b ^ c;

endmodule

