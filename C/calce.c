/* Rabia Qureshi
 * 1046427
 * April 8, 2022
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>


// print program header/information
void printHeader() {
    printf("\n");
    printf("----------------------------------------\n");
    printf("Calculating e to many significant digits\n");
    printf("----------------------------------------\n");
}


// print message before exiting program
void printStatus(char *filename) {
    printf("----------------------------------------\n");
    printf("Please find your result in %s\n", filename);
    printf("----------------------------------------\n");
    printf("\n");
}


// store value of e in user's requested ASCII file
void keepe(int *result, int numDigits, char filename[100]) {
    FILE *fptr = fopen(filename, "w");

    for (int i = 0; i < numDigits; i++) {
        if (i == 1) {
            fprintf(fptr, ".");
        }
        fprintf(fptr, "%d", result[i]);
    }

    fclose(fptr);
}

// calculate e
// NOTE: numDec and result are n and d[] respectively, from the ALGOL-60 algo
// NOTE: m-2 is being used in calculations relating to coef[] because C arrays index from 0 
    // (can't have start index of 2 as was done in the algo provided)
// ASK: should the last digit be rounded?
void ecalculation(int numDec, int *result) {
    float test = (numDec + 1) * 2.30258509;
    int m = 4;
    // used for nested for loop calculations
    int carry = 0, temp = 0;

    // if base is not specified, log() returns the natural logarithm (base e) of the first argument
    do {
        m += 1;
    } while (test >= (m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m)));

    int *coef = (int *)calloc(m-2, sizeof(int));
    for (int i = 0; i < m-2; i++) coef[i] = 1; // set all array elements to 1
    result[0] = 2; // e's value begins with a 2

    for (int i = 1; i <= numDec; i++) {
        carry = 0;
        for (int j = m-2; j >= 0; j--) {
            // not using [j+2] to access coeff elements because it has already been accounted for with the m-2
            temp = coef[j] * 10 + carry;
            // using j+2 below as it affects the value of carry and coef[j], since the algo assumes a minimum value of 2 for j 
            carry = temp / (j+2);
            coef[j] = temp - carry * (j+2);
        }
        result[i] = carry;
    }
}


int main() {
    int result[2000];
    int numDigits;
    char filename[100];

    printHeader();
    
    // get user input
    printf("Enter number of significant digits you would like to see in the result: ");
    scanf("%d", &numDigits);
    printf("Enter the name of the file in which you would like to store the calculated value of e: ");
    scanf("%s", filename);

    // calculate e and store in file
    ecalculation(numDigits-1, result);
    keepe(result, numDigits, filename);

    printStatus(filename);

    return 0;
}


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
