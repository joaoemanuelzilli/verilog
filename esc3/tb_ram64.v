`timescale 1ns/1ps

module tb_ram64;
    localparam AW = 6;

    reg clk;
    reg load;
    reg [AW-1:0] address;
    reg [15:0] in;
    wire [15:0] out;

    RAM64 dut (
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
        if (out !== value) $fatal(1, "RAM64 mismatch at %0d: exp=%h got=%h", addr, value, out);
    end
    endtask

    initial begin
        load = 1'b0;
        address = {AW{1'b0}};
        in = 16'h0000;
        repeat (2) @(posedge clk);

        write_word(6'd0, 16'h0F0F);
        write_word(6'd42, 16'hAAAA);
        write_word(6'd63, 16'h1357);

        expect_word(6'd0, 16'h0F0F);
        expect_word(6'd42, 16'hAAAA);
        expect_word(6'd63, 16'h1357);
        expect_word(6'd10, 16'h0000);

        $display("tb_ram64 passed");
        $finish;
    end
endmodule
