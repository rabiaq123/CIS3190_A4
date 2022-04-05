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
// NOTE: m-2 is used in coef[] calculations because C array indices start from 0 
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
