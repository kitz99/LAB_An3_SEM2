load 'finite-automaton.rb'
class DFA

	attr_accessor :m	
	def initialize(start_state)
		@m = FiniteAutomaton.new(start_state)
		# ==============================
		# 			tranzitii
		# ==============================

		@m.add_transition(start_state, '_', 1) # din 0 cu _ in 1
		@m.add_transition(1, '_', 1) # din 1 cu _ in 1
		@m.add_transition(start_state, '$', 1)
		@m.add_transition(1, '$', 1)

		('a'..'z').each do |letter|
			@m.add_transition(start_state, letter, 1) # din 0 cu litera in starea 1
			@m.add_transition(1, letter, 1) # din 1 cu litera in starea 1
		end

		('A'..'Z').each do |letter|
			@m.add_transition(start_state, letter, 1) # din 0 cu litera in starea 1
			@m.add_transition(1, letter, 1) # din 1 cu litera in starea 1
		end

		('0'..'9').each do |c|
			@m.add_transition(1, c, 1) # din 1 cu cifra in 1
			if c != '0'
				@m.add_transition(start_state, c, 3) # din 0 cu cifra in 3
			end
			@m.add_transition(3, c, 3) # din 3 cu cifra in 3
			@m.add_transition(4, c, 6) # din 4 cu cifra in 6
			@m.add_transition(6, c, 6) # din 6 cu cifra in 6
			# @m.add_transition(10, c, 6)
			# @m.add_transition(11, c, 6)
			@m.add_transition(10, c, 74)
			@m.add_transition(11, c, 73)
			@m.add_transition(7, c, 8)
			@m.add_transition(8, c, 8)
			@m.add_transition(60, c, 61)
			@m.add_transition(61, c, 61)
			@m.add_transition(71, c, 74)
			@m.add_transition(72, c, 73)
			@m.add_transition(73, c, 73)
      @m.add_transition(74, c, 74)
		end

		@m.add_transition(3, '.', 4) # din 3 cu . in 4
		@m.add_transition(3, 'e', 10) # din 3 cu e in 10
		@m.add_transition(10, '+', 11)
		@m.add_transition(10, '-', 11)
		@m.add_transition(start_state, '.', 7)
		@m.add_transition(8, 'e', 10)
		@m.add_transition(6, 'e', 71)
		@m.add_transition(4, 'e', 71)
		@m.add_transition(71, '+', 72)
		@m.add_transition(71, '-', 72)



		# |, ||, |=
		@m.add_transition(start_state, '|', 25)
		@m.add_transition(25, '|', 26)
		@m.add_transition(25, '=', 27)

		# &, &&, &=
		@m.add_transition(start_state, '&', 22)
		@m.add_transition(22, '=', 23)
		@m.add_transition(22, '&', 24)

		# ^, ^=
		@m.add_transition(start_state, "^", 28)
		@m.add_transition(28, '=', 29)

		# !, !=
		@m.add_transition(start_state, '!', 30)
		@m.add_transition(30, '=', 31)

		# <, <<, <<=
		@m.add_transition(start_state, '<', 32)
		@m.add_transition(32, '<', 33)
		@m.add_transition(32, '<', 34)
		@m.add_transition(33, '=', 69)

		# >, >>, >>=
		@m.add_transition(start_state, '>', 35)
		@m.add_transition(35, '>', 36)
		@m.add_transition(35, '=', 37)
		@m.add_transition(36, '=', 70)

		# =, ==
		@m.add_transition(start_state, '=', 38)
		@m.add_transition(38, '=', 39)

		# +, ++, +=
		@m.add_transition(start_state, '+', 12)
		@m.add_transition(12, '+', 13)
		@m.add_transition(12, '=', 14)

		# -, --, -=
		@m.add_transition(start_state, '-', 15)
		@m.add_transition(15, '-', 16)
		@m.add_transition(15, '=', 17)

		# * , *=
		@m.add_transition(start_state, '*', 18)
		@m.add_transition(18, '=', 19)

		# /, /=
		@m.add_transition(start_state, '/', 20)
		@m.add_transition(20, '=', 21)

		# %, %=
		@m.add_transition(start_state, '%', 40)
		@m.add_transition(40, '=', 41)

		# [] () {} 
		@m.add_transition(start_state, '[', 42)
		@m.add_transition(start_state, ']', 43)
		@m.add_transition(start_state, '(', 44)
			@m.add_transition(start_state, ")", 45)
			@m.add_transition(start_state, '{', 46)
			@m.add_transition(start_state, '}', 47)

		# STRING SI CHAR
		# string
		@m.add_transition(start_state, '"', 48)
		(32..255).each do |i|  # pot avea orice caracter in stringul ala
			if i != 34 and i != 92
				@m.add_transition(48, i.chr, 48)
        @m.add_transition(101, i.chr, 101) #aici
			end
		end
		@m.add_transition(48, '"', 49)
    @m.add_transition(101, '"', 49)
		   # cu caractere de escape

		   @m.add_transition(48, '\\', 50)
		"n,t,r,0,\",',\\".split(',').each do |char| # caractere de escape
			@m.add_transition(50, char, 48)
		end

		# CHARS
		@m.add_transition(start_state, "'", 51)
		(32..255).each do |i|  # pot avea orice caracter in stringul ala
			if i != 39 and i != 92
				@m.add_transition(51, i.chr, 52)
			end
		end
		@m.add_transition(51, '\\', 54)
		"n,t,r,0,\",',\\".split(',').each do |char| # caractere de escape
			@m.add_transition(54, char, 52)
		end
		@m.add_transition(52, "'", 53)

		# numere in HEXA
		@m.add_transition(start_state, '0', 59)
		@m.add_transition(59, 'x', 60)
		('a'..'f').each do |letter|
			@m.add_transition(60, letter, 61)
			@m.add_transition(61, letter, 61)
		end
		('A'..'F').each do |letter|
			@m.add_transition(60, letter, 61)
			@m.add_transition(61, letter, 61)
		end

		#numere in octal
		('0'..'8').each do |c| 
			@m.add_transition(59, c, 62) 
			@m.add_transition(62, c, 62)
		end

    # tratare spatii goale
    @m.add_transition(start_state, ' ', start_state)
    @m.add_transition(start_state, "\n", start_state)
    @m.add_transition(start_state, "\t", start_state)

    # , ; : . ? ...
    @m.add_transition(start_state, ',', 55)
    @m.add_transition(start_state, ';', 56)
    @m.add_transition(start_state, ':', 57)
    @m.add_transition(7, '.', 67)
    @m.add_transition(67, '.', 68)

    @m.add_transition(start_state, '?', 66)

    # comentarii multiline
    @m.add_transition(20, '*', 63)
    @m.add_transition(63, '*', 64)
    @m.add_transition(64, '*', 64)
    @m.add_transition(64, '/', start_state)
    (0..255).each do |i|
    	if i != 42
    		@m.add_transition(63, i.chr, 63)
    	end
    end

    (0..255).each do |i|
    	if i != 42 and i != 47
    		@m.add_transition(64, i.chr, 63)
      end
    end
    @m.add_transition(64, '/', start_state)

    # AICI AM MODIFICAT
    @m.add_transition(50, "\n", 101)
    @m.add_transition(101, "\\", 50)
    # AICI FINAL

    # comentarii single line
    @m.add_transition(20, '/', 65)
    (0..255).each do |i|
    	if i != 10
    		@m.add_transition(65, i.chr, 65)
    	else
    		@m.add_transition(65, i.chr, start_state)
    	end
    end

    @m.add_transition(start_state, '#', 100) # preprocessor

		# ==============================
		# 		  STARI FINALE
		# ==============================
		final_states = [1, 3, 4, 6, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 25, 26, 27, 22, 23, 24, 28,
                    29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,41, 42, 43, 44, 45, 46, 47, 49, 53, 55,
                    56, 57, 7, 59, 61, 62, 66, 68, 69, 70, 73, 74, 100
		]
		final_states.each { |state| @m.accept_states << state }


	end

	def reset_dfa()
		@m.current_state = @m.start_state
	end

	def print_automaton
		@m.x_visualize
	end
end