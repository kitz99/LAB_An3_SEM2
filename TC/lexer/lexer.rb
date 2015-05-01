class Lexer
	attr_accessor :poz
	attr_accessor :line
	attr_accessor :collumn
	attr_accessor :buffer
	attr_accessor :current_word
  attr_accessor :automat

	def initialize()
		@poz = 0
		@line = 1
		@collumn = 1
		@buffer = Array.new
		@current_word = ""
    	@automat = DFA.new(0)
    	# @automat.print_automaton()
	end

	def getToken()
    @automat.reset_dfa
		if @buffer.count > @poz
			current_char = @buffer[@poz]
			@poz = @poz + 1
      line_column(current_char)
		else
			return nil
		end
		eof = false
		state = @automat.m.make_tranz(@automat.m.current_state, current_char)
		while state != -1 and eof == false
      if state != 0
			  @current_word << current_char
      end
      if must_clear(state)
        @current_word = ""
      end
			if @buffer.count > @poz
				current_char = @buffer[@poz]
				@poz = @poz + 1
        line_column(current_char)
				state = @automat.m.make_tranz(@automat.m.current_state, current_char)
			else
				eof = true
			end
		end

		if eof == true
			if state == -1
				@poz -= 1
				@current_word = @current_word[0...-1]
				input = @current_word.split(//)
				input = add_escape input

				if @automat.m.accept? input
					return {:token => "T_token",
						:value => @current_word
					}
				else
					return {:token => "T_error",
						:value => "eroare la linia #{@line} si coloana #{@collumn}: #{@current_word}"
					}
				end
      else
        if state == 0 or state == 65
          return nil # s-a terminat fisierul cu spatii goale consumate sau comentariu
        end

				if @automat.m.final?(state)
					return {:token => "T_token",
					        :value => @current_word
					} 
				else
					return {:token => "T_error",
						:value => "eroare la linia #{@line} si coloana #{@collumn}: #{@current_word}"
					}
				end
			end
		else
			@poz -= 1
      @collumn -= 1
      if current_char == "\n"
        @collumn = 1
        @line -= 1
      end
			# @current_word = @current_word[0...-1]
			input = @current_word.split(//)
			input = add_escape input

			if @automat.m.accept? input
				return {:token => "T_token",
					:value => @current_word
				}
			else
				return {:token => "T_error",
					:value => "eroare la linia #{@line} si coloana #{@collumn}: #{@current_word}"
				}
			end
		end


  end

  def load_buffer(file_in)
    while c = file_in.getc
      @buffer << c
    end
  end


  protected

  def line_column(current_char)
    @collumn += 1
    if current_char == "\n"
      @line = @line + 1
      @collumn = 1
    end
  end

  def must_clear(state)
    if state == 63 or state == 64 or state == 65
      return true
    end
    return false
  end
	def add_escape(input)
		rez = Array.new
		input.each do |char|
			if char == "\n"
				rez << "\\"
				rez << "n"
			elsif char == "\t"
				rez << "\\"
				rez << "t"
			elsif char == "\0"
				rez << "\\"
				rez << "0"
			# elsif char == "\""
			# 	rez << "\\"
			# 	rez << '"'
			# elsif char == "\'"
			# 	rez << "\\"
			# 	rez << "'"
			# elsif char == "\\"
			# 	rez << "\\"
			# 	rez << "\\"
			else
				rez << char
			end
		end
		return rez
	end
end

# return {:token => "T_Error",
# 					:value => "Error found at line #{@line} and collumn #{@collumn}"
# 					}