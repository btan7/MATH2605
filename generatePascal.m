function P = generatePascal(n)
P = ones(n,n);
for row = 2:n
    for col = 2:n
        P(row,col) = P(row - 1, col) + P(row,col - 1);
    end
end     
end