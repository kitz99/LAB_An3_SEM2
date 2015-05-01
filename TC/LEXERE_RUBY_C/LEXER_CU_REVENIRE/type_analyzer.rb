class TypeAnalyzer
  attr_accessor :keywords
  attr_accessor :types
  attr_accessor :symbols_type

  def initialize
    @keywords = [ 'auto', 'break', 'case', 'char', 'const', 'continue', 'default', 'do', 'double', 'else', 'enum',
                  'extern', 'float', 'for', 'goto', 'if', 'include', 'int', 'long', 'register', 'return', 'short', 'signed',
                  'sizeof', 'static', 'struct', 'switch', 'typedef', 'union', 'unsigned', 'void', 'volatile', 'while'
                ]
    @types = {
      46 => 'OP - L_CURLY_BRACKET',
      47 => 'OP - R_CURLY_BRACKET',
      42 => 'OP - L_BRACKET',
      43 => 'OP - R_BRACKET',
      44 => 'OP - L_PARANT',
      45 => 'OP - R_PARANT',
      7 =>  'OP - PERIOD',
      13 => 'OP - PLUS_PLUS',
      16 => 'OP - MINUS_MINUS',
      15 => 'OP - MINUS',
      12 => 'OP - PLUS',
      18 => 'OP - MULTIPLY',
      20 => 'OP - DIVIDE',
      40 => 'OP - MOD',
      22 => 'OP - BIT_AND',
      25 => 'OP - BIT_OR',
      33 => 'OP - SHIFT_LEFT',
      36 => 'OP - SHIFT_RIGHT',
      28 => 'OP - XOR',
      30 => 'OP - NOT',
      32 => 'OP - LESS_THAN',
      34 => 'OP - LESS_THAN_EQ',
      35 => 'OP - GREATER_THAN',
      37 => 'OP - GREATER_THAN_EQ',
      38 => 'OP - ASSIGN',
      39 => 'OP - EQUAL',
      31 => 'OP - NOT_EQ',
      24 => 'OP - AND',
      26 => 'OP - OR',
      66 => 'OP - TERNARY_OP',
      19 => 'OP - ASSIGN_MULTIPLY',
      21 => 'OP - ASSIGN_DEVIDE',
      41 => 'OP - ASSIGN_MOD',
      14 => 'OP - ASSIGN_PLUS',
      17 => 'OP - ASSIGN_MINUS',
      69 => 'OP - ASSIGN_BIT_SHIFT_L',
      70 => 'OP - ASSIGN_BIT_SHIFT_RIGHT',
      29 => 'OP - ASSIGN_BIT_XOR',
      27 => 'OP - ASSIGN_BIT_OR',
      23 => 'OP - ASSIGN_BIT_AND',
      55 => 'OP - COMMA',
      56 => 'OP - SEPARATOR(SEMICOLON)',
      57 => 'OP - COLUMN',
      68 => 'OP - VAR_ARGS',
      53 => 'LIT - CHAR',
      49 => 'LIT - STRING',
      61 => 'LIT - INT_HEX',
      59 => 'LIT - INT',
      62 => 'LIT - INT_OCT',
      8 => 'LIT - FLOAT',
      9 => 'LIT - FLOAT',
      3 => 'LIT - INT',
      -1 => 'T_ERROR',
      4 => 'LIT - FLOAT',
      6 => 'LIT - FLOAT',
      73 => 'LIT - FLOAT',
      74 => 'LIT - FLOAT',
      1 => 'LIT - IDENTIFIER',
      100 => 'PREPROCESSOR'
    }
  end

  def token_type(token, state)
    if state == 1 and @keywords.include?(token)
      return 'KEYWORD_' << token.upcase
    else
      return @types[state]
    end
  end
end