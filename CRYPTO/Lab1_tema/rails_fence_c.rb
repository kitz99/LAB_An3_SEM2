class Fence
	def encrypt(word, k)
		col = word.length
		matrix = Array.new(k) { Array.new(col) { "." } }
		i = 0
		j = 0
		down = true
		up = false
		word.split(//).each do |c|
			matrix[i][j] = c
			j = j + 1
			if down
				if (i + 1) < k
					i = i + 1
				else
					down = false
					up = true
				end
			end
			if up
				if (i - 1) > 0
					i = i - 1
				else
					down = true
					up = false
					i = i -1
				end
			end
		end
		print_matrix(matrix, k, col)
		puts
		enc = matrix.join().to_s.gsub('.', "")
		puts "Enrypted message: #{enc}"
		enc
	end

	def decrypt(word, k)
		col = word.length
		matrix = Array.new(k) { Array.new(col) { "." } }
		i = 0
		j = 0
		down = true
		up = false
		c = 0
		arr = word.split(//)
		level = 0
		decrypted_message = ''
		while level < k
			if i == level 
				matrix[i][j] = arr[c]
				c = c + 1
			end
			if j + 1 >= col
				level = level + 1
				i = j = level
				down = true
				up = false
				next
			else
				j = j + 1
			end
			if down
				if (i + 1) < k
					i = i + 1
				else
					down = false
					up = true
				end
			end
			if up
				if (i - 1) > 0
					i = i - 1
				else
					down = true
					up = false
					i = i -1
				end
			end
		end
		print_matrix(matrix, k, col)
		puts
		i = 0
		j = 0
		down = true
		up = false
		word.split(//).each do
			decrypted_message += matrix[i][j]
			j = j + 1
			if down
				if (i + 1) < k
					i = i + 1
				else
					down = false
					up = true
				end
			end
			if up
				if (i - 1) > 0
					i = i - 1
				else
					down = true
					up = false
					i = i -1
				end
			end
		end
		puts "Decrypted message: #{decrypted_message}"
	end

	protected 
	def print_matrix(matrix, k, col)
		for i in (0..k-1) do
			for j in (0..col-1) do
				print matrix[i][j]
			end
			puts
		end
	end

end


def main
	puts "Insert word: "
	word = gets.chomp
	puts "Insert key"
	k = Integer(gets.chomp)
	word = word.gsub(/[^a-z0-9\s]/i, '').gsub(" ", '').upcase
	if k <= 0 
		puts "Key must be greater than 0"
	else
		cypher = Fence.new
		word1 = cypher.encrypt(word, k)
		puts
		cypher.decrypt(word1, k)
	end
end

main()



