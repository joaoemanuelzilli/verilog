module fulladder(
    input a,
    input b,
    input c,
    output sum,
    output carry
);
    wire sum1, carry1, carry2;
    
    assign sum1 = a ^ b;
    assign carry1 = a & b;
    assign sum = sum1 ^ c;
    assign carry2 = sum1 & c;
    assign carry = carry1 | carry2;
endmodule
