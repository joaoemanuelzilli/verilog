`timescale 1ns/1ps

module debug_test;
    reg clk, reset;
    reg [15:0] inM, instruction;
    wire [15:0] outM;
    wire writeM;
    wire [14:0] addressM, pc;
    
    CPU uut(.clk(clk), .reset(reset), .inM(inM), .instruction(instruction),
            .outM(outM), .writeM(writeM), .addressM(addressM), .pc(pc));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        reset = 1; inM = 0; instruction = 0;
        #20 reset = 0;
        
        // @5
        #10 instruction = 16'b0000000000000101;
        #10 $display("After @5: A=%d, D=%d", addressM, uut.D);
        
        // D=A
        #10 instruction = 16'b1110110000010000;
        #10 $display("After D=A: A=%d, D=%d", addressM, uut.D);
        
        // @10
        #10 instruction = 16'b0000000000001010;
        #10 $display("After @10: A=%d, D=%d", addressM, uut.D);
        
        // D=D+A (should be 5+10=15)
        #10 instruction = 16'b1110000010010000;
        #10 $display("After D=D+A: A=%d, D=%d, ALU_out=%d", addressM, uut.D, uut.alu_out);
        
        #10 $finish;
    end
endmodule
