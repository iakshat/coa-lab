/*
    Assignment   :  5
    Problem      :  2
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`include "74181.v"

module alu_16bit(a, b, select, mode, cin, cout, f);     //16 bit alu by concatenating 4, 4 bit alu blocks

    input[15:0] a, b;
    input[3:0] select;
    input mode, cin;
    output cout;
    output[15:0] f;

    wire[2:0] carry;            //to inter connect the alu blocks

    DM74LS181 int0(a[3:0], b[3:0], select, mode, cin, carry[0], f[3:0]);
    DM74LS181 int1(a[7:4], b[7:4], select, mode, carry[0], carry[1], f[7:4]);
    DM74LS181 int2(a[11:8], b[11:8], select, mode, carry[1], carry[2], f[11:8]);
    DM74LS181 int3(a[15:12], b[15:12], select, mode, carry[2], cout, f[15:12]);

endmodule