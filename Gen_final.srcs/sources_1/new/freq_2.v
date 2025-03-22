module freq_2(
    input clk,
    output clk_new
    );
    reg [31:0] count = 0;
    reg tmp = 1'b0;
    always @(posedge clk) begin
    if(count < 325) begin
    count <= count + 1;
    end
    else begin
    count <= 0;
    tmp <= ~tmp;
    end
    end
   assign clk_new = tmp;
    
endmodule
