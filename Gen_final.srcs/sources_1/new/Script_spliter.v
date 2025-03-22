`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/02 19:30:45
// Design Name: 
// Module Name: Script_spliter
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

//Split script into small pieces
    module Script_spliter(
    input [15:0] inst,
    output [7:0] i_num,
    output [2:0] i_sign,
    output [1:0] func,
    output [2:0] op
    );
    assign i_num = inst[15:8];
    assign i_sign = inst[7:5];
    assign func = inst[4:3];
    assign op = inst[2:0];
endmodule
