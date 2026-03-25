// Test Bench para AND Gate
`timescale 1ns/1ps

module tb_gand;
    reg a, b;
    wire out;
    
    gand uut (
        .a(a),
        .b(b),
        .out(out)
    );
    
    initial begin
        $display("Testando AND Gate");
        $display("Time\ta\tb\tout");
        $monitor("%0t\t%b\t%b\t%b", $time, a, b, out);
        
        // Testa todas as combinações
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $display("\nTeste AND concluído!");
        $finish;
    end
endmodule
