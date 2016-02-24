function [ xN N ] = jacobi_iter( x0,tol, M)
%Initialization
A = [1 1/2 1/3; 1/2 1 1/4; 1/3 1/4 1];
b = [0.1; 0.1; 0.1];
S = eye(3);
T = A;
T([1 5 9]) = [0 0 0];
T = -1*T;
xPrevious = x0;
N = 1;
while N <= M
    tempT = matrixMultiplication(T, xPrevious);
    xNew = tempT + b;
    if all(abs(xNew - xPrevious) < tol), break, end
    xPrevious = xNew;
    N = N + 1;
end
xN = xNew;
if N == M + 1;
    xN = NaN;
end
% xa = 0.1 - (1/2)*x0(2,1) - (1/3)*x0(3,1);
% xb = 0.1 - (1/2)*x0(1,1) - (1/4)*x0(3,1);
% xc = 0.1 - (1/3)*x0(1,1) - (1/4)*x0(2,1);
% xN = [xa xb xc]';
% N = 1;
% G = [10,10,10];
% 
% %Iteration
% while M >1 & (G(1) | G(2) | G(3))> tol
%     tempa = xa;
%     tempb = xb;
%     tempc = xc;
%     xa = 0.1 - (1/2)*xb - (1/3)*xc;
%     xb = 0.1 - (1/2)*xa - (1/4)*xc;
%     xc = 0.1 - (1/3)*xa - (1/4)*xb;
%     M = M-1;
%     N = N+1;
%     xN = [xa xb xc]';
%     G = abs([(tempa-xa); (tempb-xb); (tempc-xc)]);
% end
end