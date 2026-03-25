`timescale 1ns/1ps

module PC(
    input  wire        clk,
    input  wire        reset,
    input  wire        load,
    input  wire        inc,
    input  wire [15:0] in,
    output reg  [15:0] out
);
    initial out = 16'h0000;

    always @(posedge clk) begin
        if (reset) begin
            out <= 16'h0000;
        end else if (load) begin
            out <= in;
        end else if (inc) begin
            out <= out + 16'h0001;
        end
    end
endmodule
