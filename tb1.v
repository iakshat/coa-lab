/*
    Assignment   :  5
    Problem      :  1(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "74181.v"

module tb();            //test bench to simulate 4 bit alu using DM74LS181

    reg[3:0] a, b, select;
    reg mode, cin;
    wire[3:0] f;
    wire cout;

    DM74LS181 inst(a, b, select, mode, cin, cout, f);

    initial begin
        $monitor("a=%d, b=%d, select=%b, mode=%b, cin=%b, cout=%b, f=%d",
                a, b, select, mode, cin, cout, f);

        #10 a=12;b=2;select=4'b1101;mode=1;cin=1;
        #10 a=9;b=2;select=4'b0001;mode=0;cin=1;
        #10 a=9;b=2;select=4'b1011;mode=1;cin=1;
        #10 a=9;b=2;select=4'b1001;mode=0;cin=1;
        #10 a=2;b=9;select=4'b1101;mode=0;cin=1;
        #10 a=2;b=9;select=4'b0011;mode=0;cin=1;
        #10 a=12;b=2;select=4'b0101;mode=1;cin=1;
        #10 a=12;b=2;select=4'b0110;mode=0;cin=1;

    end

endmodule