function [Q R error] = qr_fact_givens(file)
fh = fopen(file);
line = '';
while ~feof(fh)
    line = [line char(10) fgetl(fh)];
end
A = str2num(line);
fclose(fh);
n = length(A);
Aoriginal = A;
if n == 2
    col = A(:, 1);
    x = col(1);
    y = col(2);
    c = x / sqrt(x^2 + y^2);
    s = -y / sqrt(x^2 + y^2);
    rot = [c -s; s c];
    [m n] = size(rot);
    [o p] = size(A);
    R = ones(m, p);
    for r = 1:m
        for c = 1:p
            R(r,c) = sum(rot(r, :) .* (A(:, c)'));
        end
    end
    col2 = rot(:, 1);
    x2 = col2(1);
    y2 = col2(2);
    c2 = x2 / sqrt(x2^2 + y2^2);
    s2 = -y2 / sqrt(x2^2 + y2^2);
    Q = [c2 -s2; s2 c2];
    [m n] = size(Q);
[o p] = size(R);
Ahat = ones(m, p);
for r = 1:m
    for c = 1:p
        Ahat(r,c) = sum(Q(r, :) .* (R(:, c)'));
    end
end
%Find difference between calulated and theoretical matrices
E = A - Ahat;
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
else
    c1 = 1;
    add = 1;
    Q = eye(n);
    cont = true;
    while cont
        G = eye(n);
        x = A(c1, c1);
        y = A(c1 + add, c1);
        cosn = x / sqrt(x^2 + y^2);
        sinn = -y / sqrt(x^2 + y^2);
        G(c1, c1) = cosn;
        G(c1 + add, c1) = sinn;
        G(c1, c1 + add) = -sinn;
        G(c1 + add, c1 + add) = cosn;
        [m n] = size(G);
        [o p] = size(A);
        temp = ones(m, p);
        for r = 1:m
            for c = 1:p
                temp(r,c) = sum(G(r, :) .* (A(:, c)'));
            end
        end
        A = temp;
        Gtrans = G';
        [m n] = size(Q);
        [o p] = size(G');
        temp = ones(m, p);
        for r = 1:m
            for c = 1:p
                temp(r,c) = sum(Q(r, :) .* (Gtrans(:, c)'));
            end
        end
        Q = temp;
        if c1 + add == n
            c1 = c1 + 1;
            add = 1;
        else
            add = add + 1;
        end
        if c1 == n
            cont = false;
            R = A;
        end
    end
[m n] = size(Q);
[o p] = size(R);
Ahat = ones(m, p);
for r = 1:m
    for c = 1:p
        Ahat(r,c) = sum(Q(r, :) .* (R(:, c)'));
    end
end
%Find difference between calulated and theoretical matrices
E = Aoriginal - Ahat;
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
