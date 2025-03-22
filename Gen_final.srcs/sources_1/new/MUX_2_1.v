`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/23 04:22:16
// Design Name: 
// Module Name: MUX_2_1
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


module MUX_2_1(
    input select,
    input one,
    input two,
    input enable,
    output reg out
    );
    always @* begin
    if(!enable)begin
    out=1'b0;
    end
    else begin
    if(select) begin
    out = two;
    end
    else begin
    out = one;
    end
    end
    end
endmodule
