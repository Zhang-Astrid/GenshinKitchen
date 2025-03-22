`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/28 23:03:21
// Design Name: 
// Module Name: MUX_2_1_8bits
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
module MUX_2_1_8bits(
    input select,
    input [7:0]one,
    input [7:0]two,
    output reg [7:0]out
    );
    always @* begin
    if(select) begin
    out = two;
    end
    else begin
    out = one;
    end
    end
endmodule
