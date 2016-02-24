function [out] = inverse(A)
out = eye(length(A));
if A(1, 1) == 0
    for i = 1:length(A)
        if A(i, 1) ~= 0, break, end
    end
    temp = A(1, :);
    tempI = out(1, :);
    A(1, :) = A(i, :);
    out(1, :) = out(i, :);
    A(i, :) = temp;
    out(i, :) = tempI;
end
for c = 1:length(A)
    if A(c, c) ~= 1
        out(c, :) = out(c, :) / A(c, c);
        A(c, :) = A(c, :) / A(c, c);
    end
    for r = c+1:length(A)
        out(r, :) = out(r, :) - (out(c, :) * A(r, c));
        A(r, :) = A(r, :) - (A(c, :) * A(r, c));
    end
end
for c = 2:length(A)
    for r = 1:c-1
        out(r, :) = out(r, :) - (out(c, :) * A(r, c));
        A(r, :) = A(r, :) - (A(c, :) * A(r, c));
    end
end
end