// Test Bench para Demultiplexador 1:4
`timescale 1ns/1ps

module tb_dmux4way;
    reg in;
    reg [1:0] sel;
    wire a, b, c, d;
    
    dmux4way uut (
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );
    
    initial begin
        $display("Testando DMUX4WAY");
        $display("Time\tin\tsel\ta\tb\tc\td");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b", $time, in, sel, a, b, c, d);
        
        // Testa com in = 0
        in = 0;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        
        // Testa com in = 1
        in = 1;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        
        $display("\nTeste DMUX4WAY concluído!");
        $finish;
    end
endmodule
