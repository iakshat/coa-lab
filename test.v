module add(input a, input b, input cin, output o, output cout);
    assign cout = (a&b)|(b&cin)|(a&cin);
    assign o = (a^b^cin);
endmodule