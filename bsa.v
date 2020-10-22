/*
    Assignment   :  2
    Problem      :  3
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
`timescale 1ns / 1ps

// Simple one bit full adder with cin as input carry and cout as output carry
module full_adder(input a, input b, input cin, output sum, output cout);

    wire ab,ac,bc;

    xor sum_generator(sum,a, b,cin);

    and and_instance1(ab,a,b);
    and and_instance2(ac,a,cin);
    and and_instance3(bc,cin,b);

    or or_instance(cout,ab,ac,bc);    // if any of a&b, b&cin or a&cin are true, carry is generated
endmodule

//Simple implementation of D flipflop
module d_ff(input clk, input d, output reg q, input clr);
    always @(posedge clk)
    begin
        if(clr == 1)
            q <= 0;
        else
            q <= d;
    end
endmodule

//Implementation of 8-bit shift register
module shift_register(input clk,input [7:0]a, input reset, input clr,output out);
    wire [7:0] w2,w1;

    //if reset is on, a is copied into the shift register else shift one bit
    assign w1[0] = reset?a[0]:w2[1];
    assign w1[1] = reset?a[1]:w2[2];
    assign w1[2] = reset?a[2]:w2[3];
    assign w1[3] = reset?a[3]:w2[4];
    assign w1[4] = reset?a[4]:w2[5];
    assign w1[5] = reset?a[5]:w2[6];
    assign w1[6] = reset?a[6]:w2[7];
    assign w1[7] = reset?a[7]:a[7];

    //using d flipflop to store the reg values and shift
    d_ff d_ff_i1(.clk(clk), .d(w1[0]),.q(w2[0]),.clr(clr));
    d_ff d_ff_i2(.clk(clk), .d(w1[1]),.q(w2[1]),.clr(clr));
    d_ff d_ff_i3(.clk(clk), .d(w1[2]),.q(w2[2]),.clr(clr));
    d_ff d_ff_i4(.clk(clk), .d(w1[3]),.q(w2[3]),.clr(clr));
    d_ff d_ff_i5(.clk(clk), .d(w1[4]),.q(w2[4]),.clr(clr));
    d_ff d_ff_i6(.clk(clk), .d(w1[5]),.q(w2[5]),.clr(clr));
    d_ff d_ff_i7(.clk(clk), .d(w1[6]),.q(w2[6]),.clr(clr));
    d_ff d_ff_i8(.clk(clk), .d(w1[7]),.q(w2[7]),.clr(clr));

    assign out = w2[0]; // last popped value from the shift_register
endmodule

module bsa(input [7:0]a, input [7:0] b, input clk, output reg [7:0] sum, input clr, input reset, input cout);
    integer index = 0; // used to finally store values to sum
    wire a_bit,b_bit;
    wire prev_carry,present_carry;
    wire sum_bit;

    //shift register instances storing vlaues for a and b
    shift_register sreg_a(.clk(clk),.a(a[7:0]),.clr(clr),.reset(reset),.out(a_bit));
    shift_register sreg_b(.clk(clk),.a(b[7:0]),.clr(clr),.reset(reset),.out(b_bit));
    //full adder instance providing sum of popper bits from a and b
    full_adder full_adder_instance(.a(a_bit),.b(b_bit),.cin(prev_carry),.cout(present_carry),.sum(sum_bit));
    //d flifflop instance used to store and update carry from full_adder
    d_ff d_flipflop_instance(.clk(clk),.q(prev_carry),.d(present_carry),.clr(clr));

    assign cout = present_carry;    //update carry out

    // if command to reset, initialize index to -1
    always @(reset)
    begin
        index = 0;
    end

    always @(posedge clk)
    begin
        if(clr == 1)    // if clr is on, reset sum and index
        begin
            sum <= 0;
            index <= 0;
        end
        else if(index < 8)  //otherwise update the sum output using integer index and sum made available by full_adder
        begin
            if(index >= 0)
            begin
                sum[index] <= sum_bit;
            end
            index <= index + 1;
        end
    end

endmodule
