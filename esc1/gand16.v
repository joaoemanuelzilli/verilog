// AND Gate de 16 bits
// Realiza AND bit a bit entre duas entradas de 16 bits
module gand16(
    input [15:0] a,
    input [15:0] b,
    output [15:0] out
);
    assign out = a & b;
endmodule
