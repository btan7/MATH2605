function [Q R error] = qr_fact_househ(file)
fh = fopen(file);
line = '';
while ~feof(fh)
    line = [line char(10) fgetl(fh)];
end
A = str2num(line);
fclose(fh);
n = length(A);
I = eye(n);
u = A(:, 1);
normu = 0;
for i = 1:length(u)
    normu = normu + u(i)^2;
end
normu = sqrt(normu);
if u(1) <0
    normu = normu * -1;
end
u(1, 1) = u(1, 1) + normu;
cont = false;
for i = 2:length(u)
    if u(i) ~= 0
        cont = true;
    end
end
if cont
    %%U = u*u'
    utrans = u';
    [m n] = size(u);
    [o p] = size(utrans);
    U = ones(m, p);
    for r = 1:m
        for c = 1:p
            U(r,c) = sum(u(r, :) .* (utrans(:, c)'));
        end
    end
    normu = 0;
    for i = 1:length(u)
        normu = normu + u(i)^2;
    end
    U = U / normu;
    H1 = I - 2*U;
    %%Find A1
    %A1 = H1 * A
    [m n] = size(H1);
    [o p] = size(A);
    A1 = ones(m, p);
    for r = 1:m
        for c = 1:p
            A1(r,c) = sum(H1(r, :) .* (A(:, c)'));
        end
    end
end
%call helper function until R is upper triangular
Q = H1;
int = 1;
[Q R] = qr_fact_househelper(A1, Q, int); %lol househelper
%%After the last recursive call, Q and R are finalized such that ...
%%Q'*Q = identity, R is upper triangular, and Q*R = A
%Multiply Q and R to get Ahat
[m n] = size(Q);
[o p] = size(R);
Ahat = ones(m, p);
for r = 1:m
    for c = 1:p
        Ahat(r,c) = sum(Q(r, :) .* (R(:, c)'));
    end
end
%Find difference between calulated and theoretical matrices
E = abs(A - Ahat);
E1 = eye(length(E));
for i = 1:length(E)
    E1(i) = sum(E(i, :));
end
%error is maximum row sum
error = abs(E1(1));
for i = 2:length(E1)
    if abs(E1(i)) > error
        error = E1(i);
    end
end
end

function [newQ Aij] = qr_fact_househelper(A, Q, int)
if false %Sorry lol
    newQ = Q;
    Ai = A;
else
    if int >= length(A)-1 %Terminating condition
        newQ = Q;
        Aij = A;
        return
    end
    %Submatrix of A
    subA = A;
    subA(1:int,:) = [];
    subA(:,1:int) = [];
    n = length(subA);
    I = eye(n);
    u = subA(:, 1);
    normu = 0;
    for i = 1:length(u)
        normu = normu + u(i)^2;
    end
    normu = sqrt(normu);
%     if u(1, 1) <0
%         normu = normu * -1;
%     end
    u(1, 1) = u(1, 1) + normu;
    cont = false;
    for i = 2:length(u)
        if u(i) ~= 0
            cont = true;
        end
    end
    if cont
        %%U = u*u'
        utrans = u';
        [m n] = size(u);
        [o p] = size(utrans);
        U = ones(m, p);
        for r = 1:m
            for c = 1:p
                U(r,c) = sum(u(r, :) .* (utrans(:, c)'));
            end
        end
        normu = 0;
        for i = 1:length(u)
            normu = normu + u(i)^2;
        end
        %Perform Householder on submatrix of A
        U = U / normu;
        Hsub = I - 2*U;
        Hi = eye(length(A));
        x = 1;
        y = 1;
        for i = int+1:length(Hi)
            for j = int+1:length(Hi)
                Hi(i,j) = Hsub(x,y);
                y = y + 1;
            end
            x = x + 1;
            y = 1;
        end
        %%Find A1
        %A1 = H1 * A
        [m n] = size(Hi);
        [o p] = size(A);
        
        Ai = ones(m, p);
        for r = 1:m
            for c = 1:p
                Ai(r,c) = sum(Hi(r, :) .* (A(:, c)'));
            end
        end
    end
    [m n] = size(Q);
    [o p] = size(Hi);
    Qi = ones(m, p);
    for r = 1:m
        for c = 1:p
            Qi(r,c) = sum(Q(r, :) .* (Hi(:, c)'));
        end
    end
    Q = Qi;
    int = int + 1;
    [newQ Aij] = qr_fact_househelper(Ai, Q, int);
end
end