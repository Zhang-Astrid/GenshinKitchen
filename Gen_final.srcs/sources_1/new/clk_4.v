`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/24 00:29:18
// Design Name: 
// Module Name: clk_4
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


module clk_4(
    input clk,
    output clk_new
    );
    reg [31:0] count = 0;
    reg tmp = 1'b0;
    always @(posedge clk) begin
    if(count < 2500000) begin
    count <= count + 1;
    end
    else begin
    count <= 0;
    tmp <= ~tmp;
    end
    end
   assign clk_new = tmp;
    
endmodule
