import sys
from parser import Parser
from code import Code
from symbol_table import SymbolTable

def assemble(input_file, output_file):
    parser = Parser(input_file)
    symbol_table = SymbolTable()
    
    rom_address = 0
    while parser.has_more_commands():
        parser.advance()
        if parser.command_type() == Parser.L_COMMAND:
            symbol = parser.symbol()
            symbol_table.add_entry(symbol, rom_address)
        else:
            rom_address += 1
    
    parser.reset()
    
    ram_address = 16
    output_lines = []
    
    while parser.has_more_commands():
        parser.advance()
        
        if parser.command_type() == Parser.A_COMMAND:
            symbol = parser.symbol()
            
            if symbol.isdigit():
                address = int(symbol)
            else:
                if not symbol_table.contains(symbol):
                    symbol_table.add_entry(symbol, ram_address)
                    ram_address += 1
                address = symbol_table.get_address(symbol)
            
            binary = format(address, '016b')
            output_lines.append(binary)
        
        elif parser.command_type() == Parser.C_COMMAND:
            dest = Code.dest(parser.dest())
            comp = Code.comp(parser.comp())
            jump = Code.jump(parser.jump())
            
            binary = '111' + comp + dest + jump
            output_lines.append(binary)
    
    with open(output_file, 'w') as f:
        for line in output_lines:
            f.write(line + '\n')

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python assembler.py <file.asm>')
        sys.exit(1)
    
    input_file = sys.argv[1]
    
    if not input_file.endswith('.asm'):
        print('Input file must have .asm extension')
        sys.exit(1)
    
    output_file = input_file.replace('.asm', '.bin')
    
    assemble(input_file, output_file)
    print(f'Assembly complete: {output_file}')
