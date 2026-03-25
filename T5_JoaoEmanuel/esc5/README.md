# Projeto 5: CPU e Computador - Hack Computer
## ESC - Estrutura e Simulação de Computadores
**Aluno: João Emanuel**

---

## 📋 Descrição

Este projeto implementa uma CPU completa e um sistema de computador capaz de executar programas escritos na linguagem de máquina Hack, conforme especificado no curso Nand2Tetris.

### Componentes Implementados

1. **Memory.v** - Sistema de memória integrado
   - RAM16K (endereços 0x0000 - 0x3FFF): 16K palavras de RAM de uso geral
   - Screen (endereços 0x4000 - 0x5FFF): 8K palavras de memória de vídeo
   - Keyboard (endereço 0x6000): 1 palavra para entrada do teclado

2. **CPU.v** - Unidade Central de Processamento
   - Integra ALU do Projeto 2
   - Registradores A e D
   - Program Counter (PC)
   - Lógica de controle e decodificação de instruções
   - Suporte para instruções A e C do Hack

3. **Computer.v** - Sistema completo
   - Integra CPU, Memory e ROM32K
   - Executa programas carregados na memória de instruções

---

## 🏗️ Arquitetura do Hack Computer

```
┌─────────────────────────────────────────┐
│            Computer                     │
│  ┌─────────────────────────────────┐   │
│  │         CPU                     │   │
│  │  ┌───┐  ┌────┐  ┌────┐  ┌───┐ │   │
│  │  │ A │  │ D  │  │ALU │  │PC │ │   │
│  │  └───┘  └────┘  └────┘  └───┘ │   │
│  └─────────────────────────────────┘   │
│           │              │              │
│           ├──────────────┤              │
│           ↓              ↓              │
│  ┌──────────────┐  ┌─────────┐        │
│  │   Memory     │  │ ROM32K  │        │
│  │ ┌──────────┐ │  │(Program)│        │
│  │ │  RAM16K  │ │  └─────────┘        │
│  │ │  Screen  │ │                     │
│  │ │ Keyboard │ │                     │
│  │ └──────────┘ │                     │
│  └──────────────┘                     │
└─────────────────────────────────────────┘
```

---

## 📝 Formato das Instruções

### Instrução A (Address)
```
Formato: 0vvvvvvvvvvvvvvv
Função:  Carrega valor no registrador A
Exemplo: @5 → 0000000000000101
```

### Instrução C (Compute)
```
Formato: 111a cccccc ddd jjj

a:      0 = usa A, 1 = usa M[A]
cccccc: Controle da ALU (zx,nx,zy,ny,f,no)
ddd:    Destino (A, D, M)
jjj:    Condição de salto (JGT, JEQ, JGE, JLT, JNE, JLE, JMP)

Exemplo: D=D+1 → 1110011111010000
```

---

## 🧪 Programas de Teste

### 1. Add.hack
Calcula 2 + 3 e armazena o resultado em RAM[0]
```assembly
@2      // A = 2
D=A     // D = 2
@3      // A = 3
D=D+A   // D = 2 + 3 = 5
@0      // A = 0
M=D     // RAM[0] = 5
```
**Resultado esperado:** RAM[0] = 5

### 2. Max.hack
Calcula o máximo entre RAM[0] e RAM[1], armazena em RAM[2]
```assembly
@0      // Carrega RAM[0]
D=M     // D = RAM[0]
@1      // Carrega RAM[1]
D=D-M   // D = RAM[0] - RAM[1]
@10     // Se D > 0, pula para OUTPUT_FIRST
D;JGT
@1      // Caso contrário, usa RAM[1]
D=M
@12     // Pula para OUTPUT_D
0;JMP
@0      // OUTPUT_FIRST: usa RAM[0]
D=M
@2      // OUTPUT_D: armazena em RAM[2]
M=D
```
**Teste:** RAM[0]=15, RAM[1]=23 → RAM[2]=23

### 3. Rect.hack
Desenha um retângulo na tela com RAM[0] linhas
```assembly
@0      // n = RAM[0] (número de linhas)
D=M
@END    // Se n <= 0, termina
D;JLE
@16384  // screen = endereço base da tela
D=A
@addr   // Variável addr
M=D
(LOOP)
@addr   // Carrega endereço atual
A=M
M=-1    // Preenche 16 pixels (preto)
@addr
M=M+1   // Próximo endereço
@0
M=M-1   // Decrementa contador
D=M
@LOOP   // Se n > 0, repete
D;JGT
(END)
```

---

## 🚀 Como Compilar e Testar

### Pré-requisitos
- **Icarus Verilog** (iverilog)
- **VVP** (Verilog simulator)
- **GTKWave** (opcional, para visualizar formas de onda)

### Instalação no Ubuntu/Debian
```bash
sudo apt-get install iverilog gtkwave
```

### Compilar e executar todos os testes
```bash
make all
```
ou
```bash
./test_all.sh
```

### Testar componentes individuais
```bash
make memory      # Testa o módulo Memory
make cpu         # Testa o módulo CPU
make computer    # Testa o Computer completo
```

### Visualizar formas de onda
```bash
make wave_memory    # Abre GTKWave com o teste de Memory
make wave_cpu       # Abre GTKWave com o teste de CPU
make wave_computer  # Abre GTKWave com o teste completo
```

### Limpar arquivos gerados
```bash
make clean
```

---

## 📂 Estrutura de Arquivos

```
esc5/
├── Memory.v          # Módulo de memória (RAM + Screen + Keyboard)
├── CPU.v             # Unidade Central de Processamento
├── Computer.v        # Sistema completo (CPU + Memory + ROM)
├── tb_Memory.v       # Test bench para Memory
├── tb_CPU.v          # Test bench para CPU
├── tb_Computer.v     # Test bench para Computer (Add, Max, Rect)
├── Makefile          # Script de compilação
├── test_all.sh       # Script para executar todos os testes
└── README.md         # Este arquivo
```

---

## 🔧 Detalhes de Implementação

### Mapa de Memória
| Endereço | Região | Descrição |
|----------|--------|-----------|
| 0x0000 - 0x3FFF | RAM16K | Memória de dados (16384 palavras) |
| 0x4000 - 0x5FFF | Screen | Memória de vídeo (8192 palavras, 512×256 pixels) |
| 0x6000 | Keyboard | Registro do teclado (1 palavra) |

### Sinais da CPU
- **Entradas:**
  - `clk`: Clock do sistema
  - `reset`: Reset assíncrono
  - `inM[15:0]`: Dados da memória (M[A])
  - `instruction[15:0]`: Instrução atual
  
- **Saídas:**
  - `outM[15:0]`: Dados para memória
  - `writeM`: Habilita escrita na memória
  - `addressM[14:0]`: Endereço da memória
  - `pc[14:0]`: Contador de programa

### Controle da ALU
| Bits | Operação |
|------|----------|
| zx | Zera entrada X |
| nx | Nega entrada X |
| zy | Zera entrada Y |
| ny | Nega entrada Y |
| f  | Função (1=soma, 0=AND) |
| no | Nega saída |

---

## ✅ Resultados Esperados

### Memory Test
- ✓ Escrita e leitura da RAM
- ✓ Escrita e leitura da Screen
- ✓ Isolamento entre regiões de memória

### CPU Test
- ✓ Instruções A (carregamento de valores)
- ✓ Instruções C (operações da ALU)
- ✓ Operações com registradores A e D
- ✓ Escrita na memória
- ✓ Saltos condicionais e incondicionais

### Computer Test
- ✓ Programa Add: RAM[0] = 5
- ✓ Programa Max: RAM[2] = max(RAM[0], RAM[1])
- ✓ Programa Rect: Pixels escritos na memória de vídeo

---

## 🎓 Referências

- **Nand2Tetris:** www.nand2tetris.org
- **Livro:** "The Elements of Computing Systems" (Nisan & Schocken)
- **Projeto 2:** ALU e componentes aritméticos
- **Projeto 3:** Memória e registradores sequenciais
- **Projeto 4:** Linguagem de máquina Hack

---

## 📧 Contato

**Aluno:** João Emanuel  
**Curso:** ESC - Estrutura e Simulação de Computadores  
**Projeto:** T5 - CPU and Computer  

---

## 📜 Licença

Este projeto foi desenvolvido para fins educacionais como parte do curso Nand2Tetris.
