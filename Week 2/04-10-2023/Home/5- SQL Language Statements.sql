-- SQL Language Statements ve PL/SQL Icinde Kullanimlari

-- DDL (Create - Alter - Drop) ve DCL (Grant - Revoke) Komutlari
-- Dinamic SQL (Execute Immediate) oldugundan PL/SQL icerisinde direk kullanilamazlar.
-- Bu komutlari Execute Immediate komutu ile kullanabiliriz.

-- DML (Select - Insert - Update - Delete) ve TCL (Commit - Rollback) Komutlari
    -- Static SQL oldugu icin PL/SQL icerisinde kullanilabilirler.


-- STATIC SQL KULLANIMI --
-- DML - TCL --
Declare
    emp_id          Employees.employee_id%TYPE;
    emp_first_name  Employees.first_name%TYPE := 'Ali';
    emp_last_name   Employees.last_name%TYPE := 'Topacik';
    emp_email       Employees.email%TYPE := 'alitopacik@gmail.com';
    emp_hire_date   Employees.hire_date%TYPE := '21-11*1973';
    emp_job_id      Employees.job_id%TYPE := 'PL/SQL';
Begin
    Select 
        Nvl(Max(employee_id), 0) + 1 
    Into emp_id
    From employees;
    
    Insert into Employees
        (employee_id, first_name, last_name, email, hire_date, job_id)
    Values
        (emp_id, emp_first_name, emp_last_name, emp_email, emp_hire_date, emp_job_id);
    
    Update Employees
    Set job_id = 'DBA'
    Where employee_id = emp_id;
    
    Commit;
       
    dbms_output.put_line(emp_id || ' ' ||
                       emp_first_name || ' ' ||
                       emp_last_name || ' ' ||
                       emp_email || ' ' ||
                       emp_hire_date || ' ' ||
                       emp_job_id);
End;

/

-- Asagidaki ornekte Update alani yok dolayisiyle job_id alanini 'DBA'ye cevirmeden ekleme yapiyor.
Declare
    emp_id          Employees.employee_id%TYPE;
    emp_first_name  Employees.first_name%TYPE := 'Ali';
    emp_last_name   Employees.last_name%TYPE := 'Topacik';
    emp_email       Employees.email%TYPE := 'alitopacik@gmail.com';
    emp_hire_date   Employees.hire_date%TYPE := '21-11*1973';
    emp_job_id      Employees.job_id%TYPE := 'PL/SQL';
Begin
    Select 
        Nvl(Max(employee_id), 0) + 1 
    Into emp_id
    From employees;
    
    Insert into Employees
        (employee_id, first_name, last_name, email, hire_date, job_id)
    Values
        (emp_id, emp_first_name, emp_last_name, emp_email, emp_hire_date, emp_job_id);
    
    Commit;
       
    dbms_output.put_line(emp_id || ' ' ||
                       emp_first_name || ' ' ||
                       emp_last_name || ' ' ||
                       emp_email || ' ' ||
                       emp_hire_date || ' ' ||
                       emp_job_id);
End;

/

-- Rollback komutu ustundeki islemleri geri alir, dolayisi ile tabloya veri ekleme islemi geri alinir.

Declare
    emp_id          Employees.employee_id%TYPE;
    emp_first_name  Employees.first_name%TYPE := 'Ali';
    emp_last_name   Employees.last_name%TYPE := 'Topacik';
    emp_email       Employees.email%TYPE := 'alitopacik@gmail.com';
    emp_hire_date   Employees.hire_date%TYPE := '21-11*1973';
    emp_job_id      Employees.job_id%TYPE := 'PL/SQL';
Begin
    Select 
        Nvl(Max(employee_id), 0) + 1 
    Into emp_id
    From employees;
    
    Insert into Employees
        (employee_id, first_name, last_name, email, hire_date, job_id)
    Values
        (emp_id, emp_first_name, emp_last_name, emp_email, emp_hire_date, emp_job_id);
    
    Rollback;
       
    dbms_output.put_line(emp_id || ' ' ||
                       emp_first_name || ' ' ||
                       emp_last_name || ' ' ||
                       emp_email || ' ' ||
                       emp_hire_date || ' ' ||
                       emp_job_id);
End;

/

Select * From Employees;

-- Savepoint --
-- Istenilen noktaya Rollback yapmak icin kullanilir.
-- Commit isleminden sonra tum Savepointler gecersiz olur.

-- Regions tablosunun bos bir kopyasini olusturalim.
Create Table RegionsCopy as
Select * From hr.regions
Where 1 = 2;

/

-- ORNEK
Begin
    Insert into RegionsCopy(region_id, region_name) Values (1, 'Avrupa');
    Savepoint A;
    
    Insert into RegionsCopy(region_id, region_name) Values (2, 'Asya');
    Savepoint B;
    
    Update RegionsCopy
    Set region_name = 'Asia'
    Where region_id = 2;
    Savepoint C;
    
    Delete From RegionsCopy Where region_id = 2;
    
    -- RollBack;       -- Tum islemleri iptal eder.
    -- Rollback To A;   -- A noktasndan sonraki tum islemleri iptal eder 
    -- RollBack To B;  -- B noktasindan sonraki tum islemleri iptal eder
    -- RollBack To C;  -- C noktasindan sonraki tum islemleri iptal eder
    Commit;
End;

/

Select * From RegionsCopy;

/

-- DYNAMIC SQL KULLANIMI --
-- DDL, DCL --
-- EXECUTE IMMEDIATE --
Begin
    Execute Immediate 'Create Table OrnekTablo(urun_id number(10), urun_adi varchar2(50))';
    dbms_output.put_line('Tablo olusturuldu.');
End;

/

-- Simdi yukaridaki sorguyu parametrik yapalim.
Declare
    ddl_komut Varchar2(2000);
Begin
    ddl_komut := 'Create Table OrnekTablo2(urun_id Number(10), urun_adi Varchar2(50))';
    Execute Immediate ddl_komut;
    
    dbms_output.put_line('Tablo olusturuldu');
End;

/
