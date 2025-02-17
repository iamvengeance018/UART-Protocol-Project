`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2025 23:19:46
// Design Name: 
// Module Name: baud_rate_generator_tb
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


`timescale 1ns / 1ps

module baud_rate_generator_tb;

    reg clk;
    reg rst;
    wire clk_en;

    baud_rate_generator #(
        .CLOCK_FREQ(50000000),
        .BAUD_RATE(921600) // Updated baud rate for faster response time
    ) uut (
        .clk(clk),
        .rst(rst),
        .clk_en(clk_en)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    initial begin
        rst = 1;
        #50;
        rst = 0;
        #1000;
        $stop;
    end
endmodule

