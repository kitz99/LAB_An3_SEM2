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
			elsif char == "\""
				rez << "\\"
				rez << '"'
			elsif char == "\'"
				rez << "\\"
				rez << "'"
			elsif char == "\\"
				rez << "\\"
				rez << "\\"
			else
				rez << char
			end
		end
		return rez
	end

	puts add_escape("ana\0".split(//))