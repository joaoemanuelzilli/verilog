// Test Bench para Demultiplexador 1:2
`timescale 1ns/1ps

module tb_dmux;
    reg in, sel;
    wire a, b;
    
    dmux uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b)
    );
    
    initial begin
        $display("Testando DMUX 1:2");
        $display("Time\tin\tsel\ta\tb");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, in, sel, a, b);
        
        // Testa todas as combinações
        in = 0; sel = 0; #10;
        in = 1; sel = 0; #10;
        in = 0; sel = 1; #10;
        in = 1; sel = 1; #10;
        
        $display("\nTeste DMUX concluído!");
        $finish;
    end
endmodule
