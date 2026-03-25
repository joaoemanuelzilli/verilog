// Test Bench para Multiplexador 8:1 de 16 bits
`timescale 1ns/1ps

module tb_mux8way16;
    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] out;
    
    mux8way16 uut (
        .a(a), .b(b), .c(c), .d(d),
        .e(e), .f(f), .g(g), .h(h),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        $display("Testando MUX8WAY16");
        $display("Time\tsel\tout");
        $monitor("%0t\t%b\t%h", $time, sel, out);
        
        // Define valores nas entradas
        a = 16'h1111;
        b = 16'h2222;
        c = 16'h3333;
        d = 16'h4444;
        e = 16'h5555;
        f = 16'h6666;
        g = 16'h7777;
        h = 16'h8888;
        
        // Testa todas as seleções
        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10;
        sel = 3'b110; #10;
        sel = 3'b111; #10;
        
        $display("\nTeste MUX8WAY16 concluído!");
        $finish;
    end
endmodule
