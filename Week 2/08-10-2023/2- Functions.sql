-- Function'lar return dondurmek zorundadir.
Declare
    ToplamSayi Number;
    
    Function Toplam(Sayi1 Number, Sayi2 Number) Return Number IS
    -- Function Toplam(Sayi1 IN Number, Sayi2 IN Number) Return Number IS
    -- IN kullanimi tercihe baglidir.
        Sayi3 Number;
        Begin
            Sayi3 := Sayi1 + Sayi2;
            Return(Sayi3);
        End;
Begin
    ToplamSayi := Toplam(99, 100);
    dbms_output.put_line('Toplam: ' || ToplamSayi);
End;

/

-- Procedure ve Function kullanarak Calisanlar? listeleyelim
-- Nested Functions
-- PROCEDURE ve FUNCTION Bir arada kullanal?m
DECLARE
      FUNCTION dept_name(p_dept departments.department_id%type)
              RETURN departments.department_name%type IS

      wdeptname departments.department_name%type;

      BEGIN
            SELECT department_name INTO wdeptname
            FROM DEPARTMENTS
            WHERE department_id = p_dept;

            RETURN(wdeptname);

            EXCEPTION WHEN NO_DATA_FOUND THEN
              RETURN(null);
      END;

      PROCEDURE emp_oku (p_dept departments.department_id%type) IS
        BEGIN

            dbms_output.put_line(p_dept || '-' || dept_name(p_dept));
            dbms_output.new_line;

            FOR I IN (SELECT employee_id, last_name FROM EMPLOYEES WHERE department_id = p_dept) 
            LOOP
                  dbms_output.put_line(I.employee_id || ' ' || I.last_name);
            END LOOP;
        End;
Begin
    emp_oku(60);
End;

/

-- Tum departmanlari yazdirmak ve her departmandaki kisileri yazdirmak icin buraya nasil bir kod yazmaliyiz ?
-- Az once yazdigimiz 60 no icin yapiyordu simdi hepsi icin yapalim.

DECLARE
      FUNCTION dept_name(p_dept departments.department_id%type)
              RETURN departments.department_name%type IS

      wdeptname departments.department_name%type;

      BEGIN
            SELECT department_name INTO wdeptname
            FROM DEPARTMENTS
            WHERE department_id = p_dept;

            RETURN(wdeptname);

            EXCEPTION WHEN NO_DATA_FOUND THEN
              RETURN(null);
      END;

      PROCEDURE emp_oku (p_dept departments.department_id%type) IS
        BEGIN
            
            dbms_output.put_line(p_dept || '-' || dept_name(p_dept));
            dbms_output.put_line('***********************************');
            dbms_output.new_line;

            FOR I IN (SELECT employee_id, last_name FROM EMPLOYEES WHERE department_id = p_dept) 
            LOOP
                  dbms_output.put_line('Emp id: ' ||I.employee_id || '  - Emp l.name: ' || I.last_name);
            END LOOP;
        End;
Begin
    For i in (Select department_id From Departments)
    Loop
        emp_oku(i.department_id);
    End Loop;
End;

/

-- Ornegimizi Cursor tan?mlay?p yapal?m
DECLARE
      Cursor c_dept IS Select Department_id From Departments;
      r_dept c_dept%rowtype;

      FUNCTION dept_name(p_dept departments.department_id%type)
              RETURN departments.department_name%type IS
      wdeptname departments.department_name%type;
      BEGIN
            SELECT department_name INTO wdeptname FROM DEPARTMENTS
            WHERE department_id = p_dept;
            RETURN(wdeptname);

            EXCEPTION WHEN NO_DATA_FOUND THEN
              RETURN(null);
      END;

      PROCEDURE emp_oku (p_dept departments.department_id%type) IS
        BEGIN
            dbms_output.new_line;
            dbms_output.put_line(p_dept || '-' || dept_name(p_dept));
            dbms_output.put_line('------------------------------------');
            FOR I IN (SELECT employee_id, first_name, last_name FROM EMPLOYEES WHERE department_id = p_dept) LOOP
                  dbms_output.put_line('       ' || I.employee_id || ' ' || I.first_name || ' ' || I.last_name);
            END LOOP;
        End;
Begin
    Open c_dept;
        Loop
            Fetch c_dept into r_dept;
            Exit When c_dept%NotFound;
            emp_oku(r_dept.Department_id);

 

        End Loop;
    Close c_dept;    
End;

/

-- Ornegimizde Procedure icerisinde Function direk dbms icinde kulland?k
-- simdi bunu degiskene aktararak yapal?m

DECLARE
      Cursor c_dept IS Select Department_id From Departments;
      r_dept c_dept%rowtype;

      FUNCTION dept_name(p_dept departments.department_id%type)
              RETURN departments.department_name%type IS
      wdeptname departments.department_name%type;
      BEGIN
            SELECT department_name INTO wdeptname FROM DEPARTMENTS
            WHERE department_id = p_dept;
            RETURN(wdeptname);

            EXCEPTION WHEN NO_DATA_FOUND THEN
              RETURN(null);
      END;

      PROCEDURE emp_oku (p_dept departments.department_id%type) IS
        wdept_adi departments.department_name%type;
        BEGIN
            wdept_adi:= dept_name(p_dept);
            dbms_output.new_line;
            dbms_output.put_line(p_dept || '-' || wdept_adi);
            dbms_output.put_line('------------------------------------');
            FOR I IN (SELECT employee_id, first_name, last_name FROM EMPLOYEES WHERE department_id = p_dept) LOOP
                  dbms_output.put_line('       ' || I.employee_id || ' ' || I.first_name || ' ' || I.last_name);
            END LOOP;
        End;
Begin
    Open c_dept;
        Loop
            Fetch c_dept into r_dept;
            Exit When c_dept%NotFound;
            emp_oku(r_dept.Department_id);

 

        End Loop;
    Close c_dept;    
End;

/

-- Procedure icerisinden Function cagrilabilir ve
-- Function icerisinden Procedure cagrilabilir
-- Her ikiside olur
-- Ayr?ca Select icerisinde de Function kullan?labilir

-- Function yal?n halde bakal?m

DECLARE
      FUNCTION dept_name(p_dept departments.department_id%type)
              RETURN departments.department_name%type IS
      wdeptname departments.department_name%type;
      BEGIN
            SELECT department_name INTO wdeptname FROM DEPARTMENTS
            WHERE department_id = p_dept;
            RETURN(wdeptname);

            EXCEPTION WHEN NO_DATA_FOUND THEN
              RETURN(null);
      END;
Begin
      dbms_output.put_line('60 -' || dept_name(60));
End;

/

--*********************************************************************************************
/*
  B) Functions
      •	Standalone ya da Package içinde yaz?labilir
      •	Veritaban? içinde saklan?r. 
*/

 

--*********************************************************************************************

 

--*********************************************************************************************
/*
  Standalone Functions
  Syntax

 

CREATE [OR REPLACE] FUNCTION <function_adi>
        (Parametreler) IS
        RETURN <data_type>

Silmek icin        
DROP FUNCTION <function_adi>;

 

*/

 --*********************************************************************************************
/*
Nested Functions dersinde yazd???m?z ornegi, Standalone Function
seklinde yaz?p veritaban?nda kal?c? hale getirelim
*/
--*********************************************************************************************

Create Or Replace Function fnc_dept_name(p_dept departments.department_id%type)
    RETURN departments.department_name%type IS
    wdeptname departments.department_name%type;
    BEGIN
          SELECT department_name INTO wdeptname FROM DEPARTMENTS
          WHERE department_id = p_dept;
          RETURN(wdeptname);

          EXCEPTION WHEN NO_DATA_FOUND THEN
            RETURN(null);
    END;
/    

Create Or Replace Procedure Proc_emp_oku
    (p_dept departments.department_id%type) IS
    wdept_adi departments.department_name%type;
    BEGIN
        wdept_adi:= fnc_dept_name(p_dept);
        dbms_output.new_line;
        dbms_output.put_line(p_dept || '-' || wdept_adi);
        dbms_output.put_line('------------------------------------');
        FOR I IN (SELECT employee_id, first_name, last_name FROM EMPLOYEES WHERE department_id = p_dept)
        LOOP
              dbms_output.put_line('       ' || I.employee_id || ' ' || I.first_name || ' ' || I.last_name);
        END LOOP;
    End;
/

DECLARE
Begin
    Proc_emp_oku(100); 
End;

/

DECLARE
      Cursor c_dept IS Select Department_id From Departments;
      r_dept c_dept%rowtype;    
Begin
    Open c_dept;
        Loop
            Fetch c_dept into r_dept;
            Exit When c_dept%NotFound;
            Proc_emp_oku(r_dept.Department_id);
        End Loop;
    Close c_dept;    
End;

/

