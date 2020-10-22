/*
    Assignment   :  4
    Problem      :  3(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "seq_gcd.v"

module tb();

    reg [7:0] a, b;
    reg start, clk, rst;
    wire [7:0] gcd;
    wire done;

    control_path inst(a, b, gcd, start, done, clk, rst); //instance od sequential gcd calculator control path with a conencted datapath

    initial begin
        clk = 0;
        $monitor("time=%0d, a=%d, b=%d, gcd=%d, start=%b, done=%b, rst=%b, state=%b",
            $time, a, b, gcd, start, done, rst, inst.state);
        #10 a=24;b=16;start=0;rst=1;
        #10 rst=0;start=1;
        #1000 $stop;
    end

    always
        #10 clk = !clk;

endmodule