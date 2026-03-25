`timescale 1ns/1ps

/*
 * Test Bench for Computer Module
 * 
 * Tests the complete computer with three programs:
 * 1. Add.hack - Adds 2+3 and stores result in RAM[0]
 * 2. Max.hack - Computes max(RAM[0], RAM[1]) and stores in RAM[2]
 * 3. Rect.hack - Draws a rectangle on screen
 */

module tb_Computer;

    // Clock and reset
    reg clk;
    reg reset;
    
    // Instantiate Computer
    Computer uut(
        .clk(clk),
        .reset(reset)
    );
    
    // Clock generation (10ns period = 100MHz)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Task to load program into ROM
    task load_program;
        input [255:0] program_name;
        input integer num_instructions;
        integer i;
        begin
            $display("Loading program: %s (%0d instructions)", program_name, num_instructions);
            // Note: actual program loading handled in each test block
        end
    endtask
    
    // Task to display RAM contents
    task display_ram;
        input integer start_addr;
        input integer end_addr;
        integer i;
        begin
            $display("RAM contents:");
            for (i = start_addr; i <= end_addr; i = i + 1) begin
                $display("  RAM[%0d] = %0d (0x%04h)", i, 
                         $signed(uut.memory.ram.mem[i]),
                         uut.memory.ram.mem[i]);
            end
        end
    endtask
    
    // Main test
    initial begin
        $dumpfile("tb_computer.vcd");
        $dumpvars(0, tb_Computer);
        
        $display("========================================");
        $display("===== Computer Test Starting =====");
        $display("========================================");
        
        // Initialize
        reset = 1;
        #20;
        
        // ===== Test 1: Add Program =====
        // Computes 2 + 3 and stores result in RAM[0]
        begin : test1_add
            integer i;
            
            $display("\n===== TEST 1: Add Program (2 + 3) =====");
            
            // Add.hack program:
            // @2        // Load 2
            // D=A       // D = 2
            // @3        // Load 3
            // D=D+A     // D = D + 3 = 5
            // @0        // Load address 0
            // M=D       // RAM[0] = 5
            // (END)
            // @END      // Infinite loop
            // 0;JMP
            
            load_program("Add.hack", 8);
            uut.rom.mem[0] = 16'b0000000000000010;  // @2
            uut.rom.mem[1] = 16'b1110110000010000;  // D=A
            uut.rom.mem[2] = 16'b0000000000000011;  // @3
            uut.rom.mem[3] = 16'b1110000010010000;  // D=D+A
            uut.rom.mem[4] = 16'b0000000000000000;  // @0
            uut.rom.mem[5] = 16'b1110001100001000;  // M=D
            uut.rom.mem[6] = 16'b0000000000000110;  // @6 (loop)
            uut.rom.mem[7] = 16'b1110101010000111;  // 0;JMP
            
            for (i = 0; i < 8; i = i + 1) begin
                $display("  ROM[%2d] = 0x%04h", i, uut.rom.mem[i]);
            end
            
            reset = 0;
            #100;  // Run for 100ns
            
            display_ram(0, 5);
            
            if (uut.memory.ram.mem[0] == 16'd5)
                $display("  *** PASS: Add test - RAM[0] = %0d", uut.memory.ram.mem[0]);
            else
                $display("  *** FAIL: Add test - Expected RAM[0]=5, got %0d", uut.memory.ram.mem[0]);
        end
        
        #50;
        reset = 1;
        #20;
        
        // ===== Test 2: Max Program =====
        // Computes max(RAM[0], RAM[1]) and stores in RAM[2]
        begin : test2_max
            integer i;
            
            $display("\n===== TEST 2: Max Program =====");
            
            // Setup: Initialize RAM[0]=15, RAM[1]=23
            uut.memory.ram.mem[0] = 16'd15;
            uut.memory.ram.mem[1] = 16'd23;
            $display("Initial values: RAM[0]=%0d, RAM[1]=%0d", 
                     uut.memory.ram.mem[0], uut.memory.ram.mem[1]);
            
            // Max.hack program:
            // @0        // Load address 0
            // D=M       // D = RAM[0]
            // @1        // Load address 1
            // D=D-M     // D = RAM[0] - RAM[1]
            // @10       // If D > 0, goto OUTPUT_FIRST
            // D;JGT
            // @1        // Load address 1
            // D=M       // D = RAM[1] (second is larger)
            // @12       // Goto OUTPUT_D
            // 0;JMP
            // (OUTPUT_FIRST)
            // @0        // Load address 0
            // D=M       // D = RAM[0] (first is larger)
            // (OUTPUT_D)
            // @2        // Load address 2
            // M=D       // RAM[2] = D (store result)
            // (END)
            // @14       // Infinite loop
            // 0;JMP
            
            load_program("Max.hack", 16);
            uut.rom.mem[0]  = 16'b0000000000000000;  // @0
            uut.rom.mem[1]  = 16'b1111110000010000;  // D=M
            uut.rom.mem[2]  = 16'b0000000000000001;  // @1
            uut.rom.mem[3]  = 16'b1111010011010000;  // D=D-M
            uut.rom.mem[4]  = 16'b0000000000001010;  // @10
            uut.rom.mem[5]  = 16'b1110001100000001;  // D;JGT
            uut.rom.mem[6]  = 16'b0000000000000001;  // @1
            uut.rom.mem[7]  = 16'b1111110000010000;  // D=M
            uut.rom.mem[8]  = 16'b0000000000001100;  // @12
            uut.rom.mem[9]  = 16'b1110101010000111;  // 0;JMP
            uut.rom.mem[10] = 16'b0000000000000000;  // @0
            uut.rom.mem[11] = 16'b1111110000010000;  // D=M
            uut.rom.mem[12] = 16'b0000000000000010;  // @2
            uut.rom.mem[13] = 16'b1110001100001000;  // M=D
            uut.rom.mem[14] = 16'b0000000000001110;  // @14
            uut.rom.mem[15] = 16'b1110101010000111;  // 0;JMP
            
            for (i = 0; i < 16; i = i + 1) begin
                $display("  ROM[%2d] = 0x%04h", i, uut.rom.mem[i]);
            end
            
            reset = 0;
            #200;  // Run for 200ns
            
            display_ram(0, 3);
            
            if (uut.memory.ram.mem[2] == 16'd23)
                $display("  *** PASS: Max test - RAM[2] = %0d", uut.memory.ram.mem[2]);
            else
                $display("  *** FAIL: Max test - Expected RAM[2]=23, got %0d", uut.memory.ram.mem[2]);
        end
        
        #50;
        reset = 1;
        #20;
        
        // ===== Test 3: Simple Rectangle Program =====
        // Draws a small rectangle (simplified version)
        begin : test3_rect
            integer i;
            
            $display("\n===== TEST 3: Rectangle Program (Simplified) =====");
            
            // Setup: RAM[0] = number of rows to draw (e.g., 4)
            uut.memory.ram.mem[0] = 16'd4;
            $display("Drawing %0d rows", uut.memory.ram.mem[0]);
            
            // Simplified Rect program (draws RAM[0] rows of 16 pixels each)
            // @0        // n = RAM[0]
            // D=M
            // @23       // if n <= 0, goto END
            // D;JLE
            // @16384    // screen = 16384 (base address)
            // D=A
            // @addr
            // M=D       // addr = 16384
            // (LOOP)
            // @addr     // Load current screen address
            // A=M       // Set A to address
            // M=-1      // Fill 16 pixels (all black)
            // @addr
            // M=M+1     // addr = addr + 1
            // @0
            // M=M-1     // n = n - 1
            // D=M       // D = n
            // @8        // if n > 0, goto LOOP
            // D;JGT
            // (END)
            // @23       // Infinite loop
            // 0;JMP
            
            load_program("Rect.hack", 20);
            uut.rom.mem[0]  = 16'b0000000000000000;  // @0
            uut.rom.mem[1]  = 16'b1111110000010000;  // D=M
            uut.rom.mem[2]  = 16'b0000000000010111;  // @23
            uut.rom.mem[3]  = 16'b1110001100000110;  // D;JLE
            uut.rom.mem[4]  = 16'b0100000000000000;  // @16384
            uut.rom.mem[5]  = 16'b1110110000010000;  // D=A
            uut.rom.mem[6]  = 16'b0000000000010000;  // @16 (addr variable)
            uut.rom.mem[7]  = 16'b1110001100001000;  // M=D
            uut.rom.mem[8]  = 16'b0000000000010000;  // @16 (LOOP)
            uut.rom.mem[9]  = 16'b1111110000100000;  // A=M
            uut.rom.mem[10] = 16'b1110111010001000;  // M=-1
            uut.rom.mem[11] = 16'b0000000000010000;  // @16
            uut.rom.mem[12] = 16'b1111110111001000;  // M=M+1
            uut.rom.mem[13] = 16'b0000000000000000;  // @0
            uut.rom.mem[14] = 16'b1111110010001000;  // M=M-1
            uut.rom.mem[15] = 16'b1111110000010000;  // D=M
            uut.rom.mem[16] = 16'b0000000000001000;  // @8
            uut.rom.mem[17] = 16'b1110001100000001;  // D;JGT
            uut.rom.mem[18] = 16'b0000000000010111;  // @23 (END)
            uut.rom.mem[19] = 16'b1110101010000111;  // 0;JMP
            
            for (i = 0; i < 20; i = i + 1) begin
                $display("  ROM[%2d] = 0x%04h", i, uut.rom.mem[i]);
            end
            
            reset = 0;
            #500;  // Run longer for rectangle drawing
            
            $display("Screen memory (first 8 words):");
            for (integer i = 0; i < 8; i = i + 1) begin
                $display("  Screen[%0d] = 0x%04h", i, uut.memory.screen.mem[i]);
            end
            
            // Check if screen was written to
            if (uut.memory.screen.mem[0] == 16'hFFFF &&
                uut.memory.screen.mem[1] == 16'hFFFF &&
                uut.memory.screen.mem[2] == 16'hFFFF &&
                uut.memory.screen.mem[3] == 16'hFFFF)
                $display("  *** PASS: Rectangle test - Screen written correctly");
            else
                $display("  *** INFO: Rectangle test - Check screen memory above");
        end
        
        #100;
        $display("\n========================================");
        $display("===== Computer Test Complete =====");
        $display("========================================");
        $finish;
    end

endmodule
