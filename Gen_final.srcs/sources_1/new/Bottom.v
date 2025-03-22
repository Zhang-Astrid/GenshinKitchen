`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/15 11:38:48
// Design Name: 
// Module Name: Bottom
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


 module Bottom(
     input clk,
     input bs,
     input rst_n,
     output outs
    );
    wire Q1,Q2,nQ1,nQ2,clk_bps;
    assign clk_bps=clk;
//    counter cou(.clk(clk),.rst_n(rst_n),.clk_bps(clk_bps));
    D_Flip_Flop D1(.D(bs),.rst_n(rst_n),.clk(clk_bps),.Q(Q1),.nQ(nQ1));
    D_Flip_Flop D2(.D(Q1),.rst_n(rst_n),.clk(clk_bps),.Q(Q2),.nQ(nQ2));
    assign outs= Q1&nQ2;
endmodule
