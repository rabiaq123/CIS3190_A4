-- Rabia Qureshi
-- 1046427
-- April 8, 2022

with ada.Text_IO; use Ada.Text_IO;
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with Ada.Strings; use Ada.Strings; 
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;


procedure calce is
    type any_list is array (integer range <>) of integer; -- upper and lower bounds are inclusive
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
        
        for i in 0..(numDigits-1) loop -- upper and lower bounds of for loop are inclusive
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
    procedure ecalculation(numDec: in integer; result: in out any_list) is
        test: constant float := float(numDec + 1) * 2.30258509;
        m: float := 4.0 + 1.0;
        carry, temp: integer := 0;
    begin
        -- find upper bound for coef array and set all elements to 1
        while (test >= (m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m))) loop
            m := m + 1.0;
        end loop;
        declare
            coef: any_list(2..integer(m));
        begin
            for i in 2..integer(m) loop
                coef(i) := 1;
            end loop;
            -- calculate and store digits in result array
            result(0) := 2; -- e's value begins with a 2
            for i in 1..numDec loop -- upper bound of for loop is inclusive
                carry := 0;
                for j in reverse 2..integer(m) loop
                    temp := coef(j) * 10 + carry;
                    carry := temp / (j);
                    coef(j) := temp - carry * (j);
                end loop;
                result(i) := carry;
            end loop;
        end;
    end ecalculation;


begin
    printHeader;
    getUserInput(numDigits, filename);
    ecalculation(numDigits-1, result);
    keepe(result, numDigits, filename);
    printStatus(filename);
end calce;
