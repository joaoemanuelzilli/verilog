// Test Bench para NOT Gate de 16 bits
`timescale 1ns/1ps

module tb_gnot16;
    reg [15:0] in;
    wire [15:0] out;
    
    gnot16 uut (
        .in(in),
        .out(out)
    );
    
    initial begin
        $display("Testando NOT16 Gate");
        $display("Time\tin (hex)\t\tout (hex)");
        $monitor("%0t\t%h\t\t%h", $time, in, out);
        
        // Testa com diferentes valores
        in = 16'h0000; #10;
        in = 16'hFFFF; #10;
        in = 16'hAAAA; #10;
        in = 16'h5555; #10;
        in = 16'h1234; #10;
        in = 16'hABCD; #10;
        
        $display("\nTeste NOT16 concluído!");
        $finish;
    end
endmodule
