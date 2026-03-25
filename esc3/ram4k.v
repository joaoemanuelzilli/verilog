`timescale 1ns/1ps

module RAM4K(
    input  wire         clk,
    input  wire         load,
    input  wire [11:0]  address,
    input  wire [15:0]  in,
    output wire [15:0]  out
);
    localparam integer DEPTH = 4096;

    reg [15:0] mem [0:DEPTH-1];
    integer idx;

    initial begin
        for (idx = 0; idx < DEPTH; idx = idx + 1) begin
            mem[idx] = 16'h0000;
        end
    end

    always @(posedge clk) begin
        if (load) begin
            mem[address] <= in;
        end
    end

    assign out = mem[address];
endmodule
