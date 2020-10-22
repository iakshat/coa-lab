/*
    Assignment   :  4
    Problem      :  2
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
module mult_of_3(bit_in, bit_out, clk, rst);

    input bit_in;
    output reg bit_out;
    input clk, rst;

    reg[2:0] state;     //state[2] denotes parity of power of bit, and state[1:0] denotes the present modulo with 3

    always @(rst)
    begin
        state = 3'b000;
    end

    always @(posedge(clk)) //state updation on each input
    begin

        if(bit_in)
        begin                   // if bit_in is 1 modulo will be updated
            if(state == 3'b100) begin
                state = 3'b010;
                bit_out = 0;
            end
            if(state == 3'b101) begin
                state = 3'b000;
                bit_out = 1;
            end
            if(state == 3'b110) begin
                state = 3'b001;
                bit_out = 0;
            end

            if(state == 3'b000) begin
                state = 3'b101;
                bit_out = 0;
            end
            if(state == 3'b001) begin
                state = 3'b110;
                bit_out = 0;
            end
            if(state == 3'b010) begin
                state = 3'b100;
                bit_out = 1;
            end
        end
        else
        begin                   // if bit_in is 0 then no updation of modulo
            if(state[2] == 1)
                state[2] = 0;
            else
                state[2] = 1;
        end
    end

endmodule