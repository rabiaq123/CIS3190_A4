# Rabia Qureshi
# 1046427
# April 8, 2022

import math


# print program header/information
def printHeader():
    print("\n")
    print("----------------------------------------", end="\n")
    print("Calculating e to many significant digits", end="\n")
    print("----------------------------------------", end="\n")
    return


# print message before exiting program
def printStatus(filename):
    print("----------------------------------------", end="\n")
    print("Please find your result in", filename, end="\n")
    print("----------------------------------------", end="\n")
    print("\n")
    return


# store value of e in user's requested ASCII file
def keepe(result, numDigits, filename):
    file = open(filename, "w")

    for i in range(numDigits):
        if result[i] != None:
            if i == 1:
                file.write(".")
            file.write(str(result[i]))

    file.close()
    return


# calculating e
# NOTE: that numDec and result are n and d[] respectively, from the ALGOL-60 algo
# NOTE: that m-2 is being used in calculations relating to coef[] because Python lists index from 0 
    # (can't start with 2 as was done in the algo provided)
# ASK: should the last digit be rounded?
def ecalculation(numDec, result):
    test = (numDec + 1) * 2.30258509
    m = 4 + 1

    # if base is not specified, math.log returns the natural logarithm (base e) of the first argument
    while test >= (m * (math.log(m) - 1.0) + 0.5 * math.log(6.2831852 * m)):
        m += 1

    # used in nested for loop
    carry, temp = 0,0
    coef = [1] * (m - 2) # create list and initialize all elements with 1
    result[0] = 2 # whole number is always 2

    for i in range(1, numDec + 1): # argument 1 is inclusive, argument 2 is exclusive
        carry = 0
        for j in reversed(range(m-2)): # start with m-2 and exit loop after reaching 0
            # not using [j+2] to access coeff elements because it has already been accounted for with the range of m-2
            temp = int(coef[j] * 10 + carry)
            # using j+2 below as it affects the value of carry and coef[j], since the algo assumes a minimum value of 2 for j 
            carry = int(temp / (j+2))
            coef[j] = int(temp - carry * (j+2))
        result[i] = carry

    return result


# get (1) number of sig digits required for e calculation and (2) filename to store value in
def getUserInput():
    numDigits = int(input("Enter number of significant digits you would like to see in the result: "))
    filename = input("Enter the name of the file in which you would like to store the calculated value of e: ")
    return numDigits, filename


# wrapper main function
def main():
    result = [None] * 2000 # declare and initialize 2000-element array with None to set all elements to null
    numDigits = 0
    filename = ""

    printHeader()
    numDigits, filename = getUserInput()
    ecalculation(numDigits-1, result)
    keepe(result, numDigits, filename)
    printStatus(filename)

    return


main()


# ASSIGNMENT DESCRIPTION
# [DONE] 1. Translate the Algol-60 procedure to Python.
# [DONE] 2. Add a wrapper main program which calls the procedure. 
# [DONE] The main program should also:
# 2.1. Prompt the user for the number of significant digits to calculate.
# 2.2. Prompt the user for the name of the file in which to store the value of e calculated.
# 2.3. Call the subprogram, keepe().
# [DONE] 3. Create a subprogram, keepe(), which saves the value of e calculated in
# an ASCII file. It takes as input the calculated value of e, and the filename specified by the user.


# calculating e to n decimal places
# n+1 is the number of sig digits to calculate, we are getting this value from user input
    # note that sig digits includes ALL digits
# digits of the result are placed in d[]
    # d[0] is the whole number
    # after printing d[0], print a decimal place into the output file, and then continue printing the other values
    # these digits are calculated individually and may be printed one-by-one within the for loop labeled 'sweep'


# ALGORITHM
# n and d are passed into subprogram ecalculation(int n, int d[])
    # n is an integer, d is an integer array containing the digits of the result
    # d[] is an empty array when passed in
# int m = 4
# float test = (n+1) * 2.30258509
# do 
    # m = m+1
    # while test >= (m * (ln(m) - 1.0)) + 0.5 * ln(6.2831852 * m)
# int i, j, carry, temp, coef[2:m]
    # for languages that allow it, like Ada, have a start index of 2 and end index of m 
    # for other languages, have a start index of 0 and end index of m-2 
    # num elements in coef[] will be m-2+1
# for (j=2; j<=m; j++) coef[j]=1
    # initialize entire array with 1
    # for languages that don't allow specifying the start index, j=0, and the condition should be j<=(m-2)
    # i.e. exit loop after m (or m-2 for the appropriate language) is reached
# d[0]=2 -> this is the whole number of e 
# for (i=1; i<=n; i++) LABEL SWEEP
    # carry=0
    # for (j=m; j<=2; j--)
        # this for loop is for digit generation
        # Note that for unsupporting languages, it'll be j=m-2 and j<=0
        # temp = coef[j] * 10 + carry
        # carry = temp / j
        # coef[j] = temp - carry * j
    # d[i] = carry
