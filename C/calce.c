/* Rabia Qureshi
 * 1046427
 * April 8, 2022
 */

#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>


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
    fprintf(fptr, "\n");

    fclose(fptr);
}


// calculate e
// NOTE: numDec and result are n and d[] respectively, from the ALGOL-60 algo
void ecalculation(int numDec, int *result) {
    float test = (numDec + 1) * 2.30258509;
    int m = 4;
    // used for nested for loop calculations
    int carry = 0, temp = 0;

    // if base is not specified, log() returns the natural logarithm (base e) of the first argument
    do {
        m += 1;
    } while (test >= (m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m)));

    int *coef = (int *)calloc(m-1, sizeof(int)); // indices range from 0 to (m-2), so there are (m-2)+1 elements
    for (int i = 0; i < m-1; i++) coef[i] = 1; // set all array elements to 1

    result[0] = 2; // e's value begins with a 2
    for (int i = 1; i <= numDec; i++) {
        carry = 0;
        for (int j = m-2; j >= 0; j--) {
            temp = coef[j] * 10 + carry;
            // using j+2 below as it affects the value of carry and coef[j]
            // algo gives j a minimum value of 2 because it makes the coef array start at index 2
            // since C arrays start indexing from 0, j reaches 0 in the final loop iteration.
            carry = temp / (j+2);
            coef[j] = temp - carry * (j+2);
        }
        result[i] = carry;
    }

    free(coef);
    coef = NULL;
}


// get num sig digits and perform error checking on user input
int getNumSigDigits() {
    bool isDigit;
    char digits[4];
    int numDigits;

    while (!isDigit) {
        isDigit = true; // reset to true for every iteration
        memset(digits, 0, 4); // reset to NULL for each input
        printf("Enter number of significant digits you would like to see in the result: ");
        scanf("%s", digits);
        for (int i = 0; i < strlen(digits); i++) {
            if (!isdigit(digits[i])) {
                isDigit = false;
            }
        }
        if (!isDigit) printf("Error: input must be numeric and non-negative.\n");
    }
    numDigits = (int)strtol(digits, (char **)NULL, 10); // convert string to integer

    return numDigits;
}


// get filename and display warning message for pre-existing output file
void getFilename(char *filename) {
    printf("\nEnter the name of the file in which you would like to store the calculated value of e: ");
    scanf("%s", filename);
    if (access(filename, F_OK) == 0) {
        printf("An output file with this name already exists. Overwriting file...\n");
    }
}


// wrapper main function
int main() {
    int result[2000];
    char filename[100];
    int numDigits;

    printHeader();

    // get user input
    numDigits = getNumSigDigits();
    getFilename(filename);

    // calculate e and store in file
    ecalculation(numDigits - 1, result);
    keepe(result, numDigits, filename);

    printStatus(filename);

    return 0;
}
