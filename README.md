# MATH2605
Part 1:
a) lu_fact takes in a filename for a .dat file containing an nxn matrix A in the form of a string. For example, running the following command for a file 'test.dat' :

	[L U LUerror] = lu_fact('test.dat')

will compute the Lu decomposition for the matrix in the file and display the outputs for L, U and LUError.

b) qr_fact_househ takes in a filename for a .dat file containing an nxn matrix A in the form of a string. For example, running the following command for a file 'test.dat' :

	[Q R QRerror] = qr_fact_househ('test.dat')

will compute the QR factorization for the matrix in the file using householder and display the outputs for Q, R and QRError.

qr_fact_givens takes in a filename for a .dat file containing an nxn matrix A in the form of a string. For example, running the following command for a file 'test.dat' :

	[Q R QRerror] = qr_fact_givens('test.dat')

 will compute the QR factorization for the matrix in the file using Givens and display the outputs for Q, R and QRError.

c) The code for solving a system Ax = b can be solved using two different methods. Both will solve the system using LU Decomposition and QR factorizations by both householder and givens and display all the required outputs in the command window. 

The first is runaug.m. runaug takes in one filename as a string. The file must contain an n x (n+1) augmented matrix [A|b] where A is n x n and b is n x 1. 
For example, running the following command for a file 'testaug.dat' :

	runaug('testaug.dat')

will solve using all the appropriate methods and display all required outputs.

The second is runab.m. runab acts similar to runaug but takes in two filenames as strings, one containing the n x n matrix A and the other containing the n x 1 matrix b. 
For example , running the following command for a file 'testa.dat' containing A and a file 'testb.dat' containing b :

	runab('testa.dat', 'testb.dat')

will solve using all the appropriate methods and display all required outputs.  

d) the symmetricPascal method takes in an integer value and generates P and b matrices for that value of n. It then performs LU and both QR methods and returns all relevant outputs. In order to display these in the command window when running simply copy and paste the following command in the command line (which we have conveniently included here to make your life easier :3 ), replacing n with the desired value:

[L U xSolByLU LUerror XsolErrorByLU QHouseh RHouseh xSolByHouseh HousehError XsolErrorByHouseh QGivens RGivens xSolByGivens GivensError XsolErrorByGivens] = symmetricPascal(n)

Part 2:
a) The function jacobi_iter.m, will take in three parameters: the initial 3 x 1 guess vector x0 of floating point numbers, an error tolerance number, and maximum number of iterations if the error tolerance is not satisfied. The function will output an approximate solution xN for N number of iterations.
Here is an example of what may be typed in the Command Window:

	x0 = [8; 1; 3];
	tol = .00005;
	M = 100;
	[xN N] = jacobi_iter(x0, tol, M)


b) Like the previous function, the function gs_iter.m takes the same three parameters as jacobi.iter.m. 
Here is an example of what may be typed in the Command Window:

	x0 = [7; 3; 9];
	tol = .00005;
	M = 100;
	[xN N] = jacobi_iter(x0, tol, M)


c, d) The function generateIterationData.m will output the error in approximation of the solution by Jacobi iteration, the error in approximating the solution by Gauss-Seidel iteration, and the average ratio of number of iterations by Jacobi method to the number of iterations by Gauss-Seidel method respectively. It takes in a single boolean parameter true or false; this input triggers the display of the error scatterplots.
For example, if this code were entered into the Command Window:

	[errorJ errorGS avgRatio] = generateIterationData(true)

the outputs would display in the Command Window, and MATLAB will display the the graphs for the errors; however, this statement:

	[errorJ errorGS avgRatio] = generateIterationData(false)

would only print the outputs stated without displaying the graphs.'

Part 3:
a) The function power_method.m uses the Power Method to approximate the dominant eigenvalue and its associated normalized eigenvector of an n x n matrix.It requires inputs of  a n x n matrix (A), a n x 1 matrix (v) of the initial approximation of the eigenvector, a tolerance parameter (tolerance), and the maximum number of iterations before quitting (N).

Implementing the function with matrix A = [1,1;1,1], matrix v = [1,1] transposed, a tolerance of 0.05, and a N of 50 would look like this:

	A = [1, 1; 1, 1]
	v = [1, 1]'
	tolerance = 0.05
	N = 50
	[eval evec iterations] = power_method(A, v, tolerance, N)

or simply

	[eval evec iterations] = power_method([1,1;1,1], [1,1]', 0.05, 50)

The result will be the eigenvalue, approximate eigenvector, and number of iterations completed.

b) The function powerMethodImplemented.m generates 100 random 2x2 matrices between with entries between the values of -2 and 2 and their inverses and implements power_method.m.

It takes in no inputs, so implementing the function would look like this:

	[inverse, A] = powerMethodImplemented()

The result would be the last matrix A generated and its inverse, and a new window would appear with 2 graphs: one of the determinants and traces of the 100 generated matrices and one of the determinants and traces of the inverses of the 100 generated matrices.
