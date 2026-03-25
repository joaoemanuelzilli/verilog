// R0 = mul(R1,R2)

@R0
M=0

@R2
D=M
@FIM
D;JLE

(LOOP)
@R2
D=M
@FIM
D;JLE

@R1
D=M
@R0
M=D+M

@R2
M=M-1

@LOOP
0;JMP

(FIM)
@FIM
0;JMP
