#!/bin/bash

echo "==========================================="
echo "Testando Componentes Aritméticos em Verilog"
echo "==========================================="
echo ""

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

TOTAL=0
PASSED=0
FAILED=0

test_module() {
    local module_name=$1
    local module_file="${module_name}.v"
    local testbench_file="tb_${module_name}.v"
    
    TOTAL=$((TOTAL + 1))
    
    echo -e "${BLUE}Testando: ${module_name}${NC}"
    
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
    
    iverilog -o "test_${module_name}.out" "$testbench_file" "$module_file" 2>/dev/null
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}  ✗ Erro na compilação${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    vvp "test_${module_name}.out" > "test_${module_name}.log"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}  ✓ Teste passou${NC}"
        PASSED=$((PASSED + 1))
        cat "test_${module_name}.log"
    else
        echo -e "${RED}  ✗ Teste falhou${NC}"
        FAILED=$((FAILED + 1))
        cat "test_${module_name}.log"
    fi
    
    rm -f "test_${module_name}.out"
    
    echo ""
}

if ! command -v iverilog &> /dev/null; then
    echo -e "${RED}Erro: Icarus Verilog (iverilog) não está instalado${NC}"
    echo "Para instalar no Ubuntu/Debian: sudo apt-get install iverilog"
    echo "Para instalar no Fedora: sudo dnf install iverilog"
    exit 1
fi

test_module "halfadder"
test_module "fulladder"
test_module "add16"
test_module "inc16"
test_module "alu"

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
