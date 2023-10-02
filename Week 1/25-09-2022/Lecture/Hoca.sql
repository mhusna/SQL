-- 25092023

-- sys alt?nda bunu yapal?m

Create User AliTOPACIK identified by Ali123;

Grant connect, resource to AliTOPACIK;

Grant All Privileges to AliTOPACIK;

--

Create User HRA identified by HRA;

Grant connect, resource to HRA;

Grant All Privileges to HRA;

--

Create User SQLDATA identified by Ali123;

Grant connect, resource to SQLDATA;

Grant All Privileges to SQLDATA;


-- simdi istedigimiz user icin gidebiliriz


Create Table Personel
( id int,
 FullName varchar2(100)
 );
 
 insert into Personel(id,FullName) Values(1,'Ali TOPACIK');
 
 Select *
 From Personel;
 
 
Create Table Ornek
(
  id int,
  isim varchar2(30)
);

insert into Ornek(id, isim) Values(1,'Ali');

Select *
From Ornek;

Select *
From employees;

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
FROM
    employees;

-- Yukar?daki sorguda JOB_ID IT_PROG OLANLARI GORELIM

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
FROM
    employees
WHERE JOB_ID='IT_PROG';

-- EMPLOYEES tablosunda her bir job_id icin odenen maas toplamlar?n? bulal?m

SELECT
    JOB_ID,
    Sum(Salary) as TotalSalary
FROM
    employees
Group By JOB_ID;

-- EMPLOYEES tablosunda her bir job_id icin odenen maas toplamlar?>20000 olanlar? bulal?m ve buyukten kucuge dogru s?ralayal?m

SELECT
    JOB_ID,
    Sum(Salary) as TotalSalary
FROM
    employees
Group By JOB_ID
Having Sum(Salary) > 20000
Order By TotalSalary desc;

--

SELECT
    JOB_ID,
    Sum(Salary) as TotalSalary
FROM
    employees
Group By JOB_ID
Having Sum(Salary) > 20000
Order By 2 desc;

--

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    employees.department_id
FROM
     employees    
join departments on employees.department_id = departments.department_id;

--

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_id,
    e.salary,
    d.department_name,
    l.postal_code,
    l.city,
    l.state_province,
    c.country_name,
    r.region_name
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id;

-- yukaridaki sorguda region_name'e gore toplamsalary bulunuz

SELECT
    r.region_name,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name;

-- Yukar?daki sorguda region_name'lerin ulkelere gore toplam salary bilgilerini bulunuz

SELECT
    r.region_name,
    c.country_name,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name,c.country_name
Order By 1,2;

-- Yukar?daki sorguda region_name'lerin ulkeler ve state_province'e gore
-- toplam salary bilgilerini bulunuz

SELECT
    r.region_name,
    c.country_name,
    l.state_province,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name,c.country_name,l.state_province
Order By 1,2,3;

--

SELECT
    r.region_name,
    c.country_name,
    l.state_province,
    l.city,
    d.department_name,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name,c.country_name,l.state_province, l.city, d.department_name
Order By 1,2,3;

--

Create Table employee1
(
    employee_id Number Primary Key,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

--

Create Table employee2
(
    employee_id Number Constraint pk_employee2_empid Primary Key,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

--

Create Table employee3
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
    Constraint pk_employee3_empid Primary Key
);

--

Create Table employee4
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date    
);

--

Alter Table employee4
Add Constraint pk_employee4_empid Primary Key(employee_id);

-- Composite Primary Key

-- Asagidaki sorgu ornek amacl?d?r

Create Table employee5
(
    employee_id Number,
    firstname varchar2(30) Constraint pk_employee5_firstname Primary Key,
    lastname varchar2(30)
    
);

insert into employee5 Values(1,'Ali','TOPACIK');
insert into employee5 Values(2,'Ali','TOPACIK'); -- ayn? isim 2 veya fazlas?na giri? izni vermez
insert into employee5 Values(3,'Ali','BULUT'); -- ayn? isim 2 veya fazlas?na giri? izni vermez

-- Asagidaki sorgu ornek amacl?d?r

Create Table employee6
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    Constraint pk_employee6_firlastname Primary Key(firstname,lastname)
);

insert into employee6 Values(1,'Ali','TOPACIK');
insert into employee6 Values(2,'Ali','TOPACIK'); -- ayn? isim 2 veya fazlas?na giri? izni vermez
insert into employee6 Values(3,'Ali','BULUT');

--

Create Table DepartmenstA1
(
    dept_id Number Primary Key,
    dept_name Varchar2(50)
);

insert into DepartmenstA1 values(1,'IT');

Select *
From DepartmenstA1;

Create Table employeeA1
(
    employee_id Number not null,
    firstname varchar2(30),
    lastname varchar2(30),
    dept_id Number
);

insert into employeeA1 Values(100,'Ali','TOPACIK',1);
insert into employeeA1 Values(101,'Ali','BULUT',2);

Select *
From employeeA1;

-- simdi foreign key k?s?tlamas? yapal?m

Create Table employeeA2
(
    employee_id Number not null,
    firstname varchar2(30),
    lastname varchar2(30),
    dept_id Number,
    constraint fk_emp_dept_deptid
        foreign key(dept_id) References DEPARTMENSTA1(dept_id)
);

Select *
From DEPARTMENSTA1;

insert into employeeA2 Values(100,'Ali','TOPACIK',1);
insert into employeeA2 Values(101,'Ali','BULUT',2); -- 2 nolu dept_id DEPARTMENSTA1 tablosunda olmad??? icin eklemez

Select *
From employeeA2;

-- unique constraint

Create Table employeeA3
(
    employee_id Number not null,
    firstname varchar2(30),
    telephone Number unique
);

insert into employeeA3 Values(100,'Ali','5559988876');
insert into employeeA3 Values(101,'Veli','5559988876'); -- unique constraint'ten dolay? girise izin vermez
insert into employeeA3 Values(102,'Anil',5343848767);
insert into employeeA3 Values(104,'Anil',5343848767); -- unique constraint'ten dolay? girise izin vermez

--

Select *
From employeeA3;

-- Check Constraint

Create Table employeeA4
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number constraint chk_salaryaA4 Check(Salary Between 10000 and 100000) 
);

insert into employeeA4 Values(100,'Ali','TOPACIK', 50000);

insert into employeeA4 Values(101,'Saadet','BOZKAN', 101000);
insert into employeeA4 Values(102,'Saadet','BOZKAN', 9000);
insert into employeeA4 Values(103,'Saadet','BOZKAN', 30000);

insert into employeeA4 Values(100,'Seyda','Akgul', -15000);
insert into employeeA4 Values(100,'Seyda','Akgul', 15000);

Select *
From employeeA4;

--

Create Table employeeA5
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    dept_id Number
);

Alter Table employeeA5
Add constraint chk_dept_id Check(Length(dept_id)>=3);

--

Create Table employeeA6
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    dept_id Number
);

Alter Table employeeA6
Add constraint chk_dept_id6 Check(dept_id>=100);

-- Default Constraint

Create Table Order1
(
    order_id Number,
    order_date date default(sysdate),    
    country Varchar2(30),
    Amount Number
);

insert into Order1 Values(1,'USA',10000); -- Bu calismaz

insert into Order1(order_id, country, Amount) Values(1,'USA',10000);

Select *
From Order1;

Select sysdate From Dual;

Select 'SQL Egitimine Hos Geldiniz' From Dual;