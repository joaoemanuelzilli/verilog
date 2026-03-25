// Demultiplexador 1:8 de 1 bit
// Direciona a entrada para uma de 8 saídas baseado em sel[2:0]
module dmux8way(
    input in,
    input [2:0] sel,
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g,
    output h
);
    assign a = (sel == 3'b000) ? in : 0;
    assign b = (sel == 3'b001) ? in : 0;
    assign c = (sel == 3'b010) ? in : 0;
    assign d = (sel == 3'b011) ? in : 0;
    assign e = (sel == 3'b100) ? in : 0;
    assign f = (sel == 3'b101) ? in : 0;
    assign g = (sel == 3'b110) ? in : 0;
    assign h = (sel == 3'b111) ? in : 0;
endmodule
