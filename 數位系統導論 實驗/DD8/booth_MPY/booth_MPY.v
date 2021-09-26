`include "FA.v"
`include "HA.v"
module MPY(clk, a, b, p);
    input clk;
    input [3:0] a, b;
    output [7:0] p;
    wire [4:0] add0, add1, add2, add3;
    wire [7:0] add0_ext;
    wire [6:0] add1_ext;
    wire [5:0] add2_ext;

    wire [6:0] s0;
    wire [5:0] s1;
    wire [4:0] s2;
    booth_add booth1(a, {b[0],1'b0}, add0);
    booth_add booth2(a, b[1:0], add1);
    booth_add booth3(a, b[2:1], add2);
    booth_add booth4(a, b[3:2], add3);

    assign add0_ext = {{3{add0[4]}},add0};
    assign add1_ext = {{2{add1[4]}},add1};
    assign add2_ext = {add2[4],add2};

    HA1FA6 HA1FA6_u1(clk, add0_ext[7:1], add1_ext, s0);
    HA1FA5 HA1FA5_u1(clk, s0[6:1], add2_ext, s1);
    HA1FA4 HA1FA4_u1(clk, s1[5:1], add3, s2);

    assign p[0] = add0_ext[0];
    assign p[1] = s0[0];
    assign p[2] = s1[0];
    assign p[7:3] = s2;
endmodule

module booth_add(a, b, ab);
    input [3:0] a;
    input [1:0] b;
    wire signed [4:0] a_ext;
    output [4:0] ab;

    assign a_ext = {a[3],a};
    assign ab = (b==2'b01) ? a_ext:
                (b==2'b10) ? -a_ext:
                             5'b0;                                
endmodule

module HA1FA6(clk, a, b, s);
    input clk;
    input [6:0] a;
    input [6:0] b;
    output [6:0] s;

    wire [6:0] carry;
    wire cout;
    HA HA1(clk,a[0],b[0],s[0],carry[0]);
    FA FA1(clk,a[1],b[1],carry[0],s[1],carry[1]);
    FA FA2(clk,a[2],b[2],carry[1],s[2],carry[2]);
    FA FA3(clk,a[3],b[3],carry[2],s[3],carry[3]);
    FA FA4(clk,a[4],b[4],carry[3],s[4],carry[4]);
    FA FA5(clk,a[5],b[5],carry[4],s[5],carry[5]);
    FA FA6(clk,a[6],b[6],carry[5],s[6],carry[6]);

    assign cout = carry[6];
endmodule

module HA1FA5(clk, a, b, s);
    input clk;
    input [5:0] a;
    input [5:0] b;
    output [5:0] s;

    wire [5:0] carry;
    wire cout;
    HA HA1(clk,a[0],b[0],s[0],carry[0]);
    FA FA1(clk,a[1],b[1],carry[0],s[1],carry[1]);
    FA FA2(clk,a[2],b[2],carry[1],s[2],carry[2]);
    FA FA3(clk,a[3],b[3],carry[2],s[3],carry[3]);
    FA FA4(clk,a[4],b[4],carry[3],s[4],carry[4]);
    FA FA5(clk,a[5],b[5],carry[4],s[5],carry[5]);

    assign cout = carry[5];
endmodule

module HA1FA4(clk, a, b, s);
    input clk;
    input [4:0] a;
    input [4:0] b;
    output [4:0] s;

    wire [4:0] carry;
    wire cout;
    HA HA1(clk,a[0],b[0],s[0],carry[0]);
    FA FA1(clk,a[1],b[1],carry[0],s[1],carry[1]);
    FA FA2(clk,a[2],b[2],carry[1],s[2],carry[2]);
    FA FA3(clk,a[3],b[3],carry[2],s[3],carry[3]);
    FA FA4(clk,a[4],b[4],carry[3],s[4],carry[4]);

    assign cout = carry[4];
endmodule