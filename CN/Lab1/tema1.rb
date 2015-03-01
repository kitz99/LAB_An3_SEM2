def sign(a)
	return -1 if a < 0e-15
	return 0 if a == 0e-15
	return 1 if a > 0e-15
end

def f(x)
	y = 1.0/2.0 + 1.0/4.0 * (x**2) - x * Math.sin(x) + 1.0/2.0 * Math.cos(2.0*x)
	y
end

def fd(x)
	y = 0.5 * x - Math.sin(x) - Math.sin(2.0 * x) - x * Math.cos(x)
	y
end

def bisection(a, b, err, total)
	x = a
	y = b
	n = 1
	nr = 0
	while n < total
		c = (x.to_f + y.to_f) / 2
		if (f(c) == 0) || ((y-x)/2 < err)
			k = c
			iter = n
		end
		n = n + 1
		if sign(f(c)) == sign(f(x))
			x = c
		else
			y = c
		end
	end
	puts "Numar de iterratii: #{iter}"
	return k
end


def chord(a, b, err, total)
	c = b - 0.2
	x = a + 0.2
	for n in 1..total
		oldX = x
		x = (c * f(oldX) - oldX * f(c))/(f(oldX) - f(c))

		if ((x - oldX).abs < err) and (f(x).abs < err)
		    puts "Numar de iteratii: #{n}"
			return x
		end
	end
end

def falsi(a, b, err, total)
	c = (a * f(b) - b * f(a)) / (f(b) - f(a))
	for n in 1..total
		oldC = c
		if (f(a) * f(c) < 0)
	        b = c;
	        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
	    end
	    if (f(a) * f(c) > 0)
	        a = c;
	        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
	    end

	    if ((c - oldC).abs < err) and (f(c).abs < err)
	    	puts "Numar de iteratii: #{n}"
	        return c
	    end
	end
end

def secant(a, b, err, total)
	x = Array.new()
	x[1] = a
	x[2] = b
	for i in 3..total
		x[i] = x[i-1] - (f(x[i-1]))*((x[i-1] - x[i-2])/(f(x[i-1]) - f(x[i-2])))
		
		if ((x[i] - x[i-1]).abs <= err) and f(x[i]).abs <= err
			puts "Numarul de iteratii: #{i}"
			return x[i]
		end 
	end
end

def newton(a, b, err, total)
	x = Array.new()
	x[1] = b - 1
	for i in 2..total
		x[i] = x[i - 1] - f(x[i-1]) / fd(x[i - 1])
		
		if ((x[i] - x[i-1]).abs <= err) and f(x[i]).abs <= err
			puts "Numarul de iteratii: #{i}"
			return x[i]
		end 
	end
end

def broke(x, y, err, total, cauta)
	for b in x..y
	    if sign(f(x)) != sign(f(b))
	      b = b + 1 if (b > 0) and (total ==101)
	      puts "Caut pe intervalul [#{x}, #{b}]"
	      sol = cauta.call(x, b, err, total);
	      puts sprintf('%.50f', sol)
	      x = b;
	    end
    end
end

def main
	print "A = "
	a = gets.chomp.to_i
	print "B = "
	b = gets.chomp.to_i
	print "err = "
	err = gets.chomp.to_f
	print "Metoda: "
	met = gets.chomp.to_s

	if a >= b
		puts "Interval invalid"
		return
	end

	if met == "b"
		broke(a, b, err, 100, method(:bisection))
	elsif met == "c"
		broke(a, b, err, 100, method(:chord))
	elsif met == "f"
		broke(a, b, err, 100, method(:falsi))
	elsif met == "s"
		broke(a, b, err, 101, method(:secant))
	elsif met == "n"
		broke(a, b, err, 101, method(:newton))
	else
		puts "metoda invalida"
	end
end

while true do
	puts "Aproximari numerice"
	main()
	puts
	puts "Introduceti r pentru a mai rula odata sau e pentru a iesi"
	arg = gets.chomp.to_s
	if arg == "e"
		puts "Exiting..."
		break
	elsif arg == "r"
		next
	else
		puts "Combinatie invalida --> Exiting..."
		break
	end
end