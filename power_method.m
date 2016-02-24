function [ eval evec iterations] = power_method( A, v, tolerance, N)
%initializations
it = N;
[m n] = size(A);
[o p] = size(v);
B = ones(m, p);
for r = 1:m
    for c = 1:p
        B(r,c) = sum(A(r, :) .* (v(:, c)'));
    end
end
[y z] = max(abs(B));
H = B/(B(z));
G = 10;
iterations = 0;

%iteration
while N~=0 & G > tolerance
  [m n] = size(A);
  [o p] = size(B);
  temp = ones(m, p);
  for r = 1:m
      for c = 1:p
          temp(r,c) = sum(A(r, :) .* (B(:, c)'));
      end
  end
  B = temp;
  N = N-1;
  iterations = iterations + 1;
  temp = H;
  [y z] = max(abs(B));
  if y == 0
      tmp = B;
      tmp(z) = [];
      [y z] = max(abs(tmp));
  end
  H = B/(B(z));
  G = sum(abs(temp-H));
end

%defining outputs from loop
% evec = H./(magnitude(H));
evec = B/magnitude(B);
[m n] = size(A);
[o p] = size(H);
hi = ones(m, p);
for r = 1:m
    for c = 1:p
        hi(r,c) = sum(A(r, :) .* (H(:, c)'));
    end
end
eval = abs((sum((hi).*H))/(sum(H.^2)));
if iterations == it
    evec = NaN;
    eval = NaN;
end
end