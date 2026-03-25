// Test Bench para Demultiplexador 1:8
`timescale 1ns/1ps

module tb_dmux8way;
    reg in;
    reg [2:0] sel;
    wire a, b, c, d, e, f, g, h;
    
    dmux8way uut (
        .in(in),
        .sel(sel),
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h)
    );
    
    initial begin
        $display("Testando DMUX8WAY");
        $display("Time\tin\tsel\ta\tb\tc\td\te\tf\tg\th");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, in, sel, a, b, c, d, e, f, g, h);
        
        // Testa com in = 0
        in = 0;
        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10;
        sel = 3'b110; #10;
        sel = 3'b111; #10;
        
        // Testa com in = 1
        in = 1;
        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10;
        sel = 3'b110; #10;
        sel = 3'b111; #10;
        
        $display("\nTeste DMUX8WAY concluído!");
        $finish;
    end
endmodule
