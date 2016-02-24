function [boolean] = isUpperTriangular(A)
boolean = true;
for c = 1:length(A)
    for r = c+1:length(A)
        if A(r, c) ~= 0
            boolean = false;
        end
    end
end