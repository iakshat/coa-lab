`include "seq_mult_ls.v"

module tb();

    reg clk, rst, load;
    reg [5:0] a, b;
    wire [11:0] product;

    unsigned_seq_mult_LS inst(clk, rst, load, a, b, product);

    initial
    begin
        clk = 0;
        $monitor("time=%0d, clk=%d, rst=%d, load=%d, a=%d, b=%d, product=%d", $time, clk, rst, load, a, b, product);

        #10 a = 57; b = 32; rst = 1; load = 1;
        #20 rst = 0; load = 0;
        #200 rst = 1;

        #10 $stop;

    end

    always
        #5 clk = !clk;

endmodule