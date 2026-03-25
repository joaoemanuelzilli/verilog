# Projeto 5: CPU e Computador Hack - Índice de Documentação

## 🎯 Visão Geral

Este é o Projeto 5 do curso Nand2Tetris, onde implementamos uma **CPU completa** e um **sistema de computador funcional** capaz de executar programas escritos na linguagem de máquina Hack.

**Status:** ✅ **CONCLUÍDO E TESTADO COM SUCESSO**

---

## 📚 Documentação Disponível

### 1. [README.md](README.md) - Guia Principal
- Descrição completa do projeto
- Arquitetura dos componentes
- Instruções de compilação e teste
- Programas de teste (Add, Max, Rect)
- Referências e recursos

**Comece por aqui se você quer entender o projeto rapidamente.**

### 2. [SUMMARY.md](SUMMARY.md) - Resumo Executivo
- Status e conquistas do projeto
- Estatísticas e métricas
- Resultados dos testes
- Comandos rápidos
- Próximos passos sugeridos

**Use este arquivo para uma visão rápida dos resultados.**

### 3. [RELATORIO.md](RELATORIO.md) - Relatório Técnico
- Análise detalhada da implementação
- Decisões de design
- Métricas de desempenho
- Desafios e soluções
- Conclusões e aprendizados

**Leia este arquivo para detalhes técnicos profundos.**

### 4. [ARCHITECTURE_DIAGRAM.md](ARCHITECTURE_DIAGRAM.md) - Diagramas
- Diagramas da arquitetura completa
- Fluxo de execução de instruções
- Exemplos de programas com anotações
- Referência rápida de instruções

**Consulte este arquivo para visualizar a arquitetura.**

---

## 🗂️ Estrutura de Arquivos

```
esc5/
├── 📄 Módulos Verilog (Implementação)
│   ├── Memory.v          # Sistema de memória
│   ├── CPU.v             # Unidade Central de Processamento
│   └── Computer.v        # Sistema completo
│
├── 🧪 Test Benches (Validação)
│   ├── tb_Memory.v       # Testes de Memory
│   ├── tb_CPU.v          # Testes de CPU
│   └── tb_Computer.v     # Testes completos
│
├── 🔨 Build & Automação
│   ├── Makefile          # Compilação automática
│   └── test_all.sh       # Testes automatizados
│
└── 📚 Documentação
    ├── INDEX.md          # Este arquivo (índice)
    ├── README.md         # Guia principal
    ├── SUMMARY.md        # Resumo executivo
    ├── RELATORIO.md      # Relatório técnico
    └── ARCHITECTURE_DIAGRAM.md  # Diagramas
```

---

## 🚀 Quick Start

### Executar Todos os Testes
```bash
cd /home/joaoemanuel/git/University/T5_JoaoEmanuel/esc5
./test_all.sh
```

### Compilar e Testar Individualmente
```bash
make memory    # Testa apenas Memory
make cpu       # Testa apenas CPU
make computer  # Testa Computer completo
```

### Visualizar Formas de Onda
```bash
make wave_memory    # GTKWave: Memory
make wave_cpu       # GTKWave: CPU
make wave_computer  # GTKWave: Computer
```

### Limpar Arquivos Gerados
```bash
make clean
```

---

## ✅ Resultados dos Testes

| Teste | Descrição | Status |
|-------|-----------|--------|
| Memory | Sistema de memória integrado | ✓ PASS |
| CPU | Processador completo | ✓ PASS |
| Add.hack | Programa: 2 + 3 = 5 | ✓ PASS |
| Max.hack | Programa: max(15, 23) = 23 | ✓ PASS |
| Rect.hack | Programa: desenha retângulo | ✓ PASS |

**Taxa de Sucesso:** 5/5 (100%) ✅

---

## 🏗️ Componentes Implementados

### 1. Memory Module
- **RAM16K:** 16K palavras (0x0000-0x3FFF)
- **Screen:** 8K palavras de vídeo (0x4000-0x5FFF)
- **Keyboard:** 1 palavra de entrada (0x6000)

### 2. CPU Module
- **Registrador A:** 16 bits (endereço/dados)
- **Registrador D:** 16 bits (dados)
- **Program Counter:** 15 bits
- **ALU:** Do Projeto 2
- **Controle:** Decodificação + Jump logic

### 3. Computer Module
- **Integração:** CPU + Memory + ROM32K
- **Suporte:** Execução de programas Hack
- **Reset:** Sistema de reset funcional

---

## 🎓 Conhecimentos Aplicados

### Arquitetura de Computadores
- [x] Arquitetura de Von Neumann
- [x] Ciclo Fetch-Decode-Execute
- [x] Linguagem de máquina
- [x] Hierarquia de memória

### Verilog HDL
- [x] Módulos hierárquicos
- [x] Always blocks (síncrono/combinacional)
- [x] Test benches
- [x] Análise de timing

### Engenharia de Software
- [x] Modularização
- [x] Testes automatizados
- [x] Documentação
- [x] Build automation (Makefile)

---

## 📖 Como Navegar na Documentação

### Para Iniciantes
1. Comece com [README.md](README.md)
2. Execute `./test_all.sh` para ver funcionando
3. Leia [ARCHITECTURE_DIAGRAM.md](ARCHITECTURE_DIAGRAM.md) para entender visualmente

### Para Estudantes/Desenvolvedores
1. Leia [RELATORIO.md](RELATORIO.md) para detalhes técnicos
2. Estude os arquivos `.v` (Memory.v, CPU.v, Computer.v)
3. Analise os test benches (`tb_*.v`)
4. Execute `make wave_*` para ver formas de onda

### Para Professores/Avaliadores
1. Veja [SUMMARY.md](SUMMARY.md) para resumo executivo
2. Revise [RELATORIO.md](RELATORIO.md) para avaliação técnica
3. Execute `./test_all.sh` para validar funcionamento
4. Confira cobertura de testes nos arquivos `tb_*.v`

---

## 🔗 Dependências

Este projeto depende de componentes dos projetos anteriores:

### Projeto 2 (ALU)
```
../T2_ALU_JoaoEmanuel/esc2_alu/
└── alu.v
```

### Projeto 3 (Memória Sequencial)
```
../T3_JoaoEmanuel/esc3/
├── register.v
├── pc.v
├── ram16k.v
├── bit.v
└── dff.v
```

---

## 🛠️ Ferramentas Necessárias

- **Icarus Verilog** (iverilog) - Compilador Verilog
- **VVP** - Simulador Verilog
- **GTKWave** (opcional) - Visualizador de formas de onda
- **Make** - Sistema de build
- **Bash** - Shell scripts

### Instalação (Ubuntu/Debian)
```bash
sudo apt-get install iverilog gtkwave make
```

---

## 📊 Estatísticas

| Métrica | Valor |
|---------|-------|
| **Módulos Verilog** | 3 |
| **Test Benches** | 3 |
| **Linhas de Código** | ~500 |
| **Linhas de Documentação** | ~1500 |
| **Testes Implementados** | 5 |
| **Taxa de Sucesso** | 100% |
| **Tempo de Compilação** | < 1s |
| **Tempo de Execução** | < 1s |

---

## 🏆 Conquistas

- ✅ CPU funcional completa
- ✅ Sistema de memória integrado
- ✅ Execução de programas Hack
- ✅ 100% dos testes passando
- ✅ Documentação completa e detalhada
- ✅ Código modular e bem estruturado
- ✅ Testes automatizados
- ✅ Build system eficiente

---

## 👨‍💻 Informações do Projeto

**Aluno:** João Emanuel  
**Curso:** ESC - Estrutura e Simulação de Computadores  
**Projeto:** T5 - CPU and Computer  
**Baseado em:** Nand2Tetris Project 5  
**Data:** 14 de Fevereiro de 2026  
**Status:** ✅ Concluído

---

## 📞 Suporte

Para dúvidas sobre este projeto:
1. Leia a documentação relevante acima
2. Examine os arquivos de código fonte
3. Execute os testes para ver exemplos funcionando
4. Consulte o livro "The Elements of Computing Systems"
5. Visite www.nand2tetris.org

---

## 📜 Licença

Este projeto foi desenvolvido para fins educacionais como parte do curso Nand2Tetris.

---

**Última Atualização:** 14 de Fevereiro de 2026  
**Versão:** 1.0 Final
