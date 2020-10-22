module add(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;

    assign cout = (a&b)|(b&cin)|(a&cin);
    assign sum = (a^b^cin);
endmodule

module unsigned_array_mult(a, b, product);

    input [5:0] a, b;
    output [11:0] product;

    wire garbage, zero;
    assign zero = 0;

    wire a0b0, a0b1, a0b2, a0b3, a0b4, a0b5, a1b0, a1b1, a1b2, a1b3, a1b4, a1b5, a2b0, a2b1, a2b2, a2b3, a2b4, a2b5, a3b0, a3b1, a3b2, a3b3, a3b4, a3b5, a4b0, a4b1, a4b2, a4b3, a4b4, a4b5, a5b0, a5b1, a5b2, a5b3, a5b4, a5b5;
    assign a0b0 = a[0]&b[0];
    assign a0b1 = a[0]&b[1];
    assign a0b2 = a[0]&b[2];
    assign a0b3 = a[0]&b[3];
    assign a0b4 = a[0]&b[4];
    assign a0b5 = a[0]&b[5];
    assign a1b0 = a[1]&b[0];
    assign a1b1 = a[1]&b[1];
    assign a1b2 = a[1]&b[2];
    assign a1b3 = a[1]&b[3];
    assign a1b4 = a[1]&b[4];
    assign a1b5 = a[1]&b[5];
    assign a2b0 = a[2]&b[0];
    assign a2b1 = a[2]&b[1];
    assign a2b2 = a[2]&b[2];
    assign a2b3 = a[2]&b[3];
    assign a2b4 = a[2]&b[4];
    assign a2b5 = a[2]&b[5];
    assign a3b0 = a[3]&b[0];
    assign a3b1 = a[3]&b[1];
    assign a3b2 = a[3]&b[2];
    assign a3b3 = a[3]&b[3];
    assign a3b4 = a[3]&b[4];
    assign a3b5 = a[3]&b[5];
    assign a4b0 = a[4]&b[0];
    assign a4b1 = a[4]&b[1];
    assign a4b2 = a[4]&b[2];
    assign a4b3 = a[4]&b[3];
    assign a4b4 = a[4]&b[4];
    assign a4b5 = a[4]&b[5];
    assign a5b0 = a[5]&b[0];
    assign a5b1 = a[5]&b[1];
    assign a5b2 = a[5]&b[2];
    assign a5b3 = a[5]&b[3];
    assign a5b4 = a[5]&b[4];
    assign a5b5 = a[5]&b[5];


    wire[5:0] c0, s0, c1, s1, c2, s2, c3, s3, c4, s4;

    //layer 1
    add inst01(.a(a1b0), .b(a0b1), .cin(zero), .sum(s0[0]), .cout(c0[0]));
    add inst02(.a(a2b0), .b(a1b1), .cin(c0[0]), .sum(s0[1]), .cout(c0[1]));
    add inst03(.a(a3b0), .b(a2b1), .cin(c0[1]), .sum(s0[2]), .cout(c0[2]));
    add inst04(.a(a4b0), .b(a3b1), .cin(c0[2]), .sum(s0[3]), .cout(c0[3]));
    add inst05(.a(a5b0), .b(a4b1), .cin(c0[3]), .sum(s0[4]), .cout(c0[4]));
    add inst06(.a(zero), .b(a5b1), .cin(c0[4]), .sum(s0[5]), .cout(c0[5]));

    //layer 2
    add inst11(.a(s0[1]), .b(a0b2), .cin(zero), .sum(s1[0]), .cout(c1[0]));
    add inst12(.a(s0[2]), .b(a1b2), .cin(c1[0]), .sum(s1[1]), .cout(c1[1]));
    add inst13(.a(s0[3]), .b(a2b2), .cin(c1[1]), .sum(s1[2]), .cout(c1[2]));
    add inst14(.a(s0[4]), .b(a3b2), .cin(c1[2]), .sum(s1[3]), .cout(c1[3]));
    add inst15(.a(s0[5]), .b(a4b2), .cin(c1[3]), .sum(s1[4]), .cout(c1[4]));
    add inst16(.a(a5b2), .b(c0[5]), .cin(c1[4]), .sum(s1[5]), .cout(c1[5]));

    //layer 3
    add inst21(.a(s1[1]), .b(a0b3), .cin(zero), .sum(s2[0]), .cout(c2[0]));
    add inst22(.a(s1[2]), .b(a1b3), .cin(c2[0]), .sum(s2[1]), .cout(c2[1]));
    add inst23(.a(s1[3]), .b(a2b3), .cin(c2[1]), .sum(s2[2]), .cout(c2[2]));
    add inst24(.a(s1[4]), .b(a3b3), .cin(c2[2]), .sum(s2[3]), .cout(c2[3]));
    add inst25(.a(s1[5]), .b(a4b3), .cin(c2[3]), .sum(s2[4]), .cout(c2[4]));
    add inst26(.a(a5b3), .b(c1[5]), .cin(c2[4]), .sum(s2[5]), .cout(c2[5]));

    //layer 4
    add inst31(.a(s2[1]), .b(a0b4), .cin(zero), .sum(s3[0]), .cout(c3[0]));
    add inst32(.a(s2[2]), .b(a1b4), .cin(c3[0]), .sum(s3[1]), .cout(c3[1]));
    add inst33(.a(s2[3]), .b(a2b4), .cin(c3[1]), .sum(s3[2]), .cout(c3[2]));
    add inst34(.a(s2[4]), .b(a3b4), .cin(c3[2]), .sum(s3[3]), .cout(c3[3]));
    add inst35(.a(s2[5]), .b(a4b4), .cin(c3[3]), .sum(s3[4]), .cout(c3[4]));
    add inst36(.a(a5b4), .b(c2[5]), .cin(c3[4]), .sum(s3[5]), .cout(c3[5]));

    //layer 5
    add inst41(.a(s3[1]), .b(a0b5), .cin(zero), .sum(s4[0]), .cout(c4[0]));
    add inst42(.a(s3[2]), .b(a1b5), .cin(c4[0]), .sum(s4[1]), .cout(c4[1]));
    add inst43(.a(s3[3]), .b(a2b5), .cin(c4[1]), .sum(s4[2]), .cout(c4[2]));
    add inst44(.a(s3[4]), .b(a3b5), .cin(c4[2]), .sum(s4[3]), .cout(c4[3]));
    add inst45(.a(s3[5]), .b(a4b5), .cin(c4[3]), .sum(s4[4]), .cout(c4[4]));
    add inst46(.a(a5b5), .b(c3[5]), .cin(c4[4]), .sum(s4[5]), .cout(c4[5]));

    assign product[0] = a0b0;
    assign product[1] = s0[0];
    assign product[2] = s1[0];
    assign product[3] = s2[0];
    assign product[4] = s3[0];
    assign product[5] = s4[0];
    assign product[6] = s4[1];
    assign product[7] = s4[2];
    assign product[8] = s4[3];
    assign product[9] = s4[4];
    assign product[10] = s4[5];
    assign product[11] = c4[5];


endmodule