`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/03 10:39:20
// Design Name: 
// Module Name: feedback_memory
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


module feedback_memory(
    input clk,
    input feedback_valid,
    input [7:0] feedback_in,
    output reg [7:0] feedback
    );//store feedback information, only update when valid
    always @(posedge clk) begin
    if(feedback_valid) begin
        feedback <= feedback_in;
    end
    end
endmodule
