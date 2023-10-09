-- Tablodaki tum sutunlari gormek icin.
Select * From hr.Employees;

-- Ilgili tablodan istedigimiz sutunlari getirmek icin sutun isimleri ile cagiririz.
Select
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
From hr.employees;

-- Belli kritere sahip kullanicilara ait istedigimiz sutunlari getirmek icin WHERE keywordu kullaniriz.
Select 
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
From hr.employees
Where job_id = 'IT_PROG';

-- Istedigimiz sutuna gore verileri gruplamak icin GROUP BY kullaniriz.
-- GROUP BY ifadesinde hangi sutuna / sutunlara gore gruplama yapiyorsak SELECT ifadesinde de o kullanilmali.
-- GROUP BY ifadesinden gelen sanal tabloyu filtrelemek icin HAVING ifadesi kullanilir.
-- HAVING'de alias kullanilamaz, fakat ORDER BY'da kullanilabilir.
Select
    job_id,
    sum(salary) as TotalSalary
From hr.employees
Group By job_id;

-- ORNEK: Maaslarin toplami 20.000'den buyuk meslekleri bulalim ve buyukten kucuge siralayalim.
Select
    job_id,
    sum(salary) as TotalSalary
From hr.employees
Group By job_id
Having sum(salary) > 20000
Order By TotalSalary desc;

-- Iki tabloyu birbirine baglamak icin ortak sutunlar kullanilir ve JOIN islemi yapilir.
Select
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
From hr.employees emp
Join hr.departments dep on dep.department_id = emp.department_id;

-- Birden fazla join islemi yapabiliriz.
select * from hr.employees;
Select
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.email,
    emp.salary,
    jbs.job_title,       -- e.job_id
    dep.department_name, -- e.department_id
    loc.postal_code,     -- dep.location_id
    loc.state_province,
    cou.country_name,    -- loc.country_id
    reg.region_name      -- cou.region_id
From hr.employees emp
Join hr.jobs jbs on emp.job_id = jbs.job_id
Join hr.departments dep on emp.department_id = dep.department_id
Join hr.locations loc on dep.location_id = loc.location_id
Join hr.countries cou on loc.country_id = cou.country_id
Join hr.regions reg on cou.region_id = reg.region_id;

-- ORNEK: Yukaridaki sorguda region_name'e gore toplam salary'i bulun.
Select
    reg.region_name,
    sum(emp.salary) as TotalSalary
From hr.employees emp
Join hr.departments dep on emp.department_id = dep.department_id
Join hr.locations loc on dep.location_id = loc.location_id
Join hr.countries cou on loc.country_id = cou.country_id
Join hr.regions reg on cou.region_id = reg.region_id
Group By reg.region_name
Order By TotalSalary;

-- ## Kirilim Ornegi ##
-- ORNEK: Yukaridaki sorguda region_name'lerin country_name'e gore toplam salary bilgisini bulun.
Select
    reg.region_name as Region,
    cou.country_name as Country,
    sum(emp.salary) as TotalSalary
From hr.employees emp
Join hr.departments dep on emp.department_id = dep.department_id
Join hr.locations loc on dep.location_id = loc.location_id
Join hr.countries cou on loc.country_id = cou.country_id
Join hr.regions reg on cou.region_id = reg.region_id
Group By reg.region_name, cou.country_name
Order By 1, 2;

-- ## Kirilim Ornegi ##
-- ORNEK: Yukaridaki sorguda region_name'lerin once country_name'e gore sonra state_province'ye gore toplam salary bilgisini bulun.
Select
    reg.region_name as Region,
    cou.country_name as Country,
    loc.state_province as State_Province,
    sum(emp.salary) as TotalSalary
From hr.employees emp
Join hr.departments dep on emp.department_id = dep.department_id
Join hr.locations loc on dep.location_id = loc.location_id
Join hr.countries cou on loc.country_id = cou.country_id
Join hr.regions reg on cou.region_id = reg.region_id
Group By reg.region_name, cou.country_name, loc.state_province
Order By 1, 2, 3;

-- ## Kirilim Ornegi ##
-- ORNEK: Yukaridaki sorguda region_name'lerin once country_name, state_province, city, department'e gore toplam salary bilgisini bulun.
Select
    reg.region_name as Region,
    cou.country_name as Country,
    loc.state_province as State_Province,
    loc.city as City,
    dep.department_name,
    sum(emp.salary) as TotalSalary
From hr.employees emp
Join hr.departments dep on emp.department_id = dep.department_id
Join hr.locations loc on dep.location_id = loc.location_id
Join hr.countries cou on loc.country_id = cou.country_id
Join hr.regions reg on cou.region_id = reg.region_id
Group By 
        reg.region_name, 
        cou.country_name, 
        loc.state_province,
        loc.city,
        dep.department_name
Order By 1, 2, 3, 4, 5;

-- Tablo Olusturma
Create Table Employee
(
    employee_id Number Primary Key,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number,
    hiredate date
);

-- Rastgele olusacak olan constraint ismini belirtmek.
-- YONTEM 1
Create Table Employee
(
    employee_id Number Constraint pk_employee_empid Primary Key,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number,
    hiredate date
);

-- YONTEM 2
Create Table Employee2
(
    employee_id Number,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number,
    hiredate date,
    Constraint pk_employee2_empid Primary Key
);

-- Var olan bir tabloya constraint eklemek istersek.
Alter Table Employee
Add Constraint pk_employee_empid Primary Key(employee_id);

-- Composite Primary Key belirtmek. (Birden fazla sutunun birlesmesi ile olusan primary key)
-- YONTEM 1
Create Table Employee
(
    employee_id Number,
    first_name Varchar2(30) Constraint pk_employee_firstname Primary Key,
    last_name Varchar2(30)
);

insert into Employee Values(1, 'Ali', 'TOPACIK');
insert into Employee Values(2, 'Ali', 'TOPACIK'); -- Girmez
insert into Employee Values(3, 'Ali', 'BULUT'); -- Girmez

-- YONTEM 2
Create Table Employee
(
    employee_id Number,
    first_name Varchar2(30),
    last_name Varchar2(30),
    Constraint pk_employee_firstLastName Primary Key(first_name, last_name)
);

insert into Employee Values(1, 'Ali', 'TOPACIK');
insert into Employee Values(2, 'Ali', 'TOPACIK'); -- Girmez
insert into Employee Values(3, 'Ali', 'BULUT'); -- Girer

-- Foreign Key olusturmak
Create Table Department
(
    department_id Number Primary Key,
    department_name Varchar(20)
);

Create Table Employee
(
    employee_id Number not null,
    first_name Varchar2(30),
    last_name Varchar2(30),
    dept_id Number,
    Constraint fk_emp_dept_dept_id Foreign Key (dept_id) References Department(department_id)
);

insert into Department Values(1, 'IT');

insert into Employee Values(1, 'Mehmet Husna', 'Kisla', 1);
insert into Employee Values(2, 'Ali', 'Topacik', 2); -- 2no'lu department olmadigi icin eklemez.

-- Unique Constraint
Create Table Employee
(
    employee_id Number not null,
    first_name Varchar2(30),
    phone Number Unique
);

insert into Employee Values(1, 'Ali', '5554443322');
insert into Employee Values(2, 'Mehmet', '5554443322'); -- Unique constraint'den dolayi eklemez.

-- Check Constraint
Create Table Employee
(
    employee_id Number not null,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number Constraint chk_salary Check(salary Between 10000 And 100000)
);

insert into Employee Values(1, 'Mehmet', 'Kisla', 25000);
insert into Employee Values(1, 'Ali', 'Topacik', 5000); -- Eklemez

-- ORNEK: dept_id alaninin 3 haneden buyuk olmasini saglayan constraint'i yazin.
Create Table Employee
(
    employee_id Number Primary Key,
    first_name Varchar2(30),
    dept_id Constraint chk_salary Check(Length(dept_id) >= 3)
);

-- Default Constraint
Create Table Employee
(
    employee_id Number Primary Key,
    hire_date Date Default(Sysdate),
    country Varchar2(30)
);

insert into Employee Values(1, 'USA'); -- Calismaz
insert into Employee (employee_id, country) Values(1, 'Turkey'); -- Calisir.

-- Dual Fonksiyonlari
Select Sysdate from Dual;
Select 'SQL Egitimine hg' from dual;