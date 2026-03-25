`timescale 1ns/1ps

module Register(
    input  wire        clk,
    input  wire        load,
    input  wire [15:0] in,
    output wire [15:0] out
);
    wire [15:0] bit_out;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_bits
            Bit bit_cell (
                .clk(clk),
                .load(load),
                .in(in[i]),
                .out(bit_out[i])
            );
        end
    endgenerate

    assign out = bit_out;
endmodule
