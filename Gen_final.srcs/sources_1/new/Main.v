`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 23:39:17
// Design Name: 
// Module Name: Main
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
module Main(
    input start,stop,clk,rst,G,P,I,M,T,io_pair_rx,
    input [4:0] i_board, // 5 pins to input op code to UART
    input [2:0] switches, // little pin
    input choose_mod,//choose script or by hand
    output io_pair_tx,        // tx, connect to T4 pin please
    output i6,i7,i5,i4,i3,i2,i1,i0, // 8 LEDs to show the input
    output [1:0] led2
    );
    wire [7:0] board_to_uart;
    wire [7:0] uart_data_out;
    wire io_dataOut_valid;
    wire io_dataIn_ready;
    wire script_mode_out;
    wire control_clk_out;
    wire uart_clk_out;
    wire [7:0] pc;
    wire [15:0] script;
    
    wire uart_clk_16;//uart clk      
    wire [7:0] dataIn_bits;//script data_in


    wire script_mode;
// The wire above is useful~
    wire [7:0] fmem;
    wire [15:0] valid_script;
    wire [7:0] i_num;
    wire [2:0] i_sign;
    wire [1:0] func;
    wire [2:0] op;
    wire over;
    wire [7:0] next;
    wire clk_new;
    
    wire t;
    wire bs;
    wire unlock;
    wire [31:0] wt;
    wire muxout;
    wire clk4;
    wire clk_new2;
    wire [7:0]data_In_To_uart;
    
    input_data_bit u0(
        .start(start),//start the game
        .stop(stop),//stop the game
        .rst(~rst),//rst button
        .i_data_bit(i_board),//input from board
        .io_dataIn_ready(io_dataIn_ready),//8bits input to uart excluding the exception cases
        .io_dataOut_valid(io_dataOut_valid),//game_state_is_valid from uart
        .io_dataOut_bits(uart_data_out),//feedback signal from uart--->prev state
        .G(G),.P(P),.I(I),.M(M),.T(T),//button of operations
        .control_clk(control_clk_out),//clock
        .to_uart(board_to_uart)//8 bits operators from board to uart
    );
    
    UART u1(
        .clock(uart_clk_out),//clock
        .reset(~rst),//rst button
        .io_pair_rx(io_pair_rx),//R5 pin 
        .io_dataIn_bits(data_In_To_uart),//8 bits operators from board to uart
        .io_pair_tx(io_pair_tx),//tx, connect to T4 pin please
        .io_dataIn_ready(io_dataIn_ready),// referring (a) ??pulse 1 after a byte tramsmit success.
        .io_dataOut_valid(io_dataOut_valid),//game_state_is_valid from uart
        .io_dataOut_bits(uart_data_out)//feedback signal from uart--->prev state
    );
    
    Clk_freq_divider u2(
        .clk(clk),
        .control_clk_out(control_clk_out),
        .uart_clk_out(uart_clk_out),
        .rst(~rst)
    ); 
    
    ScriptMem u3(
        .clock(uart_clk_out),//clock
        .reset(~rst),             // rst button
        .dataOut_bits(uart_data_out),      //feedback signal from uart--->prev state
        .dataOut_valid(io_dataOut_valid),     //game_state_is_valid from uart
        .script_mode(script_mode),  // If script_mode is 1, you should ignore the dataOut_bits from UART module
        .pc(pc),      //program counter.
        .script(script) //instructions from pc.
    );
    
    clk_4 c4(clk,clk4);//clock for script control
    feedback_memory fm(clk,io_dataOut_valid,uart_data_out,fmem);
    clk_freq3 f3(clk,clk_new2);
    Script_controller sc(clk4,bs,script_mode,script,over,next,~rst,valid_script,pc);
    Script_spliter ss(valid_script,i_num,i_sign,func,op);
    clk_freq f(clk,clk_new);
    Bottom bt(clk_new,muxout,1'b1,bs);
    Script_Lock sl(clk,bs,over,unlock);
    Script_Translater st(fmem,io_dataIn_ready,clk_new,i_num,i_sign,func,op,unlock,~rst,over,dataIn_bits,next,t,wt);
//    freq_2 f_2(clk,uart_clk_16); // use uart_clk_out instead
    MUX_2_1 mu(switches[1],clk_new2,switches[0],switches[2],muxout);
    MUX_2_1_8bits bit_to_uart(.select(choose_mod),.one(board_to_uart),.two(dataIn_bits),.out(data_In_To_uart));
    assign i7 = uart_data_out[7];
    assign i6 = uart_data_out[6];
    assign i5 = uart_data_out[5];
    assign i4 = uart_data_out[4];
    assign i3 = uart_data_out[3];
    assign i2 = uart_data_out[2];
    assign i1 = uart_data_out[1];
    assign i0 = uart_data_out[0];
    assign led2=switches;
endmodule
