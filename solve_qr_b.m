function [Xsol QRerror XsolError] = solve_qr_b(A,b)
[Q R QRerror] = qr_fact_givens(A);
Qtrans = Q';
[m n] = size(Qtrans);
[o p] = size(b);
y = ones(m, p);
for r = 1:m
    for c = 1:p
        y(r,c) = sum(Qtrans(r, :) .* (b(:, c)'));
    end
end
Xsol = gauss(R, y);
AXsol = matrixMultiplication(A, Xsol');
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