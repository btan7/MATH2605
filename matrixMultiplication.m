function [AB] = matrixMultiplication(A, B)
[m n] = size(A);
[o p] = size(B);
AB = ones(m, p);
for r = 1:m
    for c = 1:p
        AB(r,c) = sum(A(r, :) .* (B(:, c)'));
    end
end
end