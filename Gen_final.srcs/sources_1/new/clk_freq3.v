
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 09:35:02
// Design Name: 
// Module Name: clk_freq
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


module clk_freq3(
    input clk,
    output clk_new
    );
    reg [31:0] count = 0;
    reg tmp = 1'b0;
    always @(posedge clk) begin
    if(count < 10000000) begin
    count <= count + 1;
    end
    else begin
    count <= 0;
    tmp <= ~tmp;
    end
    end
   assign clk_new = tmp;
    
endmodule
