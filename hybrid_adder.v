`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2020 23:35:34
// Design Name: 
// Module Name: hybrid_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//This module calculates the generated,propagted carries and the sum bits
module full_adder(a,b,cin,sum,g,p);
input a,b,cin;
output wire sum,g,p;

assign g = a&b; // generated carry
assign p = a^b; // propagated carry
assign sum = p^cin;

endmodule

//4-bit Binary Carry Look Ahead adder 
module bcla_4bit(a,b,cin,sum,cout);

input [3:0] a,b;
input cin;
output wire [3:0] sum;
output wire cout;
wire [4:0] c,p,g;
assign c[0] = cin;

//computing the generated and propgated carries
full_adder f1(.a(a[0]),.b(b[0]),.cin(c[0]),.g(g[0]),.p(p[0]),.sum(sum[0]));
full_adder f2(.a(a[1]),.b(b[1]),.cin(c[1]),.g(g[1]),.p(p[1]),.sum(sum[1]));
full_adder f3(.a(a[2]),.b(b[2]),.cin(c[2]),.g(g[2]),.p(p[2]),.sum(sum[2]));
full_adder f4(.a(a[3]),.b(b[3]),.cin(c[3]),.g(g[3]),.p(p[3]),.sum(sum[3]));

//computing the final carries
assign c[1] = g[0] | (p[0]&c[0]);
assign c[2] = g[1] | (p[1]&g[0]) | (p[1]&p[0]&c[0]);
assign c[3] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&c[0]);
assign c[4] = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&c[0]);
assign cout = c[4];
 
endmodule

module hybrid_adder(
    a,b,cin,sum,cout
    );
    
    input [7:0] a,b;
    input cin;
    output wire [7:0] sum;
    output wire cout;
    wire carry; //intermediate carry
    bcla_4bit m1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(carry));
    bcla_4bit m2(.a(a[7:4]), .b(b[7:4]), .cin(carry), .sum(sum[7:4]), .cout(cout)); //the carry from the first BLCA unit acts as the carry_in for the 2nd BLCA unit
    
endmodule
