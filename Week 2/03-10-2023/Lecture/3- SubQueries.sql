-- SUBQUERIES
-- Kolon Seviyesinde SubQuery
-- Table Seviyesinde SubQuery
-- Where Conditions icerisinde SubQuery

-- Kolon Seviyesinde SubQuery -- 
Select
    e.employee_id,
    e.first_name,
    e.last_name,
    Department_id
From Employees e;

Select * From Departments d;

Select
    department_name
From departments d
Where department_id = 10;

-- !!!ORNEK!!!
Select
    e.employee_id,
    e.first_name,
    e.last_name,
    department_id,
    (
        Select
            department_name
        From departments d
        Where department_id = e.department_id
    )as BolumAdi
From employees e;

-- ORNEK: Herbir personelin toplam freight'ini bulunuz.
Select  
    hre.empid,
    hre.firstname,
    hre.lastname,
    (
        Select 
            sum(freight)
        From sales_orders
        Where empid = hre.empid
    )
From hr_employees hre;

-- ORNEK
Select  
    hre.empid,
    hre.firstname,
    hre.lastname,
    (
        Select 
            sum(freight)
        From sales_orders
        Where empid = hre.empid
    ) as TotalEmployeeFreight,
    (
     Select 
            sum(freight)
        From sales_orders
    ) as TotalFreight
From hr_employees hre;

-- ORNEK: Yukaridaki sorguyu join ile yapin.
Select
    hre.firstname,
    hre.lastname,
    sum(so.freight) as TotalFreight
From hr_employees hre
Join sales_orders so on so.empid = hre.empid
Group By hre.firstname, hre.lastname
Order By TotalFreight desc;

-- TABLE SEVIYESINDE SUBQUERY --
Select
    *
From
(  
    Select
        r.region_id,
        r.region_name,
        c.country_id,
        c.country_name
    From regions r
    Join countries c on c.region_id = r.region_id
) B
Where B.region_name = 'Europe';

-- Yukaridaki sorguyu join ile Locations tablosuna baglayalým
Select
      b.Region_id,
      b.Region_Name,
      b.Country_Name,
      l.City
From (
        Select
              r.Region_id,
              r.Region_Name,
              c.country_id,
              c.Country_Name
        From Regions    r
        join Countries  c on c.region_id = r.region_id
     ) b
join Locations l on l.Country_id = b.Country_id;

-- Where Conditions icerisinde SubQuery -- 
-- ORNEK: Employees tablosunda David Lee isimli kisiden sonra ise girenleri listeleyelim.
Select *
From Employees
Where Hire_Date >  (
                    Select Hire_Date
                    From Employees
                    Where first_name = 'David' and Last_Name = 'Lee'
                   );

Select *
From Employees
Where Hire_Date > '23/02/2008';

Select *
From Employees
Where Hire_Date > '23-02-2008';

Select *
From Employees
Where Hire_Date > TO_DATE('23-02-2008','DD/MM/YYYY');

Select
        employee_id,
        first_name,
        TO_CHAR(Hire_Date,'DD/MM/YYYY') as IseGirisTarihi1,
        TO_CHAR(Hire_Date,'DD MON YYYY') as IseGirisTarihi2,
        TO_CHAR(Hire_Date,'DD MONTH YYYY') as IseGirisTarihi3
From Employees
Where Hire_Date > TO_DATE('23/02/2008','DD/MM/YYYY');

-- ORNEK: Adi Jonathan ve Soyadi Taylor olan kisinin unvani ile ayni olup
-- Taylor'dan daha fazla maas alanlari listeleyelim.
Select
    *
From Employees
Where salary > (
                    Select 
                        salary
                    From Employees
                    Where first_name = 'Jonathon' and last_name = 'Taylor'
                )
       And job_id = (
                    Select
                        job_id
                    From Employees
                    Where first_name = 'Jonathon' and last_name = 'Taylor'
                );
                
-- ORNEK: Employees tablosunda en dusuk maas alan kisiyi/kisileri bulan sorguyu yaziniz.
Select
      Employee_id,
      First_Name,
      Last_Name,
      Job_id,
      Salary
From Employees
Where Salary in (
                  Select Min(Salary)
                  From Employees
                );
                
-- = 'de kullan?labilirdi cunku min her zaman tek deger doner.

-- ORNEK
Select
    e.employee_id,
    e.first_name,
    e.last_name,
    e.job_id,
    e.salary,
    e.department_id,
    (
        Select
            department_name
        From departments
        Where department_id = e.department_id
    ) as Department_Name
From employees e
Where Salary = (
                    Select Min(salary)
                    From Employees
                );
                
-- HAVING SEVIYESINDE SUBQUERY --
-- ORNEK: Minimum maasi, 50 no'lu departmanin minimum maasindan yuksek olan departmanlari getirin.
Select
    department_id,
    Min(salary) as "Min Salary"
From employees e
Group By department_id
Having Min(salary) > (
                        Select Min(salary)
                        From employees
                        Where department_id = 50
                     )
Order By 1;

-- Yukaridaki sorguyu where ile cozmek baska bir sonuc verir.
Select
      Department_id,
      Min(Salary) as MinSalary 
From Employees e
Where Salary > (
                  Select Min(Salary)
                  From Employees
                  Where department_id = 50
                )
Group By Department_id
Order By 1;

-- UPDATE ILE SUBQUERY KULLANIMI --
-- Ornek 6
-- 60 nolu bolumde calisanlarin maaslarini
-- 50 nolu bolumde calisanlarin EN BUYUK maasi ile esitleyelim
-- Once Employee tablosunun bir kopyasýný olusturalým

Create Table Employee_Update as
Select * From Employees;


Select * From Employee_Update;

Select
      Department_id,
      First_Name,
      Last_Name,
      Salary
From Employee_Update
Where Department_id = 60;

Select Max(Salary)
From Employee_Update
Where Department_id = 50;

Update Employee_Update
Set Salary = (Select Max(Salary)
              From Employee_Update
              Where Department_id = 50
             )
Where Department_id = 60;

Commit;

Select
      Department_id,
      First_Name,
      Last_Name,
      Salary
From Employee_Update
Where Department_id = 60;

-- Delete ile SubQuery Kullanýmý
-- Ornek 7
-- Soyadý(Last__Name) tekrar eden kayýtlardan
-- sadece bir tanesi kalsýn, digerlerini silelim
-- Once foreign keylere takýlmamak icin
-- Employee tablosunun bir kopyasýný olusturalým

Create Table Employee_Delete as
Select * From Employees;

Select * From Employee_Delete;

-- Rowid  : Veri tabaný icerisinde tutulan verilerin/datalarýn
-- fiziksel adresleri vardýr
-- Rowid verilerin/datalarýn fiziksel adreslerini tutar ve 10 Byte alan tutar
-- Tablolarý Select ettigimizde Rowid kolonu normalde gozukmez

Select
      Last_Name,
      Salary,
      Rowid
From Employee_Delete
Order By Last_Name;

-- Rowid ile bir kayda en hýzlý erisim saglanýr

Select
      Last_Name,
      Count(*)
From Employee_Delete
Group By Last_Name
Having Count(*) > 1;

Select
      Rowid,
      Last_Name      
From Employee_Delete
Where Rowid not in (
                      Select Max(Rowid)
                      From Employee_Delete
                      Group By Last_Name                      
                    );
-- Yani yukaridaki kayýtlarýn silinmesi gerekiyor
Delete From Employee_Delete
Where Rowid not in (
                      Select Max(Rowid)
                      From Employee_Delete
                      Group By Last_Name                      
                    );
-- Tekrar bakalým tekrar eden var mý?

Select
      Rowid,
      Last_Name      
From Employee_Delete
Where Rowid not in (
                      Select Max(Rowid)
                      From Employee_Delete
                      Group By Last_Name                      
                    );

-- Evet Last_Name ayný olan birden fazla tekrar eden kayýtlarý sildik