function generateErrorPlots()
LUerrors = ones(1,11);
HousehErrors = ones(1,11);
GivensErrors = ones(1,11);
for n = 2:12
    [~, ~, ~, LUerror ~, ~, ~, ~, HousehError ~, ~, ~, ~, GivensError, ~] = symmetricPascal(n);
    LUerrors(n-1) = LUerror;
    HousehErrors(n-1) = log(HousehError);
    GivensErrors(n-1) = log(GivensError);
end
xvalues = 2:12;
figure;
subplot(3,1,1);
plot(xvalues, LUerrors, 'ko-');
title('LU Decomposition');
xlabel('N');
ylabel('error');

subplot(3,1,2);
plot(xvalues, HousehErrors, 'ko-');
title('QR Factorization by Householder Reflection');
xlabel('N');
ylabel('log(error)');

subplot(3,1,3);
plot(xvalues, GivensErrors, 'ko-');
title('QR Factorization by Givens Rotation');
xlabel('N');
ylabel('log(error)');
end