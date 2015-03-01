## Copyright (C) 2015 Bogdan
## 
function [K] = cauta (a, b, err, total)
  format long
  c = b - 0.2;
  x = a + 0.2;
  for n = 1:100
    oldX = x;
    x = (c * f(oldX) - oldX * f(c))/(f(oldX) - f(c));
    
    if (abs(x - oldX) < err) && (abs(f(x)) < err)
      K = x;
      n = 1000;
    end
  end
endfunction