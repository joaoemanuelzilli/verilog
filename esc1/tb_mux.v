// Test Bench para Multiplexador 2:1
`timescale 1ns/1ps

module tb_mux;
    reg a, b, sel;
    wire out;
    
    mux uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        $display("Testando MUX 2:1");
        $display("Time\ta\tb\tsel\tout");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, a, b, sel, out);
        
        // Testa todas as combinações
        a = 0; b = 0; sel = 0; #10;
        a = 0; b = 1; sel = 0; #10;
        a = 1; b = 0; sel = 0; #10;
        a = 1; b = 1; sel = 0; #10;
        a = 0; b = 0; sel = 1; #10;
        a = 0; b = 1; sel = 1; #10;
        a = 1; b = 0; sel = 1; #10;
        a = 1; b = 1; sel = 1; #10;
        
        $display("\nTeste MUX concluído!");
        $finish;
    end
endmodule
