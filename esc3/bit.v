`timescale 1ns/1ps

module Bit(
    input  wire clk,
    input  wire load,
    input  wire in,
    output wire out
);
    wire stored;
    wire next_value = load ? in : stored;

    DFF storage (
        .clk(clk),
        .d(next_value),
        .q(stored)
    );

    assign out = stored;
endmodule
