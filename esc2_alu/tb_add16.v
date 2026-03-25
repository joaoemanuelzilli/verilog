`timescale 1ns/1ps

module tb_add16;
    reg [15:0] a, b;
    wire [15:0] out;
    
    add16 uut (
        .a(a),
        .b(b),
        .out(out)
    );
    
    initial begin
        $display("Testando ADD16");
        $display("Time\ta (hex)\tb (hex)\tout (hex)");
        $monitor("%0t\t%h\t%h\t%h", $time, a, b, out);
        
        a = 16'h0000; b = 16'h0000; #10;
        a = 16'h0001; b = 16'h0001; #10;
        a = 16'h1234; b = 16'h5678; #10;
        a = 16'hFFFF; b = 16'h0001; #10;
        a = 16'hAAAA; b = 16'h5555; #10;
        a = 16'h8000; b = 16'h8000; #10;
        a = 16'h7FFF; b = 16'h0001; #10;
        
        $display("\nTeste ADD16 concluído!");
        $finish;
    end
endmodule
