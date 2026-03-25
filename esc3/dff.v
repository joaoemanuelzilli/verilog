`timescale 1ns/1ps

module DFF(
    input  wire clk,
    input  wire d,
    output reg  q
);
    initial q = 1'b0;

    always @(posedge clk) begin
        q <= d;
    end
endmodule
