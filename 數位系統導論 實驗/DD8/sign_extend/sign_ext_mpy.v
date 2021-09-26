`include "FA.v"
`include "HA.v"
module MPY(clk, a, b, product);
    input clk;
    input [3:0] a, b;
    wire [3:0] ab0, ab1, ab2, ab3;
    wire [7:0] add0, add1, add2, add3;
    wire [7:0] ext0, ext1, ext2, ext3;
    wire [7:0] sum0, sum1, sum2, sum3, sum4;
    output [7:0] product;

    arrand and0(a, b[0], ab0);
    arrand and1(a, b[1], ab1);
    arrand and2(a, b[2], ab2);
    arrand and3(a, b[3], ab3);

    assign add0 = {{4{ab0[3]}}, ab0};
    assign add1 = {{3{ab1[3]}}, ab1, 1'b0};
    assign add2 = {{2{ab2[3]}}, ab2, 2'b0};
    assign add3 = {1'b0, ab3, 3'b0};
    assign ext0 = {{4{ab3[0]}}, 4'b0};
    assign ext1 = {{3{ab3[1]}}, 5'b0};
    assign ext2 = {{2{ab3[2]}}, 6'b0};

    adder adder1(clk,add0,add1,sum0);
    adder adder2(clk,sum0,add2,sum1);
    adder adder3(clk,sum1,add3,sum2);
    adder adder4(clk,sum2,ext0,sum3);
    adder adder5(clk,sum3,ext1,sum4);
    adder adder6(clk,sum4,ext2,product);

endmodule

module arrand(a, b, ab);
    input [3:0] a;
    input b;
    output [3:0] ab;

    assign ab[0] = a[0] & b;
    assign ab[1] = a[1] & b;
    assign ab[2] = a[2] & b;
    assign ab[3] = a[3] & b;
endmodule

module adder(clk, a, b, sum);
    input clk;
    input [7:0] a, b;
    output [7:0] sum;
    wire [7:0]c;
    
    HA HA1(clk, a[0], b[0], sum[0], c[0]);
    FA FA1(clk, a[1], b[1], c[0], sum[1], c[1]);
    FA FA2(clk, a[2], b[2], c[1], sum[2], c[2]);
    FA FA3(clk, a[3], b[3], c[2], sum[3], c[3]);
    FA FA4(clk, a[4], b[4], c[3], sum[4], c[4]);
    FA FA5(clk, a[5], b[5], c[4], sum[5], c[5]);
    FA FA6(clk, a[6], b[6], c[5], sum[6], c[6]);
    FA FA7(clk, a[7], b[7], c[6], sum[7], c[7]);                        
endmodule