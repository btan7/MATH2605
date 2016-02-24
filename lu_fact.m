function [L U error] = lu_fact(file)
fh = fopen(file);
line = '';
while ~feof(fh)
    line = [line char(10) fgetl(fh)];
end
A = str2num(line);
fclose(fh);
U = A;
%%Checks that very first entry is nonzero
%If 0, swap with some other row
if U(1, 1) == 0
    for i = 1:length(U)
        if U(i, 1) ~= 0, break, end
    end
    temp = U(1, :);
    U(1, :) = U(i, :);
    U(i, :) = temp;
end
%%Checks first entry
%Makes first entry 1 to be easy pivot
if U(1, 1) ~= 1
    U(1, :) = U(1, :) / U(1, 1);
end
%%Row reducing to get U
%r = row, c = column
for c = 1:length(U)
    if U(c, c) == 0
        for ind = c:length(U)
            if U(ind, c) ~= 0, break, end
        end
        temp = U(c, :);
        U(c, :) = U(ind, :);
        U(ind, :) = temp;
    end
    if U(c, c) ~= 1
        U(c, :) = U(c, :) / U(c,c); %Makes pivot 1
    end
    for r = c+1:length(U)
        U(r, :) = U(r, :) - (U(c, :) * U(r, c)); %Makes entry below pivot 0
    end
end
%%Find inverse of U
%inverse.m
matrix = U;
out = eye(length(matrix));
if matrix(1, 1) == 0
    for i = 1:length(matrix)
        if matrix(i, 1) ~= 0, break, end
    end
    temp = matrix(1, :);
    tempI = out(1, :);
    matrix(1, :) = matrix(i, :);
    out(1, :) = out(i, :);
    matrix(i, :) = temp;
    out(i, :) = tempI;
end
for c = 1:length(matrix)
    if U(c, c) == 0
        for ind = c:length(U)
            if U(ind, c) ~= 0, break, end
        end
        temp = U(c, :);
        U(c, :) = U(ind, :);
        U(ind, :) = temp;
    end
    if matrix(c, c) ~= 1
        out(c, :) = out(c, :) / matrix(c, c);
        matrix(c, :) = matrix(c, :) / matrix(c, c);
    end
    for r = c+1:length(matrix)
        out(r, :) = out(r, :) - (out(c, :) * matrix(r, c));
        matrix(r, :) = matrix(r, :) - (matrix(c, :) * matrix(r, c));
    end
end
for c = 2:length(matrix)
    for r = 1:c-1
        out(r, :) = out(r, :) - (out(c, :) * matrix(r, c));
        matrix(r, :) = matrix(r, :) - (matrix(c, :) * matrix(r, c));
    end
end
Uinv = out;
%%Find L
%Multiply A * Uinv
%matrixMultiplication.m
[m n] = size(A);
[o p] = size(Uinv);
L = ones(m, p);
for r = 1:m
    for c = 1:p
        L(r,c) = sum(A(r, :) .* (Uinv(:, c)'));
    end
end
[rice bowl] = size(L);
Ahat = ones(rice, rice);
for r = 1:rice
    for c = 1:rice
        Ahat(r,c) = sum(L(r, :) .* (U(:, c)'));
    end
end
E = A - Ahat;
E1 = eye(length(E));
for i = 1:length(E)
    E1(i) = sum(E(i, :));
end
error = abs(E1(1));
for i = 2:length(E1)
    if abs(E1(i)) > error
        error = E1(i);
    end
end
% error = 0;
% for i = 1:rice*bowl
%     error = error + E(i)^2;
% end
% error = sqrt(error);
end