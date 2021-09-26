module MPY(clk, a, b, p);
    input clk;
    input [3:0] a, b;
    output [7:0] p;
    wire [3:0] ab0, ab1, ab2, ab3;
    wire [2:0] carry;
    wire [3:0] s0, s1, s2;

    arrand and0(a, b[0], ab0);
    arrand and1(a, b[1], ab1);
    arrand and2(a, b[2], ab2);
    arrand and3(a, b[3], ab3);

    HA2FA2 HA2FA2_u1(clk, ab1, ab0[3:1], carry[0], s0);
    HA1FA3 HA1FA3_u1(clk, ab2, {carry[0],s0[3:1]}, carry[1], s1);
    HA1FA3 HA1FA3_u2(clk, ab3, {carry[1],s1[3:1]}, carry[2], s2);

    assign p[0] = ab0[0];
    assign p[1] = s0[0];
    assign p[2] = s1[0];
    assign p[6:3] = s2;
    assign p[7] = carry[2];
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

module FA(clk, a, b, cin, s, c);
    input clk;
    input a, b, cin;
    output  reg s, c;
    always @(posedge clk) begin
        s <= (a ^ b ^ cin);
        c <= ( a & b ) + ( b & cin ) + ( cin & a );
    end
endmodule

module HA(clk, a, b, s, c);
    input clk;
    input a, b;
    output  reg s, c;
    always @(posedge clk) begin
        s <=  a ^ b ;
        c <=  a & b ;
    end
endmodule

module HA1FA3(clk, a, b, c, s);
    input clk;
    input [3:0] a, b;
    output c;
    output [3:0] s;
    wire [3:0] carry;

    HA HA1(clk, a[0], b[0], s[0], carry[0]);
    FA FA1(clk, a[1], b[1], carry[0], s[1], carry[1]);
    FA FA2(clk, a[2], b[2], carry[1], s[2], carry[2]);
    FA FA3(clk, a[3], b[3], carry[2], s[3], carry[3]);

    assign c = carry[3];
endmodule

module HA2FA2(clk, a, b, c, s);
    input clk;
    input [3:0] a;
    input [2:0] b;
    output c;
    output [3:0] s;

    wire [3:0] carry;

    HA HA1(clk, a[0], b[0], s[0], carry[0]);
    FA FA1(clk, a[1], b[1], carry[0], s[1], carry[1]);
    FA FA2(clk, a[2], b[2], carry[1], s[2], carry[2]);
    HA HA2(clk, a[3], carry[2], s[3], carry[3]);

    assign c = carry[3];
endmodule