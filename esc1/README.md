# Projeto de Gates Lógicos em Verilog

Este projeto implementa gates lógicos elementares em Verilog, baseado no projeto 1 do curso Nand2Tetris.

## 📋 Conteúdo

### Portas Básicas de 1 bit
- **gnand.v** - NAND gate de 2 entradas
- **gnot.v** - NOT gate de 1 entrada
- **gand.v** - AND gate de 2 entradas
- **gor.v** - OR gate de 2 entradas
- **gxor.v** - XOR gate de 2 entradas

### Multiplexadores e Demultiplexadores Básicos
- **mux.v** - Multiplexador 2:1 de 1 bit
- **dmux.v** - Demultiplexador 1:2 de 1 bit

### Portas de 16 bits
- **gnot16.v** - NOT gate de 16 bits
- **gand16.v** - AND gate de 16 bits
- **gor16.v** - OR gate de 16 bits
- **mux16.v** - Multiplexador 2:1 de 16 bits

### Portas Multi-way
- **or8way.v** - OR gate com 8 entradas
- **mux4way16.v** - Multiplexador 4:1 de 16 bits
- **mux8way16.v** - Multiplexador 8:1 de 16 bits
- **dmux4way.v** - Demultiplexador 1:4 de 1 bit
- **dmux8way.v** - Demultiplexador 1:8 de 1 bit

## 🧪 Test Benches

Cada gate possui um test bench correspondente com o prefixo `tb_`:
- `tb_gnand.v`, `tb_gnot.v`, `tb_gand.v`, etc.

Os test benches testam todas as combinações possíveis de entradas e exibem os resultados.

## 🛠️ Requisitos

- **Icarus Verilog** (iverilog) - Compilador Verilog
- **VVP** - Simulador Verilog (incluído com Icarus Verilog)

### Instalação

**Ubuntu/Debian:**
```bash
sudo apt-get install iverilog
```

**Fedora:**
```bash
sudo dnf install iverilog
```

**macOS:**
```bash
brew install icarus-verilog
```

## 🚀 Como Usar

### Opção 1: Script Shell

Execute todos os testes de uma vez:
```bash
./test_all.sh
```

### Opção 2: Makefile

Execute todos os testes:
```bash
make
```

ou

```bash
make test
```

Teste grupos específicos:
```bash
make test-basic      # Testa apenas portas básicas
make test-mux-dmux   # Testa apenas MUX/DMUX básicos
make test-16bit      # Testa apenas portas de 16 bits
make test-multiway   # Testa apenas portas multi-way
```

Teste um gate específico:
```bash
make gnand
make mux16
```

Limpe arquivos gerados:
```bash
make clean
```

Veja a ajuda:
```bash
make help
```

### Opção 3: Teste Manual

Para testar um gate individualmente:
```bash
# Compile
iverilog -o test_gnand.out tb_gnand.v gnand.v

# Execute
vvp test_gnand.out

# Limpe
rm test_gnand.out
```

## 📊 Estrutura dos Arquivos

```
esc/
├── gnand.v           # Implementação do gate
├── tb_gnand.v        # Test bench do gate
├── gand.v
├── tb_gand.v
├── ...
├── test_all.sh       # Script de teste
├── Makefile          # Makefile para automação
└── README.md         # Este arquivo
```

## ✅ Validação

Cada test bench:
1. Testa todas as combinações possíveis de entrada
2. Exibe uma tabela verdade
3. Reporta se o teste passou ou falhou

## 📝 Notas de Implementação

- Todos os gates foram implementados usando **assign contínuo** do Verilog
- As implementações são **autorais** e não utilizam primitivas HDL específicas
- Os gates de 16 bits operam em **paralelo** em todos os bits
- Os multiplexadores usam **operador ternário** para seleção
- Os demultiplexadores direcionam a entrada baseado no **seletor**

## 🎓 Referências

- Projeto baseado no curso **Nand2Tetris**
- Documentação Verilog IEEE 1364-2005
- Icarus Verilog Documentation

## 👨‍💻 Autor

João Emanuel - Universidade/ESC

## 📅 Data

Novembro de 2025
