/*
    Assignment   :  4
    Problem      :  1(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "2s_compl.v"

module tb();

    reg clk, in, rst;
    wire out;

    twos_complement inst(.clk(clk), .bit_in(in), .bit_out(out), .rst(rst)); //instance of complement generator

    initial begin
        clk = 0;
        $monitor("time=%0d, rst=%b, in=%b, out=%b",
            $time, rst, in, out);
        #10 rst = 1; in = 0;
        #10 rst = 0; in = 0;
        #10 in = 0;
        #10 in = 0;
        #10 in = 1;
        #10 in = 1;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #10 rst = 1;
    end

    always
        #5 clk = !clk;

endmodule