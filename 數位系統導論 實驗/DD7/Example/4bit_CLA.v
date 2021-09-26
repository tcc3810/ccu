module CLA_4bit(a,b,cin,sum,cout);

    input [3:0] a,b;
    input cin;
    output [3:0] sum;
    output cout;
    
    wire [3:0] g,p,c;

    //generate g & p
    gp_generator gp_geneator1(a[3:0],b[3:0],g[3:0],p[3:0]); 
    
    //generate all carrys 
    carry_generator carry_geneator_c0(g[3:0],p[3:0],cin,c[3:0],cout);

    //generate sum
    sum_geneator geneate_sum(a[3:0],b[3:0],c[3:0],sum[3:0]);    

endmodule

module gp_generator(a,b,g,p);

    input [3:0] a,b;
    output [3:0] g,p;
    
    // g = a x b && p = a + b
    assign g[0] = a[0] & b[0];
    assign p[0] = a[0] | b[0];

    assign g[1] = a[1] & b[1];
    assign p[1] = a[1] | b[1];

    assign g[2] = a[2] & b[2];
    assign p[2] = a[2] | b[2];

    assign g[3] = a[3] & b[3];
    assign p[3] = a[3] | b[3];

endmodule

module carry_generator(g,p,cin,c,cout);

    input [3:0] g,p;
    input cin;
    output [3:0] c;
    output cout;

    //create carrys
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

endmodule

module sum_geneator(a,b,c,sum);

    input [3:0] a,b,c;
    output [3:0] sum;

    //sum = a ^ b ^ c;
    assign sum[0] = a[0] ^ b[0] ^ c[0];
    assign sum[1] = a[1] ^ b[1] ^ c[1];
    assign sum[2] = a[2] ^ b[2] ^ c[2];
    assign sum[3] = a[3] ^ b[3] ^ c[3];

endmodule
