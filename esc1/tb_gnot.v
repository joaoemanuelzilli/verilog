// Test Bench para NOT Gate
`timescale 1ns/1ps

module tb_gnot;
    reg in;
    wire out;
    
    gnot uut (
        .in(in),
        .out(out)
    );
    
    initial begin
        $display("Testando NOT Gate");
        $display("Time\tin\tout");
        $monitor("%0t\t%b\t%b", $time, in, out);
        
        // Testa todas as combinações
        in = 0; #10;
        in = 1; #10;
        
        $display("\nTeste NOT concluído!");
        $finish;
    end
endmodule
