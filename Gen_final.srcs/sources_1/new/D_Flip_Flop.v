`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/15 11:40:40
// Design Name: 
// Module Name: D_Flip_Flop
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


module D_Flip_Flop(
        input D,
        input clk,
        input rst_n,
        output reg Q,
        output nQ
    );
    assign nQ=~Q;
    always @(posedge clk,negedge rst_n)
    begin
        if(!rst_n)Q<=1'b0;
        else Q<=D;
    end
endmodule
