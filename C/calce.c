// ASSIGNMENT DESCRIPTION
// 1. Translate the Algol-60 procedure to C.
// 2. Add a wrapper main program which calls the procedure. 
// The main program should also:
// 2.1. Prompt the user for the number of significant digits to calculate.
// 2.2. Prompt the user for the name of the file in which to store the value of e calculated.
// 2.3. Call the subprogram, keepe().
// 3. Create a subprogram, keepe(), which saves the value of e calculated in
// an ASCII file. It takes as input the calculated value of e, and the filename specified by the user.


// calculating e to n decimal places
// n+1 is the number of sig digits to calculate, we are getting this value from user input
    // note that sig digits includes ALL digits
// digits of the result are placed in d[]
    // d[0] is the whole number
    // after printing d[0], print a decimal place into the output file, and then continue printing the other values
    // these digits are calculated individually and may be printed one-by-one within the for loop labeled 'sweep'


// ALGORITHM
// n and d are passed into subprogram ecalculation(int n, int d[])
    // n is an integer, d is an integer array containing the digits of the result
    // d[] is an empty array when passed in
// int m = 4
// float test = (n+1) * 2.30258509
// do 
    // m = m+1
    // while test >= (m * (ln(m) - 1.0)) + 0.5 * ln(6.2831852 * m)
// int i, j, carry, temp, coef[2:m]
    // for languages that allow it, like Ada, have a start index of 2 and end index of m 
    // for other languages, have a start index of 0 and end index of m-2 
    // num elements in coef[] will be m-2+1
// for (j=2; j<=m; j++) coef[j]=1
    // initialize entire array with 1
    // for languages that don't allow specifying the start index, j=0, and the condition should be j<=(m-2)
    // i.e. exit loop after m (or m-2 for the appropriate language) is reached
// d[0]=2 -> this is the whole number of e 
// for (i=1; i<=n; i++) LABEL SWEEP
    // carry=0
    // for (j=m; j<=2; j--)
        // this for loop is for digit generation
        // NOTE that for unsupporting languages, it'll be j=m-2 and j<=0
        // temp = coef[j] * 10 + carry
        // carry = temp / j
        // coef[j] = temp - carry * j
    // d[i] = carry
