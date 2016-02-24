function [ inverse, A ] = powerMethodImplemented()
x1 = [];
x2 = [];
y1 = [];
y2 = [];
mu = 1000;
iteration1 = [];
iteration2 = [];
while mu > 0
    detA = 0;
    while detA == 0
        %Generating a 2x2 matrix of random numbers between -2 and 2
        A = 4*(rand(2))-2;

        %Separating matrix A by entry
        aA = A(1,1);
        bA = A(1,2);
        cA = A(2,1);
        dA = A(2,2);

        %Calculating the inverse matrix
        detA = (aA*dA)-(bA*cA);
    end
    inverse = (1/(detA))*([dA -bA;-cA aA]);

    %Implementing power method for original generated matrix
    [evalA, evecA, iterA] = power_method(A, [1;1], 0.00005, 100);
    
    %Implementing power method for inverse of generated matrix
    [evalIn, evecIn, iterIn] = power_method(inverse, [1;1], 0.00005, 100);

    %Making record of trace of matrix A
    traceA = aA + dA;

    %Separating the entries of and making record of trace and determinant of inverse matrix
    aIn = inverse(1,1);
    dIn = inverse(2,2);
    traceIn = aIn + dIn;
    detIn = 1/detA;

    x1 = [x1 detA];
    y1 = [y1 traceA];
    x2 = [x2 detIn];
    y2 = [y2 traceIn];
    iteration1 = [iteration1 iterA];
    iteration2 = [iteration2 iterIn];
    mu = mu-1;
end
cell = {};

%Graphing determinant and trace of matrix A
figure;

%Graphing determinant and trace of inverse matrix
initialB = 25;
subplot(2,1,1);
for n = 1:1000
    it = iteration1(n);
    tempB = initialB + 10*it;
    if tempB > 255
        tempB = 255;
    end
    rgbtrip = [0 0 tempB]*(1/255);
    plot(x1(n),y1(n),'x', 'Color', rgbtrip);
    if n == 1
        hold on;
    end
end
title('Matrix');
xlabel('Determinant');
ylabel('Trace');

initialG = 25;
subplot(2,1,2);
for n = 1:1000
    it = iteration2(n);
    tempG = initialG + 10*it;
    if tempG > 255
        tempG = 255;
    end
    rgbtrip = [0 tempG 0]*(1/255);
    plot(x2(n),y2(n),'x', 'Color', rgbtrip);
    if n == 1
        hold on;
    end
end
title('Inverse');
xlabel('Determinant');
ylabel('Trace');
%Still need color coding by iteration
end