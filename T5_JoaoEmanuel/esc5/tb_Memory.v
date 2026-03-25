`timescale 1ns/1ps

/*
 * Test Bench for Memory Module
 * 
 * Tests the memory system including RAM, Screen, and Keyboard regions.
 */

module tb_Memory;

    // Clock
    reg         clk;
    
    // Memory signals
    reg         load;
    reg  [14:0] address;
    reg  [15:0] in;
    wire [15:0] out;
    
    // Instantiate Memory module
    Memory uut(
        .clk(clk),
        .load(load),
        .address(address),
        .in(in),
        .out(out)
    );
    
    // Clock generation (10ns period = 100MHz)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        $dumpfile("tb_memory.vcd");
        $dumpvars(0, tb_Memory);
        
        $display("===== Memory Test Starting =====");
        
        // Initialize
        load = 0;
        address = 0;
        in = 0;
        
        // Test 1: Write to RAM
        #10;
        $display("Test 1: Writing to RAM");
        address = 15'd100;
        in = 16'h1234;
        load = 1;
        #10;
        load = 0;
        #10;
        if (out == 16'h1234)
            $display("  PASS: Read back 0x%h from RAM[100]", out);
        else
            $display("  FAIL: Expected 0x1234, got 0x%h", out);
        
        // Test 2: Write to different RAM location
        #10;
        $display("Test 2: Writing to RAM[200]");
        address = 15'd200;
        in = 16'h5678;
        load = 1;
        #10;
        load = 0;
        #10;
        if (out == 16'h5678)
            $display("  PASS: Read back 0x%h from RAM[200]", out);
        else
            $display("  FAIL: Expected 0x5678, got 0x%h", out);
        
        // Test 3: Verify first location still holds value
        #10;
        $display("Test 3: Reading RAM[100] again");
        address = 15'd100;
        #10;
        if (out == 16'h1234)
            $display("  PASS: RAM[100] still contains 0x%h", out);
        else
            $display("  FAIL: Expected 0x1234, got 0x%h", out);
        
        // Test 4: Write to Screen memory (address 16384)
        #10;
        $display("Test 4: Writing to Screen memory");
        address = 15'd16384;  // First screen address
        in = 16'hFFFF;
        load = 1;
        #10;
        load = 0;
        #10;
        if (out == 16'hFFFF)
            $display("  PASS: Read back 0x%h from Screen[16384]", out);
        else
            $display("  FAIL: Expected 0xFFFF, got 0x%h", out);
        
        // Test 5: Write to another Screen location
        #10;
        $display("Test 5: Writing to Screen[16400]");
        address = 15'd16400;
        in = 16'hAAAA;
        load = 1;
        #10;
        load = 0;
        #10;
        if (out == 16'hAAAA)
            $display("  PASS: Read back 0x%h from Screen[16400]", out);
        else
            $display("  FAIL: Expected 0xAAAA, got 0x%h", out);
        
        // Test 6: Read from Keyboard (address 24576)
        #10;
        $display("Test 6: Reading from Keyboard");
        address = 15'd24576;
        #10;
        $display("  INFO: Keyboard value = 0x%h (should be 0 by default)", out);
        
        // Test 7: Verify address ranges don't overlap
        #10;
        $display("Test 7: Verifying RAM and Screen are separate");
        address = 15'd100;
        #10;
        if (out == 16'h1234)
            $display("  PASS: RAM[100] still contains 0x%h", out);
        else
            $display("  FAIL: RAM corrupted, got 0x%h", out);
        
        #10;
        address = 15'd16384;
        #10;
        if (out == 16'hFFFF)
            $display("  PASS: Screen[16384] still contains 0x%h", out);
        else
            $display("  FAIL: Screen corrupted, got 0x%h", out);
        
        #50;
        $display("===== Memory Test Complete =====");
        $finish;
    end

endmodule
