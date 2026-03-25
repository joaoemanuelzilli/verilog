// Multiplexador 4:1 de 16 bits
// Seleciona uma de 4 entradas de 16 bits baseado em sel[1:0]
module mux4way16(
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [1:0] sel,
    output [15:0] out
);
    assign out = (sel == 2'b00) ? a :
                 (sel == 2'b01) ? b :
                 (sel == 2'b10) ? c : d;
endmodule
