`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/02 19:11:17
// Design Name: 
// Module Name: Travel_to_target
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


module Travel_to_target(
    input [5:0] target,
    output reg [7:0] out
    );
    always @(target) begin
    if(target <= 6'b010100) begin
    out[7:2] = target;
    out[1:0] = 2'b11;
    end
    else begin
    out = 8'b00000011;
    end
    end
endmodule
