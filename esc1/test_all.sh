#!/bin/bash

# Script para compilar e testar todos os gates em Verilog
# Usando Icarus Verilog (iverilog) e vvp

echo "==========================================="
echo "Testando Gates Lógicos em Verilog"
echo "==========================================="
echo ""

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contador de testes
TOTAL=0
PASSED=0
FAILED=0

# Função para testar um gate
test_gate() {
    local gate_name=$1
    local module_file="${gate_name}.v"
    local testbench_file="tb_${gate_name}.v"
    
    TOTAL=$((TOTAL + 1))
    
    echo -e "${BLUE}Testando: ${gate_name}${NC}"
    
    # Verifica se os arquivos existem
    if [ ! -f "$module_file" ]; then
        echo -e "${RED}  ✗ Arquivo $module_file não encontrado${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    if [ ! -f "$testbench_file" ]; then
        echo -e "${RED}  ✗ Arquivo $testbench_file não encontrado${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    # Compila
    iverilog -o "test_${gate_name}.out" "$testbench_file" "$module_file" 2>/dev/null
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}  ✗ Erro na compilação${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    # Executa o teste
    vvp "test_${gate_name}.out" > "test_${gate_name}.log"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}  ✓ Teste passou${NC}"
        PASSED=$((PASSED + 1))
        # Mostra output do teste
        cat "test_${gate_name}.log"
    else
        echo -e "${RED}  ✗ Teste falhou${NC}"
        FAILED=$((FAILED + 1))
        cat "test_${gate_name}.log"
    fi
    
    # Limpa arquivos temporários
    rm -f "test_${gate_name}.out"
    
    echo ""
}

# Verifica se iverilog está instalado
if ! command -v iverilog &> /dev/null; then
    echo -e "${RED}Erro: Icarus Verilog (iverilog) não está instalado${NC}"
    echo "Para instalar no Ubuntu/Debian: sudo apt-get install iverilog"
    echo "Para instalar no Fedora: sudo dnf install iverilog"
    exit 1
fi

# Testa todas as portas básicas de 1 bit
echo "=== Portas Básicas de 1 bit ==="
test_gate "gnand"
test_gate "gnot"
test_gate "gand"
test_gate "gor"
test_gate "gxor"

# Testa MUX e DMUX básicos
echo "=== Multiplexadores e Demultiplexadores Básicos ==="
test_gate "mux"
test_gate "dmux"

# Testa portas de 16 bits
echo "=== Portas de 16 bits ==="
test_gate "gnot16"
test_gate "gand16"
test_gate "gor16"
test_gate "mux16"

# Testa portas multi-way
echo "=== Portas Multi-way ==="
test_gate "or8way"
test_gate "mux4way16"
test_gate "mux8way16"
test_gate "dmux4way"
test_gate "dmux8way"

# Resumo final
echo "=============================="
echo -e "${BLUE}Resumo dos Testes${NC}"
echo "======================"
echo -e "Total de testes: $TOTAL"
echo -e "${GREEN}Passaram: $PASSED${NC}"
echo -e "${RED}Falharam: $FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ Todos os testes passaram!${NC}"
    exit 0
else
    echo -e "${RED}✗ Alguns testes falharam${NC}"
    exit 1
fi
