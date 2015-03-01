## Copyright (C) 2015 Bogdan
## 
function [K] = cauta (a, b, err, total)
  format long 
  A = a; B = b;
  n = 1;
  nr = 0;
  while n < 50
    c = (A + B) / 2;
    if (f(c) == 0) || ((B-A)/2 < err)
       K = c;
   	   n = 1000;	
    end
    n = n + 1;
    if sign(f(c)) == sign(f(A))
      A = c;
     else
      B = c;
    end
  end
endfunction