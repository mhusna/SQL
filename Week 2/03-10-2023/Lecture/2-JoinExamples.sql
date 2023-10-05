-- ORNEK --
-- ANSII FORMAT
Select * From Employees Natural Join Departments;

-- GELENEKSEL FORMAT
Select
    e.employee_id,
    e.first_name,
    d.department_name
From  employees e, departments d
Where e.department_id = d.department_id;

-- ORNEK --
-- ANSII FORMAT
Select * From Employees Natural Join Jobs;

-- GELENEKSEL FORMAT
Select
    e.employee_id,
    e.first_name,
    e.job_id,
    j.job_title
From  employees e, jobs j
Where e.job_id = j.job_id;

-- ORNEK: sales_orders, hr_employees, sales_customers tablolarini hem ansii hem de geleneksel formatta birlestiriniz.
-- custid, company_name, first_name, last_name, orderid, orderdate, freight, shipcountry bilgileri gelsin.

desc sales_orders;
desc hr_employees;
desc sales_customers;

-- ANSII FORMAT
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
Join sales_customers sc on sc.custid = so.custid
order by so.custid desc;
                
-- GELENEKSEL FORMAT
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
Where so.empid = hre.empid and sc.custid = so.custid;

-- NATURAL JOIN COZUMU: bagimli olandan, olmayana dogru git.
-- HATALI BAK !!
Select
    so.custid,
    sc.companyname,
    hre.firstname,
    hre.lastname,
    so.orderid,
    so.orderdate,
    so.freight,
    so.shipcountry
From hr_employees hre, sales_orders so,
     sales_customers sc, sales_orders so
Where hre.empid = so.empid and
      sc.custid = so.custid;
     
    

-- GELENEKSEL FORMATTA LEFT JOIN YAPMAK
-- (+) nerede ise sag veya sol ona gore join yapar.
-- Eger esitligin iki tarafinda da (+) varsa full join demektir.
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From regions r, countries c, locations l
Where r.region_id = c.region_id(+) and
      c.country_id = l.country_id(+)
Order By 1, 3;
   
-- ORNEK
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From regions r, countries c, locations l
Where r.region_id = c.region_id(+) and
      c.country_id = l.country_id(+) and
      l.city is null
Order By 1, 3;

-- GELENEKSEL FORMATTA RIGHT OUTER JOIN: Kullanima gore degisiyor.
-- ORNEK
Select
      r.Region_id,
      r.Region_Name,
      c.Country_id,
      c.Country_Name,
      l.City
From Locations l, Countries c, Regions r
Where c.Region_id(+)  = r.Region_id and
      l.Country_id(+) = c.Country_id
Order By 1,3;

-- ORNEK
Select
    r.region_id,
    r.region_name,
    c.country_id,
    c.country_name,
    l.city
From Locations l, Countries c, Regions r
Where r.Region_id   = c.Region_id(+)and
      c.Country_id  = l.Country_id(+)
Order By 1,3;

-- GELENEKSEL FULL OUTER JOIN: Geleneksel Left Join ile Geleneksel Right Join sorgulari Union ile birlestirilerek bulunur.
-- Geleneksel Left Join
Select
      d1.DEPARTMENT_ID "Dept1 id",
      d1.DEPARTMENT_NAME "Dept1 Name",
      d2.DEPARTMENT_ID "Dept2 id",
      d2.DEPARTMENT_NAME "Dept2 Name"
From  Dept1 d1, Dept2 d2 
Where d1.Department_id = d2.Department_id(+)

Union

-- Geleneksel Right Join

Select
      d1.DEPARTMENT_ID "Dept1 id",
      d1.DEPARTMENT_NAME "Dept1 Name",
      d2.DEPARTMENT_ID "Dept2 id",
      d2.DEPARTMENT_NAME "Dept2 Name"
From  Dept1 d1, Dept2 d2
Where d1.Department_id(+) = d2.Department_id;

-- GeLENEKSEL SELF JOIN
Select
      e1.Employee_id,
      e1.First_Name || ' ' || e1.Last_Name "Employee Name",
      e1.Manager_id,
      e2.First_Name || ' ' || e2.Last_Name "Manager Name"
From Employees e1, Employees e2
Where e1.Manager_id = e2.Employee_id
Order By 1;

-- ORNEK: CEO'nun da bilgilerini getirmek icin left join yapildi.
Select
      e1.Employee_id,
      e1.First_Name || ' ' || e1.Last_Name "Employee Name",
      e1.Manager_id,
      NVL2(e2.First_Name || e2.Last_Name,e2.First_Name || ' ' || e2.Last_Name,'CEO') "Manager Name"
From Employees e1, Employees e2
Where e1.Manager_id = e2.Employee_id(+)
Order By 1;

-- GELENEKSEL FORMATTA CROSS JOIN
Select * From CustomersJoin cu, CityJoin ci;

-- ANSII FORMAT
Select * From CustomersJoin cu Cross Join CityJoin ci;

-- ORNEK: Her bir personelin toplam quantity(qty) miktarlarini ve qty * unitprice toplamlarini bulunuz.
-- Tables: sales_orders, hr_employees, sales_orderdetails.
desc sales_orders;
desc hr_employees;
desc sales_orderdetails;

Select Distinct
    hre.firstname || ' ' || hre.lastname as "FULL NAME",
    sum(sod.qty) as QTY_TOPLAM,
    sum(sod.unitprice * sod.qty) as "QTY*UNITPRICE"
From sales_orders so
Join hr_employees hre on hre.empid = so.empid
Join sales_orderdetails sod on sod.orderid = so.orderid
Group By hre.firstname || ' ' || hre.lastname;

-- USING KULLANIMI
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