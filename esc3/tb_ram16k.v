`timescale 1ns/1ps

module tb_ram16k;
    localparam AW = 14;

    reg clk;
    reg load;
    reg [AW-1:0] address;
    reg [15:0] in;
    wire [15:0] out;

    RAM16K dut (
        .clk(clk),
        .load(load),
        .address(address),
        .in(in),
        .out(out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task write_word(input [AW-1:0] addr, input [15:0] value);
    begin
        address = addr;
        in = value;
        load = 1'b1;
        @(posedge clk);
        #1;
        load = 1'b0;
        @(negedge clk);
    end
    endtask

    task expect_word(input [AW-1:0] addr, input [15:0] value);
    begin
        address = addr;
        #1;
        if (out !== value) $fatal(1, "RAM16K mismatch at %0d: exp=%h got=%h", addr, value, out);
    end
    endtask

    initial begin
        load = 1'b0;
        address = {AW{1'b0}};
        in = 16'h0000;
        repeat (2) @(posedge clk);

        write_word(14'd0,     16'h1111);
        write_word(14'd8191,  16'h2222);
        write_word(14'd16383, 16'h3333);

        expect_word(14'd0,     16'h1111);
        expect_word(14'd8191,  16'h2222);
        expect_word(14'd16383, 16'h3333);
        expect_word(14'd17,    16'h0000);

        $display("tb_ram16k passed");
        $finish;
    end
endmodule
