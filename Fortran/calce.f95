! Rabia Qureshi
! 1046427
! April 8, 2022

program calce 
    implicit none

    call main()

    contains


! main wrapper program
subroutine main()
    implicit none

    character(len=100) :: filename
    integer, dimension(2000) :: result
    integer :: numDigits

    call printHeader()
    call getUserInput(numDigits, filename)
    call ecalculation(numDigits-1, result)
    call keepe(result, numDigits, filename)
    call printStatus()

    return
end subroutine main


! store value of e in user's requested ASCII file
subroutine keepe(result, numDigits, filename)
    implicit none
    
    integer, intent(in) :: numDigits
    character(len=100), intent(in) :: filename
    integer, dimension(2000), intent(inout) :: result
    integer :: i = 1

    ! open output file for printing
    open(unit=25,file=filename,status='replace',action='write')
    
    do while (i <= numDigits)
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
    do i = 2, numDec + 1 ! upper bound of for loop is inclusive
        carry = 0
        do j = m, 2, -1 ! starting and ending values of loop index followed by the increment
            temp = coef(j) * 10 + carry
            carry = temp / (j)
            coef(j) = temp - carry * (j)
        end do
        result(i) = carry
    end do

    deallocate(coef)

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

