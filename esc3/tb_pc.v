`timescale 1ns/1ps

module tb_pc;
    reg clk;
    reg reset;
    reg load;
    reg inc;
    reg [15:0] in;
    wire [15:0] out;

    PC dut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .inc(inc),
        .in(in),
        .out(out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task check_output(input [15:0] expected, input [255:0] message);
    begin
        #1;
        if (out !== expected) $fatal(1, "%s: exp=%h got=%h", message, expected, out);
    end
    endtask

    initial begin
        reset = 1'b1;
        load = 1'b0;
        inc = 1'b0;
        in = 16'h0000;

        @(posedge clk);
        reset = 1'b0;
        check_output(16'h0000, "After reset release");

        inc = 1'b1;
        repeat (3) @(posedge clk);
        #1;
        inc = 1'b0;
        check_output(16'h0003, "After three increments");

        in = 16'h1234;
        load = 1'b1;
        @(posedge clk);
        #1;
        load = 1'b0;
        check_output(16'h1234, "After load");

        inc = 1'b1;
        @(posedge clk);
        #1;
        inc = 1'b0;
        check_output(16'h1235, "After increment following load");

        reset = 1'b1;
        @(posedge clk);
        #1;
        reset = 1'b0;
        check_output(16'h0000, "After reset pulse");

        $display("tb_pc passed");
        $finish;
    end
endmodule
