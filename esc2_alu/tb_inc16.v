`timescale 1ns/1ps

module tb_inc16;
    reg [15:0] in;
    wire [15:0] out;
    
    inc16 uut (
        .in(in),
        .out(out)
    );
    
    initial begin
        $display("Testando INC16");
        $display("Time\tin (hex)\tout (hex)");
        $monitor("%0t\t%h\t%h", $time, in, out);
        
        in = 16'h0000; #10;
        in = 16'h0001; #10;
        in = 16'h000F; #10;
        in = 16'h00FF; #10;
        in = 16'hFFFF; #10;
        in = 16'h1234; #10;
        in = 16'h7FFF; #10;
        
        $display("\nTeste INC16 concluído!");
        $finish;
    end
endmodule
