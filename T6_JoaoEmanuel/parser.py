class Parser:
    A_COMMAND = 0
    C_COMMAND = 1
    L_COMMAND = 2
    
    def __init__(self, filename):
        with open(filename, 'r') as f:
            self.lines = f.readlines()
        self.current_command = None
        self.current_line = 0
        self.commands = []
        self._process_lines()
        
    def _process_lines(self):
        for line in self.lines:
            line = line.strip()
            if line and not line.startswith('//'):
                if '//' in line:
                    line = line[:line.index('//')].strip()
                if line:
                    self.commands.append(line)
    
    def has_more_commands(self):
        return self.current_line < len(self.commands)
    
    def advance(self):
        self.current_command = self.commands[self.current_line]
        self.current_line += 1
    
    def command_type(self):
        if self.current_command.startswith('@'):
            return self.A_COMMAND
        elif self.current_command.startswith('('):
            return self.L_COMMAND
        else:
            return self.C_COMMAND
    
    def symbol(self):
        if self.command_type() == self.A_COMMAND:
            return self.current_command[1:]
        elif self.command_type() == self.L_COMMAND:
            return self.current_command[1:-1]
        return None
    
    def dest(self):
        if self.command_type() == self.C_COMMAND:
            if '=' in self.current_command:
                return self.current_command.split('=')[0]
        return None
    
    def comp(self):
        if self.command_type() == self.C_COMMAND:
            cmd = self.current_command
            if '=' in cmd:
                cmd = cmd.split('=')[1]
            if ';' in cmd:
                cmd = cmd.split(';')[0]
            return cmd
        return None
    
    def jump(self):
        if self.command_type() == self.C_COMMAND:
            if ';' in self.current_command:
                return self.current_command.split(';')[1]
        return None
    
    def reset(self):
        self.current_line = 0
        self.current_command = None
