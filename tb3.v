/*
    Assignment   :  2(testbench)
    Problem      :  3
    Assignment   :  5
    Assignment   :  4
    Problem      :  3(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`timescale 1ns / 1ps
`include "bsa.v"

module tb3;
    reg clk,reset,clr;
    reg [7:0] a,b;
    wire [7:0] sum;
    wire cout;

    //creating instance of bit serial adder to test
    bsa bit_serial_adder(.clk(clk),.a(a),.reset(reset),.clr(clr),.sum(sum),.b(b),.cout(cout));

    initial
    begin
        clk = 0;
        $monitor("time=%0d, reset=%b, clr=%b, a=%b, b=%b, sreg_a_content=%b, sreg_b_content=%b, sum=%b, carry_out=%b",
                        $time, reset, clr, a, b, bit_serial_adder.sreg_a.w2, bit_serial_adder.sreg_b.w2, sum, cout);

        a = 15; b = 34; clr = 1;    // setting the sum value to 0
        #10 reset = 1; clr = 0;
        #20 reset = 0;
        #200 clr = 1;

        #20 a = 129; b = 30; clr = 0;
        #20 reset = 1; // reset = 1 => shift registers reset to value of a and b
        #60 reset = 0; // reset = 0 => process to add begins
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