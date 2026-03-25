// OR Gate de 8 entradas
// Saída é 1 se pelo menos uma das 8 entradas é 1
module or8way(
    input [7:0] in,
    output out
);
    assign out = |in;  // Operador de redução OR
endmodule
