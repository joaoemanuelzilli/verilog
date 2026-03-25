`timescale 1ns/1ps

module tb_register;
    reg clk;
    reg load;
    reg [15:0] in;
    wire [15:0] out;

    Register dut (
        .clk(clk),
        .load(load),
        .in(in),
        .out(out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task load_value(input [15:0] value);
    begin
        in = value;
        load = 1'b1;
        @(posedge clk);
        load = 1'b0;
    end
    endtask

    initial begin
        load = 1'b0;
        in = 16'h0000;
        @(posedge clk);
        if (out !== 16'h0000) $fatal(1, "Register should start at 0");

        load_value(16'h1234);
        #1;
        if (out !== 16'h1234) $fatal(1, "Register failed to load 16'h1234");

        in = 16'hFFFF;
        @(posedge clk);
        if (out !== 16'h1234) $fatal(1, "Register changed without load");

        load_value(16'hABCD);
        #1;
        if (out !== 16'hABCD) $fatal(1, "Register failed to load 16'hABCD");

        $display("tb_register passed");
        $finish;
    end
endmodule
