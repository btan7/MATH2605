function b = generateB(n)
b = ones(n,1);
for row = 1:n
    b(row,1) = 1/row;
end
end