-- Select ile birlikte if komutlari kullanmak cok mantikli degil, exception varsa direk devreye girer.

-- Update ve Delete islemlerinde Exception bloguna girmez, dolayisi ile if-else blogu calisir fakat Select isleminde bu durum tam tersi.

-- CURSORS --

-- Implicit Cursors (System-Defined Cursors): Sistem Tarafindan Tanimlananlar.
-- sql%found, sql%notfound, sql%rowcount

Declare
    rec_emp Employees%ROWTYPE;
Begin
    Select *
    Into rec_emp
    From Employees2
    Where employee_id = 1000;
    
    IF sql%found Then
        dbms_output.put_line('A- Kayit var. Kayit sayisi: ' || sql%rowcount);
    ELSE
        dbms_output.put_line('A- Kayit bulunamadi.');
    END IF;
    
    IF sql%notfound Then
        dbms_output.put_line('B- Kayit bulunamadi.');
    ELSE
        dbms_output.put_line('B- Kayit var. Kayit sayisi: ' || sql%rowcount);
    END IF;
    
    Exception When NO_DATA_FOUND Then
        dbms_output.put_line('Exception - Kayit yok.');
End;

-- Yukaridaki sorguda Exception, Select isleminden sonra tetiklenir. Hata var ise Exception devreye girer ve hatayi gosterir.

-- Implicit cursor'lari Select ifadelerinde kullanmak cok mantikli degildir.

-- Cunku Select ifadesinden sonra Exception(NO_DATA_FOUND) yapisi sql%found ve sql%notfound'dan once tetiklenir.

/

Declare
    rec_emp Employees2%ROWTYPE;
Begin
    Update Employees2
    Set Salary = Salary * 1.20
    Where department_id = 1000;
    
    IF sql%found Then
        dbms_output.put_line('A- ' || sql%rowcount || ' adet kayit guncellendi.');
    ELSE
        dbms_output.put_line('A- Guncellenecek kayit bulunamadi.');
    END IF;
    
    IF sql%notfound Then
        dbms_output.put_line('B- Guncellenecek kayit bulunamadi.');
    ELSE
        dbms_output.put_line('B- ' || sql%rowcount || ' adet kayit guncellendi.');
    END IF;
End;

/


-- Explicit Cursors (Developer-Defined Cursors): Kullanici Tarafindan Tanimlananlar.

Declare
    rec_emp Employees2%ROWTYPE;
Begin
    Delete From Employees2
    Where department_id = 1000;
    
    IF sql%found Then
        dbms_output.put_line('A- ' || sql%rowcount || ' adet kayit guncellendi.');
    ELSE
        dbms_output.put_line('A- Guncellenecek kayit bulunamadi.');
    END IF;
    
    IF sql%notfound Then
        dbms_output.put_line('B- Guncellenecek kayit bulunamadi.');
    ELSE
        dbms_output.put_line('B- ' || sql%rowcount || ' adet kayit guncellendi.');
    END IF;
End;

-- Rollback;

/

-- Tanimlanan cursor acilmali, acilan cursor da kapatilmali. Yoksa arkada hafiza yer.

-- Loop icerisinde fetch kullandigimiz icin herbir satiri tek tek okuyor.

Declare
    Cursor c_emp is
        Select employee_id, first_name, last_name From Employees;
    
    emp_id Employees.employee_id%TYPE;
    f_name Employees.first_name%TYPE;
    l_name Employees.last_name%TYPE;
Begin
    Open c_emp;
    Loop 
        Fetch c_emp Into emp_id, f_name, l_name;
        Exit When c_emp%notfound;
        dbms_output.put_line('ID: ' || emp_id ||
                             ' - F.NAME: ' || f_name ||
                             ' - L.NAME: ' || l_name);
    End Loop;
    Close c_emp;
End;

/

-- Yukarida en basit haliyle kullandik.
-- Cursor icerisine istedigimiz Select islemini aktarabiliriz. Where, join..

-- ORNEK
Declare
    Cursor c_emp is 
        Select
            RPAD(job_id, 10, ' ') job_id,
            Sum(Salary) TotalSalary
        From Employees
        Group By job_id
        Order By 2 Desc;
    
    job_id Varchar2(10);
    total_salary Employees.Salary%TYPE;
Begin
    Open c_emp;
        Loop
            Fetch c_emp Into job_id, total_salary;
            Exit When c_emp%notfound;
            dbms_output.put_line('ID: ' || job_id ||
                                 ' -    TotalSalary: ' || total_salary);
        End Loop;
    Close c_emp;
End;

/

-- ORNEK
Declare
    Cursor c_reg is
        Select region_id, region_name From RegionsCopy;
    
    r_id RegionsCopy.Region_id%TYPE;
    r_name RegionsCopy.Region_name%TYPE;
Begin
    Open c_reg;
        Loop
            Fetch c_reg Into r_id, r_name;
            Exit When c_reg%notfound;
            dbms_output.put_line('Region ID: ' || r_id ||
                                 ' - Region Name: ' || r_name);
        End Loop;
    Close c_reg;
End;

/