`timescale 1ns/1ps

module tb_fulladder;
    reg a, b, c;
    wire sum, carry;
    
    fulladder uut (
        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry)
    );
    
    initial begin
        $display("Testando Full Adder");
        $display("Time\ta\tb\tc\tsum\tcarry");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b", $time, a, b, c, sum, carry);
        
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 0; #10;
        a = 0; b = 1; c = 1; #10;
        a = 1; b = 0; c = 0; #10;
        a = 1; b = 0; c = 1; #10;
        a = 1; b = 1; c = 0; #10;
        a = 1; b = 1; c = 1; #10;
        
        $display("\nTeste Full Adder concluído!");
        $finish;
    end
endmodule
