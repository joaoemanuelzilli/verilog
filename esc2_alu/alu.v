module alu(
    input [15:0] x,
    input [15:0] y,
    input zx,
    input nx,
    input zy,
    input ny,
    input f,
    input no,
    output [15:0] out,
    output zr,
    output ng
);
    wire [15:0] zx_out, nx_out, zy_out, ny_out, f_out, no_out;
    
    assign zx_out = zx ? 16'b0 : x;
    assign nx_out = nx ? ~zx_out : zx_out;
    
    assign zy_out = zy ? 16'b0 : y;
    assign ny_out = ny ? ~zy_out : zy_out;
    
    assign f_out = f ? (nx_out + ny_out) : (nx_out & ny_out);
    assign no_out = no ? ~f_out : f_out;
    
    assign out = no_out;
    assign zr = (no_out == 16'b0) ? 1'b1 : 1'b0;
    assign ng = no_out[15];
endmodule
