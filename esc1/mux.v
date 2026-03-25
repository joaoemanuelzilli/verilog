// Multiplexador 2:1 de 1 bit
// Se sel = 0, out = a; se sel = 1, out = b
module mux(
    input a,
    input b,
    input sel,
    output out
);
    assign out = sel ? b : a;
endmodule
