`timescale 1ns/1ps

module tb_halfadder;
    reg a, b;
    wire sum, carry;
    
    halfadder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );
    
    initial begin
        $display("Testando Half Adder");
        $display("Time\ta\tb\tsum\tcarry");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, a, b, sum, carry);
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $display("\nTeste Half Adder concluído!");
        $finish;
    end
endmodule
