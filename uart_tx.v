`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2025 17:00:15
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    input wire[7:0]din,
    input wire rst,
    input wire clk,
    input wire clk_en,
    input wire wr_en,
    output reg tx,
    output reg tx_busy
    );
    
    parameter STATE_IDLE = 3'b000;
    parameter STATE_START = 3'b001;
    parameter STATE_DATA = 3'b010;
    parameter STATE_PARITY = 3'b011;
    parameter STATE_STOP = 3'b100;
    parameter PARITY_TYPE = 1'b0;
    
    reg[7:0]data=8'b0;
    reg[2:0]count=3'b0;
    reg[2:0]state=STATE_IDLE;
    reg parity_bit=1'b0;
    
    always @(*) begin
        if (PARITY_TYPE==0) begin
            parity_bit = ^data;
        end else begin
            parity_bit = ~^data;
        end
    end
    
    always@(posedge clk or posedge rst) begin
        if(rst)begin
            tx<=1'b1;
            data<=8'b0;
            count<=3'b0;
            state<=STATE_IDLE;
            tx_busy<=1'b0;
        end else begin
            case(state)
                STATE_IDLE: begin
                    tx<=1'b1;
                    tx_busy<=1'b0;
                    if(wr_en)begin
                        tx_busy<=1'b1;
                        state<=STATE_START;
                        count<=3'b0;
                        data<=din;
                    end
                end
                
                STATE_START: begin
                    if(clk_en)begin
                        tx<=1'b0;
                        state<=STATE_DATA;
                    end
                end
                
                STATE_DATA: begin
                    if(clk_en)begin
                        if(count==3'b111)begin
                            state<=STATE_PARITY;
                        end else begin
                            count<=count+1;
                        end
                        tx<=data[count];
                    end       
                end
                
                STATE_PARITY: begin
                    if(clk_en)begin
                        tx<=parity_bit;
                        state<=STATE_STOP;
                    end       
                end
          
                STATE_STOP: begin 
                    if(clk_en)begin
                        tx<=1'b1;
                        state<=STATE_IDLE;
                    end
                end
                
                default: begin
                    tx<=1'b1;
                    state<=STATE_IDLE;  
                end    
            endcase
        end
    end
endmodule