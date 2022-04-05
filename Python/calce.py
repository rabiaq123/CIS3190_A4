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

    for i in range(numDigits): # upper bound of for loop is exclusive
        if result[i] != None:
            if i == 1:
                file.write(".")
            file.write(str(result[i]))

    file.close()
    return


# calculating e
# NOTE: numDec and result are n and d[] respectively, from the ALGOL-60 algo
# NOTE: m-2 is used in coef[] calculations because Python list indices start from 0 
    # (can't have start index of 2 as was done in the algo provided)
# ASK: should the last digit be rounded?
def ecalculation(numDec, result):
    test = (numDec + 1) * 2.30258509
    m = 4 + 1

    # if base is not specified, math.log returns the natural logarithm (base e) of the first argument
    while test >= (m * (math.log(m) - 1.0) + 0.5 * math.log(6.2831852 * m)):
        m += 1

    # used in nested for loop
    carry, temp = 0,0
    coef = [1] * (m - 2) # create list with (m-2) elements and initialize all elements with 1
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
