## Copyright (C) 2015 Bogdan
## 
function [] = brokeInt (A, B, err)
  hold on;
  X = A:0.01:B;
  Y = 1.0/2.0 + 1.0/4.0 * X.^2 - X .* sin(X) + 1.0/2.0 * cos(2.0*X);
  plot(X, Y, 'r');
  for b = A:B
    if sign(f(A)) != sign(f(b))
      sol = cauta(A, b, err);
      sol
      plot(sol, f(sol), 'b')
      A = b;
    end
  end
  hold off;
endfunction
