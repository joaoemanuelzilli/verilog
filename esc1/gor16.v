// OR Gate de 16 bits
// Realiza OR bit a bit entre duas entradas de 16 bits
module gor16(
    input [15:0] a,
    input [15:0] b,
    output [15:0] out
);
    assign out = a | b;
endmodule
