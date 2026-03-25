`timescale 1ns/1ps

module tb_ram8;
    localparam AW = 3;

    reg clk;
    reg load;
    reg [AW-1:0] address;
    reg [15:0] in;
    wire [15:0] out;

    RAM8 dut (
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
        if (out !== value) $fatal(1, "RAM8 mismatch at %0d: exp=%h got=%h", addr, value, out);
    end
    endtask

    initial begin
        load = 1'b0;
        address = {AW{1'b0}};
        in = 16'h0000;
        repeat (2) @(posedge clk);

        write_word(3'd0, 16'h00AA);
        write_word(3'd7, 16'h55FF);
        write_word(3'd3, 16'h1234);

        expect_word(3'd0, 16'h00AA);
        expect_word(3'd7, 16'h55FF);
        expect_word(3'd3, 16'h1234);
        expect_word(3'd1, 16'h0000);

        $display("tb_ram8 passed");
        $finish;
    end
endmodule
