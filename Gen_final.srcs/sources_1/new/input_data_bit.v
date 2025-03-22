
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 22:35:49
// Design Name: 
// Module Name: input_data_bit
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
//input shijinzhi gai erjinzhi----no need
//connect board and kehuduan
//sim output game_state debug
`include "parameters.v"
module input_data_bit(
    input start,stop,rst,
    input [4:0] i_data_bit,
    input io_dataOut_valid, // game_state is valid
    input io_dataIn_ready, // last byte sent
    input [7:0] io_dataOut_bits, // feedback signal
    input G,P,I,M,T, // Get, Put, Interact, Move, Throw
    input control_clk,
    output reg [7:0] to_uart
    );

reg [7:0] next_state;
reg [7:0] game_state;
//reg [7:0] cnt;

always @(control_clk, rst)
begin
    if(rst)
        to_uart = `SCRIPT_LOADING;
    else if(control_clk && io_dataIn_ready) begin
        to_uart = next_state;
    end  
//    else
//        to_uart <= 8'b00000010;
        
    if(io_dataOut_valid)
        game_state = io_dataOut_bits;
end

always @(start, stop, G, P, I, M, T, i_data_bit)
begin
    if(start) //start the game
        next_state = `START;
    else if(stop)//stop the game
        next_state = `END;
    else if(G) begin //Get operation
        if(game_state[1] && game_state[4]) begin // only do when in front of target, data[5] is 1 when machine is not empty
            // Machine num is 7, 8, 10, 12, 13, 15, 16, 20: Cannot get when the machine is empty
            next_state = `GET;
        end
        else 
            next_state = `SCRIPT_LOADING;
    end
    else if(P) begin //Put operation
        if(game_state[1] && game_state[2]) begin // only do when in front of target, data[3] is 1 when hand is not empty
            next_state = `PUT;
            // Machine num is 7, 8: Cannot put when the machine is full
            // Machine num 10, 12, 13, 15, 16: Can put 3 items
//            if(i_data_bit == 5'b00111 || i_data_bit == 5'b01000 || i_data_bit == 5'b01010 || i_data_bit == 5'b01100 || i_data_bit == 5'b01101 || i_data_bit == 5'b01111 || i_data_bit == 5'b10000) begin
            if((i_data_bit == 5'b00111 || i_data_bit == 5'b01000) && game_state[4]) begin // data[5] is 1 when machine is full
                next_state = `SCRIPT_LOADING;
            end 
        end
        else 
            next_state = `SCRIPT_LOADING;
    end
    else if(I) begin //Interact operation
        if(game_state[1]) begin  // data[2] is 1 when in front of the machine
            next_state = `INTERACT;
        end
        else 
            next_state = `SCRIPT_LOADING;
    end
    else if(M) begin //Move operation
        next_state = `MOVE;
    end
    else if(T) begin //Throw operation
        if(i_data_bit == 5'b01001 || i_data_bit == 5'b01011 || i_data_bit == 5'b01110 || i_data_bit == 5'b10001 || i_data_bit == 5'b10011 || i_data_bit == 5'b10100) // Only throw to table or gabage bin
            next_state = `THROW;  
        else 
            next_state = `SCRIPT_LOADING;
    end  
    else if(i_data_bit > 5'b00000 && i_data_bit <= 5'b10100) begin // if target machine > 20 then do nothing
        next_state = {i_data_bit, 2'b11}; 
    end
    else 
        next_state = `SCRIPT_LOADING;
    
//    if(cnt >= 5 && ~I) begin // reset every 5 clk, except interacting
//        cnt = 8'b00000000;
//        next_state= 8'b00000010;
//    end
//    else
//        cnt = cnt + 1;
end 
endmodule
