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
Shoes.app :title => "CAESAR CIPHER", :width => 500, :height => 500 do

  stack :margin => 10 do
    @input  = edit_box :width => 480, :height => 40
    myKey = "0"
    list_box items: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"],
     width: 120, choose: "0" do |list|
        myKey = Integer(list.text)
       @keys.text = list.text
   end
    button "Encrypt" do
      @output.clear
      c = Caesar.new
      plain = @input.text.upcase
      word = c.encrypt(plain, myKey)
      @output.append {para "Encrypted message: " + word}
    end
    @output = stack { title " " }

    @input1  = edit_box :width => 480, :height => 40
    myKey1 = "0"
    list_box items: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"],
     width: 120, choose: "0" do |list|
        myKey1 = Integer(list.text)
    end

    button "Decrypt" do
      @output1.clear
      c = Caesar.new
      plain = @input1.text.upcase
      word = c.decrypt(plain, myKey1)
      @output1.append {para "Decrypted message: " + word}
    end
    @output1 = stack { title " " }

  end

end
