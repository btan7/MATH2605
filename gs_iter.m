function [ xN N ] = gs_iter( x0,tol, M)
%Initialization
A = [1 1/2 1/3; 1/2 1 1/4; 1/3 1/4 1];
b = [0.1; 0.1; 0.1];
S = A;
S([4 7 8]) = [0 0 0];
Sinv = inverse(S);
T = zeros(3,3);
T([4 7 8]) = A([4 7 8]);
T = -1*T;
xPrevious = x0;
N = 1;
while N <= M
    tempT = matrixMultiplication(T, xPrevious);
    xNew = matrixMultiplication(Sinv, (tempT + b));
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
% while M >1 & (G(1) | G(2) | G(3))> tolerance
%     tempa = xa;
%     tempb = xb;
%     tempc = xc;
%     xa = 0.1 - (1/2)*tempb - (1/3)*tempc;
%     xb = 0.1 - (1/2)*tempa - (1/4)*tempc;
%     xc = 0.1 - (1/3)*tempa - (1/4)*tempb;
%     M = M-1;
%     N = N+1;
%     xN = [xa xb xc]';
%     G = abs([(tempa-xa); (tempb-xb); (tempc-xc)]);
% end

% %initialization
% A = [1 1/2 1/3; 1/2 1 1/4; 1/3 1/4 1];
% b = [0.1; 0.1; 0.1];
% 
% %getting the D....
% D = [A(1,1),0,0;0,A(2,2),0;0,0,A(3,3)];
% 
% %Row Reduction to Upper Echelon Form... Hopefully...
% U = A;
% U(1,:) = U(1,:)/U(1,1);
% U(2,:) = U(2,:) - (U(1,:)*U(2,1));
% U(3,:) = U(3,:) - (U(1,:)*U(3,1));
% U(2,:) = U(2,:)/U(2,2);
% U(3,:) = U(3,:) - (U(2,:)*U(3,2));
% U(3,:) = U(3,:)/U(3,3);
% 
% %Row Reduction to Lower Echelon Form... Hopefully...
% L = A;
% L(1,:) = A(3,:);
% L(3,:) = A(1,:);
% L(1,:) = L(1,:)/L(1,1);
% L(2,:) = L(2,:) - (L(1,:)*L(2,1));
% L(3,:) = L(3,:) - (L(1,:)*L(3,1));
% L(2,:) = L(2,:)/L(2,2);
% L(3,:) = L(3,:) - (L(2,:)*L(3,2));
% L(3,:) = L(3,:)/L(3,3);
% temp = L;
% L(1,:) = temp(3,:);
% L(3,:) = temp(1,:);
% 
% %Jacobi: D*X(k+1) = -(L + U)*X(k) + b........ I don't know what I'm doing
% %but here :)
% xN = 0;
% N = 0;
end

