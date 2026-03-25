// AND Gate - 2 entradas
// Saída é 1 apenas quando ambas as entradas são 1
module gand(
    input a,
    input b,
    output out
);
    assign out = a & b;
endmodule
