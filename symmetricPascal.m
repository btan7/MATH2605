function [L U xSolByLU LUerror XsolErrorByLU QHouseh RHouseh xSolByHouseh HousehError XsolErrorByHouseh QGivens RGivens xSolByGivens GivensError XsolErrorByGivens] = symmetricPascal(n)
P = generatePascal(n);
b = generateB(n);
[L U LUerror] = lu_fact(P);
[xSolByLU LUerror XsolErrorByLU] = solve_lu_b(P, b);
[QHouseh RHouseh HousehError] = qr_fact_househ(P);
[xSolByHouseh HousehError XsolErrorByHouseh] = solve_qr_bh(P, b);
[QGivens RGivens GivensError] = qr_fact_givens(P);
[xSolByGivens GivensError XsolErrorByGivens] = solve_qr_b(P, b);
end