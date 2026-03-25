// NAND Gate - 2 entradas
// Saída é 0 apenas quando ambas as entradas são 1
module gnand(
    input a,
    input b,
    output out
);
    assign out = ~(a & b);
endmodule
