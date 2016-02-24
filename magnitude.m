function [mag] = magnitude(A)
[m n] = size(A);
mag = 0;
for i = 1:m*n
    mag = mag + A(i)^2;
end
mag = sqrt(mag);