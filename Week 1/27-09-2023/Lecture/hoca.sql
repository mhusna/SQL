

--27092023

Select * From all_users;

Select * From all_tables;

Select *
From all_tables
Where owner = 'HR';

Select * From all_cons_columns;

Select *
From all_cons_columns
Where owner = 'HR';

Select *
From all_constraints;

Select *
From all_constraints
Where owner = 'HR';

Create Table cityjoincopy as
Select *
From cityjoin;

desc cityjoincopy;

Select * From cityjoincopy;

Alter Table cityjoincopy Add Populate Number(10);

desc cityjoincopy;

Alter Table cityjoincopy
Modify Populate Varchar2(30);

desc cityjoincopy;

--

Alter Table cityjoincopy Add TelNo Number(10);

desc cityjoincopy;

Alter Table cityjoincopy
Rename Column TelNo to MobileNumber;

desc cityjoincopy;

-- SavePoint

Create Table OrnekTablo
(
    Ad VarChar2(30),
    Soyad VarChar2(50),
    MobileNo VarChar2(15)
);

Desc OrnekTablo;

Rename OrnekTablo To SampleTablo;

Desc SampleTablo;

Select *
From SampleTablo;

insert into SampleTablo Values('Ali','TOPACIK','05559988876');
Commit;

Select *
From SampleTablo;

insert into SampleTablo Values('Saadet','Bozkan','121212122');
insert into SampleTablo Values('Seyda','Akgul','3365656');
SavePoint A;

insert into SampleTablo Values('Yusuf','Uluocak','6659979');
SavePoint B;

insert into SampleTablo Values('Erkut','Ates','4123569');
SavePoint C;

insert into SampleTablo Values('Firat','Tosun','23995644');
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

Select *
From SampleTablo;

RollBack To A;

Select *
From SampleTablo;

--

Select *
From all_cons_columns cc;

Select *
From all_constraints co;


Select
        cc.owner, cc.CONSTRAINT_NAME, cc.Table_Name, cc.Column_Name,
       co.*
From all_cons_columns cc
join all_constraints  co on co.CONSTRAINT_NAME = cc.CONSTRAINT_NAME
Where cc.Owner = 'HR';

--

Select *
from all_tab_columns;

--

Select *
from all_tab_columns
Where Owner = 'HR';


Select 'Select * From ' || Table_Name || ';' as Sorgu
from all_tab_columns
Where Owner = 'HR';

Select EMPLOYEE_ID,	FIRST_NAME,	LAST_NAME,	MANAGER_ID
From Ora_Employees;

--

Select EMPLOYEE_ID,	FIRST_NAME,	LAST_NAME,	MANAGER_ID
From Ora_Employees
Connect By Prior EMPLOYEE_ID = MANAGER_ID;

--

Select EMPLOYEE_ID,	FIRST_NAME,	LAST_NAME,	MANAGER_ID
From Ora_Employees
Connect By EMPLOYEE_ID = Prior MANAGER_ID;

Create Table ora_employees_Copy as
Select *
From ora_employees;

Select *
From ora_employees_Copy;

Select *
From ora_employees_Copy
Where employee_id <> 100;

Update ora_employees_Copy
Set Salary = Salary * 1.20,
    COMMISSION_PCT = 0.25
Where employee_id <> 100;

Commit;

Select *
From ora_employees_Copy
Where employee_id <> 100;

-- 101 ve 102 nolu calisanlar?n maaslar?n? 400$ dusurelim
-- Tablo : ora_employees_Copy

Select *
From ora_employees_Copy
Where employee_id in(101,102);

--

Update ora_employees_Copy
Set Salary = Salary - 400
Where employee_id in(101,102);

Commit;

-- sys ile asag?daki yetkileri verelim

Create User PersonelA identified by PersonelA;

Grant connect, resource to PersonelA;

Grant connect, resource, unlimited TableSpace to PersonelA;

Grant Select on HR.Employees to PersonelA;
Grant insert on HR.Employees to PersonelA;
Grant delete on HR.Employees to PersonelA;
Grant Update on HR.Employees to PersonelA;

Grant Select,insert,update,delete on HR.Employees to PersonelA;

-- PersonelA adl? kullanc?n?n baskas?na yetki vermesi icin Grant Option ile yetki verelim

Grant Select on HR.Employees to PersonelA With Grant Option;
Grant insert on HR.Employees to PersonelA With Grant Option;
Grant delete on HR.Employees to PersonelA With Grant Option;
Grant Update on HR.Employees to PersonelA With Grant Option;


Grant Select,insert,update,delete on HR.Employees to PersonelA With Grant Option;

-- Yetkileri geri alal?m

Revoke delete on HR.Employees From PersonelA;

Revoke insert, update on HR.Employees From PersonelA;

-- Yukar?da bir user icin yetki verdik
-- Public olarak haz?r bir role var
-- Yetkileri bu role uzerinede verebiliriz
-- Bu durumda veritaban?na baglanma yetkisi olan tum userlar yetkilendirilmis olur

Grant Select on HR.Employees to Public;

Grant Select on OracleData.Regions_Copy to PersonelA;
Revoke Select on OracleData.Regions_Copy From PersonelA;


-- System Admini olarak connect olal?m

Grant Create Role to OracleData;

-- OracleData user olarak baglanal?m

Create Role R_SEL;
Create Role R_INS;


Create Role R_SELUPD;
Create Role R_INSDEL;

--Drop Table Regions_Copy;

Create Table Regions_Copy as
Select *
From hrA.Ora_Regions;

Select *
From Regions_Copy;

insert into Regions_Copy Values(5,'Africa');

Select *
From OracleData.Regions_Copy;

Grant Select on OracleData.Regions_Copy to R_SEL;
Grant insert on OracleData.Regions_Copy to R_INS;

-- simdi bu rolleri atayal?m

Grant Select, Update on OracleData.Regions_Copy to R_SELUPD;
Set Role R_SELUPD;
Grant R_SEL to PersonelA;

Select *
From OracleData.Regions_Copy;

Grant insert, Delete on OracleData.Regions_Copy to R_INSDEL;


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

-- AT3 kullanýcýsýnýn R_Ins_Del role yetkisini Revoke edelim

-- AT1 ile connect olalým
Revoke R_Ins_Del From AT3;

-- Rolu Drop edelim

Drop Role R_Ins_Del;

-- Select * From User_Tab_Privs_Made;

-- AT3 ile connect olalým

insert into AT1.Personel Values(9,'Bursa');
Commit;

-- Set(Kume) Operatorleri
-- Union
-- Union All
-- Intersect
-- Minus

-- OracleData ile connect olalým

-- Departments tablosundan 2 tane tablo olusturalým

-- Drop Table Dept1;
-- Drop Table Dept2;

Create Table Departments as
Select *
From HR.Ora_Departments;

Create Table Dept1 as
Select *
  From Departments 
  Where Department_id <= 50;

Create Table Dept2 as
Select *
  From Departments
  Where Department_id <= 30 or Department_id in(90,100,110);
  
--------------------------------------------------

Select department_id,department_name,manager_id,location_id From Dept1;

Select department_id,department_name,manager_id,location_id From Dept2;


Select department_id,department_name,manager_id,location_id From Dept1
Union
Select department_id,department_name,manager_id,location_id From Dept2;

Select department_id,department_name,manager_id,location_id From Dept1
Union All
Select department_id,department_name,manager_id,location_id From Dept2;

Select department_id,department_name,manager_id,location_id From Dept1
intersect
Select department_id,department_name,manager_id,location_id From Dept2;


Select department_id,department_name,manager_id,location_id From Dept1
minus
Select department_id,department_name,manager_id,location_id From Dept2;

Select department_id,department_name,manager_id,location_id From Dept2
minus
Select department_id,department_name,manager_id,location_id From Dept1;


Select distinct COUNTRY From HR_Employees;

Select distinct COUNTRY From Sales_Customers;

Select COUNTRY From HR_Employees
Union
Select COUNTRY From Sales_Customers;

Select COUNTRY From HR_Employees
Union All
Select COUNTRY From Sales_Customers;

Select CITY, COUNTRY From HR_Employees

Select CITY, COUNTRY From Sales_Customers;


Select CITY, COUNTRY From HR_Employees
Union
Select CITY, COUNTRY From Sales_Customers;

Select CITY, COUNTRY From HR_Employees
Union All
Select CITY, COUNTRY From Sales_Customers;

Select CITY, COUNTRY From HR_Employees
Minus
Select CITY, COUNTRY From Sales_Customers;

Select CITY, COUNTRY From Sales_Customers
Minus
Select CITY, COUNTRY From HR_Employees;

Select CITY, COUNTRY From HR_Employees
intersect
Select CITY, COUNTRY From Sales_Customers;

Select CITY, REGION, COUNTRY From HR_Employees;

Select CITY, REGION, COUNTRY From Sales_Customers;

Select CITY, REGION, COUNTRY From HR_Employees
Union
Select CITY, REGION, COUNTRY From Sales_Customers;

Select CITY, REGION, COUNTRY From HR_Employees
Union All
Select CITY, REGION, COUNTRY From Sales_Customers;

-- Oncelik Sirasi
-- once Minus calisir sonra intersect calisir

Select CITY, REGION, COUNTRY From PRODUCTION_SUPPLIERS
Minus
Select CITY, REGION, COUNTRY From HR_Employees
intersect
Select CITY, REGION, COUNTRY From Sales_Customers;

(Select CITY, REGION, COUNTRY From PRODUCTION_SUPPLIERS
Minus
Select CITY, REGION, COUNTRY From HR_Employees)
intersect
Select CITY, REGION, COUNTRY From Sales_Customers;

Select CITY, REGION, COUNTRY From PRODUCTION_SUPPLIERS
Minus
(Select CITY, REGION, COUNTRY From HR_Employees
intersect
Select CITY, REGION, COUNTRY From Sales_Customers);

-- Soru 1
-- Ocak 2008 'de aktivitesi olup Subat 2008'de aktivitesi olmayan Customer ve Employee
-- ciftini bulunuz

-- Tables : Sales_Orders

Select * From Sales_Orders;

Select custid, empid 
From Sales_Orders 
Where orderdate >='01-01-2008' and orderdate < '01-02-2008'
Minus
Select custid, empid 
From Sales_Orders 
Where orderdate >='01-02-2008' and orderdate < '01-03-2008';

--

Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')='2008' and To_Char(orderdate,'MM')='01'
Minus
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')='2008' and To_Char(orderdate,'MM')='02';

Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 1
Minus
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 2;

--

-- Soru 2
-- Ocak 2008 'de ve Subat 2008'de aktivitesi olan Customer ve Employee
-- ciftini bulunuz

-- Tables : Sales_Orders

Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 1
intersect
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 2;

-- Soru 3
-- Ocak 2008 'de ve Subat 2008'de aktivitesi olan 
-- ancak 2007'de aktivitesi olmayan Customer ve Employee
-- ciftini bulunuz

-- Tables : Sales_Orders

Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 1
intersect
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 2
Minus
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2007;

--

(Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 1
intersect
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2008 and To_Char(orderdate,'MM')= 2)
Minus
Select custid, empid 
From Sales_Orders 
Where To_Char(orderdate,'YYYY')= 2007;

-- Soru 4
-- Asagidaki sorguya sahibiz
-- HR_EMPLOYEES tablosundaki bilgilerin PRODUCTION_SUPPLIERS tablosundan once gelmesini
-- garanti ediniz
-- Tables : HR_EMPLOYEES, PRODUCTION_SUPPLIERS

Select CITY, REGION, COUNTRY From HR_EMPLOYEES;

Select CITY, REGION, COUNTRY From PRODUCTION_SUPPLIERS;

Select CITY, REGION, COUNTRY From HR_EMPLOYEES
Union
Select CITY, REGION, COUNTRY From PRODUCTION_SUPPLIERS;

(Select CITY, REGION, COUNTRY From HR_EMPLOYEES)
Union All
Select CITY, REGION, COUNTRY From PRODUCTION_SUPPLIERS;

-- CTEs ile yapal?m

Select CITY, REGION, COUNTRY,1 as TabloNo From HR_EMPLOYEES
Union All
Select CITY, REGION, COUNTRY,2 as TabloNo From PRODUCTION_SUPPLIERS;


With
A as
(
    Select CITY, REGION, COUNTRY,1 as TabloNo From HR_EMPLOYEES
    Union All
    Select CITY, REGION, COUNTRY,2 as TabloNo From PRODUCTION_SUPPLIERS
)
Select CITY, REGION, COUNTRY
From A
Order By TabloNo;

-- Fonksiyonlar

-- Sayýsal Fonksiyonlar,
-- Karakter Fonksiyonlar,
-- Tekil Sonuc Fonksiyonlarý,
-- istatistik Fonksiyonlar,
-- Tarih ve Zaman Fonksiyonlarý

-- Sayýsal Fonksiyonlar;

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

Select Salary, Sign(Salary) From EmployeesCopy;

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

--


-- Ceil, Floor


Select Ceil(123.456), Ceil(-5.6) From Dual;
Select Ceil(123.006), Ceil(-5.6) From Dual;

Select Floor(123.456), Floor(-5.6) From Dual;
Select Floor(123.856), Floor(-5.6) From Dual;


-- Mod, Power, Sqrt
Select Mod(5,2) From Dual;
-- 5 sayýsýnýn 2 ye bolumunden kalaný verir

Select Mod(100,9) From Dual;

-- 1 den 11 e kadar olan bir sayý elde edelim
Select Level From Dual connect by Level < 12;

Select Level*-1 From Dual connect by Level < 12;

Select Level From Dual connect by Level < 12;

Select Level*-1 From Dual connect by Level < 12
Union
Select Level From Dual connect by Level < 12;

Select Level*-1 From Dual connect by Level < 12
Union
Select 0 From Dual
Union
Select Level From Dual connect by Level < 12;


------------------------------------------------------


Select
    Level,
    Mod(100, Level) -- 100 sayýsýnýn Level'a bolumunden kalan sayýyý verir
From Dual connect by Level < 12;

-- Power
Select Power(3,2) From Dual; -- 3 sayýsýnýn karesini verir
Select Power(2,3) From Dual; -- 2 sayýsýnýn kupunu verir
Select Power(3,4) From Dual; -- 3 sayýsýnýn 4. kuvvetini verir

-- SQRT -- karekok verir

Select
      SQRT(25),
      SQRT(625),
      SQRT(100)
From Dual;

Select
      Power(3,4),
      SQRT(Power(3,4))
From Dual;

-- Round

Select
      Round(1234.456789),  -- 0 yazýlmasada olabilir
      Round(1234.456789,0),
      Round(1234.56789,0),
      Round(1234.456789,1),
      Round(1234.456789,2),
      Round(1234.456789,3),
      Round(1234.456789,4),
      Round(1234.4599,5)
From Dual;

Select
      Round(1234.456789),  -- 0 yazýlmasada olabilir
      Round(1234.456789,0),
      Round(1234.456789,-1),
      Round(1234.456789,-2),
      Round(1234.456789,-3)
From Dual;

Select
      Round(1234.56789),  -- 0 yazýlmasada olabilir
      Round(1234.56789,0),
      Round(1234.56789,-1),
      Round(1234.56789,-2),
      Round(1234.56789,-3),
      Round(1234.56789,-4),
      Round(1234.56789,-5)
From Dual;

Select
      Round(5679.56789) Result_A,  -- 0 yazýlmasada olabilir
      Round(5679.56789,0) Result_0,
      Round(5679.56789,-1) Result_1,
      Round(5679.56789,-2) Result_2,
      Round(5679.56789,-3) Result_3,
      Round(5679.56789,-4) Result_4,
      Round(5679.56789,-5) Result_5
From Dual;

--
Select rownum, rowid,first_name, last_name
From EmployeesCopy
Order By Salary desc;

Create Table Employees as
Select *
From EmployeesCopy;

-- TOP n kullanimi icin RowNumber kullan?l?r
-- Employees tablosunda en yuksek maas alan 3 kisinin bilgilerini bulunuz
/
Select rownum, rowid,first_name, last_name, Salary
From Employees
Order By Salary desc;
/

With A as
(
    Select rownum, first_name, last_name, Salary
    From Employees
    Order By Salary desc
)
Select first_name, last_name, Salary
From A
Where rownum <= 3;
/
With A as
(
    Select first_name, last_name, Salary
    From Employees
    Order By Salary desc
)
Select first_name, last_name, Salary
From A
Where rownum <= 3;
/
--Derived Table ile yapal?m

Select first_name, last_name, Salary
From (
        Select first_name, last_name, Salary
        From Employees
        Order By Salary desc
     ) A
Where rownum <= 3;

/
Select rownum, rowid,firstname, lastname
From HR_Employees
Order By empid desc;
/


Select *
From (
      Select *
      From Employees
      Order By Salary desc
      ) A
Where RowNum <= 3;

-- TOP n kullanýmý
-- RowNumber
-- Employees tablosunda en dusuk maas alan 3 kisinin bilgilerini bulunuz

Select *
From (
      Select *
      From Employees
      Order By Salary
      ) A
Where
        RowNum <= 3
Order By
        Salary desc;
        
/

DROP TABLE rownum_order_test;

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

/

-- Employees tablosunda ki
-- Department_id'lere gore maas toplamlari En Yuksek olan
-- ilk 3 Department_id bulunuz

Select
        department_id,
        Sum(Salary) as TotalSalary
From Employees
Group By department_id
Order By TotalSalary desc;

With Rapor as
(
    Select
            department_id,
            Sum(Salary) as TotalSalary
    From Employees
    Group By department_id
    Order By TotalSalary desc
)
Select *
From Rapor
Where rownum <= 3;

/

Select Department_id, Sum(Salary) TotalSalary
From Employees
Group By Department_id
Order By Sum(Salary) Desc;
/
Select *
From (
        Select Department_id, Sum(Salary) TotalSalary
        From Employees
        Group By Department_id
        Order By Sum(Salary) Desc
      ) A
Where RowNum <= 3;

/

-- Employees Tablosunda job_id'si 'SA_REP', 'AD_PRES'
-- ve salary >15000'den buyuk olan kayýtlarý bulunuz

Select *
From Employees
Where Job_id in('SA_REP', 'AD_PRES') and Salary > 15000;

-- Employees Tablosunda
-- salary 1900-2100 arasý olan kayýtlarý bulunuz

SELECT last_name, first_name, salary
FROM ORA_employees
WHERE salary BETWEEN 1900 AND 2100;

-- ANY and ALL
-- Burada Any ve All icin parantez içerisinde bir altsorgudan gelen bilgileri kullanabiliriz

Select *
From Employees;

Create Table EmployeesB as
Select *
From Employees
Where department_id in(10,40,70,110);

Select *
From EmployeesB
Where department_id > ANY (10);

Select *
From EmployeesB
Where department_id > ANY (10,40);

Select *
From EmployeesB
Where department_id > ANY (10,40,70); -- Herhangi birinden buyuk olanlar gelir



Select *
From EmployeesB
Where department_id < ANY (110);

Select *
From EmployeesB
Where department_id < ANY (110,70);

Select *
From EmployeesB
Where department_id < ANY (110,70,40); -- Herhangi birinden kucuk olanlar gelir

-- ALL

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