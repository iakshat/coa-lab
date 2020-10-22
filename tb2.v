/*
    Assignment   :  4
    Problem      :  2(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "mult_of_3.v"

module tb2();

    reg clk, rst, bit_in;
    wire bit_out;

    mult_of_3 inst(.bit_in(bit_in), .bit_out(bit_out), .clk(clk), .rst(rst)); //instance of multiple of 3 checker, returns 1 if divisible, 0 if not

    initial
    begin
        clk = 0;
        $monitor("time=%0d, rst=%d, bit_in=%b, bit_out=%b",
            $time, rst, bit_in, bit_out);
        #10 rst = 1;bit_in = 0;
        #10 rst = 0;bit_in = 1;
        #10 bit_in = 0;
        #10 bit_in = 1;
        #10 bit_in = 1;
        #10 bit_in = 0;
        #10 bit_in = 1;
        #10 bit_in = 0;
        #10 rst=1;
        $stop;
    end

    always
        #5 clk = !clk;

endmodule