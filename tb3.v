/*
    Assignment   :  2(testbench)
    Problem      :  3
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
    end

    always
        #10 clk = !clk;

endmodule