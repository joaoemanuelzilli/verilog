// Test Bench para Multiplexador 2:1 de 16 bits
`timescale 1ns/1ps

module tb_mux16;
    reg [15:0] a, b;
    reg sel;
    wire [15:0] out;
    
    mux16 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        $display("Testando MUX16 2:1");
        $display("Time\ta (hex)\tb (hex)\tsel\tout (hex)");
        $monitor("%0t\t%h\t%h\t%b\t%h", $time, a, b, sel, out);
        
        // Testa com diferentes valores
        a = 16'h1234; b = 16'hABCD; sel = 0; #10;
        a = 16'h1234; b = 16'hABCD; sel = 1; #10;
        a = 16'h0000; b = 16'hFFFF; sel = 0; #10;
        a = 16'h0000; b = 16'hFFFF; sel = 1; #10;
        a = 16'hAAAA; b = 16'h5555; sel = 0; #10;
        a = 16'hAAAA; b = 16'h5555; sel = 1; #10;
        
        $display("\nTeste MUX16 concluído!");
        $finish;
    end
endmodule
