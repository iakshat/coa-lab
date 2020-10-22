/*
    Assignment   :  5
    Assignment   :  4
    Problem      :  2(testbench)
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "16bit_alu.v"

module tb();                 //test bench to simulate 16 bit alu using DM74LS181

    reg[15:0] a, b;
    reg[3:0] select;
    reg mode, cin;
    wire[15:0] f;
    wire cout;

    alu_16bit inst(a, b, select, mode, cin, cout, f);

    initial begin
        $monitor("a=%b, b=%b, select=%b, mode=%b, cin=%b, cout=%b, f=%b",
                a, b, select, mode, cin, cout, f);

        #20 a=12;b=2;select=4'b1101;mode=1;cin=1;
        #20 a=128;b=64;select=4'b0001;mode=0;cin=1;
        #20 a=128;b=64;select=4'b1011;mode=1;cin=1;
        #20 a=128;b=64;select=4'b1001;mode=0;cin=1;
        #20 a=64;b=128;select=4'b1101;mode=0;cin=1;
        #20 a=128;b=64;select=4'b0011;mode=0;cin=1;
        #20 a=12;b=12;select=4'b0110;mode=0;cin=1;
        // cin=1;

		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 0	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 1	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 2	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 3	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 4	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 5	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 6	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 7	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 8	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 9	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 10	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 11	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 12	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 13	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 14	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 15	; mode = 0;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 0	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 1	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 2	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 3	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 4	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 5	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 6	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 7	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 8	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 9	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 10	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 11	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 12	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 13	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 14	; mode = 1;
		// #10
		// a=16'b0001001000110101; b=16'b0000010001110000 ; select = 15	; mode = 1;
		// #10

		// a=1;b=5;select=2;mode=0;cin=0;
		// #10;

    end

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