-- NATURAL JOIN --
-- Ansii Format
Select * From hr.employees Natural Join hr.departments;

-- Geleneksel Format
Select
    *
From hr.employees hre, hr.departments hrd
Where hre.department_id = hrd.department_id;

-- ORNEK: sales_orders, hr_employees, sales_customers tablolarini hem ansii hem de geleneksel formatta birlestiriniz.
-- custid, company_name, first_name, last_name, orderid, orderdate, freight, shipcountry bilgileri gelsin.

-- YONTEM 1: Ansii format.
Select
    so.custid,
    sc.companyname,
    hre.firstname,
    hre.lastname,
    so.orderid,
    so.orderdate,
    so.freight,
    so.shipcountry
From sales_orders so
Join hr_employees hre on hre.empid = so.empid
Join sales_customers sc on sc.custid = so.custid;

-- YONTEM 2: Geleneksel format.
Select
    so.custid,
    sc.companyname,
    hre.firstname,
    hre.lastname,
    so.orderid,
    so.orderdate,
    so.freight,
    so.shipcountry
From sales_orders so, hr_employees hre, sales_customers sc
Where so.empid = hre.empid 
And   so.custid = sc.custid;

-- NATURAL JOIN COZUMU: Bagimli olandan, olmayana dogru git.
Select
    *
From sales_orders so
Join hr_employees hre using(empid) 
Join sales_customers sc using(custid);

-- GELENEKSEL FORMATTA LEFT JOIN YAPMAK --
-- (+) nerede ise sag veya sol, ona gore join yapar.
-- Eger esitligin iki tarafinda da (+) varsa full join demektir.
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From hr.regions r, hr.countries c, hr.locations l
Where r.region_id = c.region_id(+)
And c.country_id = l.country_id(+)
Order By 1, 3;

-- ORNEK
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From hr.regions r, hr.countries c, hr.locations l
Where r.region_id = c.region_id(+)
And   c.country_id = l.country_id(+)
And   l.city is null
Order By 1, 3;

-- GELENEKSEL FORMATTA RIGHT JOIN YAPMAK --
-- Sonuc (+)'nin kullanildigi yere gore degisiklik gosterir.
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From hr.locations l, hr.countries c, hr.regions r
Where c.region_id(+) = r.region_id
And   l.country_id(+) = c.country_id
Order By 1, 3;

-- ORNEK: Yukaridaki ile ayni sonucu verir.
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From hr.locations l, hr.countries c, hr.regions r
Where r.region_id = c.region_id(+)
And   c.country_id = l.country_id(+)
Order By 1, 3;

-- GELENEKSEL FULL OUTER JOIN --
-- (Geleneksel left join) UNION (Geleneksel  right join)

-- (Geleneksel left join)
Select
    d1.department_id as "Dept1 id",
    d1.department_name as "Dept1 name",
    d2.department_id as "Dept2 id",
    d2.department_name as "Dept2 name"
From mhusna_test.dept1 d1, mhusna_test.dept2 d2
Where d1.department_id = d2.department_id(+)

-- (union)
UNION

-- (Geleneksel right join)
Select
    d1.department_id as "Dept1 id",
    d1.department_name as "Dept1 name",
    d2.department_id as "Dept2 id",
    d2.department_name as "Dept2 name"
From mhusna_test.dept1 d1, mhusna_test.dept2 d2
Where d1.department_id(+) = d2.department_id;

-- GELENEKSEL SELF JOIN --
Select
    e1.employee_id as "Personel Id",
    e1.first_name || ' ' || e2.last_name as "Personel",
    e2.first_name || ' ' || e2.last_name as "Manager",
    e2.employee_id as "Manager Id"
From hr.employees e1, hr.employees e2
Where e1.manager_id = e2.employee_id;

-- ORNEK
Select
    e1.employee_id as "Personel Id",
    e1.first_name || ' ' || e2.last_name as "Personel",
    e1.manager_id as "Manager id",
    NVL2(e2.first_name || e2.last_name,  e2.first_name || ' ' || e2.last_name, 'CEO') as "Manager"
From hr.employees e1, hr.employees e2
Where e1.manager_id = e2.employee_id(+)
Order By 1;

-- GELENEKSEL FORMATTA CROSS JOIN --
Select * From CustomersJoin, CityJoin;

-- ORNEK: Herbir personelin toplam quantity(qty) miktarlarini ve (qty * unitprice) toplamlarini bulunuz.
-- Tables: sales_orders, hr_employees, sales_orderdetails.
desc sales_orders; 
desc hr_employees;
desc sales_orderdetails;

Select
    hre.firstname ||' ' || hre.lastname as "Name",
    sum(sod.qty) as "Toplam QTY",
    sum(sod.qty * sod.unitprice) as "Genel Toplam"
From sales_orders so 
Join hr_employees hre on hre.empid = so.empid
Join sales_orderdetails sod on sod.orderid = so.orderid
Group By hre.firstname ||' ' || hre.lastname;

-- NATURAL JOIN ILE 3 TABLO BIRLESTIRELIM
Select
    *
From sales_orders so
Join hr_employees hre using(empid)
Join sales_customers sc using(custid);

-- NATURAL JOIN ILE 2 TABLO BIRLESTIRELIM
Select
    *
From sales_orders so
Join hr_employees hre using(empid);

-- GELENEKSEL YONTEM
Select
    *
From sales_orders so, hr_employees hre
Where so.empid = hre.empid;