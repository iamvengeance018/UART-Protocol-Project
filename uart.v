`timescale 1ns / 1ps

module uart(
    // Transmitter Interface
    input wire [7:0] din,       // Data to transmit
    input wire wr_en,           // Write enable (starts transmission)
    output wire tx_busy,         // Transmitter busy flag
    
    // Receiver Interface
    output wire [7:0] dout,      // Received data
    output wire error,           // Error flag (parity or framing)
    output wire rx_busy,         // Receiver busy flag
    
    // Loopback Control
    input wire loopback_en,      // Enable internal loopback (tx -> rx)
    input wire external_rx,      // External RX input (used when loopback_en = 0)
    output wire external_tx,     // External TX output (used when loopback_en = 0)
    
    // Common Signals
    input wire clk,              // System clock
    input wire rst               // Active-high reset
);

    // Internal Signals
    wire clk_en;                 // Baud rate enable
    wire tx;                     // Internal TX signal
    wire rx;                     // Internal RX signal

    // Baud Rate Generator
    baud_rate_generator #(
        .CLOCK_FREQ(50000000),   // 50 MHz clock
        .BAUD_RATE(921600)       // 921600 baud
    ) baud_gen_inst (
        .clk(clk),
        .rst(rst),
        .clk_en(clk_en)
    );

    // UART Transmitter
    uart_tx uart_tx_inst(
        .din(din),
        .rst(rst),
        .clk(clk),
        .clk_en(clk_en),
        .wr_en(wr_en),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // UART Receiver
    uart_rx uart_rx_inst(
        .rx(rx),
        .rst(rst),
        .clk(clk),
        .clk_en(clk_en),
        .dout(dout),
        .error(error),
        .rx_busy(rx_busy)
    );

    // Loopback and External Interface Logic
    assign external_tx = loopback_en ? 1'bz : tx;  // High-Z when loopback enabled
    assign rx = loopback_en ? tx : external_rx;    // Internal loopback or external RX

endmodule