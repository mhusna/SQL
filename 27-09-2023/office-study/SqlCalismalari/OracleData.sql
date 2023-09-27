--------------------------------
Select * From all_users;

Select * From all_tables;

Select * From all_tables
Where owner = 'HR';

Select * From all_cons_columns;

Select * From all_cons_columns
Where owner = 'HR';

Select * From all_constraints;

Select * From all_constraints
Where owner = 'HR';

Create Table cityjoincopy as
Select *
From cityjoin;

-- Table kolonlari gelir.
desc cityjoin;

Select * From cityjoincopy;

Alter Table cityjoincopy Add Populate Number(10);

desc cityjoincopy;

Alter Table cityjoincopy 
Modify Populate Varchar2(30);

Alter Table cityjoincopy Add TelNo Number(10);

desc cityjoincopy;

Alter Table cityjoincopy
Rename Column TelNo to MobileNumber;

desc cityjoincopy;

---- SAVE POINT

Create Table OrnekTablo(
    Ad Varchar2(30),
    Soyad Varchar2(50),
    MobileNo Varchar2(15)
);

Rename OrnekTablo to SampleTablo;
desc SampleTablo;

Select *
From SampleTablo;

Insert into SampleTablo Values('Ali', 'TOPACIK','05556667788');
Commit;

insert into SampleTablo Values('Saadet', 'BOZKAN','12121212');
insert into SampleTablo Values('Seyda', 'Akgul','342512412');
SavePoint A;

insert into SampleTablo Values('Yusuf', 'ULUOCAK','1231241213');
SavePoint B;

insert into SampleTablo Values('Erkut', 'ATE?','3242441');
SavePoint C;

insert into SampleTablo Values('F?rat', 'TOSUN','67564654654');
SavePoint D;

Select *
From SampleTablo;

RollBack To C;

Select *
From SampleTablo;

RollBack To B;

Select *
From SampleTablo;

Commit;

-- Buna izin verilmez cunku commit atildi.
RollBack to A;

Select *
From SampleTablo;

----------------------------------------

Select * From all_cons_columns cc;

Select * From all_constraints co;

Select 
    cc.owner, 
    cc.constraint_name, 
    cc.table_name, 
    cc.column_name,
    co.constraint_type, 
    co.search_condition
From all_cons_columns cc
Join all_constraints co on co.constraint_name = cc.constraint_name
Where cc.owner = 'HR';

----------------------------------------

Select *
From all_tab_columns;

Select *
From all_tab_columns
Where Owner = 'HR';

Select 
    'Select * From ' ||Table_Name || ';' as Sorgu
From all_tab_columns
Where Owner = 'HR';

---------------------------------------

Select 
    employee_id,
    first_name,
    last_name,
    manager_id
From ora_employees;

Select 
    employee_id,
    first_name,
    last_name,
    manager_id
From ora_employees
Connect By Prior employee_id = manager_id
Order By employee_id;

-- Prior keyword'unu esitligin sagina ekledik.
-- Sonucun goruntusu degisir.

Select 
    employee_id,
    first_name,
    last_name,
    manager_id
From ora_employees
Connect By employee_id = Prior manager_id
Order By employee_id;

---------------------------------------

Create Table ora_employees_copy
As 
Select * 
From ora_employees;

Select *
From ora_employees_copy;

Select *
From ora_employees_copy
Where employee_id <> 100;

Update ora_employees_copy
Set Salary = Salary * 1.20,
    commission_pct = 0.25
Where employee_id <> 100;

-- 101 ve 102 no'lu calisanlarin maaslarini
-- 400 dusurelim

Select 
    Salary
From ora_employees_copy
where employee_id in (101, 102);

Update ora_employees_copy
Set Salary = Salary - 400
Where employee_id = 101 or employee_id = 102;

Commit;

----------------------------------
-- Bu islemi sys altinda yap.

Create User PersonelA identified by PersonelA;
Grant connect, resource to PersonelA;

-- Tablo limitini kaldirma
-- Grant connect, resource, unlimited TableSpace to PersonelA;

-- Daha sonra PersonelA kullanicisina gec
-- ve Select * from hr.employees komutunu
-- calistir. Erisemeyecek ve hata alacak.

-- Yetkileri tek tek verme.
Grant Select on hr.employees to PersonelA;
Grant Insert on hr.employees to PersonelA;
Grant Delete on hr.employees to PersonelA;
Grant Update on hr.employees to PersonelA;

-- Bu islemleri sys altinda yaptik. PersonelA'nin
-- da bu yetkileri bir baskasina verebilmesi icin
-- Grant Option kullanmaliyiz.

Grant Select on hr.employees to PersonelA with Grant Option;

-- Yetkileri satir satir yazmamak icin;
Grant
    Select,
    Insert,
    Update,
    Delete
on hr.employees to PersonelA with Grant Option;

-- Yetki geri alma
Revoke delete on hr.employees from PersonelA;

-- Birden fazla yetkiyi ayni anda alma.
Revoke insert, update on hr.employees from PersonelA;

-- Yukarida bir user icin yetki verdik.
-- Public olacak hazir bir rol var.
-- Yetkileri bu rol uzerinde verebiliriz.
-- Bu durumda veritabaninin baglanma yetkisi olan
-- tum userlar yetkilendirilmis olur.
Grant Select on hr.employees to Public