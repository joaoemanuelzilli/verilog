`timescale 1ns/1ps

module tb_ram512;
    localparam AW = 9;

    reg clk;
    reg load;
    reg [AW-1:0] address;
    reg [15:0] in;
    wire [15:0] out;

    RAM512 dut (
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
        if (out !== value) $fatal(1, "RAM512 mismatch at %0d: exp=%h got=%h", addr, value, out);
    end
    endtask

    initial begin
        load = 1'b0;
        address = {AW{1'b0}};
        in = 16'h0000;
        repeat (2) @(posedge clk);

        write_word(9'd0,   16'hAAAA);
        write_word(9'd255, 16'hBEEF);
        write_word(9'd511, 16'h1234);

        expect_word(9'd0,   16'hAAAA);
        expect_word(9'd255, 16'hBEEF);
        expect_word(9'd511, 16'h1234);
        expect_word(9'd100, 16'h0000);

        $display("tb_ram512 passed");
        $finish;
    end
endmodule
