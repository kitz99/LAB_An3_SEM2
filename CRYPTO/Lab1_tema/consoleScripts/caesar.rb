class Caesar
	def encrypt(word, key)
		word != "" or return
		(0..25).include?(key) or return "Invalid Key"
		word = word.tr(("A".."Z").to_a.join, [*"A".."Z"].rotate(key).join)
		word
	end
	def decrypt(word, key)
		word != "" or return
		(0..25).include?(key) or return "Invalid Key"
		word = word.tr([*"A".."Z"].rotate(key).join, ("A".."Z").to_a.join)
		word
	end
end

C = Caesar.new
puts C.encrypt("ANA", 8)
puts C.decrypt("IVI", 8)