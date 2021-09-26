module FA(clk, a, b, cin, s, c);
    input clk;
    input a, b, cin;
    output  reg s, c;
    always @(posedge clk) begin
        s <= (a ^ b ^ cin);
        c <= ( a & b ) + ( b & cin ) + ( cin & a );
    end
endmodule