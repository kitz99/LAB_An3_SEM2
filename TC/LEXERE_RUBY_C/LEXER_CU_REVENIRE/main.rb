load 'dfa.rb'
load 'lexer.rb'
require 'terminal-table'


def sources
	[File.open('test.c', 'r'), File.open('output.txt', 'w')]
end


def main
	file_in, file_out = sources()

	lex = Lexer.new()
    lex.load_buffer(file_in)

  rows = Array.new
  rows << :separator
	while true
		token = lex.getToken()
		if token.nil?
			break
    end
    if token[:token] == 'T_ERROR'
      rows << [token[:token], token[:value]]
      rows << :separator
      break
    end
    rows << [token[:token], lex.symbol_table[token[:value]].gsub("\\\n", '')] # .tr("\n", '')
    rows << :separator
		lex.current_word = ''
  end

  rows.pop()
  table = Terminal::Table.new :headings => ['Token_type', 'Token_value'], :rows => rows
  file_out.puts table

	file_in.close
	file_out.close
end

main()