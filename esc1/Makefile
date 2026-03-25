# Makefile para compilar e testar gates Verilog
# Usa Icarus Verilog (iverilog)

# Compilador e simulador
VERILOG = iverilog
VVP = vvp

# Lista de todos os gates
GATES = gnand gnot gand gor gxor mux dmux \
        gnot16 gand16 gor16 mux16 \
        or8way mux4way16 mux8way16 dmux4way dmux8way

# Arquivos de teste
TEST_OUTPUTS = $(patsubst %, test_%.out, $(GATES))
TEST_LOGS = $(patsubst %, test_%.log, $(GATES))

# Cores
GREEN = \033[0;32m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m

.PHONY: all test clean help

# Alvo padrão
all: test

# Testa todos os gates
test: $(GATES)
	@echo ""
	@echo "$(BLUE)=========================================$(NC)"
	@echo "$(GREEN)Todos os testes foram executados!$(NC)"
	@echo "$(BLUE)=========================================$(NC)"

# Regra genérica para testar cada gate
$(GATES): %:
	@echo "$(BLUE)Testando: $@$(NC)"
	@$(VERILOG) -o test_$@.out tb_$@.v $@.v 2>/dev/null
	@$(VVP) test_$@.out > test_$@.log
	@cat test_$@.log
	@echo ""

# Testa apenas portas básicas
test-basic: gnand gnot gand gor gxor
	@echo "$(GREEN)Portas básicas testadas$(NC)"

# Testa apenas mux/dmux básicos
test-mux-dmux: mux dmux
	@echo "$(GREEN)MUX/DMUX básicos testados$(NC)"

# Testa apenas portas de 16 bits
test-16bit: gnot16 gand16 gor16 mux16
	@echo "$(GREEN)Portas de 16 bits testadas$(NC)"

# Testa apenas portas multi-way
test-multiway: or8way mux4way16 mux8way16 dmux4way dmux8way
	@echo "$(GREEN)Portas multi-way testadas$(NC)"

# Limpa arquivos gerados
clean:
	@echo "$(BLUE)Limpando arquivos gerados...$(NC)"
	@rm -f $(TEST_OUTPUTS) $(TEST_LOGS)
	@rm -f *.vcd
	@echo "$(GREEN)Limpeza concluída$(NC)"

# Mostra ajuda
help:
	@echo "Makefile para testar gates Verilog"
	@echo ""
	@echo "Uso:"
	@echo "  make              - Testa todos os gates"
	@echo "  make test         - Testa todos os gates"
	@echo "  make test-basic   - Testa apenas portas básicas"
	@echo "  make test-mux-dmux - Testa apenas MUX/DMUX básicos"
	@echo "  make test-16bit   - Testa apenas portas de 16 bits"
	@echo "  make test-multiway - Testa apenas portas multi-way"
	@echo "  make <gate>       - Testa um gate específico (ex: make gnand)"
	@echo "  make clean        - Remove arquivos gerados"
	@echo "  make help         - Mostra esta ajuda"
	@echo ""
	@echo "Gates disponíveis:"
	@echo "  $(GATES)"
