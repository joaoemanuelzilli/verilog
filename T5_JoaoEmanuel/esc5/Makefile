# Makefile for Hack Computer (Project 5)
# ESC - Estrutura e Simulação de Computadores
# T5 - CPU and Computer Implementation

# Compiler settings
VERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Source directories
ALU_DIR = ../T2_ALU_JoaoEmanuel/esc2_alu
MEM_DIR = ../T3_JoaoEmanuel/esc3

# Include paths
INCLUDES = -I$(ALU_DIR) -I$(MEM_DIR)

# Source files from previous projects
ALU_SRC = $(ALU_DIR)/alu.v
MEM_SRC = $(MEM_DIR)/register.v $(MEM_DIR)/pc.v $(MEM_DIR)/ram16k.v \
          $(MEM_DIR)/bit.v $(MEM_DIR)/dff.v

# Project 5 source files
SRC = Memory.v CPU.v Computer.v

# Test benches
TB_MEMORY = tb_Memory.v
TB_CPU = tb_CPU.v
TB_COMPUTER = tb_Computer.v

# Output files
OUT_MEMORY = memory_test
OUT_CPU = cpu_test
OUT_COMPUTER = computer_test

# VCD files for waveform viewing
VCD_MEMORY = tb_memory.vcd
VCD_CPU = tb_cpu.vcd
VCD_COMPUTER = tb_computer.vcd

# Default target
all: test_all

# Build and run Memory test
memory: $(TB_MEMORY) Memory.v
	@echo "===== Building Memory Test ====="
	$(VERILOG) $(INCLUDES) -o $(OUT_MEMORY) $(MEM_SRC) Memory.v $(TB_MEMORY)
	@echo "===== Running Memory Test ====="
	$(VVP) $(OUT_MEMORY)
	@echo ""

# Build and run CPU test
cpu: $(TB_CPU) CPU.v
	@echo "===== Building CPU Test ====="
	$(VERILOG) $(INCLUDES) -o $(OUT_CPU) $(ALU_SRC) $(MEM_SRC) CPU.v $(TB_CPU)
	@echo "===== Running CPU Test ====="
	$(VVP) $(OUT_CPU)
	@echo ""

# Build and run Computer test
computer: $(TB_COMPUTER) Computer.v
	@echo "===== Building Computer Test ====="
	$(VERILOG) $(INCLUDES) -o $(OUT_COMPUTER) $(ALU_SRC) $(MEM_SRC) $(SRC) $(TB_COMPUTER)
	@echo "===== Running Computer Test ====="
	$(VVP) $(OUT_COMPUTER)
	@echo ""

# Run all tests
test_all: memory cpu computer
	@echo "=========================================="
	@echo "===== All Tests Completed ====="
	@echo "=========================================="

# View waveforms
wave_memory: memory
	$(GTKWAVE) $(VCD_MEMORY) &

wave_cpu: cpu
	$(GTKWAVE) $(VCD_CPU) &

wave_computer: computer
	$(GTKWAVE) $(VCD_COMPUTER) &

# Clean generated files
clean:
	rm -f $(OUT_MEMORY) $(OUT_CPU) $(OUT_COMPUTER)
	rm -f $(VCD_MEMORY) $(VCD_CPU) $(VCD_COMPUTER)
	rm -f *.vcd
	@echo "Cleaned all generated files"

# Help target
help:
	@echo "Makefile for Hack Computer (Project 5)"
	@echo ""
	@echo "Targets:"
	@echo "  all          - Run all tests (default)"
	@echo "  memory       - Build and test Memory module"
	@echo "  cpu          - Build and test CPU module"
	@echo "  computer     - Build and test Computer module"
	@echo "  test_all     - Run all tests"
	@echo "  wave_memory  - View Memory test waveform"
	@echo "  wave_cpu     - View CPU test waveform"
	@echo "  wave_computer- View Computer test waveform"
	@echo "  clean        - Remove all generated files"
	@echo "  help         - Display this help message"

.PHONY: all memory cpu computer test_all clean help wave_memory wave_cpu wave_computer
