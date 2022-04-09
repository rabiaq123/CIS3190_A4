# CIS3190 (Software for Legacy Systems) Assignment 4

Fun With Languages - Calculate e to many digits in Python, C, Fortran, and Ada.

## Author Information

* Name: Rabia Qureshi
* Email: rqureshi@uoguelph.ca
* Student ID: 1046427

## About the Repo

* `Assignment_4.pdf`: assignment doc
* `test801.txt`: sample output file to compare program output with for 801 significant digits
* `CIS3190 A4 Reflection Report - Rabia Qureshi.pdf`: reflection report on my experience with all four languages, and the benefits and limitations of using each for this task

## Compiling and Running

* Python: 
  * To compile and run: `python3 -Wall calce.py`
* C: 
  * To compile: `gcc -std=c99 -lm -Wall calce.c`
  * To run: `./a.out`
* Fortran:
  * To compile: `gfortran -Wall calce.f95`
  * To run: `./a.out`
* Ada:
  * To compile: `gnatmake -Wall calce.adb`
  * To run: `./calce`
