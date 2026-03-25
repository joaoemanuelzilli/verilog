// Multiplexador 2:1 de 16 bits
// Se sel = 0, out = a; se sel = 1, out = b
module mux16(
    input [15:0] a,
    input [15:0] b,
    input sel,
    output [15:0] out
);
    assign out = sel ? b : a;
endmodule
