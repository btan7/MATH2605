function [Xsol LUerror XsolError] = solve_lu_b(A, b)
[L U LUerror] = lu_fact(A);
[m n] = size(L);
[o p] = size(b);
y = ones(m, p);
for r = 1:m
    for c = 1:p
        y(r,c) = sum(L(r, :) .* (b(:, c)'));
    end
end
y = matrixMultiplication(inverse(L), b);
Xsol = matrixMultiplication(inverse(U), y);
%%Solve for x
%L*y = x
% Ui = inverse(U);
% [dog meat] = size(Ui);
% [bark woof] = size(y);
% Xsol = ones(dog, woof);
% for r = 1:dog
%     for c = 1:woof
%         Xsol(r,c) = sum(Ui(r, :) .* (y(:, c)'));
%     end
% end
AXsol = matrixMultiplication(A, Xsol);
E = abs(AXsol - b);
E1 = eye(length(E));
for i = 1:length(E)
    E1(i) = sum(E(i, :));
end
%error is maximum row sum
XsolError = abs(E1(1));
for i = 2:length(E1)
    if abs(E1(i)) > XsolError
        XsolError = E1(i);
    end
end
end
% %%Find U
% %Row reduce until matrix is upper triangular
% U = A;
% if U(1, 1) == 0
%     for i = 1:length(U)
%         if U(i, 1) ~= 0, break, end
%     end
%     temp = U(1, :);
%     U(1, :) = U(i, :);
%     U(i, :) = temp;
% end
% if U(1, 1) ~= 1
%     U(1, :) = U(1, :) / U(1, 1);
% end
% for c = 1:length(U)
%     if U(c, c) == 0
%         for ind = c:length(U)
%             if U(ind, c) ~= 0, break, end
%         end
%         temp = U(c, :);
%         U(c, :) = U(ind, :);
%         U(ind, :) = temp;
%     end
%     if U(c, c) ~= 1
%         U(c, :) = U(c, :) / U(c,c);
%     end
%     for r = c+1:length(U)
%         U(r, :) = U(r, :) - (U(c, :) * U(r, c));
%     end
% end
% %%Find L
% %Perform same row operations done for U on identity matrix
% matrix = U;
% out = eye(length(matrix));
% L = eye(length(matrix));
% if matrix(1, 1) == 0
%     for i = 1:length(matrix)
%         if matrix(i, 1) ~= 0, break, end
%     end
%     temp = matrix(1, :);
%     tempI = out(1, :);
%     matrix(1, :) = matrix(i, :);
%     out(1, :) = out(i, :);
%     matrix(i, :) = temp;
%     out(i, :) = tempI;
% end
% for c = 1:length(matrix)
%     if matrix(c, c) == 0
%         for ind = c:length(matrix)
%             if matrix(ind, c) ~= 0, break, end
%         end
%         temp = matrix(c, :);
%         matrix(c, :) = matrix(ind, :);
%         matrix(ind, :) = temp;
%     end
%     if matrix(c, c) ~= 1
%         out(c, :) = out(c, :) / matrix(c, c);
%         L(c, :) = L(c, :) / matrix(c, c);
%     end
%     for r = c+1:length(matrix)
%         out(r, :) = out(r, :) - (out(c, :) * matrix(r, c));
%         L(r, :) = L(r, :) - (L(c, :) * matrix(r, c));
%     end
% end
% for c = 2:length(matrix)
%     for r = 1:c-1
%         out(r, :) = out(r, :) - (out(c, :) * matrix(r, c));
%         L(r, :) = L(r, :) - (L(c, :) * matrix(r, c));
%     end
% end
% %%Ax = b, A = LU, (LU)x = b, y = Ux, Ly = b
% %[y1; y2; y3] = U * [x1; x2; x3]
% %L * [y1; y2; y3] = [b1; b2; b3];
% Ui = out;
% [m n] = size(A);
% [o p] = size(Ui);
% L = ones(m, p);
% for r = 1:m
%     for c = 1:p
%         L(r,c) = sum(A(r, :) .* (Ui(:, c)'));
%     end
% end
% L1 = eye(length(L));
% if L(1, 1) == 0
%     for i = 1:length(L)
%         if L(i, 1) ~= 0, break, end
%     end
%     temp = L(1, :);
%     tempI = L1(1, :);
%     L(1, :) = L(i, :);
%     L1(1, :) = L1(i, :);
%     L(i, :) = temp;
%     L1(i, :) = tempI;
% end
% for c = 1:length(L)
%     if L(c, c) ~= 1
%         L1(c, :) = L1(c, :) / L(c, c);
%         L(c, :) = L(c, :) / L(c, c);
%     end
%     for r = c+1:length(L)
%         L1(r, :) = L1(r, :) - (L1(c, :) * L(r, c));
%         L(r, :) = L(r, :) - (L(c, :) * L(r, c));
%     end
% end
% for c = 2:length(L)
%     for r = 1:c-1
%         L1(r, :) = L1(r, :) - (L1(c, :) * L(r, c));
%         L(r, :) = L(r, :) - (L(c, :) * L(r, c));
%     end
% end
% 
% [m n] = size(L1);
% [o p] = size(b);
% y = ones(m, p);
% for r = 1:m
%     for c = 1:p
%         y(r,c) = sum(L1(r, :) .* (b(:, c)'));
%     end
% end
% %%Solve for x
% %L*y = x
% [dog meat] = size(Ui);
% [bark woof] = size(y);
% Xsol = ones(dog, woof);
% for r = 1:dog
%     for c = 1:woof
%         Xsol(r,c) = sum(Ui(r, :) .* (y(:, c)'));
%     end
% end
% end