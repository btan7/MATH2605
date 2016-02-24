function [errorJ errorGS avgRatio] = generateIterationData(boolean)
x0 = cell(100, 1);
xnJacobi = cell(100, 2);
xnGaussSeidel = cell(100, 2);
tol = .00005;
M = 100;
for n = 1:100
    xinit= -1 + (1+1).*rand(3,1);
    x0{n} = xinit;
    [xnJ nJ] = jacobi_iter(xinit, tol, M);
    xnJacobi{n, 1} = xnJ;
    xnJacobi{n, 2} = nJ;
    [xnGS nGS] = gs_iter(xinit, tol, M);
    xnGaussSeidel{n, 1} = xnGS;
    xnGaussSeidel{n, 2} = nGS;
end
xApproxJacobi = xnJacobi{1,1};
for i = 2:100
    xApproxJacobi = xApproxJacobi + xnJacobi{n, 1};
end
xApproxJacobi = xApproxJacobi / 100;
xApproxGaussSeidel = xnGaussSeidel{1,1};
for i = 2:100
    xApproxGaussSeidel = xApproxGaussSeidel + xnGaussSeidel{n, 1};
end
xApproxGaussSeidel = xApproxGaussSeidel / 100;
xExact = [9/190; 28/475; 33/475];
errorJ = max(abs(xApproxJacobi - xExact));
errorGS = max(abs(xApproxGaussSeidel - xExact));
NJacobi = xnJacobi{1,2};
NGaussSeidel = xnGaussSeidel{1,2};
avgRatio = 0;
for n = 1:100
    NJacobi = xnJacobi{n,2};
    NGaussSeidel = xnGaussSeidel{n,2};
    ratio = NJacobi / NGaussSeidel;
    avgRatio = avgRatio + ratio;
end
avgRatio = avgRatio/100;
if boolean
    figure;
    subplot(2,1,1);
    for n = 1:100
        x0error = max(abs(x0{n} - xExact));
        y = xnJacobi{n, 2};
        plot(x0error,y,'kx');
        if n == 1
            hold on;
        end
    end
title('Jacobi');
xlabel('Initial Error');
ylabel('Iterations');

subplot(2,1,2);
    for n = 1:100
        x0error = max(abs(x0{n} - xExact));
        y = xnGaussSeidel{n, 2};
        plot(x0error,y,'bx');
        if n == 1
            hold on;
        end
    end
    title('Gauss Seidel');
    xlabel('Initial Error');
    ylabel('Iterations');
end
end