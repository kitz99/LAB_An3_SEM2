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
		enc = matrix.join().to_s.gsub('.', "")
		return enc
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
		return decrypted_message
	end

end

Shoes.app :title => "Rails Fence", :width => 500, :height => 500 do

	stack :margin => 10 do
		@titlu = stack { title "Encrypt plain text:" }
		@input  = edit_box :width => 480, :height => 40
		@key = edit_line :width => 480
		button "Encrypt" do
			@output.clear
			word = @input.text
			word = word.gsub(/[^a-z0-9\s]/i, '').gsub(" ", '').upcase
			k = @key.text
			if k =~ /^\d+$/ or k == 0
				k = Integer(k)
				f = Fence.new
				encrypted = f.encrypt(word, k)
				@output.append {para "Encrypted message: " + encrypted}
			else
				@output.append {para "Invalid key" }
			end
		end
		@output = stack { title " " }


		@titlu1 = stack { title "Decrypt message:" }
		@input1  = edit_box :width => 480, :height => 40
		@key1 = edit_line :width => 480
		button "Decrypt" do
			@output1.clear
			word = @input1.text
			word = word.gsub(/[^a-z0-9\s]/i, '').gsub(" ", '').upcase
			k = @key1.text
			if k =~ /^\d+$/ or k == 0
				k = Integer(k)
				f = Fence.new
				decrypted = f.decrypt(word, k)
				@output1.append {para "Encrypted message: " + decrypted}
			else
				@output1.append {para "Invalid key" }
			end
		end
		@output1 = stack { title " " }

	end

end