# Componentes Aritméticos em Verilog

Implementação de componentes aritméticos baseados no projeto 2 do Nand2Tetris.

## Componentes

### halfadder.v
Meio somador de 1 bit. Recebe duas entradas e produz soma e carry.

### fulladder.v
Somador completo de 1 bit. Recebe três entradas (a, b, carry-in) e produz soma e carry-out.

### add16.v
Somador de 16 bits. Realiza adição de dois números de 16 bits.

### inc16.v
Incrementador de 16 bits. Adiciona 1 a um número de 16 bits.

### alu.v
Arithmetic Logic Unit do Hack Computer. Realiza operações aritméticas e lógicas baseadas em sinais de controle.

## Estrutura

Cada componente possui:
- Arquivo de implementação: `<nome>.v`
- Arquivo de teste: `tb_<nome>.v`

## Requisitos

- Icarus Verilog (iverilog)
- VVP (simulador Verilog)

Instalação no Ubuntu/Debian:
```bash
sudo apt-get install iverilog
```

## Como Usar

### Opção 1: Script Shell

Executar todos os testes:
```bash
chmod +x test_all.sh
./test_all.sh
```

### Opção 2: Makefile

Testar todos:
```bash
make
```

Testar componente específico:
```bash
make halfadder
make alu
```

Limpar arquivos gerados:
```bash
make clean
```

Ver ajuda:
```bash
make help
```

### Opção 3: Teste Manual

Para testar individualmente:
```bash
iverilog -o test_halfadder.out tb_halfadder.v halfadder.v
vvp test_halfadder.out
rm test_halfadder.out
```

## ALU - Sinais de Controle

A ALU aceita os seguintes sinais de controle:
- `zx`: Zero input x
- `nx`: Negate input x
- `zy`: Zero input y
- `ny`: Negate input y
- `f`: Function (1=add, 0=and)
- `no`: Negate output

Saídas:
- `out`: Resultado de 16 bits
- `zr`: Flag zero (1 se out == 0)
- `ng`: Flag negativo (1 se out < 0)

## Validação

Todos os componentes foram testados com múltiplas combinações de entrada para garantir funcionamento correto.
