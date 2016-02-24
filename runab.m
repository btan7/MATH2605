function runab(testa, testb)
fh = fopen(testa);
line = '';
while ~feof(fh)
    line = [line char(10) fgetl(fh)];
end
A = str2num(line);
fclose(fh);
fh2 = fopen(testb);
lineb = '';
while ~feof(fh2)
    lineb = [lineb char(10) fgetl(fh2)];
end
b = str2num(lineb);
fclose(fh2);
[L U LUerror] = lu_fact(A);
[xSolByLU LUerror XsolErrorByLU] = solve_lu_b(A, b);
[QHouseh RHouseh HousehError] = qr_fact_househ(A);
[xSolByHouseh HousehError XsolErrorByHouseh] = solve_qr_bh(A, b);
[QGivens RGivens GivensError] = qr_fact_givens(A);
[xSolByGivens GivensError XsolErrorByGivens] = solve_qr_b(A, b);
display('LU Decomposition: ');
display(char(10));
display('L: ');
display(L);
display(char(10));
display('U: ');
display(U);
display(char(10));
display('Xsol by LU Decomposition: ');
display(xSolByLU);
display(char(10));
display('LU error: ');
display(LUerror);
display(char(10));
display('Error in Xsol by LU Decomposition: '); 
display(XsolErrorByLU);
display(char(10));
display('QR Factorization by Householder Reflection: ');
display(char(10));
display('Q: '); 
display(QHouseh);
display('R: ');
display(RHouseh);
display(char(10));
display('Xsol by Householder Reflection: ')
display(xSolByHouseh);
display(char(10));
display('QR Error: ');
display(HousehError);
display(char(10));
display('Error in Xsol by Householder Reflection: ');
display(XsolErrorByHouseh);
display(char(10));
display('QR Factorization by Givens Rotation: ');
display(char(10));
display('Q: ');
display(QGivens);
display('R: ');
display(RGivens);
display(char(10));
display('Xsol by Givens Rotation');
display(xSolByGivens);
display(char(10));
display('QR Error: ');
display(GivensError);
display(char(10));
display('Error in Xsol by Givens Rotation: ');
display(XsolErrorByGivens);
display(char(10));
end