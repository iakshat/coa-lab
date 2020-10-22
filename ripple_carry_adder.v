`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2020 16:33:25
// Design Name: 
// Module Name: ripple_carry_adder
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

// Takes 3 input bits a,b,cin and produces the corresponding carry and sum
module full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    wire w1,w2,w3;
    xor sum_bit(sum,a,b,cin);
    and m1(w1,a,b);
    and m2(w2,a,cin);
    and m3(w3,cin,b);
    or m4(cout,w1,w2,w3);    // If atleast any two of a,b,cin bits are set then carry bit is set
endmodule

//2-bit adder using two full adders
module two_bit_adder(a,b,cin,sum,cout);

input [1:0] a,b;
input cin;
output wire [1:0] sum; 
output wire cout;
wire carry; // store intermediate carry
full_adder f1(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(carry));
full_adder f2(.a(a[1]),.b(b[1]),.cin(carry),.sum(sum[1]),.cout(cout)); // carry from 1st full adder act as input carry for 2nd full adder

endmodule

//4-bit adder using two 2-bit adders
module four_bit_adder(a,b,cin,sum,cout);

input [3:0] a,b;
input cin;
output wire [3:0] sum;
output wire cout;
wire carry; // store intermediate carry
two_bit_adder f1(.a(a[1:0]),.b(b[1:0]),.cin(cin),.sum(sum[1:0]),.cout(carry));
two_bit_adder f2(.a(a[3:2]),.b(b[3:2]),.cin(carry),.sum(sum[3:2]),.cout(cout));  // carry from 1st 2-bit adder act as input carry for 2nd 2-bit adder

endmodule

module ripple_carry_adder(a,b,cin,sum,cout);

input [7:0] a,b;
input cin;
output wire [7:0] sum;
output wire cout;
wire carry; // store intermediate carry
four_bit_adder f1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.cout(carry));
four_bit_adder f2(.a(a[7:4]),.b(b[7:4]),.cin(carry),.sum(sum[7:4]),.cout(cout)); // carry from 1st 4-bit adder act as input carry for 2nd 4-bit adder


endmodule

