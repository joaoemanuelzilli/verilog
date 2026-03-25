`timescale 1ns/1ps

/*
 * CPU Module - Hack Computer Central Processing Unit
 * 
 * The Hack CPU executes 16-bit instructions with the following format:
 * 
 * A-instruction (bit 15 = 0): 0vvvvvvvvvvvvvvv
 *   - Loads value vvvvvvvvvvvvvvv into A register
 * 
 * C-instruction (bit 15 = 1): 111a cccccc ddd jjj
 *   - a:      A/M select (0=A, 1=M[A])
 *   - cccccc: ALU control bits (zx, nx, zy, ny, f, no)
 *   - ddd:    Destination (A, D, M)
 *   - jjj:    Jump condition
 * 
 * Inputs:
 *   - inM:         Memory input (M[A])
 *   - instruction: Current instruction to execute
 *   - reset:       Reset PC to 0
 * 
 * Outputs:
 *   - outM:      Memory output (to be written to M[A])
 *   - writeM:    Memory write enable
 *   - addressM:  Memory address (A register)
 *   - pc:        Program counter
 */

module CPU(
    input  wire         clk,
    input  wire         reset,
    input  wire [15:0]  inM,          // M value input (data from memory)
    input  wire [15:0]  instruction,  // Instruction for execution
    output wire [15:0]  outM,         // M value output (data to memory)
    output wire         writeM,       // Write to M?
    output wire [14:0]  addressM,     // Address in data memory (of M)
    output wire [14:0]  pc            // Address of next instruction
);

    // Internal registers
    reg  [15:0] A;      // A register
    reg  [15:0] D;      // D register
    wire [15:0] PC_out; // Program Counter output (16-bit internally)
    
    // Instruction decode
    wire is_c_inst;     // Is C-instruction?
    wire is_a_inst;     // Is A-instruction?
    
    wire a_bit;         // A/M select
    wire [5:0] comp;    // Compute bits
    wire [2:0] dest;    // Destination bits
    wire [2:0] jump;    // Jump bits
    
    // ALU signals
    wire [15:0] alu_x, alu_y, alu_out;
    wire alu_zr, alu_ng;
    
    // Control signals
    wire load_a, load_d, load_pc;
    wire do_jump;
    wire inc_pc;
    
    // Instruction type
    assign is_c_inst = instruction[15];
    assign is_a_inst = ~instruction[15];
    
    // Decode C-instruction fields
    assign a_bit = instruction[12];
    assign comp  = instruction[11:6];  // ALU control: zx, nx, zy, ny, f, no
    assign dest  = instruction[5:3];   // d1=A, d2=D, d3=M
    assign jump  = instruction[2:0];   // j1=<0, j2==0, j3=>0
    
    // ALU inputs
    assign alu_x = D;                           // X is always D register
    assign alu_y = a_bit ? inM : A;             // Y is A or M[A] depending on a-bit
    
    // ALU instance
    alu alu_inst(
        .x(alu_x),
        .y(alu_y),
        .zx(comp[5]),
        .nx(comp[4]),
        .zy(comp[3]),
        .ny(comp[2]),
        .f(comp[1]),
        .no(comp[0]),
        .out(alu_out),
        .zr(alu_zr),
        .ng(alu_ng)
    );
    
    // Control logic for A register
    // Load A if: (1) A-instruction, or (2) C-instruction with dest[2] (d1) set
    assign load_a = is_a_inst | (is_c_inst & dest[2]);
    
    // A register
    always @(posedge clk) begin
        if (reset) begin
            A <= 16'h0000;
        end else if (load_a) begin
            if (is_a_inst)
                A <= instruction;  // A-instruction: load value
            else
                A <= alu_out;      // C-instruction: load ALU output
        end
    end
    
    // Control logic for D register
    // Load D if: C-instruction with dest[1] (d2) set
    assign load_d = is_c_inst & dest[1];
    
    // D register
    always @(posedge clk) begin
        if (reset) begin
            D <= 16'h0000;
        end else if (load_d) begin
            D <= alu_out;
        end
    end
    
    // Jump logic
    // Determine if we should jump based on ALU flags and jump bits
    wire jlt, jeq, jgt;
    assign jlt = jump[2] & alu_ng;         // j1: jump if < 0
    assign jeq = jump[1] & alu_zr;         // j2: jump if == 0
    assign jgt = jump[0] & (~alu_ng & ~alu_zr);  // j3: jump if > 0
    
    assign do_jump = is_c_inst & (jlt | jeq | jgt);
    assign inc_pc = ~do_jump;
    assign load_pc = do_jump;
    
    // Program Counter
    PC pc_inst(
        .clk(clk),
        .reset(reset),
        .load(load_pc),
        .inc(inc_pc),
        .in(A),
        .out(PC_out)
    );
    
    // Outputs
    assign outM = alu_out;                      // Data to write to memory
    assign writeM = is_c_inst & dest[0];        // Write to M if C-instruction with dest[0] (d3) set
    assign addressM = A[14:0];                  // Memory address from A register
    assign pc = PC_out[14:0];                   // Program counter (15-bit address)

endmodule
