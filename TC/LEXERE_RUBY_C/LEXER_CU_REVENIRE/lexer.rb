load 'type_analyzer.rb'

class Lexer
	attr_accessor :poz
	attr_accessor :line
	attr_accessor :buffer
	attr_accessor :current_word
  attr_accessor :automat
  attr_accessor :type_analyzer

  attr_reader :symbol_table

	def initialize
		@poz = 0
		@line = 1
		@buffer = Array.new
		@current_word = ''
    @automat = DFA.new(0)
    @type_analyzer = TypeAnalyzer.new
    @symbol_table = Array.new
	end

	def getToken()
    @automat.reset_dfa # Resetez automatul
    states = Array.new # fac o lista in care sa tin starile prin care am trecut

		if @buffer.count > @poz # Daca inca mai exista caractere in buffer
			current_char = @buffer[@poz] # citesc caracterul de la pozitia curenta
			@poz = @poz + 1
      line(current_char) # stabilesc pozitia curenta in fisier
		else
			return nil # nu mai exista caractere in buffer
    end

		eof = false
		state = @automat.m.make_tranz(@automat.m.current_state, current_char) # fac miscare in DFA cu carcterul citit
    aux = ''
    while state != -1 and eof == false # cat timp nu s-a ajuns in stare de eroare sau nu s-a sfarsit bufferul
      if state != 0
			  @current_word << current_char # adaug caracterul citit la cuvantul curent
        aux << current_char
      end

      if must_clear(state)
        @current_word = ''
      end

			if @buffer.count > @poz # daca se mai poate citi din buffer
				current_char = @buffer[@poz] #citesc caracter din buffer
				@poz = @poz + 1 #incrementez pozitia
        line(current_char) # actualizez pozitia in fisier
        states << state unless state == 0 # pastrez starea din care plec, ca sa pot eventual sa ma intorc daca e cazul
				state = @automat.m.make_tranz(@automat.m.current_state, current_char) # fac miscare cu caracterul citit in automat plecand din starea curenta
			else
				eof = true
			end
		end

    # while se termina in momentul in care s-a terminat bufferul sau s-a ajuns in stare de eroare
		if eof == true # daca s-a terminat fisierul, exista doua posib: starea in care s-a ajuns sa fie de eroare sau nu
			if state == -1 # daca starea in care s-a ajuns este de eroare, ma intorc pana in ultima stare finala intalnita
        loop do
          st = states.pop()
          @poz -= 1
          if @automat.m.final?(st)
            if not @symbol_table.include?(@current_word)
               @symbol_table << @current_word
            end
            value = @symbol_table.index(@current_word)
            return {:token => @type_analyzer.token_type(@current_word, st),
              :value => value
            }
          end
          @current_word = @current_word[0...-1] # tai ultimul caracter din cuvant
          break if states.empty? # ma opresc daca nu mai am stari in care sa ma intorc
        end
				return {:token => @type_analyzer.token_type(@current_word, state),
						    :value => "eroare la linia #{@line}: #{@current_word}"
				}
      else # daca starea in care s-a ajuns nu este stare de eroare si fisierul s-a terminat
        if state == 63 or state == 64 # ma aflu intr-un comentariu multiline care nu s-a inchis
          @current_word = aux[0..-1]
        end
        if state == 0 or state == 65 
          return nil # s-a terminat fisierul cu spatii goale consumate sau comentariu
        end

				if @automat.m.final?(state) # verific daca starea de in care s-a ajuns este finala
          if not @symbol_table.include?(@current_word)
            @symbol_table << @current_word
          end
          value = @symbol_table.index(@current_word)
					return {:token => @type_analyzer.token_type(@current_word, state),
					        :value => value
					} 
				else # trebuie sa ma intorc la ultima stare finala intalnita
          loop do
            st = states.pop()

            # if st.nil? or st == 48 or st == 50 or st == 54 or st == 52 or st == 51
            if st.nil? or st == 48 or st == 54 or st == 52 or st == 51 # ma aflu intr-un string sau char care nu s-a inchis corect
              return {:token => @type_analyzer.token_type(@current_word, -1),
                      :value => "eroare la linia #{@line}: #{@current_word}"
              }
            end

            @poz -= 1
            if @automat.m.final?(st)
              @current_word = @current_word[0...-1]
              if not @symbol_table.include?(@current_word)
                @symbol_table << @current_word
              end
              value = @symbol_table.index(@current_word)
              return {:token => @type_analyzer.token_type(@current_word, st),
                      :value => value
              }
            end
            @current_word = @current_word[0...-1]
            break if states.empty?
          end
          return {:token => @type_analyzer.token_type(@current_word, state),
                  :value => "eroare la linia #{@line}: #{@current_word}"
          }
				end
			end
    else # inseamna ca fisierul nu s-a terminat, dar s-a ajuns intr-o stare de eroare
         # presupune sa ne intoarcem pana la ultima stare finala intalnita
      loop do
        st = states.pop()
        @poz -= 1

        if current_char == "\n"
          @line -= 1
          # if st == 48 or st == 50 or st == 51 or st == 54 or st == 52
          if st == 48 or st == 50 or st == 51 or st == 54 or st == 52
            return {:token => @type_analyzer.token_type(@current_word, state),
                    :value => "eroare la linia #{@line}: #{@current_word}"
            }
          end
        end

        if @automat.m.final?(st)
          if not @symbol_table.include?(@current_word)
            @symbol_table << @current_word
          end
          value = @symbol_table.index(@current_word)
          return {:token => @type_analyzer.token_type(@current_word, st),
                  :value => value
          }
        end
        @current_word = @current_word[0...-1]
        break if states.empty?
      end

        return {:token => @type_analyzer.token_type(@current_word, state),
                :value => "eroare la linia #{@line}: #{@current_word}"
        }

		end

  end

  def load_buffer(file_in)
    while c = file_in.getc
      @buffer << c
    end
  end


  protected

  def line(current_char)
    if current_char == "\n"
      @line = @line + 1
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
			else
				rez << char
			end
		end
		return rez
	end
end
