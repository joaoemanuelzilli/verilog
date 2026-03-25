`timescale 1ns/1ps

module tb_dff;
    reg clk;
    reg d;
    wire q;

    DFF dut (
        .clk(clk),
        .d(d),
        .q(q)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        d = 1'b0;
        @(posedge clk);
        #1;
        if (q !== 1'b0) $fatal(1, "DFF failed to reset to 0");

        d = 1'b1;
        @(posedge clk);
        #1;
        if (q !== 1'b1) $fatal(1, "DFF failed to capture 1");

        d = 1'b0;
        @(negedge clk);
        #1;
        if (q !== 1'b1) $fatal(1, "DFF changed without a clock edge");
        @(posedge clk);
        #1;
        if (q !== 1'b0) $fatal(1, "DFF failed to capture 0");

        d = 1'b1;
        @(posedge clk);
        #1;
        if (q !== 1'b1) $fatal(1, "DFF failed to capture trailing 1");

        d = 1'b0;
        @(posedge clk);
        #1;
        if (q !== 1'b0) $fatal(1, "DFF failed final capture");

        $display("tb_dff passed");
        $finish;
    end
endmodule
