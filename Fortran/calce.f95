! Rabia Qureshi
! 1046427
! April 8, 2022

program calce 
    implicit none

    ! variables
    character(len=100) :: filename
    integer, dimension(2000) :: result
    integer :: numDigits

    call printHeader()
    call getUserInput(numDigits, filename)
    call ecalculation(numDigits-1, result)
    call keepe(result, numDigits, filename)
    call printStatus()

    contains


! store value of e in user's requested ASCII file
subroutine keepe(result, numDigits, filename)
    implicit none
    
    integer, intent(in) :: numDigits
    character(len=100), intent(in) :: filename
    integer, dimension(2000), intent(inout) :: result
    integer :: i = 1

    ! open output file for printing
    open(unit=25,file=filename,status='replace',action='write')
    
    do while (i < numDigits+1)
        if (i == 2) then
            write(25,"(A)",advance='no') '.'
        end if
        write(25,"(I1.1)",advance='no') result(i) ! a 1-character int is used and 1 digit is displayed
        i = i+1
    end do

    close(25, status='keep')

    return
end subroutine keepe


! calculate e
! NOTE: numDec and result are n and d[] respectively, from the ALGOL-60 algo
! ASK: should the last digit be rounded?
subroutine ecalculation(numDec, result)
    implicit none

    integer, intent(in) :: numDec
    integer, dimension(2000), intent(out) :: result
    real :: test, mReal
    integer :: carry, temp, m=4, i, j
    integer, dimension(:), allocatable :: coef
    
    test = (numDec + 1) * 2.30258509
    ! used for nested for loop calculations
    carry = 0
    temp = 0
    
    ! if base is not specified, log() returns the natural logarithm (base e) of the first argument
    mReal = m
    do while (test >= (mReal * (log(mReal) - 1.0) + 0.5 * log(6.2831852 * mReal)))
        m = m + 1
        mReal = m
    end do

    allocate(coef(2:m))
    coef = 1 ! set all array elements to 1
    result(1) = 2 ! e's value begins with a 2

    do i = 2, numDec+1
        carry = 0
        do j = m, 2, -1
            temp = coef(j) * 10 + carry;
            carry = temp / (j);
            coef(j) = temp - carry * (j);
        end do
        result(i) = carry
    end do

    return
end subroutine ecalculation


! print message before exiting program
subroutine printStatus()
    implicit none

    write(*,"(A)") '----------------------------------------'
    write(*,"(A)") 'The result has been written to your file'
    write(*,"(A)") '----------------------------------------'
    write(*,*)

    return
end subroutine printStatus



! print program header/information 
subroutine printHeader()
    implicit none

    write(*,*)
    write(*,"(A)") '----------------------------------------'
    write(*,"(A)") 'Calculating e to many significant digits'
    write(*,"(A)") '----------------------------------------'

    return
end subroutine printHeader


! get (1) number of sig digits required for e calculation and (2) filename to store value in
subroutine getUserInput(numDigits, filename)
    implicit none

    integer, intent(out) :: numDigits
    character(len=100), intent(out) :: filename

    write(*,"(A)",advance='no') 'Enter number of significant digits you would like to see in the result: '
    read(*,*) numDigits
    write(*,"(A)",advance='no') 'Enter the name of the file in which you would like to store the calculated value of e: '
    read(*,*) filename

    return
end subroutine getUserInput


end program calce


! ASSIGNMENT DESCRIPTION
! 1. Translate the Algol-60 procedure to C.
! 2. Add a wrapper main program which calls the procedure. 
! The main program should also:
! 2.1. Prompt the user for the number of significant digits to calculate.
! 2.2. Prompt the user for the name of the file in which to store the value of e calculated.
! 2.3. Call the subprogram, keepe().
! 3. Create a subprogram, keepe(), which saves the value of e calculated in
! an ASCII file. It takes as input the calculated value of e, and the filename specified by the user.


! calculating e to n decimal places
! n+1 is the number of sig digits to calculate, we are getting this value from user input
    ! note that sig digits includes ALL digits
! digits of the result are placed in d[]
    ! d[0] is the whole number
    ! after printing d[0], print a decimal place into the output file, and then continue printing the other values
    ! these digits are calculated individually and may be printed one-by-one within the for loop labeled 'sweep'


! ALGORITHM
! n and d are passed into subprogram ecalculation(int n, int d[])
    ! n is an integer, d is an integer array containing the digits of the result
    ! d[] is an empty array when passed in
! int m = 4
! float test = (n+1) * 2.30258509
! do 
    ! m = m+1
    ! while test >= (m * (ln(m) - 1.0)) + 0.5 * ln(6.2831852 * m)
! int i, j, carry, temp, coef[2:m]
    ! for languages that allow it, like Ada, have a start index of 2 and end index of m 
    ! for other languages, have a start index of 0 and end index of m-2 
    ! num elements in coef[] will be m-2+1
! for (j=2; j<=m; j++) coef[j]=1
    ! initialize entire array with 1
    ! for languages that don't allow specifying the start index, j=0, and the condition should be j<=(m-2)
    ! i.e. exit loop after m (or m-2 for the appropriate language) is reached
! d[0]=2 -> this is the whole number of e 
! for (i=1; i<=n; i++) LABEL SWEEP
    ! carry=0
    ! for (j=m; j<=2; j--)
        ! this for loop is for digit generation
        ! NOTE that for unsupporting languages, it'll be j=m-2 and j<=0
        ! temp = coef[j] * 10 + carry
        ! carry = temp / j
        ! coef[j] = temp - carry * j
    ! d[i] = carry
