`include "comb_mult.v"

module tb();

    reg [5:0] a, b;
    wire [11:0] product;

    unsigned_array_mult skajf(.a(a), .b(b), .product(product));

    initial
    begin
        $monitor("a=%d, b=%d, product=%d", a, b, product);
        #10 a = 6'b00001;b = 6'b00111;
        #20 a = 63; b = 63;
        #30 a = 12; b = 24;
        #40 a = 6; b = 23;
        #50 a = 49; b = 44;
        #60 a = 33; b = 2;
        #80 a = 19; b = 19;
        #90 a = 60; b = 6;
    end



endmodule