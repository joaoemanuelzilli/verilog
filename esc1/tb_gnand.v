// Test Bench para NAND Gate
`timescale 1ns/1ps

module tb_gnand;
    reg a, b;
    wire out;
    
    gnand uut (
        .a(a),
        .b(b),
        .out(out)
    );
    
    initial begin
        $display("Testando NAND Gate");
        $display("Time\ta\tb\tout");
        $monitor("%0t\t%b\t%b\t%b", $time, a, b, out);
        
        // Testa todas as combinações
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $display("\nTeste NAND concluído!");
        $finish;
    end
endmodule
