`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 21:01:21
// Design Name: 
// Module Name: start_and_end
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
module start_and_end(
    input st_en,
    output reg [7:0] ins
    );
    
    always @(posedge st_en) begin
    ins <= `START;
    end
    always @(negedge st_en) begin
    ins <= `END;
    end
endmodule
