// NOT Gate de 16 bits
// Inverte cada bit da entrada
module gnot16(
    input [15:0] in,
    output [15:0] out
);
    assign out = ~in;
endmodule
