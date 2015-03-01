## Copyright (C) 2015 Bogdan
## 
function [K] = cauta (a, b, err)
   format long
   c = (a * f(b) - b * f(a)) / (f(b) - f(a));
   for n = 1:100
      oldC = c;
      if (f(a) * f(c) < 0)
        b = c;
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
      end
      if (f(a) * f(c) > 0)
        a = c;
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
      end
      if (abs(c - oldC) < err) && (abs(f(c)) < err)
        K = c;
        n = 1000;
      end
   end
endfunction
