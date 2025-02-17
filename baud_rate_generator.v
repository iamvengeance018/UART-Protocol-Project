`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2025 18:20:57
// Design Name: 
// Module Name: baud_rate_generator
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


module baud_rate_generator(
    input wire clk,
    input wire rst,
    output reg clk_en
    );
    
    parameter CLOCK_FREQ=50000000;
    parameter BAUD_RATE=921600;
    parameter COUNTER_MAX=CLOCK_FREQ/BAUD_RATE;
    
    reg[31:0]counter;
    
    always@(posedge clk or posedge rst) begin
        if(rst)begin
            counter<=0;
            clk_en<=1'b0;
        end else begin
            if(counter==COUNTER_MAX-1)begin
                clk_en<=1'b1;
                counter<=0;
            end else begin
                counter<=counter+1;
                clk_en<=1'b0;
            end
        end    
    end
endmodule
