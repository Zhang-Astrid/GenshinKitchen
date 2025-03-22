`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 16:16:26
// Design Name: 
// Module Name: Clk_freq_divider
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


module Clk_freq_divider(
input clk,
output reg control_clk_out,
output reg uart_clk_out,
input rst
    );
    parameter control_period = 10000000; // 100M / 10M = 10HZ
    parameter uart_period = 651; // 100M / 651 = 153600HZ
//    parameter uart_period = 356; 
    reg [31:0] cnt;
    reg [31:0] cnt2;
    
//    initial begin
//        cnt <= 0;
//        cnt2 <= 0;
//        control_clk_out <= 0;
//        uart_clk_out <= 0;
//    end
    
    always@(posedge clk)
    begin
        if (rst) begin
            cnt <= 0;
            cnt2 <= 0;
            control_clk_out <= 0;
            uart_clk_out <= 0;
        end
        else begin
            if(cnt==((control_period >> 1) - 1)) begin
                control_clk_out <= ~control_clk_out;
                cnt <= 0;
            end
            else begin
                cnt <= cnt + 1;
            end
            
            if(cnt2==((uart_period >> 1) - 1)) begin
               uart_clk_out <= ~uart_clk_out;
               cnt2 <= 0;
            end
            else begin
               cnt2 <= cnt2 + 1;
            end
        end
    end
endmodule
