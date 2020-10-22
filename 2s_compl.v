/*
    Assignment   :  4
    Problem      :  1
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
module twos_complement(bit_in, bit_out, clk, rst);

    input bit_in;
    output reg bit_out;
    input clk, rst;

    reg state;      //state to keep track ifwe encountered a one till now

    always @(rst) begin
        state = 0;
    end

    always @(posedge(clk)) begin
        if(state == 1'b0) begin //if state is 0 we return the same bit
            bit_out = bit_in;
            if(bit_in)          //update state on encountering 1
                state = 1'b1;
        end
        else begin              // is state is 1 we return the negated bit
            bit_out = !bit_in;
        end
    end

endmodule