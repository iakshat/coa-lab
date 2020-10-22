/*
    Assignment   :  5
    Problem      :  3(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "csla.v"

module tb();            //test bench to simulate carry select adder

    reg[15:0] a, b;
    reg cin;
    wire[15:0] sum;
    wire cout;

    csla_16bit inst(a, b, sum, cin, cout);

    initial begin

        cin = 0;
        $monitor("time=%0d, a=%d, b=%d, sum=%d, carry_out=%b",
                $time, a, b, sum, cout);

        #10 a=25;b=32;
        #10 a=64;b=64;
        #10 a=123;b=50;
        #10 a=22;b=234;
        #10 a=13;b=0;
        #10 a=0;b=0;

    end

endmodule