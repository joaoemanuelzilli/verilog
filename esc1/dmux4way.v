// Demultiplexador 1:4 de 1 bit
// Direciona a entrada para uma de 4 saídas baseado em sel[1:0]
module dmux4way(
    input in,
    input [1:0] sel,
    output a,
    output b,
    output c,
    output d
);
    assign a = (sel == 2'b00) ? in : 0;
    assign b = (sel == 2'b01) ? in : 0;
    assign c = (sel == 2'b10) ? in : 0;
    assign d = (sel == 2'b11) ? in : 0;
endmodule
