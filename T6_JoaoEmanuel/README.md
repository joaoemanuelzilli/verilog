# Montador Hack Assembly

Montador para traduzir programas escritos em Hack Assembly para código binário Hack.

## Uso

```bash
python3 assembler.py <arquivo.asm>
```

O montador irá gerar um arquivo `.bin` com o código binário correspondente.

## Exemplo

```bash
python3 assembler.py Add.asm
```

Isso irá gerar o arquivo `Add.bin` contendo o código binário.

## Arquitetura

O montador é composto por 4 módulos:

- **assembler.py**: Programa principal que coordena o processo de montagem
- **parser.py**: Analisa e processa as instruções assembly
- **code.py**: Traduz mnemonics para código binário
- **symbol_table.py**: Gerencia a tabela de símbolos (labels e variáveis)
