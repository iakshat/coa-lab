/*
    Assignment   :  5
    Problem      :  3
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
module full_adder(a, b, sum, cin, cout);    //1 bit full adder

    input a, b;
    input cin;
    output sum;
    output cout;

    assign sum = a^b^cin;
    assign cout = a&b | b&cin | cin&a;

endmodule

module adder_row(a, b, sum, cin, cout);     //row of 4 full adders

    input[3:0] a, b;
    input cin;
    output[3:0] sum;
    output cout;

    wire carry[2:0];

    full_adder adder0(a[0], b[0], sum[0], cin, carry[0]);
    full_adder adder1(a[1], b[1], sum[1], carry[0], carry[1]);
    full_adder adder2(a[2], b[2], sum[2], carry[1], carry[2]);
    full_adder adder3(a[3], b[3], sum[3], carry[2], cout);


endmodule

module mux(in0, in1, select, out);          //mux to select output wrt to input carry

    input in0, in1;
    input select;
    output out;

    assign out = select ? in1 : in0;

endmodule

module csla(a, b, sum, cin, cout);          //4 bit carry select adder

    input[3:0] a, b;
    input cin;
    output[3:0] sum;
    output cout;

    wire zero, one, carry0, carry1;
    wire[3:0] sum0, sum1;

    assign zero = 0;
    assign one = 1;

    adder_row row0(a, b, sum0, zero, carry0);   //adders assuming carry to be 0
    adder_row row1(a, b, sum1, one, carry1);    //adders assuming carry to be 1

    mux m0(sum0[0], sum1[0], cin, sum[0]);
    mux m1(sum0[1], sum1[1], cin, sum[1]);
    mux m2(sum0[2], sum1[2], cin, sum[2]);
    mux m3(sum0[3], sum1[3], cin, sum[3]);
    mux m4(carry0, carry1, cin, cout);

endmodule

module csla_16bit(a, b, sum, cin, cout);        //concatenating 4 carry select adder to get 16 bit csa

    input[15:0] a, b;
    input cin;
    output[15:0] sum;
    output cout;

    wire carry[2:0];

    csla adder0(a[3:0], b[3:0], sum[3:0], cin, carry[0]);
    csla adder1(a[7:4], b[7:4], sum[7:4], carry[0], carry[1]);
    csla adder2(a[11:8], b[11:8], sum[11:8], carry[1], carry[2]);
    csla adder3(a[15:12], b[15:12], sum[15:12], carry[2], cout);

endmodule