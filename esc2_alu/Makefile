VERILOG = iverilog
VVP = vvp

MODULES = halfadder fulladder add16 inc16 alu

TEST_OUTPUTS = $(patsubst %, test_%.out, $(MODULES))
TEST_LOGS = $(patsubst %, test_%.log, $(MODULES))

GREEN = \033[0;32m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m

.PHONY: all test clean help

all: test

test: $(MODULES)
	@echo ""
	@echo "$(BLUE)=========================================$(NC)"
	@echo "$(GREEN)Todos os testes foram executados!$(NC)"
	@echo "$(BLUE)=========================================$(NC)"

$(MODULES): %:
	@echo "$(BLUE)Testando: $@$(NC)"
	@$(VERILOG) -o test_$@.out tb_$@.v $@.v 2>/dev/null
	@$(VVP) test_$@.out > test_$@.log
	@cat test_$@.log
	@echo ""

clean:
	@echo "$(BLUE)Limpando arquivos gerados...$(NC)"
	@rm -f $(TEST_OUTPUTS) $(TEST_LOGS)
	@rm -f *.vcd
	@echo "$(GREEN)Limpeza concluída$(NC)"

help:
	@echo "Makefile para testar componentes aritméticos em Verilog"
	@echo ""
	@echo "Uso:"
	@echo "  make              - Testa todos os componentes"
	@echo "  make test         - Testa todos os componentes"
	@echo "  make <componente> - Testa um componente específico"
	@echo "  make clean        - Remove arquivos gerados"
	@echo "  make help         - Mostra esta ajuda"
	@echo ""
	@echo "Componentes disponíveis:"
	@echo "  $(MODULES)"
