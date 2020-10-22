`include "test.v"
module tb;
    reg a, b, c;
    wire cout, sum;
    wire xy, y;
    add abc(a, b, c, sum, cout);

    initial
    begin
        $monitor("a: %d, b: %d, sum: %d, cout: %d", a, b, sum, cout);
        #10 a = 0;b = 0;c = 1;
        #15 a = sum;b = cout;
        #20 a = 1;b = 0;c = 1;
        #25 a = sum;b = cout;
        #30 a = 1;b = 1;c = 1;
        #35 a = sum;b = cout;
    end
endmodule