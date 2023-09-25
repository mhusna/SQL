-- Sys Alt?nda Bunu yapal?m
CREATE User KullaniciAdi identified by Sifre;

-- Connect yetkisi
Grant connect, resource to AliA;

-- Tüm yetkiler
Grant All Privileges to AliA;

-- Simdi istedi?imiz user için gidebiliriz.
-- Sa? üstten user seç.


CREATE User SQLDATA identified by Ali123;
Grant connect, resource to SQLDATA;
Grant All Privileges to SQLDATA;


select * from Employees;

select 
    EMPLOYEE_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    JOB_ID, 
    SALARY
from 
    EMPLOYEES
where JOB_ID = 'IT_PROG';

select 
    JOB_ID, sum(salary) as TotalSalary 
from 
    employees 
GROUP BY JOB_ID;
    
-- Toplam maa?? 20k'dan büyük i?leri bulal?m ve büyükten küçü?e s?ralayal?m.
    
SELECT
    JOB_ID, sum(SALARY)as TotalSalary 
FROM
    EMPLOYEES
GROUP BY JOB_ID
HAVING sum(SALARY) > 2000
Order By TotalSalary desc;

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    employees.department_id
FROM
    employees
JOIN departments on employees.department_id = departments.department_id;

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
    employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id
JOIN countries c on l.country_id = c.country_id
JOIN regions r on c.region_id = r.region_id;

-- yukar?daki sorguda region_name'e göre toplam salary'i bulun.

SELECT
    r.region_name, sum(e.salary)as TotalSalary
FROM
    employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id
JOIN countries c on l.country_id = c.country_id
JOIN regions r on c.region_id = r.region_id
GROUP BY r.region_name;

-- Yukar?daki sorguda region_name'lerin önce ülkelere göre toplam salary bilgilerini bulunuz.

SELECT
    r.region_name, 
    c.country_name,
    sum(e.salary)as TotalSalary
FROM
    employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id
JOIN countries c on l.country_id = c.country_id
JOIN regions r on c.region_id = r.region_id
GROUP BY r.region_name, c.country_name
Order BY 1, 2;

-- Yukar?daki sorguda region_name'lerin önce ülkelere göre sonra 
-- state_province'ye göre toplam salary bilgilerini bulunuz. 

SELECT
    r.region_name, 
    c.country_name,
    l.state_province,
    sum(e.salary)as TotalSalary
FROM
    employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id
JOIN countries c on l.country_id = c.country_id
JOIN regions r on c.region_id = r.region_id
GROUP BY r.region_name, c.country_name, l.state_province
Order BY 1, 2, 3;

-- Yukar?daki sorguda region_name'lerin önce ülkelere göre
-- sonra state_province'ye göre
-- sonra ?ehirlere göre
-- sonra departmanlar?na göre toplam salary bilgilerini bulunuz. 

SELECT
    r.region_name, 
    c.country_name,
    l.state_province,
    l.city,
    d.department_name,
    sum(e.salary)as TotalSalary
FROM
    employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id
JOIN countries c on l.country_id = c.country_id
JOIN regions r on c.region_id = r.region_id
GROUP BY r.region_name, c.country_name, l.state_province, l.city, d.department_name
Order BY 1, 2, 3, 4;

--

Create Table employee1
(
    employee_id Number Primary Key,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

-- Rastgele atanm?? olan constraint ismini de?i?tirdik.
-- Ve art?k pk_employee2_empid olsun dedik.

Create Table employee2
(
    employee_id Number Constraint pk_employee2_empid Primary Key,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

-- Constraint belirtmenin bir ba?ka yolu da en altta belirtmek.

Create Table employee3
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
    Constraint pk_employee3_empid Primary Key
);

-- Var olan bir tabloya constraint eklemek.
-- Önce tabloyu olu?tur.
Create Table employee4
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

-- Sonra alter komutu ile constraint ekle.
Alter Table employee4
Add Constraint pk_employee4_empid Primary Key(employee_id);


-- Composite Primary Key (Birden fazla sütunun birle?mesi ile olu?an primary key)
-- Örnek amaçl?..
Create Table employee5
(
    employee_id Number,
    firstname varchar2(30) Constraint pk_employee5_firstname Primary Key,
    lastname varchar2(30)
);

insert into employee5 Values (1, 'Ali', 'TOPACIK');
insert into employee5 Values (2, 'Ali', 'TOPACIK'); -- Girmez
insert into employee5 Values (3, 'Ali', 'BULUT'); -- Girmez

--

Create Table employee6
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    Constraint pk_employee6_firstLastName Primary Key (firstname, lastname)
);

insert into employee6 Values (1, 'Ali', 'TOPACIK');
insert into employee6 Values (2, 'Ali', 'TOPACIK'); -- Girmez
insert into employee6 Values (3, 'Ali', 'BULUT'); -- Girer

-- 

Create Table DepartmentsA1
(
    dept_id Number Primary Key,
    dept_name varchar2(50)
);

insert into DepartmentsA1 Values(1, 'IT');
Select * From DepartmentsA1;

Create Table EmployeeA1
(
    employee_id Number not null,
    firstname varchar2(30),
    lastname varchar2(30),
    dept_id Number
);

insert into EmployeeA1 Values (100, 'Ali', 'TOPACIK', 1);
insert into EmployeeA1 Values (101, 'Ali', 'BULUT', 2);


--

Create Table employeeA2
(
    employee_id Number not null,
    firstname varchar2(30),
    lastname varchar2(30),
    dept_id Number,
    constraint fk_emp_dept_deptid
        foreign key(dept_id) References DepartmentsA1(dept_id)
);

insert into employeeA2 Values(100, 'Ali', 'TOPACIK', 1);
insert into employeeA2 Values(101, 'Ali', 'BULUT', 2); -- 2 no'lu department id olmad??? için eklemez.

select * from departmentsa1;


-- unique constraint

Create Table employeeA3
(
    employee_id Number not null,
    firstname varchar2(30),
    telephone_number Number unique
);

insert into employeeA3 Values(100, 'Ali', '5559988756');
insert into employeeA3 Values(101, 'Veli', '5559988756'); -- unique constraint'den dolay? giri?e izin vermez.

-- Check Constraint

Create Table employeeA4
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number constraint chk_salaryA4 check(Salary Between 10000 And 100000)
);

insert into employeeA4 Values(100, 'Ali', 'TOPACIK', 50000);
insert into employeeA4 Values(101, 'Saadet', 'BOZKAN', 9500);

--

Create Table employeeA5
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    dept_id Number constraint chk_deptid check(Length(dept_id) >= 3)
    --dept_id Number constraint chk_deptid check(dept_id > 100) --> FARKLI B?R YÖNTEM
);

-- Default Constraint

Create Table Order1
(
    order_id Number,
    order_date date default(sysdate),
    country Varchar2(30),
    Amount Number
);

insert into Order1 Values(1 ,'USA', 1000); --> Bu çal??maz
insert into Order1 (order_id, country, amount) Values(1 ,'USA', 1000);

select sysdate from Dual;
select 'SQL Egitimine hg' from dual;

