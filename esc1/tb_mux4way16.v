// Test Bench para Multiplexador 4:1 de 16 bits
`timescale 1ns/1ps

module tb_mux4way16;
    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;
    
    mux4way16 uut (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        $display("Testando MUX4WAY16");
        $display("Time\ta\tb\tc\td\tsel\tout");
        $monitor("%0t\t%h\t%h\t%h\t%h\t%b\t%h", $time, a, b, c, d, sel, out);
        
        // Define valores nas entradas
        a = 16'h1111;
        b = 16'h2222;
        c = 16'h3333;
        d = 16'h4444;
        
        // Testa todas as seleções
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        
        // Testa com outros valores
        a = 16'hAAAA;
        b = 16'hBBBB;
        c = 16'hCCCC;
        d = 16'hDDDD;
        
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        
        $display("\nTeste MUX4WAY16 concluído!");
        $finish;
    end
endmodule
