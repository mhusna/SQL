-- Uzerinde Islem Yapacagimiz 
-- Gecici Tabloyu Olusturma
-------------------------------------------
Create Table regions_copy as 
Select *
From hr.regions;

Select *
From regions_copy;

Insert into regions_copy values(5, 'Africa');

Select *
From regions_copy;
-------------------------------------------

-- Rol olusturma
-- System admini olarak connect olalim.
Grant Create Role To OracleData;

-- OracleData olarak baglanalim.

Create Role R_SEL;
Create Role R_INS;

Create Role R_SELUPD;
Create Role R_INSDEL;

------------------------------------------------

Grant Select on OracleData.Regions_Copy to R_SEL;
Grant Insert on OracleData.Regions_Copy to R_INS;

Grant Select, Update on OracleData.Regions_Copy to R_SELUPD;
Grant Insert, Delete on OracleData.Regions_Copy to R_INSDEL;

-- Simdi bu rolleri atayalim
Set Role R_SELUPD;
Grant R_SELUPD to PersonelA;



/* Buradan itibaren rolleri ad?m ad?m yap?n?z */
--------------------------------------------------

-- BIR ORNEK ILE PEKISTIRELIM
-- System olarak baglanalým
Create User AT1 identified by AT1;
Grant connect, resource, unlimited TableSpace to AT1;

Grant Create Role to AT1;

Create User AT2 identified by AT2;
Grant connect, resource, unlimited TableSpace to AT2;

Create User AT3 identified by AT3;
Grant connect, resource, unlimited TableSpace to AT3;

-- AT1 ile connect olalým

Create Table Personel(
  id number,
  Sehir Varchar(2)
);
Alter Table Personel Modify (Sehir Varchar(50));

insert into AT1.Personel Values(1,'istanbul');

Select * From Personel;

Create Role R_Sel_Upd;
Create Role R_Ins_Del;

Grant Select, Update on AT1.Personel to R_Sel_Upd;
Grant Insert, Delete on AT1.Personel to R_Ins_Del;

Grant R_Sel_Upd To AT2;
Grant R_Ins_Del To AT3;

Select * From User_Tab_Privs_Made;

Select * From Personel;

-- AT2 ile connect olalým

Set Role R_Sel_Upd;
Select * From AT1.Personel;

-- AT3 ile connect olalým
-- Yekiyi kendine aliyor.
Set Role R_Ins_Del;
insert into AT1.Personel Values(2,'Bursa');
Commit;

insert into AT1.Personel Values(3,'izmir');
Commit;

-- AT2 ile connect olalým
Select * From AT1.Personel;

Update AT1.Personel
Set SEHIR = 'Adana'
Where id = 3;
Commit;

-- AT1 ile connect olalým

-- R_Sel_Upd rolunden Update Yetkisini alalým

Revoke Update on AT1.Personel From R_Sel_Upd;
-- R_Sel_Upd rolunun Update yetkisi alýndý

-- AT2 ile connect olalým
Select * From AT1.Personel;

Update AT1.Personel
Set SEHIR = 'Adana'
Where id = 3;
Commit;
-- AT2 kullanýcýnda Yukarýdaki islem Update yapmayacaktýr
-- Select yapabilir

-- AT1 ile connect olalim.
-- AT3 kullanýcýsýnýn R_Ins_Del role yetkisini Revoke edelim

Revoke R_Ins_Del From AT3;

-- Rolu Drop edelim

Drop Role R_Ins_Del;

-- Select * From User_Tab_Privs_Made;

-- AT3 ile connect olalým

insert into AT1.Personel Values(9,'Bursa');
Commit;
--------------------------------------------------
-- Set(Kume) Operatorleri
-- Union
-- Union All
-- Intersect
-- Minus

-- OracleData ile connect olalim

Create Table Departments as
Select * 
From hr.departments;

-- Departments tablosundan 2 tane tablo olusturalim

-- Drop Table Dept1;
-- Drop Table Dept2;
Create Table Dept1 as
Select *
  From departments 
  Where Department_id <= 50;

Create Table Dept2 as
Select *
  From Departments
  Where Department_id <= 30 or Department_id in(90,100,110);
  
--------------------------------------------------

SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept1;
    
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept2;

-------------------------------------------------
-- 10, 20, 30 numarali kayitlari tekrar etmeden yazdi.
-- Union'da gizli distinct vardir.
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept1
    
UNION
    
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept2;
    
-------------------------------------------------

SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept1
    
UNION ALL
    
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept2;
    
--------------------------------------------------
-- intersect: Kumelerin kesisimini alir.
-- Yani ortak kayitlari getirir.

SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept1
    
INTERSECT
    
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept2;
    
--------------------------------------------------
-- A kumesinin B kumesinden farkini bulmak icin
-- minus ile buluyoruz.

SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept1
    
MINUS
    
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept2;

--------------------------------------------------
-- B'nin A'dan farki

SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept2

MINUS
    
SELECT
    department_id,
    department_name,
    manager_id,
    location_id
FROM
    dept1;
    
--------------------------------------------------

Select distinct COUNTRY From HR_Employees;
Select distinct COUNTRY From Sales_Customers;

--------------------------------------------------

Select COUNTRY From HR_Employees
Union
Select COUNTRY From Sales_Customers;

--------------------------------------------------

Select COUNTRY From HR_Employees
Union All
Select COUNTRY From Sales_Customers;

--------------------------------------------------

Select CITY, COUNTRY From HR_Employees;
Select CITY, COUNTRY From Sales_Customers;

--------------------------------------------------

Select CITY, COUNTRY From HR_Employees
Union
Select CITY, COUNTRY From Sales_Customers;

--------------------------------------------------

Select CITY, COUNTRY From HR_Employees
Union All
Select CITY, COUNTRY From Sales_Customers;

--------------------------------------------------

Select CITY, COUNTRY From HR_Employees
Minus
Select CITY, COUNTRY From Sales_Customers;

--------------------------------------------------

Select CITY, COUNTRY From Sales_Customers
Minus
Select CITY, COUNTRY From HR_Employees;

--------------------------------------------------

Select CITY, COUNTRY From HR_Employees
intersect
Select CITY, COUNTRY From Sales_Customers;

--------------------------------------------------

Select CITY, REGION, COUNTRY From HR_Employees;
Select CITY, REGION, COUNTRY From Sales_Customers;

--------------------------------------------------
-- FONKSIYONLAR

-- Sayisal Fonksiyonlar,
-- Karakter Fonksiyonlar,
-- Tekil Sonuc Fonksiyonlari,
-- istatistik Fonksiyonlar,
-- Tarih ve Zaman Fonksiyonlari

-- Sayisal Fonksiyonlar;

-- Sign : Bir ifadenin/deðerin/fonksiyonun iþaretini bulur
-- Abs  : Mutlak deger Fonksiyonu

-- Ceil   : Aldýðý Sayýsal degeri Yukarý tam sayýya cevirir
-- Floor  : Aldýðý Sayýsal degeri Asagi tam sayýya cevirir

-- Mod    : Moduler aritmetik, ozellikle bir sayýnýn ciftmi tekmi olduguna bakarýz

-- Power  : ussel fonksiyon
-- SQRT   : Sayýnýn karekokunu bulur
-- Round  : Yuvarlama fonksiyonu, aldýðý sayýsal degeri yuvarlar

-- Ornekler

Select Sign(-3), Sign(3) From Dual;

Select Salary, Sign(Salary) From ora_employees_copy;

Select Abs(-10), Abs(10), Abs(123.45),Abs(-123.45) From Dual;

Select Sign(-3) * 15 + 5 From Dual;

Select
    Sign(-3 * 15 + 5),
    Abs(-3 * 15 + 5),
    Abs(3 * 15 + 5),
    Sign(-3 * 15 + 5 -Abs(-3 * 15 + 5)),
    Sign(-3 * 15 + 5 -Abs(-3 * 15)),
    -3 * 15 + 5, -Abs(-3 * 15)
From Dual;

Select
    -3 * 15, -Abs(-3 * 15),
    Sign(-3 * 15 -Abs(-3 * 15)),
    Sign(-3 * 15 +Abs(-3 * 15))
From Dual;

Select
    3 * 15,
    Sign(3 * 15 +Abs(-3 * 15))
From Dual;

-- 1'den 11'e kadar olan sayilari elde edelim
Select Level From dual connect by Level < 12;
Select Level * (-1) From dual connect by Level < 12;

-----------------------------------
-- Bunda 0 yok.
Select Level From dual connect by Level < 12
union
Select Level * (-1) From dual connect by Level < 12;

-----------------------------------

Select Level From dual connect by Level < 12
union
Select 0 From Dual
union
Select Level * (-1) From dual connect by Level < 12;

-----------------------------------

Select city, region, country From hr_employees
union
Select city, region, country From sales_customers;

-----------------------------------

Select city, region, country From hr_employees
union all
Select city, region, country From sales_customers;

-----------------------------------
-- Once minus calisir, sonra intersect calisir
Select city, region, country From production_suppliers
minus
Select city, region, country From hr_employees
intersect
Select city, region, country From sales_customers;

-----------------------------------
-- Onceligi bilmiyorsak parantes acip kapatiriz
(Select city, region, country From production_suppliers
minus
Select city, region, country From hr_employees)
intersect
Select city, region, country From sales_customers;

-- Soru1: Ocak 2008'de aktivitesi olup Subat 2008'de
-- aktivitesi olmayan customer ve employee ciftini bulun.
-- Tables: sales_orders

Select custid, empid From sales_orders where orderdate >= '01-01-2008' and orderdate < '01-02-2008'
minus
Select custid, empid From sales_orders where orderdate >= '01-02-2008' and orderdate < '01-03-2008';

-----------------------------------

Select custid, empid, orderdate From sales_orders where To_Char(orderdate, 'YYYY') = 2008 and To_Char(orderdate, 'MM') = 1
minus
Select custid, empid, orderdate From sales_orders where To_Char(orderdate, 'YYYY') = 2008 and To_Char(orderdate, 'MM') = 2
order by orderdate;


-- Soru2: Ocak 2008'de ve Subat 2008'de aktivitesi olan
-- customer ve employe ciftini bulunuz.

Select custid, empid From sales_orders where orderdate >= '01-01-2008' and orderdate < '01-02-2008'
intersect
Select custid, empid From sales_orders where orderdate >= '01-02-2008' and orderdate < '01-03-2008';

-- Soru3: Ocak ve subat 2008'de aktivitesi olan
-- ancak 2007'de aktivitesi olmayan cust ve emp
-- ciftini bulunuz.

(Select custid, empid From sales_orders where orderdate >= '01-01-2008' and orderdate < '01-02-2008'
intersect
Select custid, empid From sales_orders where orderdate >= '01-02-2008' and orderdate < '01-03-2008')
minus
Select custid, empid From sales_orders where orderdate >= '01-01-2007' and orderdate < '01-01-2008';

-- Soru4: Asagidaki sorguya sahibiz
-- hr_employees tablosundaki bilgilerin production_suppliers
-- tablosundan once gelmesini garanti edniz.
-- Tables: hr_employees, production_suppliers
------------------------------------------
Select country, region, city From hr_employees;
Select country, region, city From production_suppliers;
------------------------------------------
-- CTEs ile yapalim
With A as
(
    Select country, region, city, 1 as TabloNo From hr_employees
    union all
    Select country, region, city, 2 as TabloNo From production_suppliers
)
Select * from A
order by TabloNo;

Create Table Employee as
Select *
From ora_employees_copy;

Rename Employee to Employees;

-- Top n kullanimi icin RowNumber kullanilir
-- Employees tablosunda en yuksek maas alan 3
-- kisinin bilgilerini bulunuz.

With A As
(
    Select rownum, rowid, first_name, last_name, salary
    From Employees
    Order By salary desc
)
Select first_name, last_name, salary 
From A
Where rownum <= 3;

-----------------------------------
-- Rownum yok
With A As
(
    Select first_name, last_name, salary
    From Employees
    Order By salary desc
)
Select first_name, last_name, salary 
From A
Where rownum <= 3;

-----------------------------------
-- Derived Table Ile Yapalim

Select first_name, last_name, salary
From (
    Select first_name, last_name, salary
    From Employees
    Order By salary desc
) A
where rownum <= 3;

----------------------------------
CREATE TABLE rownum_order_test (
  val  NUMBER
);

INSERT ALL
  INTO rownum_order_test
  INTO rownum_order_test
  INTO rownum_order_test
SELECT level
FROM   dual
CONNECT BY level <= 10;

COMMIT;

Select * From rownum_order_test;

-- employees tablosundaki Department_id'lere gore maas toplamlari en yuksek
-- olan ilk 3 department_id bulun.

With EnYuksek as
(
    Select 
        department_id,
        sum(salary) as TotalSalary
    From employees
    Group By department_id
    Order By TotalSalary desc
)
Select *
From EnYuksek
Where rownum <= 3;

---------------------------------
-- Derived Table Yontemi

Select *
From
(
    Select 
        department_id,
        sum(salary) as TotalSalary
    From employees
    Group By department_id
    Order By TotalSalary desc
) A
Where rownum <= 3;


-------------------------------
-- Employees tablosunda job_id'si 'SA_REP', 'AD_PRES'
-- ve salary > 15000'den buyuk olan kayitlari bulun.

Select *
From Employees
Where ((job_id = 'SA_REP' or job_id = 'AD_PRES') and salary > 15000);
-- Where (job_id in('SA_REP', 'AD_PRES') and salary > 15000)

------------------------------
-- Employees tablosunda salary 1900-2100 arasi 
-- kayitlari bulunuz.

Select * 
From Employees
Where salary between 1900 and 2100;

------------------------------
-- ANY ve ALL
-- Any ve All icin parantez icerisinde bir altsorgudan gelen
-- bilgileri kullanabiliriz.

-- Any: Kume elemanlarinin herhangi birinden buyuk olanlari getir.

Create Table EmployeesB as
Select *
From Ora_Employees
Where department_id in(10,40,70,110);

Select *
From EmployeesB
Where department_id > ANY (10);

Select *
From EmployeesB
Where department_id > ANY (10,40);

Select *
From EmployeesB
Where department_id < ANY (110, 70);

-- All: Tum kume elemanlarindan buyuk olanlari getir

Select *
From EmployeesB
Where department_id > ALL (10);

Select *
From EmployeesB
Where department_id > ALL (10,40);

Select *
From EmployeesB
Where department_id > ALL (10,40,70); -- Hepsinden buyuk olanlar gelir

Select *
From EmployeesB
Where department_id < ALL (110);

Select *
From EmployeesB
Where department_id < ALL (110,70);

Select *
From EmployeesB
Where department_id < ALL (110,70,40); -- Hepsinden kucuk olanlar gelir