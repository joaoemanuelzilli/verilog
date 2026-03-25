// Test Bench para XOR Gate
`timescale 1ns/1ps

module tb_gxor;
    reg a, b;
    wire out;
    
    gxor uut (
        .a(a),
        .b(b),
        .out(out)
    );
    
    initial begin
        $display("Testando XOR Gate");
        $display("Time\ta\tb\tout");
        $monitor("%0t\t%b\t%b\t%b", $time, a, b, out);
        
        // Testa todas as combinações
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $display("\nTeste XOR concluído!");
        $finish;
    end
endmodule
