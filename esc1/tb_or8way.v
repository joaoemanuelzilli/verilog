// Test Bench para OR de 8 entradas
`timescale 1ns/1ps

module tb_or8way;
    reg [7:0] in;
    wire out;
    
    or8way uut (
        .in(in),
        .out(out)
    );
    
    initial begin
        $display("Testando OR8WAY");
        $display("Time\tin (bin)\t\tout");
        $monitor("%0t\t%b\t%b", $time, in, out);
        
        // Testa com diferentes valores
        in = 8'b00000000; #10;
        in = 8'b00000001; #10;
        in = 8'b00000010; #10;
        in = 8'b10000000; #10;
        in = 8'b11111111; #10;
        in = 8'b10101010; #10;
        in = 8'b01010101; #10;
        
        $display("\nTeste OR8WAY concluído!");
        $finish;
    end
endmodule
