/*
    Assignment   :  4
    Problem      :  3
    Semester     :  Autumn 2020
    Group        :  G9
    Members      :  Akshat Shukla(18CS10002)
                    Animesh Barua(18CS10003)
*/
module subtractor(a, b, diff);      //returns difference (a-b) in 2s complement form in output diff (simple subtractor)

    input [8:0] a, b;
    output [8:0] diff;

    wire [8:0] _a, _b;

    assign _a = a;
    assign _b = (b^9'b111111111)+1; //compute 2s complement of b

    assign diff = (_a + _b); // may use adder from other assignments here

endmodule

module continous_subtractor(a, b, a_out, done, clk, rst);   //subtracts b from a continously until it is positive and notifies of done by wire done

    input [7:0] a, b;
    input clk, rst;
    output reg done;            //denotes if process of taking till positive difference is completed
    output reg [7:0] a_out;     // final value of a after continous subtraction

    wire[8:0] present_diff;     // contains value of _a-_b always (may be negative)
    reg[8:0] _a, _b;
    reg state;

    always @(rst) begin         // on reset
        _a = a; _b = b;
        done = 0;
    end

    subtractor inst(_a, _b, present_diff);     //present = _a-_b always

    always @(posedge(clk)) begin

        if(done == 0) begin         // if the process is not completed yet
            if(present_diff[8] || present_diff == 0) begin      //check if present_diff > 0
                a_out = _a;         //if difference if negative or 0 dont update _a further and term process done
                done = 1;
            end
            else
                _a = present_diff;  //if difference is positive, put _a = _a-_b
        end

    end

endmodule

module data_path(a, b, load, start_process, process_done, gcd, clk);    //datapath managing all data transctions till output

    input [7:0] a, b;
    input load, start_process, clk;     //start_process should be 1 to begin processing
    output reg process_done;            //denotes if the processing is completed ie we've got the gcd
    output reg [7:0] gcd;               //contains value of gcd after processing

    reg[7:0] _a, _b, temp;              //registers to hold values of input a and b
    wire [7:0] reduced_a;               // get changed value of a after continous subtractions
    wire reducing_done;                 //wire to check if the processing by continous subtractor is complete
    reg state, sub_rst;                 //sub_rst resets the continous subtractor to load new value of a and b and starts processing

    always @(load) begin                // on reset
        _a = a;
        _b = b;
        gcd = 0;
        process_done = 0;
        sub_rst = 1;
    end

    continous_subtractor inst(_a, _b, reduced_a, reducing_done, clk, sub_rst);      //instance of continous subractor

    always @(posedge(clk)) begin

        if(sub_rst) begin               //if continous subtractor if in reset state, get it start working
            sub_rst = 0;
        end
        if(!process_done) begin         //if process is not done yet
            if(start_process) begin     //if we are allowed to start process
                if(reducing_done) begin // if output from continous subtractor has been recieved
                    _a = reduced_a;     //update a with the new value obtained after taking difference
                    if(reduced_a == _b) begin   //if a==b ie we've got the gcd
                        gcd = _a;       //update gcd and render process complete
                        process_done = 1;
                    end
                    else begin          //otherwise swap a and b and reset continous subtractor to load the new swapped values
                        // temp = _a;
                        // _a = _b;
                        // _b = temp;
                        _a <= _b;
                        _b <= _a;
                        sub_rst = 1;
                    end
                end
            end
        end

    end

endmodule

module control_path(a, b, gcd, start, done, clk, rst);      //control path also combines the data path together

    input [7:0] a, b;
    input start, rst, clk;
    output reg [7:0] gcd;           //final value of gcd
    output reg done;                //output to denote of processing is over

    reg [1:0] state;                //state to keep tract of process(DFA states)
    reg alpha, beta;                //alpha to reset the data path beta to start processing with datapath
    wire check_done;                //check if datapath has completed processing
    wire [7:0] data_output;         //copied output of datapath(just to combine the parts)

    always @(rst) begin             //on reset
        done = 0;
        state = 0;
    end

    data_path inst(a, b, alpha, beta, check_done, data_output, clk);        //instanec of datapath

    always @(posedge(clk)) begin

        if(state == 2'b00) begin            //start state, if start is 1 goto next state
            if(start == 1)
                state = 2'b01;
        end

        else if(state == 2'b01) begin       // reset the datapath and move to next state
            state = 2'b11;
            alpha = 1;

        end

        else if(state == 2'b11) begin       //start processing in datapath and wait for it to be done
            alpha = 0;
            beta = 1;
            if(check_done)
                state = 2'b10;
        end

        else if(state == 2'b10) begin      //if processing by datapath is done, move to initial state and update the output
            done = 1;
            gcd = data_output;
            alpha = 0;
            beta = 0;
            state = 2'b00;
        end

    end

endmodule