`timescale 1ns/1ps

/*
 * Memory Module - Hack Computer Memory System
 * 
 * Memory map:
 * 0x0000 - 0x3FFF (0-16383):     RAM16K (16K words of general-purpose RAM)
 * 0x4000 - 0x5FFF (16384-24575): Screen memory map (8K words = 256 rows x 512 pixels)
 * 0x6000 (24576):                Keyboard memory map (1 word)
 * 
 * The chip has a 15-bit address input (0-32767), but only addresses 0-24576 are used.
 */

module Memory(
    input  wire         clk,
    input  wire         load,         // Write enable
    input  wire [14:0]  address,      // 15-bit address (32K address space)
    input  wire [15:0]  in,          // Data input
    output reg  [15:0]  out          // Data output
);

    // Internal memory components
    wire [15:0] ram_out, screen_out;
    reg  [15:0] keyboard_reg;
    
    // Control signals
    wire load_ram, load_screen;
    wire sel_ram, sel_screen, sel_keyboard;
    
    // Address decoding
    // RAM:      0x0000 - 0x3FFF (address[14] = 0, address[13] = 0)
    // Screen:   0x4000 - 0x5FFF (address[14] = 1, address[13] = 0)
    // Keyboard: 0x6000          (address[14] = 1, address[13] = 1)
    
    assign sel_ram      = (~address[14]);                      // address < 16384
    assign sel_screen   = (address[14] & ~address[13]);        // 16384 <= address < 24576
    assign sel_keyboard = (address[14] & address[13]);         // address >= 24576
    
    assign load_ram     = load & sel_ram;
    assign load_screen  = load & sel_screen;
    
    // RAM16K instance (addresses 0-16383)
    RAM16K ram(
        .clk(clk),
        .load(load_ram),
        .address(address[13:0]),
        .in(in),
        .out(ram_out)
    );
    
    // Screen memory (8K words, addresses 16384-24575)
    Screen screen(
        .clk(clk),
        .load(load_screen),
        .address(address[12:0]),   // 13-bit address for 8K
        .in(in),
        .out(screen_out)
    );
    
    // Keyboard register (read-only at address 24576)
    // In simulation, this will be set by the testbench
    initial keyboard_reg = 16'h0000;
    
    // Output multiplexing
    always @(*) begin
        case ({sel_keyboard, sel_screen, sel_ram})
            3'b001: out = ram_out;
            3'b010: out = screen_out;
            3'b100: out = keyboard_reg;
            default: out = 16'h0000;
        endcase
    end

endmodule


/*
 * Screen Module - 8K words (256 rows x 512 pixels / 16 pixels per word)
 * Memory-mapped screen buffer
 */
module Screen(
    input  wire         clk,
    input  wire         load,
    input  wire [12:0]  address,      // 13-bit address (8K words)
    input  wire [15:0]  in,
    output wire [15:0]  out
);
    localparam integer DEPTH = 8192;  // 8K words
    
    reg [15:0] mem [0:DEPTH-1];
    integer idx;
    
    initial begin
        for (idx = 0; idx < DEPTH; idx = idx + 1) begin
            mem[idx] = 16'h0000;
        end
    end
    
    always @(posedge clk) begin
        if (load && address < DEPTH) begin
            mem[address] <= in;
        end
    end
    
    assign out = (address < DEPTH) ? mem[address] : 16'h0000;
endmodule
