module uart_tb;
    reg clk;
    reg rst;
    reg [7:0] din;
    reg wr_en;
    reg loopback_en;
    
    wire tx_busy;
    wire [7:0] dout;
    wire error;
    wire rx_busy;
    wire external_tx;

    uart uut(
        .din(din),
        .wr_en(wr_en),
        .tx_busy(tx_busy),
        .dout(dout),
        .error(error),
        .rx_busy(rx_busy),
        .loopback_en(loopback_en),
        .external_rx(external_tx),  // Loopback: Connect external_tx to external_rx
        .external_tx(external_tx),
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock
    end

    // Test Sequence
    initial begin
        // Initialize
        rst = 1;
        din = 8'h00;
        wr_en = 0;
        loopback_en = 1;  // Enable loopback for testing
        #100;
        
        // Release reset
        rst = 0;
        #100;
        
        // Test Case 1: Send 0xA5
        din = 8'hA5;
        wr_en = 1;
        #10 wr_en = 0;
        wait(tx_busy == 0);
        #100;
        if (dout === 8'hA5 && !error)
            $display("Test 1 Passed: Received 0x%h", dout);
        else
            $display("Test 1 Failed: Expected 0xA5, Got 0x%h", dout);
        
        // Test Case 2: Send 0xFF
        din = 8'hFF;
        wr_en = 1;
        #10 wr_en = 0;
        wait(tx_busy == 0);
        #100;
        if (dout === 8'hFF && !error)
            $display("Test 2 Passed: Received 0x%h", dout);
        else
            $display("Test 2 Failed: Expected 0xFF, Got 0x%h", dout);
        
        // Test Case 3: Send 0x00
        din = 8'h00;
        wr_en = 1;
        #10 wr_en = 0;
        wait(tx_busy == 0);
        #100;
        if (dout === 8'h00 && !error)
            $display("Test 3 Passed: Received 0x%h", dout);
        else
            $display("Test 3 Failed: Expected 0x00, Got 0x%h", dout);
        
        // End Simulation
        #100;
        $display("Simulation Complete");
        $finish;
    end
endmodule