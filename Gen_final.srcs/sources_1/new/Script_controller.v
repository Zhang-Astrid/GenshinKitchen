`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 10:36:59
// Design Name: 
// Module Name: Script_controller
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


module Script_controller(
    input clk,
    input ctrl,
    input script_mode,
    input [15:0] raw_script,
    input over,
    input [7:0] raw_next,
    input rst,
    
    output reg [15:0] script,
    output  [7:0] pc
    );
    reg [7:0] pctmp = 0;
    reg timer = 1'b1;
    reg flag=1'b0;
    always @(posedge clk) begin
        if(rst)begin
            pctmp <= 0;
            timer <= 1'b1;
            flag<=1'b0;
        end
        else begin
                if(~script_mode) begin
                        script <= raw_script;
                        if(script>16'b0)timer <= 1'b0;
        
                end
                    
                    
        
        if(ctrl) begin
            if(over|timer) begin
                if(~flag)begin
                   pctmp <= pctmp + 2 * raw_next;
                   flag=1'b1;
                   
                   end
            end
        end
     
        else begin
            flag=1'b0;
        end
        end
    end
    
assign pc =  pctmp;
endmodule
