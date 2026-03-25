`timescale 1ns/1ps

/*
 * Test Bench for CPU Module
 * 
 * Tests basic CPU operations with simple instructions.
 */

module tb_CPU;

    // Clock and reset
    reg         clk;
    reg         reset;
    
    // CPU signals
    reg  [15:0] inM;
    reg  [15:0] instruction;
    wire [15:0] outM;
    wire        writeM;
    wire [14:0] addressM;
    wire [14:0] pc;
    
    // Instantiate CPU
    CPU uut(
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .pc(pc)
    );
    
    // Clock generation (10ns period)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        $dumpfile("tb_cpu.vcd");
        $dumpvars(0, tb_CPU);
        
        $display("===== CPU Test Starting =====");
        
        // Initialize
        reset = 1;
        inM = 0;
        instruction = 0;
        
        // Release reset after 2 cycles
        #20;
        reset = 0;
        
        // Test 1: A-instruction (@5)
        #10;
        $display("Test 1: A-instruction @5");
        instruction = 16'b0000000000000101;  // @5
        #10;
        if (addressM == 15'd5)
            $display("  PASS: A register = %d", addressM);
        else
            $display("  FAIL: Expected A=5, got A=%d", addressM);
        
        // Test 2: C-instruction (D=A)
        #10;
        $display("Test 2: C-instruction D=A");
        instruction = 16'b1110110000010000;  // D=A
        #10;
        $display("  INFO: D register loaded from A");
        
        // Test 3: A-instruction (@10)
        #10;
        $display("Test 3: A-instruction @10");
        instruction = 16'b0000000000001010;  // @10
        #10;
        if (addressM == 15'd10)
            $display("  PASS: A register = %d", addressM);
        else
            $display("  FAIL: Expected A=10, got A=%d", addressM);
        
        // Test 4: C-instruction (D=D+A, should be 5+10=15)
        $display("Test 4: C-instruction D=D+A");
        instruction = 16'b1110000010010000;  // D=D+A
        #10;
        $display("  INFO: D = D + A (should be 15)");
        
        // Test 5: A-instruction to set address for memory write
        $display("Test 5a: Setting address @10 for memory write");
        instruction = 16'b0000000000001010;  // @10
        #10;
        
        // Test 5b: C-instruction (M=D, write to memory)
        $display("Test 5b: C-instruction M=D");
        instruction = 16'b1110001100001000;  // M=D
        #10;
        if (writeM && outM == 16'd15)
            $display("  PASS: Writing %d to memory at address %d", outM, addressM);
        else
            $display("  FAIL: Expected writeM=1, outM=15, got writeM=%d, outM=%d", writeM, outM);
        
        // Test 6: Unconditional jump (@0; 0;JMP)
        #10;
        $display("Test 6: Testing jump");
        instruction = 16'b0000000000000000;  // @0
        #10;
        instruction = 16'b1110101010000111;  // 0;JMP
        #10;
        if (pc == 15'd0)
            $display("  PASS: PC jumped to 0");
        else
            $display("  FAIL: Expected PC=0, got PC=%d", pc);
        
        #50;
        $display("===== CPU Test Complete =====");
        $finish;
    end

endmodule
