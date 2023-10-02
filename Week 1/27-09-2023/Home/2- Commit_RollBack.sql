-- Sistemdeki tum kullanicilarin listesini getirir.
Select * From all_users;

-- Sistemdeki tum tablolarin listesini getirir.
Select * From all_tables;

-- Kullaniciya ait tablolari getirir.
Select * From all_tables Where Owner = 'HR';

-- Butun constraint'leri getirir.
Select * From all_cons_columns;

-- Belli kullaniciya ait constraint'leri getirir.
Select * From all_cons_columns Where Owner = 'HR';

-- Var olan tabloya kolon eklemek.
Alter Table cityjoin Add Populate Number(10);

-- Var olan bir kolonu degistirmek.
Alter Table cityjoin Modify Populate Varchar2(30);

-- Bir kolonun adini degistirme.
Alter Table cityjoin Rename Column Populate to Poplate1;

-- SAVE POINT
Create Table OrnekTablo
(
    Ad Varchar2(30),
    Soyad Varchar2(30),
    TelNo Varchar2(15)
);

-- COMMIT
Insert Into OrnekTablo Values('Ali', 'TOPACIK', '5554443322');
Commit;

Insert Into OrnekTablo Values('Saadet', 'BOZKAN','12121212');
Insert Into OrnekTablo Values('Seyda', 'Akgul','342512412');
SavePoint A;

Insert Into OrnekTablo Values('Yusuf', 'ULUOCAK','1231241213');
SavePoint B;

Insert Into OrnekTablo Values('Erkut', 'ATES','3242441');
SavePoint C;

Insert Into OrnekTablo Values('Firat', 'TOSUN','67564654654');
SavePoint D;

Select * From OrnekTablo;

RollBack To C;

Select * From OrnekTablo;

RollBack To B;

Select * From OrnekTablo;

Commit;

-- Buna izin verilmez cunku commit atildi.
RollBack to A;

Select * From OrnekTablo;

-- Tum tablolara select atan sorgu.
Select 
    'Select * From ' ||Table_Name || ';' as Sorgu
From all_tab_columns
Where Owner = 'HR';

-- CONNECT BY PRIOR ile self join sorgusu.
Select 
    employee_id,
    first_name,
    last_name,
    manager_id
From hr.employees
Connect By Prior employee_id = manager_id
Order By employee_id;

-- Prior keyword'unu esitligin sagina ekledik. Sonucun goruntusu degisir.
Select 
    employee_id,
    first_name,
    last_name,
    manager_id
From hr.employees
Connect By employee_id = Prior manager_id
Order By employee_id;

-- Belli sutundaki belli degerlerin degerini degistirme
Update hr.employees
Set Salary = Salary * 1.20,
    commission_pct = 0.25
Where employee_id <> 100;
