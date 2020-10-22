/*
    Assignment   :  5
    Problem      :  1
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
module bit1FA (A,B,P,G);        //1 bit full-adder
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

module cla (A,B,S,Cin,Cout);    //4 bit carry look-ahead adder
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

module DM74LS181(a, b, select, mode, cin, cout, f); //implementation of IC DM74LS181

    input [3:0] a, b, select;       //input output ports
    input mode, cin;
    output reg cout;
    output reg [3:0] f;

    wire carry_in, carry_out;       //actual calue of carry in and carry out
    wire[3:0] not_a, not_b;         // wires storing not of A and not of B
    reg[3:0] operand0, operand1;    //operands to calculate sum of
    wire[3:0] sum_out;              //sum of operand0 and operand1 at any instance
    wire sum_cout;                  //carry out of adder with operands
    wire[3:0] minus_1;              //wire storing -1 in 2s complement

    assign carry_in = !cin;         //assigining values to constant supportive wires
    assign not_a = ~a;
    assign not_b = ~b;
    assign minus_1 = 15;

    cla adder(.A(operand0), .B(operand1), .Cin(carry_in), .Cout(sum_cout), .S(sum_out));    //look-ahead adder instance

    always @ (*) begin              //implemented functions of IC from the datasheet

        if(mode) begin

            if(select == 4'b0000)
                f = not_a;
            else if(select == 4'b0001)
                f = (not_a | not_b);
            else if(select == 4'b0010)
                f = (not_a & b);
            else if(select == 4'b0011)
                f = 0;
            else if(select == 4'b0100)
                f = ~(a & b);
            else if(select == 4'b0101)
                f = not_b;
            else if(select == 4'b0110)
                f = (a ^ b);
            else if(select == 4'b0111)
                f = (a & not_b);
            else if(select == 4'b1000)
                f = (not_a | b);
            else if(select == 4'b1001)
                f = (not_a ^ not_b);
            else if(select == 4'b1010)
                f = b;
            else if(select == 4'b1011)
                f = (a & b);
            else if(select == 4'b1100)
                f = 1;
            else if(select == 4'b1101)
                f = (a | not_b);
            else if(select == 4'b1110)
                f = (a | b);
            else if(select == 4'b1111)
                f = a;

        end
        else begin              //arithmetic functions for mode = 0
                                //used adder instance above and changed input to it to find sum wherever required
            if(select == 4'b0000) begin
                operand0 = a;
                operand1 = 0;
            end
            if(select == 4'b0001) begin
                operand0 = a|b;
                operand1 = 0;
            end
            if(select == 4'b0010) begin
                operand0 = a|not_b;
                operand1 = 0;
            end
            if(select == 4'b0011) begin
                operand0 = minus_1;
                operand1 = 0;
            end
            if(select == 4'b0100) begin
                operand0 = a;
                operand1 = a&not_b;
            end
            if(select == 4'b0101) begin
                operand0 = (a|b);
                operand1 = (a&not_b);
            end
            if(select == 4'b0110) begin
                operand0 = a;
                operand1 = not_b;
            end
            if(select == 4'b0111) begin
                operand0 = (a&b);
                operand1 = minus_1;
            end
            if(select == 4'b1000) begin
                operand0 = a;
                operand1 = (a&b);
            end
            if(select == 4'b1001) begin
                operand0 = a;
                operand1 = b;
            end
            if(select == 4'b1010) begin
                operand0 = (a|not_b);
                operand1 = (a&b);
            end
            if(select == 4'b1011) begin
                operand0 = (a&b);
                operand1 = minus_1;
            end
            if(select == 4'b1100) begin
                operand0 = a;
                operand1 = a;
            end
            if(select == 4'b1101) begin
                operand0 = (a|b);
                operand1 = a;
                f = sum_out;
                cout = !sum_cout;
            end
            if(select == 4'b1110) begin
                operand0 = (a|not_b);
                operand1 = a;
            end
            if(select == 4'b1111) begin
                operand0 = a;
                operand1 = minus_1;
            end

            f = sum_out;
            cout = !sum_cout;           //carry is the negation of actual carry produced

        end

    end

endmodule