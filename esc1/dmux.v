// Demultiplexador 1:2 de 1 bit
// Se sel = 0, a = in e b = 0; se sel = 1, a = 0 e b = in
module dmux(
    input in,
    input sel,
    output a,
    output b
);
    assign a = (sel == 0) ? in : 0;
    assign b = (sel == 1) ? in : 0;
endmodule
