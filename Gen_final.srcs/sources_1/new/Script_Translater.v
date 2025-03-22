
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/03 10:22:41
// Design Name: 
// Module Name: Script_Translater
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "parameters.v"

module Script_Translater(
    input [7:0] feedback_signal,
    input in_ready,
    input clock,
    input [7:0] i_num,
    input [2:0] i_sign,
    input [1:0] func,
    input [2:0] op,
    input unlock,
    input rst,
    output reg this_line_is_over,//set(1) if one line of script is over, reset(0) otherwise, Atttention, when this is 1, you can move to the next line.
    output reg [7:0] out,
    output [7:0] next,//the next line of script that should be executed
    output t,
    output [7:0] wt
    );
    reg [7:0] next_line = 8'b00000000;
    reg [2:0] count = 3'b000;//a counter for steps in a line of script
    reg[7:0] waitcnt = 8'b00000000;
    reg[2:0] count2=3'b000;
    reg times = 1'b1;
    reg [5:0] random_target=6'b000001;
    assign next = next_line;
    assign t = times;
    assign wt = waitcnt;
    always @(posedge clock) begin
    if(rst)begin
        next_line <= 8'b00000000;
        count <= 3'b000;//a counter for steps in a line of script
        waitcnt <= 8'b00000000;
       count2<=3'b000;
       times <= 1'b1;
      random_target<=6'b000001;
    end
    else begin
//    out <= `START;
    if(random_target<6'b000110)random_target<=random_target+1;
    else random_target<=6'b000001;
    if(unlock|times) begin
    
    if(op == 3'b100) begin//start and end
    if(func == 2'b01) begin
    times <= 1'b0;
    out <= `START;
    next_line <= 8'b00000001;
    this_line_is_over <= 1'b1;
    end
    else if(func == 2'b10) begin
    out <= `END;
    next_line <= 8'b00000001;
    this_line_is_over <= 1'b1;
    end
    end
    if(op == 3'b001) begin
    if(func == 2'b00) begin//get action
         if(feedback_signal[3])begin
            if(count2 == 3'b000) begin
                 this_line_is_over <= 1'b0;
                 out[7:2] <= 5'b10100;
                 out[1:0] <= 2'b11;
                 count2 <= count2 + 1;//set target
            end
            else if(count2 == 3'b001) begin
                  out <= 8'b01000010;//throw directily
                  count2 <= 3'b000;
            end
         end
         else begin     
            if(count == 3'b000) begin
             this_line_is_over <= 1'b0;
             out[7:2] <= i_num[5:0];
             out[1:0] <= 2'b11;
             count <= count + 1;//set target
             end
             else if(count == 3'b001) begin
             out <= 8'b00100010;
             count <= count + 1;//move to target
             end
             else if(count == 3'b010) begin
             if(feedback_signal[7:6] == 2'b00&&feedback_signal[2:0] == 3'b101) begin
             out <= 8'b00000110;
             count <= 3'b000;
             next_line <= 8'b00000001;
             this_line_is_over <= 1'b1;
             end
             end
        end
    end
    else if(func == 2'b01) begin//put action
        if(feedback_signal[3])begin
            if(count == 3'b000) begin
                this_line_is_over <= 1'b0;
                out[7:2] <= i_num[5:0];
                out[1:0] <= 2'b11;
                count <= count + 1;//set target
            end
            else if(count == 3'b001) begin
                out <= 8'b00100010;
                count <= count + 1;//move to target
            end
            else if(count == 3'b010) begin
                if(feedback_signal[7:6] == 2'b00&&feedback_signal[2:0] == 3'b101) begin
                    out <= 8'b00001010;
                    count <= 3'b000;
                    next_line <= 8'b00000001;
                    this_line_is_over <= 1'b1;
                end
            end
        end
        else begin
            if(count2 == 3'b000) begin
                        this_line_is_over <= 1'b0;
                        out[7:2] <= random_target;
                        out[1:0] <= 2'b11;
                        count2 <= count2 + 1;//set target
                    end
                    else if(count2 == 3'b001) begin
                        out <= 8'b00100010;
                        count2 <= count2 + 1;//move to target
                    end
                    else if(count2 == 3'b010) begin
                        if(feedback_signal[7:6] == 2'b00&&feedback_signal[2:0] == 3'b101) begin
                            out <= 8'b00000110;
                            count2 <= 3'b000;
                        end
                    end
        end
    end
    if(func == 2'b10) begin//interact action
    if(count == 3'b000) begin
    this_line_is_over <= 1'b0;
    out[7:2] <= i_num[5:0];
    out[1:0] <= 2'b11;
    count <= count + 1;//set target
    end
    else if(count == 3'b001) begin
    out <= 8'b00100010;
    count <= count + 1;//move to target
    end
    else if(count == 3'b010) begin
    if(feedback_signal[7:6] == 2'b00&&feedback_signal[2:0] == 3'b101) begin
    out <= 8'b00010010;
    count <= 3'b000;
    next_line <= 8'b00000001;
    this_line_is_over <= 1'b1;
    end
    end
    end
    else if(func == 2'b11) begin//throw action
    
        if(feedback_signal[3]) begin
            if(i_num[5:0]==6'b001001||i_num[5:0]==6'b001011||i_num[5:0]==6'b001110||i_num[5:0]==6'b010001||i_num[5:0]==6'b010011||i_num[5:0]==6'b010100)begin
                if(count == 3'b000) begin
                    this_line_is_over <= 1'b0;
                    out[7:2] <= i_num[5:0];
                    out[1:0] <= 2'b11;
                    count <= count + 1;//set target
                end
                else if(count == 3'b001) begin
                    out <= 8'b01000010;//throw directily
                    count <= 3'b000;
                    next_line <= 8'b00000001;
                    this_line_is_over <= 1'b1;
                end
            end
            else begin
                 if(count == 3'b000) begin
                        this_line_is_over <= 1'b0;
                        out[7:2] <= i_num[5:0];
                        out[1:0] <= 2'b11;
                        count <= count + 1;//set target
                  end
                 else if(count == 3'b001) begin
                      out <= 8'b00100010;
                      count <= count + 1;//move to target
                 end
                 else if(count == 3'b010) begin
                       if(feedback_signal[7:6] == 2'b00&&feedback_signal[2:0] == 3'b101) begin
                              out <= 8'b00001010;
                              count <= 3'b000;
                              next_line <= 8'b00000001;
                             this_line_is_over <= 1'b1;
                          end
                       end
                                 
                end
            end
            else begin
                if(count2 == 3'b000) begin
                    this_line_is_over <= 1'b0;
                    out[7:2] <= random_target;
                    out[1:0] <= 2'b11;
                    count2 <= count2 + 1;//set target
                    end
                else if(count2 == 3'b001) begin
                    out <= 8'b00100010;
                    count2 <= count2 + 1;//move to target
                end
                else if(count2 == 3'b010) begin
                    if(feedback_signal[7:6] == 2'b00&&feedback_signal[2:0] == 3'b101) begin
                        out <= 8'b00000110;
                        count2 <= 3'b000;
                    end
                end
            end
    end
    end
//    //-----jump-------
    if(op == 3'b010) begin
    this_line_is_over <= 1'b0;
    
    if(i_sign == 3'b000) begin//player ready
        if(feedback_signal[2] == ~func[0]) begin
            next_line <= i_num;
        end 
        else begin
            next_line <= 8'b00000001;
        end
        this_line_is_over <= 1'b1;
    end
    else if(i_sign == 3'b001) begin//player has item
        if(feedback_signal[3] == ~func[0]) begin
            next_line <= i_num;
        end
        else begin
            next_line <= 8'b00000001;
        end
        this_line_is_over <= 1'b1;
    end
    else if(i_sign == 3'b101) begin//target has item
        if(feedback_signal[5] == ~func[0]) begin
            next_line <= i_num;
        end
        else begin
            next_line <= 8'b00000001;
        end
        this_line_is_over <= 1'b1;
    end
    else if(i_sign == 3'b100) begin//target ready
            if(feedback_signal[4] == ~func[0]) begin
            next_line <= i_num;
        end
        else begin
            next_line <= 8'b00000001;
        end
        this_line_is_over <= 1'b1;
        end
    end
    //---------wait----------
    
    if(op == 3'b011) begin
    //next_line <= 8'b00000000;
    this_line_is_over <= 1'b0;
    if(func == 2'b00) begin
    if(waitcnt < i_num + 1) begin
    waitcnt <= waitcnt + 1;
    end
    else begin
    next_line <= 8'b00000001;
    waitcnt <= 0;
    this_line_is_over <= 1'b1;
    
    end
    end
    if(func == 2'b01) begin//wait until
    if(i_sign == 3'b000) begin//player ready
    if(feedback_signal[2] == 1'b1) begin
    next_line <= 8'b00000001;
    this_line_is_over <= 1'b1;
    end
    end                                                                                    
    else if(i_sign == 3'b001) begin//player has item
    if(feedback_signal[3] == 1'b1) begin
    this_line_is_over <= 1'b1;
    next_line <= 8'b00000001;
    end
    end
    else if(i_sign == 3'b010) begin//target has item
    if(feedback_signal[4] == 1'b1) begin
    next_line <= 8'b00000001;
    this_line_is_over <= 1'b1;
    end
    end
    else if(i_sign == 3'b011) begin//target ready
    if(feedback_signal[5] == 1'b1) begin
    next_line <= 8'b00000001;
    this_line_is_over <= 1'b1;
    end
    end
    end
    end
    end
    end
    end
    
endmodule
