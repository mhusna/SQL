-- KUME OPERATORLERI
-- Union: Distinct islemi yapar.
-- Union All
-- Intersect: Iki kumenin kesisimini alir.
-- Minus: Iki kumenin farkini alir.

-- dept1 ve dept2 tablolari olusturalim.
Create Table dept1 as
Select 
    * 
From hr.departments
Where department_id <= 50;

Create Table dept2 as
Select
    *
From hr.departments
Where department_id <= 30 or department_id in(90, 100, 110);

-- UNION
Select * From dept1
UNION
Select * From dept2;

-- UNION ALL
Select * From dept1
UNION ALL
Select * From dept2;

-- INTERSECT
Select * From dept1
INTERSECT
Select * From dept2;

-- MINUS
Select * From dept1
MINUS
Select * From dept2;

Select * From dept2
MINUS
Select * From dept1;

-- ORNEK: Ocak 2008'de aktivitesi olup Subat 2008'de aktivitesi olmayan
-- customer ve employee ciftini bulun.
-- Tables: sales_orders
-- YONTEM 1
Select custid, empid From sales_orders Where orderdate >= '01-01-2008' and orderdate < '01-02-2008'
MINUS
Select custid, empid From sales_orders Where orderdate >= '01-02-2008' and orderdate < '01-03-2008';

-- YONTEM 2
Select custid, empid, orderdate From sales_orders Where To_Char(orderdate, 'YYYY') = 2008 and To_Char(orderdate, 'MM') = 1
MINUS
Select custid, empid, orderdate From sales_orders Where To_Char(orderdate, 'YYYY') = 2008 and To_Char(orderdate, 'MM') = 2
order by orderdate;

-- ORNEK: Ocak 2008'de ve Subat 2008'de aktivitesi olan customer ve employee ciftini bulunuz.
Select custid, empid From sales_orders Where orderdate >= '01-01-2008' and orderdate < '01-02-2008'
INTERSECT
Select custid, empid From sales_orders Where orderdate >= '01-02-2008' and orderdate < '01-03-2008';

-- ORNEK: Ocak ve Subat 2008'de aktivitesi olan ancak 2007'de aktivitesi olmayan customer ve employee ciftini bulunuz.
(
    Select custid, empid From sales_orders Where orderdate >= '01-01-2008' and orderdate < '01-02-2008'
    INTERSECT
    Select custid, empid From sales_orders Where orderdate >= '01-02-2008' and orderdate < '01-03-2008'
)
MINUS
Select custid, empid From sales_orders Where To_Char(orderdate, 'YYYY') = 2007;

-- ORNEK: hr_employees tablosundaki bilgilerin production_suppliers tablosundan once gelmesini garanti ediniz.
-- Tables: hr_employees, production_suppliers
With A as
(
    Select country, region, city, 1 as TabloNo From hr_employees
    union all
    Select country, region, city, 2 as TabloNo From production_suppliers
)
Select * From A
Order By TabloNo;