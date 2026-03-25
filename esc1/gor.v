// OR Gate - 2 entradas
// Saída é 1 quando pelo menos uma entrada é 1
module gor(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
