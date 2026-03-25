// XOR Gate - 2 entradas
// Saída é 1 quando as entradas são diferentes
module gxor(
    input a,
    input b,
    output out
);
    assign out = a ^ b;
endmodule
