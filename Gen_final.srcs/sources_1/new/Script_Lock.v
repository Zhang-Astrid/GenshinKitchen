`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/22 13:25:22
// Design Name: 
// Module Name: Script_Lock
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


module Script_Lock(
        input clk,
        input singal,
        input over,
        output reg unlock
    );
    always @(posedge clk)begin
        if(singal)begin
            unlock<=1;
        end
        else begin
            unlock<=~over;
        end
    end
endmodule
