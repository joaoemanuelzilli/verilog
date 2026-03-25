`timescale 1ns/1ps

module tb_alu;
    reg [15:0] x, y;
    reg zx, nx, zy, ny, f, no;
    wire [15:0] out;
    wire zr, ng;
    
    alu uut (
        .x(x),
        .y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(out),
        .zr(zr),
        .ng(ng)
    );
    
    initial begin
        $display("Testando ALU");
        $display("Time\tx\ty\tzx\tnx\tzy\tny\tf\tno\tout\tzr\tng");
        $monitor("%0t\t%h\t%h\t%b\t%b\t%b\t%b\t%b\t%b\t%h\t%b\t%b", 
                 $time, x, y, zx, nx, zy, ny, f, no, out, zr, ng);
        
        x = 16'h0000; y = 16'hFFFF;
        
        zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0; #10;
        zx = 1; nx = 1; zy = 1; ny = 1; f = 1; no = 1; #10;
        zx = 1; nx = 1; zy = 1; ny = 0; f = 1; no = 0; #10;
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 0; #10;
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 0; #10;
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 1; #10;
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 1; #10;
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 1; #10;
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 1; #10;
        zx = 0; nx = 1; zy = 1; ny = 1; f = 1; no = 1; #10;
        zx = 1; nx = 1; zy = 0; ny = 1; f = 1; no = 1; #10;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0; #10;
        zx = 0; nx = 1; zy = 0; ny = 0; f = 1; no = 1; #10;
        zx = 0; nx = 0; zy = 0; ny = 1; f = 1; no = 1; #10;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0; #10;
        zx = 0; nx = 1; zy = 0; ny = 1; f = 0; no = 1; #10;
        
        x = 16'h1234; y = 16'h5678;
        
        zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0; #10;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0; #10;
        zx = 0; nx = 1; zy = 0; ny = 1; f = 0; no = 1; #10;
        
        $display("\nTeste ALU concluído!");
        $finish;
    end
endmodule
