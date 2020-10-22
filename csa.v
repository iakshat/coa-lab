/*
    Assignment   :  5
    Problem      :  4
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
module bit1FA (A,B,P,G);        //1 bit full adder
    input A,B;
    output P,G;
    and o1 (G,A,B);
    xor o2 (P,A,B);
endmodule

module bit4CLA (P,G,Cin,Cout);  //4 bit look-ahead block
    input [3:0] P,G;
    input Cin;
    output [4:1] Cout;
    assign Cout[1]=G[0] | (P[0]&Cin);
	assign Cout[2]=G[1] | (P[1]&G[0]) | (P[1]&P[0]&Cin);
	assign Cout[3]=G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin);
	assign Cout[4]=G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin);
endmodule

module cla4bit_block (A,B,S,Cin,Cout);  //4 bit carry look-ahead adder
    input [3:0] A,B;
    input Cin;
    output [3:0] S;
    wire [4:1] C;
    output Cout;
    wire [3:0] P,G;
    bit1FA one (A[0],B[0],P[0],G[0]);
    bit1FA two (A[1],B[1],P[1],G[1]);
    bit1FA three (A[2],B[2],P[2],G[2]);
    bit1FA four (A[3],B[3],P[3],G[3]);
    bit4CLA box(P,G,Cin,C);
    assign S[0]=P[0]^Cin;
    assign S[1]=P[1]^C[1];
    assign S[2]=P[2]^C[2];
    assign S[3]=P[3]^C[3];
    assign Cout=C[4];

endmodule

module cla(A,B,S,Cin,Cout);         //16 bit carry look-ahead adder
    input [15:0] A,B;
    input Cin;
    output [15:0] S;
    output Cout;
    wire c1,c2,c3;
    cla4bit_block b0 (A[3:0],B[3:0],S[3:0],Cin,c1);
    cla4bit_block b1 (A[7:4],B[7:4],S[7:4],c1,c2);
    cla4bit_block b2 (A[11:8],B[11:8],S[11:8],c2,c3);
    cla4bit_block b3 (A[15:12],B[15:12],S[15:12],c3,Cout);

endmodule

module csa_base(a, b, c, sum, carry);       //1 bit carry save adder block

    input a, b, c;
    output sum, carry;

    assign sum = a^b^c;
    assign carry = a&b | b&c | c&a;

endmodule

module csa(a, b, c, sum, carry);            //carry save adder block for 3 16 bit inputs and 2 16 bit outputs

    input[15:0] a, b, c;
    output[15:0] sum, carry;

    wire garbage;

    assign carry[0] = 0;

    csa_base inst0(a[0], b[0], c[0], sum[0], carry[1]);
    csa_base inst1(a[1], b[1], c[1], sum[1], carry[2]);
    csa_base inst2(a[2], b[2], c[2], sum[2], carry[3]);
    csa_base inst3(a[3], b[3], c[3], sum[3], carry[4]);
    csa_base inst4(a[4], b[4], c[4], sum[4], carry[5]);
    csa_base inst5(a[5], b[5], c[5], sum[5], carry[6]);
    csa_base inst6(a[6], b[6], c[6], sum[6], carry[7]);
    csa_base inst7(a[7], b[7], c[7], sum[7], carry[8]);
    csa_base inst8(a[8], b[8], c[8], sum[8], carry[9]);
    csa_base inst9(a[9], b[9], c[9], sum[9], carry[10]);
    csa_base inst10(a[10], b[10], c[10], sum[10], carry[11]);
    csa_base inst11(a[11], b[11], c[11], sum[11], carry[12]);
    csa_base inst12(a[12], b[12], c[12], sum[12], carry[13]);
    csa_base inst13(a[13], b[13], c[13], sum[13], carry[14]);
    csa_base inst14(a[14], b[14], c[14], sum[14], carry[15]);
    csa_base inst15(a[15], b[15], c[15], sum[15], garbage);

endmodule

module csa_16bit_9nums(num0, num1, num2, num3, num4, num5, num6, num7, num8, sum);  //carry save adder to add 9 16 bit numbers with final step with cla

    input [15:0] num0, num1, num2, num3, num4, num5, num6, num7, num8;
    output[15:0] sum;

    wire[15:0] mids0, mids1, mids2, mids3, mids4, mids5, mids6;
    wire[15:0] midc0, midc1, midc2, midc3, midc4, midc5, midc6;
    wire zero, garbage;

    assign zero = 0;

    csa inst0(num0, num1, num2, mids0, midc0);
    csa inst1(mids0, midc0, num3, mids1, midc1);
    csa inst2(mids1, midc1, num4, mids2, midc2);
    csa inst3(mids2, midc2, num5, mids3, midc3);
    csa inst4(mids3, midc3, num6, mids4, midc4);
    csa inst5(mids4, midc4, num7, mids5, midc5);
    csa inst6(mids5, midc5, num8, mids6, midc6);

    cla inst(mids6, midc6, sum, zero, garbage);

endmodule