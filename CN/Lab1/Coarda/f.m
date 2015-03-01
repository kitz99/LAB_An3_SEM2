## Copyright (C) 2015 Bogdan
## 
function [y] = f (x)
  y = 1.0/2.0 + 1.0/4.0 * x^2 - x * sin(x) + 1.0/2.0 * cos(2.0*x);
endfunction
