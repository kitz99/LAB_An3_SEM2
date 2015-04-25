load 'dfa.rb'
load 'lexer.rb'

def sources()
	[File.open('test.cpp', 'r'), File.open('output.txt', 'w')]
end


def main()
	file_in, file_out = sources()

	lex = Lexer.new()
    lex.load_buffer(file_in)

	while true
		token = lex.getToken()
		if token.nil?
			break
    end
    if token[:token] == "T_error"
      file_out.puts "#{token[:token]} ---> #{token[:value]}"
      break
    end
    file_out.puts "#{token[:token]} ---> #{token[:value]}"
		lex.current_word = ""
	end
	
	file_in.close
	file_out.close
end

main()