`timescale 1ns/1ps

module tb_bit;
    reg clk;
    reg load;
    reg in;
    wire out;

    Bit dut (
        .clk(clk),
        .load(load),
        .in(in),
        .out(out)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        load = 1'b0;
        in = 1'b0;
        @(posedge clk);
        #1;
        if (out !== 1'b0) $fatal(1, "Bit should start at 0");

        in = 1'b1;
        load = 1'b1;
        @(posedge clk);
        load = 1'b0;
        #1;
        if (out !== 1'b1) $fatal(1, "Bit failed to load 1");

        in = 1'b0;
        @(posedge clk);
        #1;
        if (out !== 1'b1) $fatal(1, "Bit lost stored value with load=0");

        load = 1'b1;
        @(posedge clk);
        load = 1'b0;
        #1;
        if (out !== 1'b0) $fatal(1, "Bit failed to load 0");

        $display("tb_bit passed");
        $finish;
    end
endmodule
