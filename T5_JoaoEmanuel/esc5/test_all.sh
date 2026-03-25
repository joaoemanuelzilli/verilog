#!/bin/bash
# Test script for Hack Computer (Project 5)
# ESC - Estrutura e Simulação de Computadores

echo "=========================================="
echo "= Hack Computer Test Suite (Project 5) ="
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name=$1
    local make_target=$2
    
    echo ""
    echo "${YELLOW}Running ${test_name}...${NC}"
    echo "----------------------------------------"
    
    if make ${make_target} > /tmp/test_output.txt 2>&1; then
        # Check if there were any FAIL messages
        if grep -q "FAIL" /tmp/test_output.txt; then
            echo "${RED}✗ ${test_name} FAILED${NC}"
            cat /tmp/test_output.txt
            TESTS_FAILED=$((TESTS_FAILED + 1))
        else
            echo "${GREEN}✓ ${test_name} PASSED${NC}"
            grep "PASS\|INFO" /tmp/test_output.txt
            TESTS_PASSED=$((TESTS_PASSED + 1))
        fi
    else
        echo "${RED}✗ ${test_name} COMPILATION FAILED${NC}"
        cat /tmp/test_output.txt
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Change to script directory
cd "$(dirname "$0")"

# Clean previous builds
echo "Cleaning previous builds..."
make clean > /dev/null 2>&1

# Run tests
run_test "Memory Test" "memory"
run_test "CPU Test" "cpu"
run_test "Computer Test" "computer"

# Summary
echo ""
echo "=========================================="
echo "= Test Summary ="
echo "=========================================="
echo "${GREEN}Passed: ${TESTS_PASSED}${NC}"
echo "${RED}Failed: ${TESTS_FAILED}${NC}"
echo "Total:  $((TESTS_PASSED + TESTS_FAILED))"
echo ""

# Exit with error code if any tests failed
if [ ${TESTS_FAILED} -gt 0 ]; then
    echo "${RED}Some tests failed. Please review the output above.${NC}"
    exit 1
else
    echo "${GREEN}All tests passed!${NC}"
    exit 0
fi
