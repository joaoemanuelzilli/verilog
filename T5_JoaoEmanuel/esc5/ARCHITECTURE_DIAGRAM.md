# Diagrama da Arquitetura - Projeto 5

## Visão Geral do Sistema

```
┌─────────────────────────────────────────────────────────────────────┐
│                         COMPUTER.V                                  │
│                                                                     │
│  ┌────────────────────┐                                            │
│  │     ROM32K         │  instruction[15:0]                         │
│  │  (Instruction      │─────────────┐                              │
│  │   Memory)          │             │                              │
│  │                    │             │                              │
│  │  Carrega programas │             ↓                              │
│  │  em código de      │    ┌─────────────────────────┐            │
│  │  máquina Hack      │    │        CPU.V            │            │
│  └────────────────────┘    │                         │            │
│           ↑                │  ┌────┐  ┌────┐  ┌────┐│            │
│           │                │  │ A  │  │ D  │  │ PC ││            │
│           │  pc[14:0]      │  │Reg │  │Reg │  │    ││            │
│           └────────────────│  └─┬──┘  └─┬──┘  └──┬─┘│            │
│                            │    │       │        │  │            │
│                            │    └───┬───┘        │  │            │
│                            │        ↓            │  │            │
│                            │    ┌────────┐       │  │            │
│                            │    │  ALU   │       │  │            │
│                            │    │(Proj 2)│       │  │            │
│                            │    └────────┘       │  │            │
│                            │                     │  │            │
│                            └─────────────────────┘  │            │
│                                     │               │            │
│                          outM[15:0] │ writeM       │            │
│                          addressM[14:0]            │            │
│                                     │               │            │
│                                     ↓               ↓            │
│                            ┌──────────────────────────┐          │
│                            │      MEMORY.V            │          │
│                            │                          │          │
│       inM[15:0]           │  ┌─────────────────────┐ │          │
│           ↑                │  │     RAM16K          │ │          │
│           │                │  │  0x0000 - 0x3FFF   │ │          │
│           │                │  │  (16384 words)     │ │          │
│           │                │  └─────────────────────┘ │          │
│           │                │                          │          │
│           │                │  ┌─────────────────────┐ │          │
│           │                │  │     Screen          │ │          │
│           │                │  │  0x4000 - 0x5FFF   │ │          │
│           │                │  │  (8192 words)      │ │          │
│           │                │  │  512×256 pixels    │ │          │
│           │                │  └─────────────────────┘ │          │
│           │                │                          │          │
│           │                │  ┌─────────────────────┐ │          │
│           └────────────────│  │     Keyboard        │ │          │
│                            │  │     0x6000          │ │          │
│                            │  │     (1 word)        │ │          │
│                            │  └─────────────────────┘ │          │
│                            └──────────────────────────┘          │
└─────────────────────────────────────────────────────────────────────┘
```

## Fluxo de Execução de Instruções

```
┌─────────────────────────────────────────────────────────────────┐
│                    CICLO DE INSTRUÇÃO                           │
└─────────────────────────────────────────────────────────────────┘

1. FETCH (Busca)
   ┌────────┐
   │   PC   │──────→ ROM32K[PC] ──────→ instruction
   └────────┘
      │
      └──────→ PC = PC + 1 (ou jump)


2. DECODE (Decodificação)
   ┌──────────────────────────────────┐
   │  instruction[15:0]               │
   │                                  │
   │  bit 15: A-inst (0) / C-inst (1) │
   │  bit 12: a (A/M select)          │
   │  bits 11-6: comp (ALU control)   │
   │  bits 5-3: dest (destination)    │
   │  bits 2-0: jump (jump condition) │
   └──────────────────────────────────┘


3. EXECUTE (Execução)

   A-Instruction (@value):
   ┌─────────────────────┐
   │  A ← value          │
   └─────────────────────┘

   C-Instruction (dest=comp;jump):
   ┌──────────────────────────┐
   │  1. Compute: ALU(D, A/M) │
   │  2. Store: dest ← result │
   │  3. Jump: check condition│
   └──────────────────────────┘
```

## Exemplo: Execução de "D=D+A"

```
Instrução: 1110 0000 10 010 000
           │││└─┬──┘ │  └┬┘ └┬┘
           │││  │     │   │   └─ jump = 000 (no jump)
           │││  │     │   └───── dest = 010 (D register)
           │││  │     └───────── a = 0 (use A, not M)
           │││  └─────────────── comp = 000010 (D+A operation)
           ││└────────────────── C-instruction bits
           │└─────────────────── C-instruction
           └──────────────────── C-instruction

Passo a passo:
┌──────────────────────────────────────────┐
│ Cycle N:                                 │
│   PC = 5                                 │
│   A = 10                                 │
│   D = 5                                  │
├──────────────────────────────────────────┤
│ 1. Fetch: instruction ← ROM[5]           │
│    instruction = 0xE090 (D=D+A)          │
│                                          │
│ 2. Decode:                               │
│    is_c_inst = 1                         │
│    a_bit = 0 → use A register            │
│    comp = 000010 → D+A                   │
│    dest = 010 → store in D               │
│    jump = 000 → no jump                  │
│                                          │
│ 3. Execute:                              │
│    alu_x = D = 5                         │
│    alu_y = A = 10                        │
│    alu_out = 5 + 10 = 15                 │
│    D ← 15                                │
│    PC ← PC + 1 = 6                       │
└──────────────────────────────────────────┘
```

## Instruções Suportadas

### A-Instruction: @value
```
┌─────────────────────────────────┐
│ 0 vvv vvvv vvvv vvvv             │
│   └──────┬──────────┘            │
│      15-bit value                │
│                                  │
│ Efeito: A ← value                │
└─────────────────────────────────┘
```

### C-Instruction: dest=comp;jump
```
┌─────────────────────────────────────────────┐
│ 1 1 1 a cc cccc ddd jjj                     │
│       │ └──┬──┘ └┬┘ └┬┘                     │
│       │    │     │   └─ jump bits           │
│       │    │     └───── dest bits           │
│       │    └─────────── comp bits (ALU)     │
│       └──────────────── a-bit (A/M select)  │
│                                             │
│ comp (6 bits): zx nx zy ny f no             │
│   - zx: zero X                              │
│   - nx: negate X                            │
│   - zy: zero Y                              │
│   - ny: negate Y                            │
│   - f:  function (1=add, 0=and)             │
│   - no: negate output                       │
│                                             │
│ dest (3 bits): A D M                        │
│   - bit 2: store in A                       │
│   - bit 1: store in D                       │
│   - bit 0: store in M[A]                    │
│                                             │
│ jump (3 bits): < = >                        │
│   - bit 2: jump if negative                 │
│   - bit 1: jump if zero                     │
│   - bit 0: jump if positive                 │
└─────────────────────────────────────────────┘
```

## Exemplos de Programas

### Programa 1: Adição (2 + 3)
```
Address | Binary           | Assembly | Descrição
--------|------------------|----------|------------------
   0    | 0000000000000010 | @2       | A = 2
   1    | 1110110000010000 | D=A      | D = 2
   2    | 0000000000000011 | @3       | A = 3
   3    | 1110000010010000 | D=D+A    | D = 2 + 3 = 5
   4    | 0000000000000000 | @0       | A = 0
   5    | 1110001100001000 | M=D      | RAM[0] = 5
   6    | 0000000000000110 | @6       | A = 6
   7    | 1110101010000111 | 0;JMP    | goto 6 (loop)
```

### Programa 2: Máximo
```
# Calcula max(RAM[0], RAM[1]) → RAM[2]

@0      # A = 0
D=M     # D = RAM[0]
@1      # A = 1
D=D-M   # D = RAM[0] - RAM[1]
@10     # A = 10
D;JGT   # if (D > 0) goto 10
@1      # A = 1
D=M     # D = RAM[1]
@12     # A = 12
0;JMP   # goto 12
@0      # (address 10) A = 0
D=M     # D = RAM[0]
@2      # (address 12) A = 2
M=D     # RAM[2] = D
@14     # A = 14
0;JMP   # goto 14 (loop)
```

## Referência Rápida de Instruções

| Instrução Assembly | Binário | Descrição |
|--------------------|---------|-----------|
| @value | 0vvvvvvvvvvvvvvv | A ← value |
| D=A | 1110110000010000 | D ← A |
| D=M | 1111110000010000 | D ← M[A] |
| A=D | 1110001100100000 | A ← D |
| M=D | 1110001100001000 | M[A] ← D |
| D=D+A | 1110000010010000 | D ← D + A |
| D=D+M | 1111000010010000 | D ← D + M[A] |
| D=D-A | 1110010011010000 | D ← D - A |
| D=D-M | 1111010011010000 | D ← D - M[A] |
| D=D&A | 1110000000010000 | D ← D & A |
| D=D\|A | 1110010101010000 | D ← D \| A |
| D=!D | 1110001101010000 | D ← !D |
| D=D+1 | 1110011111010000 | D ← D + 1 |
| D=D-1 | 1110001110010000 | D ← D - 1 |
| 0;JMP | 1110101010000111 | goto A (unconditional) |
| D;JGT | 1110001100000001 | if (D > 0) goto A |
| D;JEQ | 1110001100000010 | if (D == 0) goto A |
| D;JGE | 1110001100000011 | if (D >= 0) goto A |
| D;JLT | 1110001100000100 | if (D < 0) goto A |
| D;JNE | 1110001100000101 | if (D != 0) goto A |
| D;JLE | 1110001100000110 | if (D <= 0) goto A |
