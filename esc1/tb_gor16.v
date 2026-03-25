// Test Bench para OR Gate de 16 bits
`timescale 1ns/1ps

module tb_gor16;
    reg [15:0] a, b;
    wire [15:0] out;
    
    gor16 uut (
        .a(a),
        .b(b),
        .out(out)
    );
    
    initial begin
        $display("Testando OR16 Gate");
        $display("Time\ta (hex)\tb (hex)\tout (hex)");
        $monitor("%0t\t%h\t%h\t%h", $time, a, b, out);
        
        // Testa com diferentes valores
        a = 16'h0000; b = 16'h0000; #10;
        a = 16'hFFFF; b = 16'hFFFF; #10;
        a = 16'hFFFF; b = 16'h0000; #10;
        a = 16'hAAAA; b = 16'h5555; #10;
        a = 16'h1234; b = 16'hABCD; #10;
        a = 16'hF0F0; b = 16'h0F0F; #10;
        
        $display("\nTeste OR16 concluído!");
        $finish;
    end
endmodule
