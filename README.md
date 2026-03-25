# ESC Studies - Elements of Computer Systems

This repository contains my practical study work for **Elements of Computer Systems** (Nand2Tetris-oriented), developed during the ESC (Computer Structure and Simulation) course.

The project evolves from basic logic gates to a complete Hack computer implementation, and then to an assembler for Hack Assembly.

## Study Scope

The repository is organized by milestones (`esc1`, `esc2_alu`, `esc3`, `T4`, `T5`, `T6`) that mirror the classic hardware-to-software progression:

1. Boolean logic building blocks
2. Arithmetic circuits and ALU
3. Sequential logic and memory hierarchy
4. Hack Assembly programs
5. Full CPU + Computer integration
6. Assembler implementation in Python

## Repository Structure

### `esc1/` - Combinational Logic (Project 1 style)

Implemented in Verilog:
- Basic gates: `gnand`, `gnot`, `gand`, `gor`, `gxor`
- Multi-bit chips: `gnot16`, `gand16`, `gor16`
- MUX/DMUX family: `mux`, `dmux`, `mux16`, `mux4way16`, `mux8way16`, `dmux4way`, `dmux8way`
- Reduction logic: `or8way`

Includes dedicated testbenches (`tb_*.v`), `Makefile`, and `test_all.sh`.

### `esc2_alu/` - Arithmetic Logic (Project 2 style)

Implemented in Verilog:
- `halfadder.v`
- `fulladder.v`
- `add16.v`
- `inc16.v`
- `alu.v` (Hack ALU-compatible control interface)

Includes testbenches, `Makefile`, and `test_all.sh`.

### `esc3/` - Sequential Logic and Memory (Project 3 style)

Implemented in Verilog:
- Primitive storage: `dff.v`, `bit.v`
- Registers and control: `register.v`, `pc.v`
- RAM hierarchy: `ram8.v`, `ram64.v`, `ram512.v`, `ram4k.v`, `ram16k.v`

Includes testbenches and a `Makefile` using a `build/` output directory.

### `T4_JoaoEmanuel/` - Hack Assembly Programs

Assembly routines:
- `mul.asm` (multiplication)
- `div.asm` (integer division)
- `max.asm` (maximum value)
- `avg.asm` (average)

These programs exercise Hack machine-level programming concepts (register usage, loops, branching, arithmetic logic).

### `T5_JoaoEmanuel/esc5/` - CPU and Computer Integration (Project 5 style)

Implemented in Verilog:
- `Memory.v` (RAM16K + Screen + Keyboard mapping)
- `CPU.v` (A/D registers, ALU control, jump logic, PC updates)
- `Computer.v` (CPU + Memory + ROM integration)

Includes:
- Testbenches for each major module
- Waveform dumps (`.vcd`)
- `Makefile` and `test_all.sh`
- Extended docs (`ARCHITECTURE_DIAGRAM.md`, `INDEX.md`, etc.)

### `T6_JoaoEmanuel/` - Hack Assembler (Project 6 style)

Python implementation:
- `assembler.py` (two-pass assembly flow)
- `parser.py`
- `code.py`
- `symbol_table.py`

Translates `.asm` into Hack binary (`.bin`).

## Tooling

Hardware simulation:
- `iverilog`
- `vvp`
- `make`
- Optional: `gtkwave`

Assembler:
- `python3`

## Quick Start

### 1) Run Verilog tests by module

```bash
cd esc1 && make test
cd ../esc2_alu && make
cd ../esc3 && make test
cd ../T5_JoaoEmanuel/esc5 && make all
```

You can also run each folder's `test_all.sh` where available.

### 2) Run the assembler

```bash
cd T6_JoaoEmanuel
python3 assembler.py Add.asm
```

This generates `Add.bin` in the same folder.

## Learning Goals Covered

- Digital logic design from NAND-level abstractions
- Combinational and sequential circuit design in Verilog
- Memory hierarchy and address mapping
- CPU datapath/control integration
- Machine language and low-level assembly programming
- Assembler architecture (parsing, symbol resolution, code generation)

## Academic Context

This repository is part of my **Elements of Computer Systems** studies, with implementations and tests developed as coursework/lab practice.

## Author

Joao Emanuel
