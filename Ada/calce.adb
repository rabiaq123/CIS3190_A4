-- Rabia Qureshi
-- 1046427
-- March 4, 2022

with ada.Text_IO; use Ada.Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Strings; use Ada.Strings; 
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;


procedure calce is
    type any_list is array (integer range <>) of integer;
    filename: unbounded_string;
    numDigits: integer;
    result: any_list(0..1999);


    -- print program header/information
    procedure printHeader is
    begin
        new_line;
        put_line("----------------------------------------");
        put_line("Calculating e to many significant digits");
        put_line("----------------------------------------");
    end printHeader;


    -- print message before exiting program
    procedure printStatus(filename: in unbounded_string) is
    begin
        put_line("----------------------------------------");
        put_line("Please find your result in " & filename);
        put_line("----------------------------------------");
        new_line;
    end printStatus;


    -- get (1) number of sig digits required for e calculation and (2) filename to store value in
    procedure getUserInput(numDigits: out integer; filename: in out unbounded_string) is
    begin
        put("Enter number of significant digits you would like to see in the result: ");
        get(numDigits);
        skip_line; -- skip newline that will come from enter on previous input
        put("Enter the name of the file in which you would like to store the calculated value of e: ");
        get_line(filename);
    end getUserInput;


    -- store value of e in user's requested ASCII file
    procedure keepe(result: in any_list; numDigits: in integer; filename: in unbounded_string) is
        fp: file_type;
    begin
        create(fp, out_file, to_string(filename));
        set_output(fp);
        
        for i in 0..(numDigits-1) loop
            if (i = 1) then
                put('.');
            end if;
            put(trim(integer'image(result(i)), ada.strings.Left));
        end loop;
        
        set_output(standard_output);
        close(fp);
    end keepe;


    -- calculate e
    -- NOTE: numDec and result are n and d[] respectively, from the ALGOL-60 algo
    -- ASK: should the last digit be rounded?
    procedure ecalculation(numDec: in integer; result: in out any_list) is
        test: constant float := float(numDec + 1) * 2.30258509;
        m: float := 4.0 + 1.0;
        carry, temp: integer := 0;
        coef: any_list(2..2000); 
    begin
        -- find upper bound for coef array and set all elements to 1
        while (test >= (m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m))) loop
            m := m + 1.0;
        end loop;
        for i in 2..integer(m) loop
            coef(i) := 1;
        end loop;

        -- calculate and store digits in result array
        result(0) := 2; -- e's value begins with a 2
        for i in 1..numDec loop
            carry := 0;
            for j in reverse 2..integer(m) loop
                temp := coef(j) * 10 + carry;
                carry := temp / (j);
                coef(j) := temp - carry * (j);
            end loop;
            result(i) := carry;
        end loop;
    end ecalculation;


begin
    printHeader;
    getUserInput(numDigits, filename);
    ecalculation(numDigits-1, result);
    keepe(result, numDigits, filename);
    printStatus(filename);
end calce;


-- ASSIGNMENT DESCRIPTION
-- 1. Translate the Algol-60 procedure to C.
-- 2. Add a wrapper main program which calls the procedure. 
-- The main program should also:
-- 2.1. Prompt the user for the number of significant digits to calculate.
-- 2.2. Prompt the user for the name of the file in which to store the value of e calculated.
-- 2.3. Call the subprogram, keepe().
-- 3. Create a subprogram, keepe(), which saves the value of e calculated in
-- an ASCII file. It takes as input the calculated value of e, and the filename specified by the user.


-- calculating e to n decimal places
-- n+1 is the number of sig digits to calculate, we are getting this value from user input
    -- note that sig digits includes ALL digits
-- digits of the result are placed in d[]
    -- d[0] is the whole number
    -- after printing d[0], print a decimal place into the output file, and then continue printing the other values
    -- these digits are calculated individually and may be printed one-by-one within the for loop labeled 'sweep'


-- ALGORITHM
-- n and d are passed into subprogram ecalculation(int n, int d[])
    -- n is an integer, d is an integer array containing the digits of the result
    -- d[] is an empty array when passed in
-- int m = 4
-- float test = (n+1) * 2.30258509
-- do 
    -- m = m+1
    -- while test >= (m * (ln(m) - 1.0)) + 0.5 * ln(6.2831852 * m)
-- int i, j, carry, temp, coef[2:m]
    -- for languages that allow it, like Ada, have a start index of 2 and end index of m 
    -- for other languages, have a start index of 0 and end index of m-2 
    -- num elements in coef[] will be m-2+1
-- for (j=2; j<=m; j++) coef[j]=1
    -- initialize entire array with 1
    -- for languages that don't allow specifying the start index, j=0, and the condition should be j<=(m-2)
    -- i.e. exit loop after m (or m-2 for the appropriate language) is reached
-- d[0]=2 -> this is the whole number of e 
-- for (i=1; i<=n; i++) LABEL SWEEP
    -- carry=0
    -- for (j=m; j<=2; j--)
        -- this for loop is for digit generation
        -- NOTE that for unsupporting languages, it'll be j=m-2 and j<=0
        -- temp = coef[j] * 10 + carry
        -- carry = temp / j
        -- coef[j] = temp - carry * j
    -- d[i] = carry
