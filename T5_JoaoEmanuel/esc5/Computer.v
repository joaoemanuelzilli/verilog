`timescale 1ns/1ps

/*
 * Computer Module - Complete Hack Computer System
 * 
 * Integrates:
 *   - CPU: Central Processing Unit
 *   - Memory: Data memory (RAM + Screen + Keyboard)
 *   - ROM32K: Instruction memory (program)
 * 
 * The computer can be reset using the reset signal.
 * When reset is released, the CPU begins executing instructions from address 0.
 */

module Computer(
    input  wire clk,
    input  wire reset
);

    // Internal signals
    wire [15:0] instruction;    // Current instruction from ROM
    wire [15:0] inM;            // Data from memory to CPU
    wire [15:0] outM;           // Data from CPU to memory
    wire [14:0] addressM;       // Data memory address
    wire [14:0] pc;             // Program counter
    wire        writeM;         // Memory write enable
    
    // CPU instance
    CPU cpu(
        .clk(clk),
        .reset(reset),
        .inM(inM),
        .instruction(instruction),
        .outM(outM),
        .writeM(writeM),
        .addressM(addressM),
        .pc(pc)
    );
    
    // Memory instance
    Memory memory(
        .clk(clk),
        .load(writeM),
        .address(addressM),
        .in(outM),
        .out(inM)
    );
    
    // ROM32K instance (instruction memory)
    ROM32K rom(
        .address(pc),
        .out(instruction)
    );

endmodule


/*
 * ROM32K Module - 32K words of read-only instruction memory
 * 
 * This module stores the program to be executed.
 * In simulation, the program is loaded from the testbench.
 */
module ROM32K(
    input  wire [14:0]  address,      // 15-bit address (32K words)
    output wire [15:0]  out           // Instruction output
);
    localparam integer DEPTH = 32768;  // 32K words
    
    reg [15:0] mem [0:DEPTH-1];
    integer idx;
    
    // Initialize memory to NOPs (0x0000 = @0)
    initial begin
        for (idx = 0; idx < DEPTH; idx = idx + 1) begin
            mem[idx] = 16'h0000;
        end
    end
    
    assign out = (address < DEPTH) ? mem[address] : 16'h0000;

endmodule
