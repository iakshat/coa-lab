/*
    Assignment   :  5
    Problem      :  4(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "csa.v"

module tb();            //test bench to simulate carry save adder to add 9 numbers

    reg [15:0] num0, num1, num2, num3, num4, num5, num6, num7, num8;
    wire [15:0] sum;

    csa_16bit_9nums inst(num0, num1, num2, num3, num4, num5, num6, num7, num8, sum);

    initial begin

        $monitor("num0=%d;num1=%d;num2=%d;num3=%d;num4=%d;num5=%d;num6=%d;num7=%d;num8=%d,sum=%d",
                num0,num1,num2,num3,num4,num5,num6,num7,num8,sum);
        #10 num0=0;num1=1;num2=2;num3=3;num4=4;num5=5;num6=6;num7=7;num8=100;

    end

endmodule