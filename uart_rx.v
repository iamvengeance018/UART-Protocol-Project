`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2025 15:24:43
// Design Name: 
// Module Name: uart_rx
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


module uart_rx(
    input wire rx,
    input wire rst,
    input wire clk,
    input wire clk_en,
    output reg[7:0]dout,
    output reg error,
    output reg rx_busy
    );
    
    parameter STATE_START = 2'b00;
    parameter STATE_DATA = 2'b01;
    parameter STATE_PARITY = 2'b10;
    parameter STATE_STOP = 2'b11;
    parameter PARITY_TYPE = 1'b0;
    
    reg[7:0]data=8'b0;
    reg[2:0]count=3'b0;
    reg[2:0]state=STATE_START;
    reg expected_parity=1'b0;
    
    always@(posedge clk or posedge rst) begin
        if(rst)begin
            data<=8'b0;
            count<=3'b0;
            state<=STATE_START;
            rx_busy<=1'b0;
            error<=1'b0;
            dout<=8'b0;
        end else begin
            case(state)
                STATE_START: begin
                    if(clk_en)begin
                        if(rx==1'b0)begin
                            state<=STATE_DATA;
                            dout<=8'b0;
                            count<=3'b0;
                            rx_busy<=1'b1;
                            error<=1'b0;
                        end
                    end
                end
                
                STATE_DATA: begin
                    if(clk_en)begin
                        data[count]<=rx;
                        if(count==3'b111)begin
                            state<=STATE_PARITY;
                        end else begin
                            count<=count+1;
                        end
                    end
                end
                
                STATE_PARITY:begin
                    expected_parity<=(PARITY_TYPE == 1'b0)? ^data : ~^data;
                    if(clk_en)begin
                        if(rx!=expected_parity)begin
                            error<=1'b1;
                        end
                        state<=STATE_STOP;
                    end
                end
                    
                STATE_STOP:begin
                    if(clk_en)begin
                        if(rx!=1'b1)begin
                            error<=1'b1;
                        end
                        dout<=data;
                        rx_busy<=1'b0;
                        state<=STATE_START;
                    end
                end
                
                default: begin
                    state<=STATE_START;
                end
                
            endcase
        end                        
    end
endmodule
