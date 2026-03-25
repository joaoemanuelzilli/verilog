// R0 = avg(R1,R2)

@R0
M=0

@R3
M=0

@R2
D=M
@DIV
D;JLE

@i
M=0

(SOMA)
@i
D=M
@R2
D=D-M
@DIV
D;JGE

@R1
D=M
@i
D=D+M
A=D
D=M

@R0
M=D+M

@i
M=M+1

@SOMA
0;JMP

(DIV)
@R2
D=M
@FIM
D;JLE

(LOOP_DIV)
@R0
D=M
@R2
D=D-M
@FIM
D;JLT

@R0
M=D

@R3
M=M+1

@LOOP_DIV
0;JMP

(FIM)
@R3
D=M
@R0
M=D

@FIM
0;JMP
