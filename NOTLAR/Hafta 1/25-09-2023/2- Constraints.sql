-- TABLO OLUSTURMA --
Create Table EmployeeOrnek
(
    employee_id Number Primary Key,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number,
    hiredate Date
);

-- Rastgele olusacak constraint ismini belirtmek.
-- YONTEM 1
Create Table EmployeeOrnek1
(
    employee_id Number Constraint pk_employee_empid Primary Key,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number,
    hiredate Date
);

-- YONTEM 2
Create Table EmployeeOrnek2
(
    employee_id Number,
    first_name Varchar2(30),
    last_name Varchar2(30),
    salary Number,
    hiredate Date,
    Constraint pk_employee3_empid Primary Key
);

-- Var olan bir tabloya constraint eklemek istersek.
Alter Table EmployeeOrnek
Add Constraint pk_employeeornek_empid Primary Key(employee_id);

-- Composite Primary Key belirtmek. (Birden fazla sutunun birlesmesi ile olusan primary key)
-- YONTEM 1
Create Table EmployeeOrnek3
(
    employee_id Number,
    first_name Varchar2(30) Constraint pk_emp3_fname Primary Key,
    last_name Varchar2(30)
);

Insert Into Employee Values(1, 'Ali', 'TOPACIK');
Insert Into Employee Values(2, 'Ali', 'TOPACIK'); -- Eklenmez.
Insert Into Employee Values(3, 'Ali', 'BULUT'); -- Eklenmez.

-- YONTEM 2
Create Table EmployeeOrnek4
(
    employee_id Number,
    first_name Varchar2(30),
    last_name Varchar2(30),
    Constraint pk_emp4_fnamelname Primary Key(first_name, last_name)
);

Insert Into Employee Values(1, 'Ali', 'TOPACIK');
Insert Into Employee Values(2, 'Ali', 'TOPACIK'); -- Eklenmez.
Insert Into Employee Values(3, 'Ali', 'BULUT');

-- Foreign Key Olusturmak
Create Table Department
(
    department_id Number Primary Key,
    department_name Varchar2(30)
);

Create Table Employees
(
    employee_id Number Primary Key,
    first_name Varchar2(30),
    last_name Varchar2(30),
    dept_id Number,
    Constraint fk_emp_dept_deptid Foreign Key (dept_id) References Department(department_id)
);

insert into Department Values(1, 'IT');

insert into Employee Values(1, 'Mehmet Husna', 'Kisla', 1);
insert into Employee Values(2, 'Ali', 'Topacik', 2); -- 2 no'lu department olmadigi icin eklemez.

-- UNIQUE CONSTRAINT
Create Table Employee
(
    employee_id Number not null,
    first_name Varchar2(30),
    phone Number Unique
);

insert into Employee Values(1, 'Ali', '5554443322');
insert into Employee Values(2, 'Mehmet', '5554443322'); -- Unique constraint'den dolayi eklemez.

-- CHECK CONSTRAINT
Create Table Employees
(
    employee_id Number Primary Key,
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
    dept_id Number Constraint chk_dpt Check(Length(dept_id) >= 3)
);

-- DEFAULT CONSTRAINT
Create Table Employee
(
    employee_id Number Primary Key,
    hire_date Date Default(Sysdate),
    country Varchar2(30)
);

insert into Employee Values(1, 'USA'); -- Calismaz
insert into Employee (employee_id, country) Values(1, 'Turkey'); -- Calisir.

-- DUAL FONKSIYONLARI
Select Sysdate From Dual;
Select 'SQL Egitimine Hos Geldiniz' From Dual;