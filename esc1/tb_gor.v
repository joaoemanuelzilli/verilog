// Test Bench para OR Gate
`timescale 1ns/1ps

module tb_gor;
    reg a, b;
    wire out;
    
    gor uut (
        .a(a),
        .b(b),
        .out(out)
    );
    
    initial begin
        $display("Testando OR Gate");
        $display("Time\ta\tb\tout");
        $monitor("%0t\t%b\t%b\t%b", $time, a, b, out);
        
        // Testa todas as combinações
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $display("\nTeste OR concluído!");
        $finish;
    end
endmodule
