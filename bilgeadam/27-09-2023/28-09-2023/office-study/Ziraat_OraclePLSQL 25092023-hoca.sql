-- 25092023

-- sys alt?nda bunu yapal?m

Create User AliTOPACIK identified by Ali123;

Grant connect, resource to AliTOPACIK;

Grant All Privileges to AliTOPACIK;

--

Create User HRA identified by HRA;

Grant connect, resource to HRA;

Grant All Privileges to HRA;

--

Create User SQLDATA identified by Ali123;

Grant connect, resource to SQLDATA;

Grant All Privileges to SQLDATA;


-- simdi istedigimiz user icin gidebiliriz


Create Table Personel
( id int,
 FullName varchar2(100)
 );
 
 insert into Personel(id,FullName) Values(1,'Ali TOPACIK');
 
 Select *
 From Personel;
 
 
Create Table Ornek
(
  id int,
  isim varchar2(30)
);

insert into Ornek(id, isim) Values(1,'Ali');

Select *
From Ornek;

Select *
From employees;

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
FROM
    employees;

-- Yukar?daki sorguda JOB_ID IT_PROG OLANLARI GORELIM

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
FROM
    employees
WHERE JOB_ID='IT_PROG';

-- EMPLOYEES tablosunda her bir job_id icin odenen maas toplamlar?n? bulal?m

SELECT
    JOB_ID,
    Sum(Salary) as TotalSalary
FROM
    employees
Group By JOB_ID;

-- EMPLOYEES tablosunda her bir job_id icin odenen maas toplamlar?>20000 olanlar? bulal?m ve buyukten kucuge dogru s?ralayal?m

SELECT
    JOB_ID,
    Sum(Salary) as TotalSalary
FROM
    employees
Group By JOB_ID
Having Sum(Salary) > 20000
Order By TotalSalary desc;

--

SELECT
    JOB_ID,
    Sum(Salary) as TotalSalary
FROM
    employees
Group By JOB_ID
Having Sum(Salary) > 20000
Order By 2 desc;

--

SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary,
    employees.department_id
FROM
     employees    
join departments on employees.department_id = departments.department_id;

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
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id;

-- yukaridaki sorguda region_name'e gore toplamsalary bulunuz

SELECT
    r.region_name,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name;

-- Yukar?daki sorguda region_name'lerin ulkelere gore toplam salary bilgilerini bulunuz

SELECT
    r.region_name,
    c.country_name,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name,c.country_name
Order By 1,2;

-- Yukar?daki sorguda region_name'lerin ulkeler ve state_province'e gore
-- toplam salary bilgilerini bulunuz

SELECT
    r.region_name,
    c.country_name,
    l.state_province,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name,c.country_name,l.state_province
Order By 1,2,3;

--

SELECT
    r.region_name,
    c.country_name,
    l.state_province,
    l.city,
    d.department_name,
    sum(e.salary) as TotalSalary
FROM
     employees   e    
join departments d on e.department_id = d.department_id
join locations   l on d.location_id   = l.location_id
join countries   c on c.country_id    = l.country_id
join regions     r on r.region_id     = c.region_id
Group By
        r.region_name,c.country_name,l.state_province, l.city, d.department_name
Order By 1,2,3;

--

Create Table employee1
(
    employee_id Number Primary Key,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

--

Create Table employee2
(
    employee_id Number Constraint pk_employee2_empid Primary Key,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
);

--

Create Table employee3
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date
    Constraint pk_employee3_empid Primary Key
);

--

Create Table employee4
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    hiredate date    
);

--

Alter Table employee4
Add Constraint pk_employee4_empid Primary Key(employee_id);

-- Composite Primary Key

-- Asagidaki sorgu ornek amacl?d?r

Create Table employee5
(
    employee_id Number,
    firstname varchar2(30) Constraint pk_employee5_firstname Primary Key,
    lastname varchar2(30)
    
);

insert into employee5 Values(1,'Ali','TOPACIK');
insert into employee5 Values(2,'Ali','TOPACIK'); -- ayn? isim 2 veya fazlas?na giri? izni vermez
insert into employee5 Values(3,'Ali','BULUT'); -- ayn? isim 2 veya fazlas?na giri? izni vermez

-- Asagidaki sorgu ornek amacl?d?r

Create Table employee6
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    Constraint pk_employee6_firlastname Primary Key(firstname,lastname)
);

insert into employee6 Values(1,'Ali','TOPACIK');
insert into employee6 Values(2,'Ali','TOPACIK'); -- ayn? isim 2 veya fazlas?na giri? izni vermez
insert into employee6 Values(3,'Ali','BULUT');

--

Create Table DepartmenstA1
(
    dept_id Number Primary Key,
    dept_name Varchar2(50)
);

insert into DepartmenstA1 values(1,'IT');

Select *
From DepartmenstA1;

Create Table employeeA1
(
    employee_id Number not null,
    firstname varchar2(30),
    lastname varchar2(30),
    dept_id Number
);

insert into employeeA1 Values(100,'Ali','TOPACIK',1);
insert into employeeA1 Values(101,'Ali','BULUT',2);

Select *
From employeeA1;

-- simdi foreign key k?s?tlamas? yapal?m

Create Table employeeA2
(
    employee_id Number not null,
    firstname varchar2(30),
    lastname varchar2(30),
    dept_id Number,
    constraint fk_emp_dept_deptid
        foreign key(dept_id) References DEPARTMENSTA1(dept_id)
);

Select *
From DEPARTMENSTA1;

insert into employeeA2 Values(100,'Ali','TOPACIK',1);
insert into employeeA2 Values(101,'Ali','BULUT',2); -- 2 nolu dept_id DEPARTMENSTA1 tablosunda olmad??? icin eklemez

Select *
From employeeA2;

-- unique constraint

Create Table employeeA3
(
    employee_id Number not null,
    firstname varchar2(30),
    telephone Number unique
);

insert into employeeA3 Values(100,'Ali','5559988876');
insert into employeeA3 Values(101,'Veli','5559988876'); -- unique constraint'ten dolay? girise izin vermez
insert into employeeA3 Values(102,'Anil',5343848767);
insert into employeeA3 Values(104,'Anil',5343848767); -- unique constraint'ten dolay? girise izin vermez

--

Select *
From employeeA3;

-- Check Constraint

Create Table employeeA4
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number constraint chk_salaryaA4 Check(Salary Between 10000 and 100000) 
);

insert into employeeA4 Values(100,'Ali','TOPACIK', 50000);

insert into employeeA4 Values(101,'Saadet','BOZKAN', 101000);
insert into employeeA4 Values(102,'Saadet','BOZKAN', 9000);
insert into employeeA4 Values(103,'Saadet','BOZKAN', 30000);

insert into employeeA4 Values(100,'Seyda','Akgul', -15000);
insert into employeeA4 Values(100,'Seyda','Akgul', 15000);

Select *
From employeeA4;

--

Create Table employeeA5
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    dept_id Number
);

Alter Table employeeA5
Add constraint chk_dept_id Check(Length(dept_id)>=3);

--

Create Table employeeA6
(
    employee_id Number,
    firstname varchar2(30),
    lastname varchar2(30),
    salary Number,
    dept_id Number
);

Alter Table employeeA6
Add constraint chk_dept_id6 Check(dept_id>=100);

-- Default Constraint

Create Table Order1
(
    order_id Number,
    order_date date default(sysdate),    
    country Varchar2(30),
    Amount Number
);

insert into Order1 Values(1,'USA',10000); -- Bu calismaz

insert into Order1(order_id, country, Amount) Values(1,'USA',10000);

Select *
From Order1;

Select sysdate From Dual;

Select 'SQL Egitimine Hos Geldiniz' From Dual;

-- SQLDATA olarak olusturulan User secelim

--26092023

-- sys'ye baglanal?m ve asag?daki komutlar? calistiral?m

Create User OracleData identified by OracleData;

Grant connect, resource to OracleData;

Grant All Privileges to OracleData;

-- OracleData'ya baglanal?m

-- Gerekli olan dosyalar? buraya yukleyelim
-- C:\SQLDATATABLES klasoru alt?nda dosyalar var

/*

DROP TABLE CITYJOIN;
DROP TABLE CUSTOMERSJOIN;

DROP TABLE SALES_ORDERDETAILS;
DROP TABLE SALES_ORDERS;
DROP TABLE SALES_SHIPPERS;
DROP TABLE PRODUCTION_PRODUCTS;
DROP TABLE PRODUCTION_CATEGORIES;
DROP TABLE PRODUCTION_SUPPLIERS;
DROP TABLE HR_EMPLOYEES;
DROP TABLE SALES_CUSTOMERS;

*/

/*

@"C:\SQLDATATABLES\1- CityJoin.sql";
@"C:\SQLDATATABLES\2- CustomerJoin.sql";
@"C:\SQLDATATABLES\3- Customers.sql";
@"C:\SQLDATATABLES\4- HR_Employees.sql";
@"C:\SQLDATATABLES\5- Production_Supliers.sql";
@"C:\SQLDATATABLES\6- Production_Category.sql";
@"C:\SQLDATATABLES\7- Production_Products.sql";
@"C:\SQLDATATABLES\8- Sales_Shippers.sql";
@"C:\SQLDATATABLES\9- Sales_Orders.sql";
@"C:\SQLDATATABLES\10- Sales_OrderDetails.sql";

*/


Select * From CITYJOIN;
Select * From CUSTOMERSJOIN;

Select * From SALES_CUSTOMERS;
Select * From HR_EMPLOYEES;
Select * From SALES_ORDERS;
Select * From SALES_ORDERDETAILS;
Select * From PRODUCTION_PRODUCTS;
Select * From PRODUCTION_CATEGORIES;
Select * From PRODUCTION_SUPPLIERS;
Select * From SALES_SHIPPERS;

--

Select
        --c.custid,
        c.companyname,
        --e.empid,
        e.firstname,
        e.lastname,
        --o.orderid,
        o.orderdate,
        o.freight,
        --o.shipperid,
        --od.productid,
        od.unitprice,
        od.qty,
        pp.productname,
        --pp.supplierid,
        --pp.categoryid,
        pc.categoryname,
        ps.companyname,
        ss.companyname
From SALES_ORDERS           o
join SALES_CUSTOMERS        c  on c.custid       = o.custid
join HR_EMPLOYEES           e  on e.empid        = o.empid
join SALES_ORDERDETAILS     od on od.orderid     = o.orderid
join PRODUCTION_PRODUCTS    pp on pp.productid   = od.productid
join PRODUCTION_CATEGORIES  pc on pc.categoryid  = pp.categoryid
join PRODUCTION_SUPPLIERS   ps on ps.supplierid  = pp.supplierid
join SALES_SHIPPERS         ss on ss.shipperid   = o.shipperid
Order By o.orderid;

-- Yukar?daki sorguda companyname'lere Alias verelim

Select
        c.companyname Cust_companyname,
        e.firstname,
        e.lastname,
        o.orderdate,
        o.freight,
        od.unitprice,
        od.qty,
        pp.productname,
        pc.categoryname,
        ps.companyname Supp_companyname,
        ss.companyname ship_companyname
From SALES_ORDERS           o
join SALES_CUSTOMERS        c  on c.custid       = o.custid
join HR_EMPLOYEES           e  on e.empid        = o.empid
join SALES_ORDERDETAILS     od on od.orderid     = o.orderid
join PRODUCTION_PRODUCTS    pp on pp.productid   = od.productid
join PRODUCTION_CATEGORIES  pc on pc.categoryid  = pp.categoryid
join PRODUCTION_SUPPLIERS   ps on ps.supplierid  = pp.supplierid
join SALES_SHIPPERS         ss on ss.shipperid   = o.shipperid
Order By o.orderid;

--
Create View vw_OrdersAll
as
Select
        c.companyname Cust_companyname,
        e.firstname,
        e.lastname,
        o.orderdate,
        o.freight,
        od.unitprice,
        od.qty,
        pp.productname,
        pc.categoryname,
        ps.companyname Supp_companyname,
        ss.companyname ship_companyname
From SALES_ORDERS           o
join SALES_CUSTOMERS        c  on c.custid       = o.custid
join HR_EMPLOYEES           e  on e.empid        = o.empid
join SALES_ORDERDETAILS     od on od.orderid     = o.orderid
join PRODUCTION_PRODUCTS    pp on pp.productid   = od.productid
join PRODUCTION_CATEGORIES  pc on pc.categoryid  = pp.categoryid
join PRODUCTION_SUPPLIERS   ps on ps.supplierid  = pp.supplierid
join SALES_SHIPPERS         ss on ss.shipperid   = o.shipperid
Order By o.orderid;

-- Yukar?daki sorguyu view haline getirelim

Select *
From vw_OrdersAll;

-- view haline gelen sorgudan ve beslendigi sorgudan sorgular?m?z? ayr? ayr? yazal?m ve inceleyelim

-- her bir categoryname icin toplam freightlar? bulan sorguyu yaz?n?z

Select
        pc.categoryname,
        Sum(o.freight) as TotalFreight
From SALES_ORDERS           o
join SALES_CUSTOMERS        c  on c.custid       = o.custid
join HR_EMPLOYEES           e  on e.empid        = o.empid
join SALES_ORDERDETAILS     od on od.orderid     = o.orderid
join PRODUCTION_PRODUCTS    pp on pp.productid   = od.productid
join PRODUCTION_CATEGORIES  pc on pc.categoryid  = pp.categoryid
join PRODUCTION_SUPPLIERS   ps on ps.supplierid  = pp.supplierid
join SALES_SHIPPERS         ss on ss.shipperid   = o.shipperid
Group By pc.categoryname;

--

Select
        categoryname,
        Sum(freight) as TotalFreight
From vw_OrdersAll
Group By categoryname;

--

Select *
From vw_OrdersAll;

Select
        Ship_Companyname,
        Sum(freight) TotalFreight
From vw_OrdersAll
Group By Ship_Companyname;

-- her bir categoryname'nin productname'e gore Toplamfreight degerlerini bulunuz

Select
        categoryname,
        productname,
        Sum(freight) as TotalFreight
From vw_OrdersAll
Group By categoryname,productname
Order By categoryname,productname;

-- yillara gore toplamfreightlar? bulunuz

Select *
From vw_OrdersAll;

Select
        orderdate,
        to_char(orderdate,'YYYY') as orderyear
From vw_OrdersAll;

-- 

Select
        to_char(orderdate,'YYYY') as orderyear,
        Count(*) as siparissayisi
From vw_OrdersAll
Group By to_char(orderdate,'YYYY')
Order By orderyear;

-- Yukar?daki sorgu tum tablodaki verilerin bilgisini getiriyor

-- SHIP_COMPANYNAME = Shipper ZHISN olanlar?n yillara gore toplam freightlarini bulunuz

Select
        to_char(orderdate,'YYYY') as orderyear,
        Count(*) as siparissayisi
From vw_OrdersAll
Where SHIP_COMPANYNAME = 'Shipper ZHISN'
Group By to_char(orderdate,'YYYY')
Order By orderyear;

-- Yukaridaki sorguda siparis sayisi > 160 olan kayitlari bulunuz

Select
        to_char(orderdate,'YYYY') as orderyear,
        Count(*) as siparissayisi
From vw_OrdersAll
Where SHIP_COMPANYNAME = 'Shipper ZHISN'
Group By to_char(orderdate,'YYYY')
Having Count(*) > 160
Order By orderyear;

--Distinct komutu

Select *
From Sales_Customers;


Select
        Country
From Sales_Customers
Order By 1;


Select Distinct
        Country
From Sales_Customers
Order By 1;


Select Count(Country) as Sayisi
From Sales_Customers;


Select Count(Distinct Country) as Sayisi
From Sales_Customers;

--

Select
        orderid,
        TO_CHAR(orderdate,'YYYY') as orderyear,
        orderyear + 1 as nextyear        
From Sales_Orders;

-- Yukar?daki sorgu bu haliyle calismaz
-- su sekilde yazal?m

Select
        orderid,
        TO_CHAR(orderdate,'YYYY') as orderyear,
        TO_CHAR(orderdate,'YYYY') + 1 as nextyear        
From Sales_Orders;

-- veya derived table ile yapal?m

Select
        orderid,
        orderyear,
        orderyear + 1 as nextyear
From (
        Select
                orderid,
                TO_CHAR(orderdate,'YYYY') as orderyear
        From Sales_Orders
     ) A;

-- Yukar?daki sorguyu CTEs ile yazal?m

/*
With TabloAdi as
(
    ... Calisan kod
)
Select *
From TabloAdi;
*/

With A as
(
       Select
                orderid,
                TO_CHAR(orderdate,'YYYY') as orderyear
        From Sales_Orders
)
Select
        orderid,
        orderyear,
        orderyear + 1 as nextyear
From A;

--

With
personeller as
(
    Select empid, firstname || ' ' || lastname as FullName
    From HR_EMPLOYEES
),
siparisler as
(
    Select orderid, custid, empid, orderdate, freight
    From Sales_Orders
)
Select *
From personeller p
join siparisler s on p.empid = s.empid;

--

With
TumSiparisler as
(
    Select orderid, custid, empid, orderdate, freight, shipcity, shipcountry
    From Sales_Orders
),
UsaSiparisleri as 
(
    Select *
    From TumSiparisler
    Where shipcountry = 'USA'
),
CityToplamlari as
(
    Select shipcity, sum(freight) as ToplamFreight
    From UsaSiparisleri
    Group By shipcity
)
Select *
From CityToplamlari
Order By ToplamFreight desc;

--

Select
        e.lastname,
        Count(o.orderid) as SiparisSayisi

From    
        (       Sales_Orders o
          join  HR_Employees e  on e.empid = o.empid
        )
Group By e.lastname
Having Count(o.orderid) > 50
Order By SiparisSayisi desc;

--

Select
        orderid,
        orderdate,        
        To_Char(orderdate, 'YYYY') as Yillar,
        To_Char(orderdate, 'MM') as Aylar,
        Case To_Char(orderdate, 'MM')
                When '01' Then 'Ocak'
                When '02' Then 'Subat'
                When '03' Then 'Mart'
                When '04' Then 'Nisan'
                When '05' Then 'Mayis'
                When '06' Then 'Haziran'
                When '07' Then 'Temmuz'
                When '08' Then 'Agustos'
                When '09' Then 'Eylul'
                When '10' Then 'Ekim'
                When '11' Then 'Kasim'
                When '12' Then 'Aralik'        
        End as AylarStr,
        freight        
From Sales_Orders;
        
--

Select
        orderid,
        orderdate,        
        To_Char(orderdate, 'YYYY') as Yillar,
        To_Char(orderdate, 'MM') as Aylar,
        Case 
                When To_Char(orderdate, 'MM') = '01' Then 'Ocak'
                When To_Char(orderdate, 'MM') = '02' Then 'Subat'
                When To_Char(orderdate, 'MM') = '03' Then 'Mart'
                When To_Char(orderdate, 'MM') = '04' Then 'Nisan'
                When To_Char(orderdate, 'MM') = '05' Then 'Mayis'
                When To_Char(orderdate, 'MM') = '06' Then 'Haziran'
                When To_Char(orderdate, 'MM') = '07' Then 'Temmuz'
                When To_Char(orderdate, 'MM') = '08' Then 'Agustos'
                When To_Char(orderdate, 'MM') = '09' Then 'Eylul'
                When To_Char(orderdate, 'MM') = '10' Then 'Ekim'
                When To_Char(orderdate, 'MM') = '11' Then 'Kasim'
                When To_Char(orderdate, 'MM') = '12' Then 'Aralik'        
        End as AylarStr,
        freight        
From Sales_Orders;
        
        
--

Select
        orderid,
        orderdate,        
        To_Char(orderdate, 'YYYY') as Yillar,
        To_Char(orderdate, 'MM') as Aylar,
        Case 
                When To_Char(orderdate, 'MM') = '01' Then 'Ocak'
                When To_Char(orderdate, 'MM') = '02' Then 'Subat'
                When To_Char(orderdate, 'MM') = '03' Then 'Mart'
                When To_Char(orderdate, 'MM') = '04' Then 'Nisan'
                When To_Char(orderdate, 'MM') = '05' Then 'Mayis'
                When To_Char(orderdate, 'MM') = '06' Then 'Haziran'
                When To_Char(orderdate, 'MM') = '07' Then 'Temmuz'
                When To_Char(orderdate, 'MM') = '08' Then 'Agustos'
                When To_Char(orderdate, 'MM') = '09' Then 'Eylul'
                When To_Char(orderdate, 'MM') = '10' Then 'Ekim'
                When To_Char(orderdate, 'MM') = '11' Then 'Kasim'
                When To_Char(orderdate, 'MM') = '12' Then 'Aralik'        
        End as AylarStr,
         Case 
                When freight Between 0 and 100 Then '0-100 Arasi'
                When freight Between 100 and 200 Then '100-200 Arasi'
                When freight Between 200 and 500 Then '200-500 Arasi'
                
            Else
                '500 den buyuk'
        End as FreightGrubu,
        freight        
From Sales_Orders;

-- Custid = 20 olan musterinin empid baz?nda y?llara gore toplam siparis say?s?n? bulunuz

Select
        empid,
        To_Char(orderdate,'YYYY') as Yillar,
        Count(*) as SiparisSayisi
From Sales_Orders
Where custid = 20
Group By empid, To_Char(orderdate,'YYYY')
Order By 1,2;

--


Select
        firstname || ' ' || lastname as FullName,
        To_Char(orderdate,'YYYY') as Yillar,
        Count(*) as SiparisSayisi
From Sales_Orders o
join HR_Employees e on e.empid = o.empid
Where custid = 20
Group By firstname || ' ' || lastname, To_Char(orderdate,'YYYY')
Order By 1,2;

--

Select
        firstname || ' ' || lastname as FullName,
        To_Char(orderdate,'YYYY') as Yillar,
        Count(*) as SiparisSayisi
From Sales_Orders o
join HR_Employees e on e.empid = o.empid
Where custid = 20
Group By firstname, lastname, To_Char(orderdate,'YYYY')
Order By 1,2;

--

Select *
From HR.Employees;

Create Table Ora_Employees as
Select *
From HR.Employees;

--

Select *
From Ora_Employees;

-- Ora_Employees tablosunda ayn? maas? alanlar?n say?s?n? bulunuz

Select
        Salary,
        Count(*) as Sayisi
From Ora_Employees
Group By Salary
Order By 2 desc;

--

Select
        companyname,
        region,
        city,
        country
From Sales_Customers
Order By Region desc;

--

Select
        companyname,
        region,
        city,
        country
From Sales_Customers
Order By (
            Case When region is not null Then 1 End
         ) desc;
      
--

Select
        companyname,
        region,
        city,
        country,
        Case When region is not null Then 1 End as RegionDurumu
From Sales_Customers
Order By Case When region is not null Then 1 End ,4,3;

-- En son verilen ilk 5 siparisi bulunuz
-- S?ralamay? orderdate alan?na gore yap?n?z

Select *
From Sales_Orders;

Select *
From Sales_Orders
Order By orderdate desc;

With
A as
(
    Select *
    From Sales_Orders
    Order By orderdate desc
)
Select *
From A
Where rownum <= 5;

--

Select  orderid, custid, empid, orderdate,
        NTILE(100) Over ( Order By orderdate) as NtileOrnek
From Sales_Orders;

--

With Top_Ntile as
(
    Select  orderid, custid, empid, orderdate,
            NTILE(100) Over ( Order By orderdate desc) as NtileOrnek
    From Sales_Orders
)
Select *
From Top_Ntile
Where NtileOrnek = 1;

--

With Top_Ntile as
(
    Select  orderid, custid, empid, orderdate,
            NTILE(100) Over ( Order By orderdate desc) as NtileOrnek
    From Sales_Orders
)
Select orderid, custid, empid, orderdate
From Top_Ntile
Where NtileOrnek = 1;

-- Kosullar ve Operatorler

-- IN

    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where orderid = 10248 or orderid = 10250 or orderid = 10299;
    
    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where orderid IN(10248,10250,10299);    

--
  
    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where orderdate = '06-MAY-08';    

-- Between

    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where orderid Between 10300 and 10310;

-- Like
        
Select *
From HR_Employees
Where lastname like 'D%';

Select *
From HR_Employees
Where lastname like '%d';

Select *
From HR_Employees
Where lastname like '%e%';


Select *
From Ora_Employees
Where first_name like 'A%';

Select *
From Ora_Employees
Where first_name like '%a';

Select *
From Ora_Employees
Where first_name like '%a%';


Select *
From Ora_Employees
Where Upper(first_name) like '%A%';


-- Ora_Employees tablosunda
-- job_id 'si SA_REP olan,
-- first_name icerisinde e harfi gecen ve
-- Salary > 8000 olan kay?tlar? bulunuz

Select *
From Ora_Employees
Where job_id = 'SA_REP' and Upper(first_name) like '%E%' and salary > 8000;

--

Select *
From Ora_Employees
Where job_id = 'SA_REP' and first_name like '%a%' and salary > 8000;

Select *
From Ora_Employees
Where job_id = 'SA_REP' and Upper(first_name) like '%A%' and salary > 8000;


Select *
From Ora_Employees
Where job_id = 'SA_REP' and first_name like '%a%' and salary > 5000;

Select *
From Ora_Employees
Where job_id = 'SA_REP' and Upper(first_name) like '%A%' and salary > 5000;

--

    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where  custid = 1  and empid in(1,3,5) or custid = 85 and empid in(2,4,6);
    
    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where  custid = 1  and empid in(1,3,5)
        or custid = 85 and empid in(2,4,6);    

    Select  orderid, custid, empid, orderdate
    From Sales_Orders
    Where  (custid = 1  and empid in(1,3,5))
        or (custid = 85 and empid in(2,4,6));
        
--

    Select
            orderid,
            custid,
            empid,
            orderdate,
            freight,
            Case
                When freight < 100 Then '100 den kucuk'
                When freight Between 100 and 200 Then '100-200 arasinda'
                Else '200 den buyuk'
            end as FreightCategory    
    From Sales_Orders;

-- Decode ifadesi

Select 
        first_name,
        department_id,
        Decode(department_id,
                             10,'Yazilim',
                             30,'Uretim',
                             50,'Pazarlama',
                             'Diger'        
              ) as Departments
From Ora_Employees
Order By department_id;

--

Select
        orderid,
        orderdate,        
        To_Char(orderdate, 'MM') as Aylar,
        Decode(To_Char(orderdate, 'MM'),
                                        1,'Ocak',
                                        2,'Subat',
                                        3,'Mart',
                                        4,'Nisan',
                                        5,'Mayis',
                                        6,'Haziran',
                                        7,'Temmuz',
                                        8,'Agustos',
                                        9,'Eylul',
                                        10,'Ekim',
                                        11,'Kasim',
                                        12,'Aralik'    
              ) as AyAdlari,
        freight        
From Sales_Orders;

--

Select *
From User_Constraints;

--

Select *
From User_Constraints
Where Table_Name = 'SALES_ORDERS';

Desc SALES_ORDERS;

-- Commit;
-- Rollback;

Create table oraemployeestest as
Select * From ora_employees;

Delete From oraemployeestest;
Commit;
rollback;

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

--28092023


Commit;

-- Delete Komutu
-- Verileri silme amacýyla kullanýrýz

Select *
From Employees_Copy;

Delete
From Employees_Copy;

Select *
From Employees_Copy;

insert into Employees_Copy
Select *
From Employees;

Select *
From Employees_Copy;

Delete
From Employees_Copy
Where department_id = 100;

commit;

Select *
From Employees_Copy
Where department_id = 100;

Delete
From Employees_Copy
Where department_id > 101;

Commit;

Select *
From Employees_Copy
Where department_id > 101;

-- DCL
-- Grant ve Revoke

Create User Ali2 identified by Ali2;
-- yukarýdaki komutu Ali1 user'ý uzerinde calýstýrmak istersek
-- calismayacaktýr. Cunku yetki olmasý lazým
-- user yetkilendirilirken (With Grant Options) ile yetkilendirilirse
-- bu durumda yetki verebilir

-- yetkiler DBA'ler tarafýndan verilir
-- veya (With Grant Options) ile yetkilendirdikleri kisiler verebilir

Select Table_Name From Tabs;

Select * From Tabs;

Select * From Ali1.Employees;

-- SYS ve SYSTEM yetkisi ile asagýdaki komutlarý calistiralým

--system privileges --DBA olan kisinin verdigi yetkiler

Create User Ali2 identified by Ali2;
Create User Ali3 identified by Ali3;
Create User Ali4 identified by Ali4;

Grant connect, resource to Ali2;
Grant connect, resource to Ali3;
Grant connect, resource to Ali4;

-- Ali2 ile connect olalým ve Ali1'deki employees tablosundan veri cekelim

Select * From Ali1.Employees;

/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*/

-- Ali2 user'ýnýn Select yetkisi olmadýgý icin Select yapamadý

-- Ya sys ile veya Ali1 ile Select yetkisi verelim

--object privileges --Kullanýcý bazlý yapýlan nesne yetkileri
Grant Select on Employees to Ali2;
--Grant succeeded dedi
-- simdi Ali2 ile select edelim

Select * From Ali1.Employees;
-- Sorgu calýsýr

Grant Select on REGIONS to Ali2;
Select * From Ali1.REGIONS;

-- Ali2 kullanýcýsýna gecelim
insert into Ali1.REGIONS VALUES(6,'Antartika');
-- Yetki-privileges hatasý gelecek

-- Ali1 kullanýcýsýna gecelim
Grant Insert on REGIONS to Ali2;

-- Ali2 kullanýcýsýna gecelim
insert into Ali1.REGIONS VALUES(6,'Antartika');
-- Yetki-privileges gelmeyecek ve basarili bir sekilde insert edilecek

Commit;

Select * From Ali1.REGIONS;

-- Ali1 kullanýcýsýna gecelim
Grant Update, Delete on REGIONS to Ali2;


-- Ali2 kullanýcýsýna gecelim
Update Ali1.REGIONS
Set Region_Name = 'Antartica'
Where Region_id = 6;

Commit;

Select * From Ali1.REGIONS;

Delete Ali1.REGIONS
Where Region_id = 6;

Delete From Ali1.REGIONS
Where Region_id = 6;

Commit;

-- Ali1 kullanýcýsýna gecelim ve Ali2 kullanýcýsýna baskasýna yetki vermesi icinde yetki verelim
-- parametremiz With Grant Option

Grant insert, Update, Delete on Ali1.REGIONS to Ali2 With Grant Option; 
-- Bu sekilde olunca Ali2 kullanýcýsý baskasýna Update ve Delete yetkisi verebilir

-- Ali2 kullanýcýsýna gecelim
Grant insert, Update, Delete on Ali1.REGIONS to Ali3;

insert into Ali1.REGIONS VALUES(6,'Antartika');

Select * From Ali1.REGIONS;

Update Ali1.REGIONS
Set Region_Name = 'Antartica'
Where Region_id = 6;



Commit;

Select * From Ali1.REGIONS;

Delete Ali1.REGIONS
Where Region_id = 6;

-- Ali1 kullanýcýsýna gecelim
Grant Select, insert, Update, Delete on Ali1.REGIONS to Ali2 With Grant Option;
--Grant Select, insert, Update, Delete on Ali1.REGIONS to Ali3 With Grant Option;
-- Ali2 kullanýcýsýna gecelim
Grant Select, insert, Update, Delete on Ali1.REGIONS to Ali3;


-- Ali2 kullanýcýsýna gecelim
Create Table Regions_Copy as
Select * From Ali1.Regions;

Grant Select, insert, Update, Delete on Ali2.Regions_Copy to Ali3 With Grant Option;

-- Ali3 kullanýcýsýna gecelim
Select * From Ali1.REGIONS;

Select * From Ali2.Regions_Copy;

-- Revoke  -- Yetkileri Geri alýr

-- Ali1 Kullanýcýsý kimlere ne yetki vermis listelemek icin sunu yaparýz

Select * From User_Tab_Privs_Made;

-- Ali2 Kullanýcýsý kimlere ne yetki vermis listelemek icin sunu yaparýz
Select * From User_Tab_Privs_Made;

-- Ali1 Kullanýcýsýna gecelim

Revoke Delete on Regions from Ali2;
Revoke Update on Regions from Ali2;
Revoke insert on Regions from Ali2;

Select * From User_Tab_Privs_Made;

Grant Select, insert, Update, Delete on Ali1.Regions to Ali3 With Grant Option;
Select * From User_Tab_Privs_Made;

Revoke insert, Update, Delete on Ali1.Regions from Ali3;
Select * From User_Tab_Privs_Made;

-- Yukarýda bir user icin yetki vermistik
-- Public olarak hazýr bir role var
-- Yetkileri bu role uzerine verebiliriz
-- Bu durumda veritabanýna baglanma yetkisi olan tum userlar yetkilendirilmis olur
Grant Select on Ali1.REGIONS to Public;


-- System Adminine baglanalým

-- Ali5 kullanýcýsý olusturalým ve Ali5 kullanýcýsýna connect olalým
Create User Ali5 identified by Ali5;
Grant connect, resource, unlimited TableSpace to Ali5;

-- Ali5 kullanýcýsýna gecelim

Select * From Ali1.Regions; -- Public yetkisi verildigi icin Select yapabiliriz

-- Ancak Public vermek dogru bir hareket degildir
-- Kullanýcýlara tek tek yetki vermekte dogru degildir
-- Yetkiler roller uzerinden verilmeli ve alýnmalýdýr
--Ornek Roller
-- Select yapabilen Roller
-- Insert yapabilen Roller
-- Update yapabilen Roller
-- Select ve Update yapabilen Roller
-- Insert ve Delete yapabilen Roller
-- Select, insert ve Update yapabilen Roller gibi...

Grant connect, resource, unlimited TableSpace to Ali1;
--Grant Select, Insert, Update, Delete to Ali1;
-- ROLES

Create User Ali6 identified by Ali6;
Grant connect, resource, unlimited TableSpace to Ali6;

Create User AliT1 identified by AliT1;
Grant connect, resource, unlimited TableSpace to AliT1;

Create User AliT2 identified by AliT2;
Grant connect, resource, unlimited TableSpace to AliT2;


-- System Admini olarak connect olalým
Grant Create Role to Ali1;

-- Ali1 userýna baglanalým

Create Table Regions_Copy as
Select * From Ali1.Regions;

Select * From Ali1.Regions_Copy;

Create Role R_SEL;
Create Role R_INS;

Create Role R_SELUPD;
Create Role R_INSDEL;
--role R_SELUPD created
--role R_INSDEL created

Grant Select On ALI1.REGIONS_COPY to R_SEL;
Grant Insert On ALI1.REGIONS_COPY to R_INS;

Grant Select, Update On ALI1.REGIONS_COPY to R_SELUPD;
Grant Insert, Delete On ALI1.REGIONS_COPY to R_INSDEL;

-- Simdi bu rolleri atayalým

-- Grant R_SEL to AliT1;
Grant R_SELUPD to AliT1;
Grant R_INSDEL to AliT2;


-- AliT1 ile baglanalým

Select * From ALI1.REGIONS_COPY;
-- Privileges meydana gelecektir,
-- Bununda Set Role edilmesi gerekiyor


-- Oncelikle AliT1 user'ýnýn bu rolleri kullanabilmesi icin Set Role yapmasý gerekir
Set Role R_SELUPD;
Select * From ALI1.REGIONS_COPY;

-- AliT2 ile baglanalým
-- Oncelikle AliT1 user'ýnýn bu rolleri kullanabilmesi icin Set Role yapmasý gerekir
Set Role R_INSDEL;

-- Simdi insert yapalým
insert into ALI1.REGIONS_COPY Values(7,'A_Antartika');
commit;

-- AliT1 ile baglanalým
Select * From ALI1.REGIONS_COPY;

-- Update yapalým
Update Ali1.Regions_Copy
Set Region_Name = 'Antartica'
Where Region_id = 7;
commit;

insert into ALI1.REGIONS_COPY Values(8,'A_Antartika');
commit;

Select * From ALI1.REGIONS_COPY;

-- 7 numaralý kaydý silelim
Delete From ALI1.REGIONS_COPY
Where Region_id = 7;

-- Privileges meydana gelecektir,

-- AliT2 ile baglanalým
Delete From ALI1.REGIONS_COPY
Where Region_id = 8;
commit;

--Ali1 ile baglanalým
Grant R_InsDel to AliT1;
Commit;

-- AliT1 ile baglanalým
Select * From ALI1.REGIONS_COPY;






Select Level From Dual Connect By Level < 6;

Select Level-1 From Dual Connect By Level < 6;

Select 
      Level-1,
      Round(1234.56789,Level-1)
From Dual Connect By Level < 6;

Select 
      Level-1,
      Round(56789.56789,Level-1)
From Dual Connect By Level < 9;

Select 
      Level-1,
      'Round(56789.56789,' || To_Char(Level-1) || ')',
      Round(56789.56789,Level-1)      
From Dual Connect By Level < 9;

Select 
      -Level+1,
      'Round(56789.56789,' || To_Char(-Level+1) || ')',
      Round(56789.56789,-Level+1)      
From Dual Connect By Level < 9;

Select 
      -(Level-1),
      'Round(56789.56789,' || To_Char(-(Level-1)) || ')',
      Round(56789.56789,-(Level-1))      
From Dual Connect By Level < 9;


Select 
      -Level+1,
      'Round(56789.56789,' || To_Char(-Level+1) || ')',
      Round(56789.56789,-Level+1)      
From Dual Connect By Level < 9
union all
Select 
      -(Level-1),
      'Round(56789.56789,' || To_Char(-(Level-1)) || ')',
      Round(56789.56789,-(Level-1))      
From Dual Connect By Level < 9
Order By 1 desc;


        
        


/*
Database Programming with SQL 4-1: Case and Character Manipulation Practice Activities
Objectives
  • Select and apply single-row functions that perform case conversion and/or character
    manipulation
  • Select and apply character case-manipulation functions LOWER, UPPER, and
    INITCAP in a SQL query
  • Select and apply character-manipulation functions CONCAT, SUBSTR, LENGTH,
    INSTR, LPAD, RPAD, TRIM, and REPLACE in a SQL query
  • Write flexible queries using substitution variables

Vocabulary
Identify the vocabulary word for each definition below.

DUAL      Dummy table used to view results from functions and calculations
FORMAT    The arrangement of data for storage or display.
INITCAP   Converts alpha character values to uppercase for the first letter of
          each word, all other letters in lowercase.

CHARACTER FUNCTION Functions that accept character data as input and can return both
character and numeric values.

TRIM    Removes all specified characters from either the beginning or the
        ending of a string.
EXPRESSION A symbol that represents a quantity or a relationship between
        quantities
SINGLE ROW FUNCTION Functions that operate on single rows only and return one result
        per row
UPPER   Converts alpha characters to upper case
INPUT   Raw data entered into the computer
CONCAT  Concatenates the first character value to the second character
        value; equivalent to concatenation operator (||).
OUTPUT  Data that is processed into information

LOWER   Converts alpha character values to lowercase.

LPAD    Pads the left side of a character, resulting in a right-justified value
SUBSTR  Returns specific characters from character value starting at a
        specific character position and going specified character positions
        long
REPLACE Replaces a sequence of characters in a string with another set of
        characters.
INSTR   Returns the numeric position of a named string.
LENGTH  Returns the number of characters in the expression
RPAD    Pads the right-hand side of a character, resulting in a left- justified
        value
*/

-- String Fonksiyonlar

-- Lower
-- Upper
-- initcap
-- Length
-- Substr(string,m,n)
-- instr(string,?)
-- Replace(string, old_string, new_string)
-- Translate(string, old_character(s), new_character(s))
-- Rpad
-- Lpad
-- Ltrim
-- Rtrim
-- Trim
-- Concat (veya ||)

-- simdi bunlarý inceleyelim

-- Lower

Select Lower('Ali TOPACIK') From Dual;

Select
    first_name,
    Lower(first_name)
From Employees;

--

SELECT LOWER(email) || '@institutedomain.com' as "Email Address", hire_date
FROM employees
WHERE salary > 9000 AND
      (commission_pct = 0 OR commission_pct IS NULL) AND
      hire_date >= '01-01-2002' AND
      hire_date <= '31-03-2003';
      
-- Upper

Select Upper('Ali TOPACIK') From Dual;

Select
    first_name,
    Upper(first_name)
From Employees;

-- initcap  -- Her Kelimenin ilk harfini buyuk harfe cevirir

Select initcap('merhaba arkadaslar, nasilsiniz') From Dual;


Select
      Lower(Department_Name),
      initcap(Lower(Department_Name))      
From Departments;

-- Length

Select Length('Ali TOPACIK') From Dual;

Select
      Department_Name,
      Length(Department_Name)
From Departments;

--



-- Substr(string,m,n)
-- Burada
-- m pozitif olursa soldan baþlar saða doðru alýr
-- m negatif olursa saðdan sola doðru gider bulduðu yerden itibaren saða dogru n kadar karakter alýr

-- eger n yazýlmaz ise m'den baslayýp sonuna kadar alýr

Select Substr('ali_topacik@gmail.com',5,7) From Dual;
Select Substr('ali_topacik@gmail.com',5) From Dual;

Select Substr('ali_topacik@gmail.com',-9,6) From Dual;
Select Substr('ali_topacik@gmail.com',-9) From Dual;

Select 
      instr('ali_topacik@gmail.com','@') Result_A,
      Length('ali_topacik@gmail.com') Result_B,
      Length('ali_topacik@gmail.com') - instr('ali_topacik@gmail.com','@') Result_C,
      Substr('ali_topacik@gmail.com',1) Result_D,
      Substr('ali_topacik@gmail.com',instr('ali_topacik@gmail.com','@')+ 1) Result_E,
      Substr('ali_topacik@gmail.com',-(Length('ali_topacik@gmail.com') - instr('ali_topacik@gmail.com','@'))) Result_G 
From Dual;

Select
      Department_Name,
      Substr(Department_Name,3,5)
From Departments;

-- instr(string,?)
-- instr(string,?,[m],[n])
-- Buradaki m ve n tercihe baglýdýr
-- m'den basla n. tekrar edeni bul anlamýndadýr
-- m pozitif olursa soldan saga dogru konumlanýr
-- m negatif olursa sagdan sola dogru konumlanýr
-- verilmez ise her ikisi 1 kabul edilir

Select instr('ali_topacik@gmail.com','@') From Dual;

Select
      instr('ali_topacik@gmail.com','a') Result_A,
      instr('ali_topacik@gmail.com','a',1,1) Result_B,
      instr('ali_topacik@gmail.com','a',5,1) Result_C,
      instr('ali_topacik@gmail.com','a',5,2) Result_D,
      instr('ali_topacik@gmail.com','a',5,3) Result_E
From Dual;

Select
      instr('ali_topacik@gmail.com','a') Result_A,
      instr('ali_topacik@gmail.com','a',-5,1) Result_B,
      instr('ali_topacik@gmail.com','a',-10,1) Result_C,
      instr('ali_topacik@gmail.com','a',-10,2) Result_D,
      instr('ali_topacik@gmail.com','a',-10,3) Result_E,
      instr('ali_topacik@gmail.com','a',-10,4) Result_F,
      instr('ali_topacik@gmail.com','a',-20,3) Result_G
From Dual;

Select
      length('oracle.egitim@gmail.com') as uzunluk,
      instr('oracle.egitim@gmail.com','m') Result_A1,
      instr('oracle.egitim@gmail.com','m',1,1) Result_A2,
      instr('oracle.egitim@gmail.com','m',-1,1) Result_A3
From Dual;

Select
      instr('SQL Veri Sorgulama ve Raporlama ogreniyorum','lama') Result_A,
      instr('SQL Veri Sorgulama ve Raporlama ogreniyorum','lama',1,1) S_1denbasla_birinciyi_bul,
      instr('SQL Veri Sorgulama ve Raporlama ogreniyorum','lama',1,2) S_1denbasla_ikinciyi_bul
From Dual;

Select
      Substr('oracle.egitim@gmail.com',14,1) as Sonuc
From Dual;

Select
      Substr('oracle.egitim@gmail.com',14+1,5) as Sonuc1,
      Substr('oracle.egitim@gmail.com',15,5) as Sonuc2,
      instr('oracle.egitim@gmail.com','@') as Pozisyon      
From Dual;

Select
      length('oracle.egitim@gmail.com') as uzunluk,
      Substr('oracle.egitim@gmail.com',15,length('oracle.egitim@gmail.com')) as Sonuc
           
From Dual;

Select
      length('oracle.egitim@gmail.com') as uzunluk,
      Substr('oracle.egitim@gmail.com',15,length('oracle.egitim@gmail.com')-14) as Sonuc
           
From Dual;

Select
      instr('oracle.egitim@gmail.com','@') as Pozisyon,
      Substr('oracle.egitim@gmail.com',instr('oracle.egitim@gmail.com','@')+1,5) as Sonuc
           
From Dual;


Select
      length('oracle.egitim@gmail.com') as uzunluk,
      instr('oracle.egitim@gmail.com','@') as Pozisyon,
      Substr('oracle.egitim@gmail.com',instr('oracle.egitim@gmail.com','@')+1,length('oracle.egitim@gmail.com')-instr('oracle.egitim@gmail.com','@')) as Sonuc
           
From Dual;

With A as
(
Select
      length('oracle.egitim@gmail.com') as uzunluk,
      instr('oracle.egitim@gmail.com','@') as Pozisyon           
From Dual
)
Select
        Substr('oracle.egitim@gmail.com',Pozisyon+1,uzunluk-Pozisyon) as Sonuc
From A;

Select
      Department_Name
From Departments;

-- Departments tablosunda Department_Name icerisinde ikinci kelimeden itibaren olanlar? bulunuz

Select
      Department_Name,
      instr(Department_Name,' '),
      Substr(Department_Name,instr(Department_Name,' ') + 1, 100) ResultA,
      Substr(Department_Name,instr(Department_Name,' ') + 1) ResultB
From Departments;

-- Burada her ne kadar 100 yazm?s olsakta gercekte 100 yerine uzunluktan bulunan pozisyonu c?kartmam?z laz?m
-- ve o sonucu elde etmemiz laz?m
-- sorgular? dinamik hale getirmemiz laz?m
-- 3 onceki ornekte oldugu gibi

Select
      Department_Name,
      instr(Department_Name,' '),
      Substr(Department_Name,instr(Department_Name,' ') + 1) ResultA
From Departments;

Select
      Department_Name,
      instr(Department_Name,' '),
      Substr(Department_Name,instr(Department_Name,' ') + 1, 100) ResultA
From Departments
Where instr(Department_Name,' ') > 0;

Select
      Department_Name,
      instr(Department_Name,' ',1,1),
      Substr(Department_Name,instr(Department_Name,' ',1,1) + 1, 100) ResultA
From Departments
Where instr(Department_Name,' ',1,1) > 0;

Select
      Department_Name,
      instr(Department_Name,' '),
      Substr(Department_Name,instr(Department_Name,' ') + 1, 100) ResultA
From Departments
Where instr(Department_Name,' ') > 0;


Select
      Department_Name,
      instr(Department_Name,' ') Konum_1,
      instr(Department_Name,' ',instr(Department_Name,' ')+1) Konum_2,
      Substr(Department_Name,instr(Department_Name,' ') + 1, 100) Result_A,
      Substr(Department_Name,instr(Department_Name,' ',instr(Department_Name,' ')+1) + 1, 100) Result_B
From Departments
Where instr(Department_Name,' ') > 0;

Select * From Departments;

INSERT INTO DEPARTMENTS(DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
  VALUES(999,'Ulusal Arastir ve Gelistir',200,1900);

Commit;

Select * From Departments;

Select
      Department_Name,
      instr(Department_Name,' ') Konum_1,
      instr(Department_Name,' ',instr(Department_Name,' ')+1) Konum_2,
      Substr(Department_Name,instr(Department_Name,' ') + 1, 100) Result_A,
      Substr(Department_Name,instr(Department_Name,' ',instr(Department_Name,' ')+1) + 1, 100) Result_B
From Departments
Where instr(Department_Name,' ',instr(Department_Name,' ')+1) > instr(Department_Name,' ');

Select
      Substr('ali_topacik@gmail.com',instr('ali_topacik@gmail.com','@')+1,100) Result_1,
      Substr('ali_topacik@gmail.com',instr('ali_topacik@gmail.com','@')+1,5) Result_2,
      instr('ali_topacik@gmail.com','@') Konum
From Dual;

--******************************************
-- Replace(string, old_string, new_string)
--******************************************
Select Replace('SQL Veri Yonetimi, Veri Analizi','Veri', 'Data') From Dual;

Select Replace('SQL Veri Yonetimi','veri', 'Data') From Dual;

Select
    first_name,
    Replace(first_name,'e','') ResultA
From Employees;

-- firstname icerisinde gecen e'lerin sayýsýný bulalým

Select
    first_name,
    Lower(first_name) as isimufak,
    Replace(Lower(first_name),'e','') ResultA,
    (Length(first_name) - Length(Replace(Lower(first_name),'e',''))) e_Sayisi
From Employees;

With A as
(
    Select
        first_name,
        Lower(first_name) as isimufak,
        Length(first_name) as Uzunluk,
        Replace(Lower(first_name),'e','') as isim_E,
        Length(Replace(Lower(first_name),'e','')) as uzunlukE
    From Employees
)
Select
       first_name,
       Uzunluk - uzunlukE as E_lerinSayisi
       
From A;

-- Departments tablosundaki Department_Name kac kelimeden olusuyor


Select
      Department_Name,
      Replace(Department_Name,' ','') "BosluklariSil",
      (Length(Department_Name) - Length(Replace(Department_Name,' ',''))) +  1 KelimeSayisi
From Departments;

Select
      first_name,
      Job_id,
      Replace(Job_id,'IT','BT') Result_A,
      Replace(Job_id,'IT','BIL') Result_B                
From Employees;

Select
      first_name,
      Job_id,
      Replace(Job_id,'IT','BT') Result_A,
      Replace(Job_id,'IT','BIL') Result_B                
From Employees
Where Job_id Like '%IT%';

--******************************************
-- Translate(string, old_character(s), new_character(s))
-- Select Translate('SQL Veri Yonetimi','ei', 'x.') From Dual;
-- burada e harfini x ile i harfini ise . ile replace eder
-- Replace gibi calisir daha gelismisidir
--******************************************

Select Translate('SQL Veri Yonetimi','e', 'x') From Dual;

Select Translate('SQL Veri Yonetimi','ei', 'x') From Dual;
Select Translate('SQL Veri Yonetimi','ei', 'x.') From Dual;

Select Translate('Super bulus ile super sonuc','upe', 'x') From Dual;
-- Burada u harfini x ile
-- p ve e harfini ise hicbirsey ile replace eder
-- Result : Sxr bxlxs il sxr sonxc
Select Translate('SQL Veri Yonetimi, Veri Analizi','Veri', 'Data')
From Dual;

Select Replace('SQL Veri ve Yonetimi','Veri', 'Data') From Dual;
-- Replace ile veri kelimesi Data ile degistirilir

Select Translate('SQL Veri ve Yonetimi','Veri', 'Data') From Dual;
-- Translate ile ise V-e-r-i harfleri ayrý ayrý D-a-t-a harfleri ile degisgirilir
-- Yani harf harf degistirilir
-- Buyuk ve kucuk harfleri ayrý ayrý gorur
-- Yani A harfi a'dan farklýdýr

Select Translate('SQL Veri ve Yonetimi','veri', 'Data') From Dual;

Select Translate('Elek Nedir nedendir','eN', 'x*') From Dual;

-- Translate ile bir mesajý sifreleyelim ve geri cozelim
-- Algoritma olarak sunu kullanalým
-- Her harf kendinden sonra gelen harf ile degissin

Select
      'SQL Veri Yonetimi' Orjinal_Mesaj,
      Translate('SQL Veri Yonetimi',
      'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz',
      'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza') Sifreli_Mesaj
From Dual;

-- simdide sifreli mesajý cozelim
Select
      'TRM%Yfsi%Zpofuini' Sifreli_Mesaj,
      Translate('TRM%Yfsi%Zpofuini',
      'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza',
      'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz') Orjinal_Mesaj
From Dual;

--******************************************
-- Lpad
--******************************************
Select Lpad('SQL',12, '*') From Dual;

Select
      first_name,
      LPad(first_name,20,'*') LPad_Ornek,
      RPad(first_name,20,'*') RPad_Ornek
From Employees;

Select
      first_name,
      LPad(first_name,10,'*-') LPad_Ornek,
      RPad(first_name,10,'*-') RPad_Ornek
From Employees;

-- Rpad
Select Rpad('SQL',12, '*') From Dual;

SELECT REPLACE(RPAD(LPAD('Oracle PL SQL', 18, '*'),23,'*'),' ', '*****') AS "Result"
FROM DUAL;

SELECT
      LPAD('Oracle PL SQL', 18, '*') AS "ResultA",
      RPAD(LPAD('Oracle PL SQL', 18, '*'),23,'*') AS "ResultB",
      REPLACE(RPAD(LPAD('Oracle PL SQL', 18, '*'),23,'*'),' ', '*****') AS "ResultC"
FROM DUAL;

-- Ltrim

Select Ltrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;

-- sonuc #SQL   Veri   Yonetimi ve Veri Sorgulama    #

-- Rtrim
Select RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;

-- sonuc #  SQL   Veri   Yonetimi ve Veri Sorgulama#

Select LTrim(RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    '))
From Dual;

-- sonuc #SQL   Veri   Yonetimi ve Veri Sorgulama#

-- Trim
Select Trim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;
--*SQL   Veri   Yonetimi ve Veri Sorgulama*

Select Trim(' ' From  'SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;
--*SQL   Veri   Yonetimi ve Veri Sorgulama*

Select LTrim(RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    '))
From Dual;

-- Concat (veya ||)

Select 'SQL' || ' ' || 'Ogreniyorum' From Dual;

Select Concat('SQL','Ogreniyorum') From Dual;

Select Concat(Concat('SQL',' '),'Ogreniyorum') From Dual;

Select
      first_name,
      last_name,
      Concat(first_name,last_name) FullNameA,
      Concat(Concat(first_name,' '), last_name) FullNameB,
      first_name || ' ' || last_name FullNameC
From Employees;

Select
      first_name,
      Job_id
From Employees;

Select
      Concat(Concat(first_name,' is a '),Job_id) as Result_A,
      first_name || ' is a ' || Job_id as Result_B
From Employees;



-- Tekil Sonuc Fonksiyonlarý
-- Sayýsal fonksiyonlarda Return degeri Sayýsal
-- Karakter fonksiyonlarda Return degeri Karakter
-- Tekil Sonuc fonksiyonlarda ise Sayýsalda olabilir, Karakterde olabilir
-- Bu nedenle Tekil sonuc fonksiyonlarý denmektedir

-- NVL, NVL2, NULLIF

-- GREATEST, LEAST

-- DECODE, CASE

-- UID, USER, SYS_CONTEXT

-- Simdi bunlari inceleyelim
-- NVL  -- Null Value kontrolu yapar
-- NVL(A,B) -- A null degilse A doner, A null ise B doner



Select
      first_name,
      Commission_pct,
      NVL(Commission_pct,0) as SonucA,
      NVL(Commission_pct,'9') as SonucB
      --,NVL(Commission_pct,'Komisyon')
      -- Komisyon yazarsak olmaz cunku A'nýn Tipi ne ise B'ninde ayný olmasý gerekir
From Employees;

Select
      Region,
      NVL(Region,'Kontrol')
      ,NVL(Region,0)
      -- 0 yazarsak hata vermez ama mant?k olarak dogru degildir
      -- cunku A'nýn Tipi ne ise B'ninde ayný olmasý gerekir
From HR_Employees;

-- NVL2(A,B,C) 
-- A null degilse B
-- A null ise C gelir

Select
      first_name,
      Commission_pct,
      NVL2(Commission_pct, Commission_pct, 0) as SonucA,
      NVL2(Commission_pct, Commission_pct, '9') as SonucB
      --,NVL2(Commission_pct,Commission_pct,'Komisyon')
      -- Komisyon yazarsak olmaz cunku A'nýn Tipi ne ise B ve C'ninde ayný olmasý gerekir
From Employees;

Select
      first_name,
      Commission_pct,
      NVL2(Commission_pct, Salary, 0) as SonucA
From Employees;


Select
      first_name,
      Salary,
      Commission_pct,
      1+ commission_pct,
      NVL2(Commission_pct,Salary * (1+ commission_pct),Salary) Result_A
From Employees;

Select
      Region,
      NVL2(Region,Region,'Kontrol')
      -- 0 yazarsak olmaz cunku A'nýn Tipi ne ise B ve C'ninde ayný olmasý gerekir
From HR_Employees;

-- NULLIF(A,B)
-- Eger A=B ise  null donderir
-- Eger A<>B ise A'yi donderir 

Select
      Nullif('Elma','Elma'),
      Nullif('Elma','Armut')
From Dual;

Select
      Nullif(9999,9999),
      Nullif(9999,1234)
From Dual;

Select
      first_name,      
      Commission_pct,
      NVL(Commission_pct,0),
      Salary,
      Salary - NVL(Commission_pct,0) Salary_C,
      Nullif(Salary, Salary - NVL(Commission_pct,0)) Result_A
From Employees;

Select
      first_name,      
      Salary,
      Salary - NVL(Commission_pct,0) Salary_C,
      To_Char(Salary) || ' = ' || To_Char(Salary - NVL(Commission_pct,0)) || ' esit ise null degilse:' || To_Char(Salary),
      Nullif(Salary, Salary - NVL(Commission_pct,0)) Result_A
From Employees;

-- GREATEST(Parametre1,Parametre2,Parametre3,Parametre4,Parametre5...)
-- Parametre sýnýrlamasý yok
-- Aldýgý parametrelerin en buyugunu verir

Select
      Greatest(100,110,99,10,1000,-50,300)
From Dual;

Select
      Greatest('Elma','Armut','Muz','Kiraz','Ananas') as Sonuc1,
      Greatest('Elma','Armut','Muz','Kiraz','Zeytin','Ananas') as Sonuc2,
      Greatest('Elma','Armut','Muz','Kiraz','Zeytin','Ananas', 'ananas') as Sonuc3,
      Greatest('Elma','Armut','Muz',100,'Zeytin',300) as Sonuc4,
      Greatest('E','A','Muz',999,'Ananas') as Sonuc5
From Dual;

-- LEAST(Parametre1,Parametre2,Parametre3,Parametre4,Parametre5...)
-- Parametre sýnýrlamasý yok
-- Aldýgý parametrelerin en Kucugunu verir

Select
      LEAST(100,110,99,10,1000,-50,300)
From Dual;

Select
      LEAST(100,110,99,1000,300)
From Dual;

Select
      LEAST('Elma','Armut','Muz','Kiraz'),
      LEAST('Elma','Armut','Muz','Kiraz','Zeytin','Ananas'),
      LEAST('Elma','Armut','Muz',100,'Zeytin',300),
      LEAST('E','A','Muz',999,'Ananas')
From Dual;

-- DECODE ile Case arasýnda amac bakýmýndan bir fark yoktur
-- her ikiside kullanýlabilir

-- DECODE

Select
      first_name,
      department_id,
      Decode(department_id,
                            10,'Yazýlým',
                            30,'Uretim',
                            50,'Pazarlama',
                            'Diger'
            ) Department
From Employees
Order By 2;

-- CASE

Select
      first_name,
      department_id,
      Case department_id
           When 10 Then 'Yazýlým'
           When 30 Then 'Uretim'
           When 50 Then 'Pazarlama'
           Else 'Diger'
      End Department
From Employees
Order By 2;



-- UID  -- Parametre almaz
-- Her bir kullanýcý icin unique bir kimlik numarasý atanýr,
-- Bu numara UID ile ogrenilir

Select UID From Dual;

-- USER  -- Parametre almaz

Select USER From Dual;

Show User;

Select UID, User From Dual;

-- SYS_CONTEXT  -- aldýgý paramatrelere gore sonuc donderir

-- log'lama yapmak istersek (audit dosyasý gibi),
-- kullanýcýlara ait log'larý takip etmek amacýyla bu fonksiyonlardan faydalanabiliriz


Select SYS_CONTEXT('userenv','Session_User') as UserName From Dual;

Select
      SYS_CONTEXT('USERENV','SESSION_USER') as UserName1,
      SYS_CONTEXT('USERENV','session_user') as UserName2,
      SYS_CONTEXT('userenv','session_user') as UserName3
From Dual;

Select
      SYS_CONTEXT('USERENV','SESSION_USER') as UserName,
      SYS_CONTEXT('USERENV','ISDBA') as ISDBA,           -- DBA yetkisi varmý diye kontrol ediyoruz
      SYS_CONTEXT('USERENV','HOST') as HOST,
      SYS_CONTEXT('USERENV','INSTANCE') as INSTANCE,
      SYS_CONTEXT('USERENV','IP_ADDRESS') as IP_ADRESSES,
      SYS_CONTEXT('USERENV','DB_NAME') as DB_NAME         -- Kurulumda SID olarak XE vermistim
From Dual;

Select
      SYS_CONTEXT('USERENV','SESSION_USER') as UserName,
      SYS_CONTEXT('USERENV','ISDBA') as ISDBA,
      SYS_CONTEXT('USERENV','HOST') as HOST,
      SYS_CONTEXT('USERENV','INSTANCE') as INSTANCE,
      SYS_CONTEXT('USERENV','INSTANCE_NAME') as INSTANCE_NAME,
      SYS_CONTEXT('USERENV','IP_ADDRESS') as IP_ADRESSES,
      SYS_CONTEXT('USERENV','DB_NAME') as DB_NAME,
      SYS_CONTEXT('USERENV','OS_USER') as OS_USER,
      SYS_CONTEXT('USERENV','SERVICE_NAME') as SERVICE_NAME,
      SYS_CONTEXT('USERENV','SESSION_EDITION_NAME') as SESSION_EDITION_NAME
From Dual;

Select
      SYS_CONTEXT('USERENV','ACTION') as ACTION,
      SYS_CONTEXT('USERENV','CLIENT_INFO') as CLIENT_INFO,
      SYS_CONTEXT('USERENV','CURRENT_SCHEMAID') as CURRENT_SCHEMAID,
      SYS_CONTEXT('USERENV','CURRENT_SCHEMA') as CURRENT_SCHEMA,
      SYS_CONTEXT('USERENV','CURRENT_SQL') as CURRENT_SQL,
      SYS_CONTEXT('USERENV','CURRENT_USER') as CURRENT_USER,
      SYS_CONTEXT('USERENV','DB_DOMAIN') as DB_DOMAIN,
      SYS_CONTEXT('USERENV','GLOBAL_UID') as GLOBAL_UID,
      SYS_CONTEXT('USERENV','LANGUAGE') as LANGUAGE
From Dual;

Select
      SYS_CONTEXT('USERENV','NLS_CALENDAR') as NLS_CALENDAR,
      SYS_CONTEXT('USERENV','NLS_CURRENCY') as NLS_CURRENCY,
      SYS_CONTEXT('USERENV','NLS_DATE_FORMAT') as NLS_DATE_FORMAT,
      SYS_CONTEXT('USERENV','NLS_DATE_LANGUAGE') as NLS_DATE_LANGUAGE,
      SYS_CONTEXT('USERENV','NLS_SORT') as NLS_SORT,
      SYS_CONTEXT('USERENV','NLS_TERRITORY') as NLS_TERRITORY,
      SYS_CONTEXT('USERENV','SERVER_HOST') as SERVER_HOST,
      SYS_CONTEXT('USERENV','SERVICE_NAME') as SERVICE_NAME
From Dual;

--
select *
from   nls_session_parameters;

select *
from   nls_session_parameters
where  PARAMETER = 'NLS_TERRITORY';

select t.value,
       case 
          when t.value != 'DENMARK' then to_char(sysdate-1, 'd') || ' A'
          else to_char(sysdate, 'd') || ' B'
       end as Sonuc
from   nls_session_parameters t
where  t.parameter = 'NLS_TERRITORY';

/

select 
      to_char (sysdate, 'FmDay', 'nls_date_language=english'),
      case to_char (sysdate, 'FmDay', 'nls_date_language=english')
          when 'Monday' then 1
          when 'Tuesday' then 2
          when 'Wednesday' then 3
          when 'Thursday' then 4
          when 'Friday' then 5
          when 'Saturday' then 6
          when 'sunday' then 7
      end d
  from dual;
  
/

select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english'),
      case to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english')
          when 'Monday' then 1
          when 'Tuesday' then 2
          when 'Wednesday' then 3
          when 'Thursday' then 4
          when 'Friday' then 5
          when 'Saturday' then 6
          when 'Sunday' then 7
      end d
  from employees;

/

select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english') as Gunler,
      to_char (HIRE_DATE, 'FmMonth', 'nls_date_language=english') as Aylar
from employees;

/


-- Employees tablosunda ayn? gun ise al?nanlar?n?n say?s?n? bulunuz

select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay') as Gunler
from employees;

select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay') as GunlerA,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english') as GunlerB,
      to_char (HIRE_DATE, 'FmMonth', 'nls_date_language=english') as Aylar
from employees;

select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay') as GunlerA,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=turkish') as GunlerB,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=German') as GunlerC,
      to_char (HIRE_DATE, 'FmMonth', 'nls_date_language=turkish') as Aylar
from employees;


With A as
(
    select 
          first_name, last_name, hire_date,
          to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english') as Gunler
    from employees
)
Select Gunler, Count(*) as Sayisi
From A
Group By Gunler;

/

select 
      to_char (sysdate, 'FmDay', 'nls_date_language=turkish'),
      to_char (to_date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish'),
      case to_char (to_date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish')
      --case to_char (sysdate, 'FmDay', 'nls_date_language=turkish')
          when 'Pazartesi' then 1
          when 'Sal?' then 2
          when 'Çarþamba' then 3
          when 'Perþembe' then 4
          when 'Cuma' then 5
          when 'Cumartesi' then 6
          when 'Pazar' then 7
      end d
  from dual;

select 
      to_date('08/05/2023','DD/MM/YYYY') AA,
      to_char (to_date('08-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Pazartesi,
      to_char (to_date('09-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Sal?,
      to_char (to_date('10-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Çar?amba,
      to_char (to_date('11-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Per?embe,
      to_char (to_date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Cuma,
      to_char (to_date('06-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Cumartesi,
      to_char (to_date('07-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish') Pazar
  from dual;
/

select 
      to_date('08/05/2023','DD/MM/YYYY') AA,
      to_char (to_date('08-05-2023','DD/MM/YYYY'), 'd') Pazartesi,
      to_char (to_date('09-05-2023','DD/MM/YYYY'), 'd') Sali,
      to_char (to_date('10-05-2023','DD/MM/YYYY'), 'd') Çarsamba,
      to_char (to_date('11-05-2023','DD/MM/YYYY'), 'd') Persembe,
      to_char (to_date('12-05-2023','DD/MM/YYYY'), 'd') Cuma,
      to_char (to_date('06-05-2023','DD/MM/YYYY'), 'd') Cumartesi,
      to_char (to_date('07-05-2023','DD/MM/YYYY'), 'd') Pazar      
  from dual;
/
Select *
From nls_session_parameters;
/
Select *
From nls_session_parameters
Where parameter = 'NLS_DATE_LANGUAGE';
/
--
Select
      SYS_CONTEXT('USERENV','SESSION_EDITION_ID') as SESSION_EDITION_ID,
      SYS_CONTEXT('USERENV','SESSION_EDITION_NAME') as SESSION_EDITION_NAME,
      SYS_CONTEXT('USERENV','SESSION_USER') as SESSION_USER,
      SYS_CONTEXT('USERENV','SESSION_USERID') as SESSION_USERID,
      UID
From Dual;
/

Select SYS_CONTEXT('USERENV','TERMINAL') as TERMINAL From Dual;
/
-- Yukarýdaki sorguda TERMINAL icin cmd>sqlplus ile kullan ve sonucu incele


--******************************************************
-- istatistik fonksiyonlar
--******************************************************

-- Sum, AVG, Max, Min, Count, STDDEV(Standart Sapma), VARIANCE(Standart Sapmaya gore ortalama)

-- Bu fonksiyonlar hem geleneksel kumeleme(Aggregate)   -- Group By(ve Having)
-- hemde Analitik sorgulamalarda kullanýlýr             -- Over




--******************************************************
-- Sum
--******************************************************
Select * From Employees;

Select Sum(Salary) From Employees;

With A as
(
    Select job_id, Sum(Salary) as ToplamMaas,'1' as TabloNo
    From Employees
    Group By job_id
    Union
    Select 'Genel Toplam', Sum(Salary) as ToplamMaas,'2' as TabloNo
    From Employees
)
Select job_id, ToplamMaas
From A
Order By TabloNo;

--

With A as
(
    Select job_id, Sum(Salary) as ToplamMaas
    From Employees
    Group By job_id
    Union
    Select 'Genel Toplam', Sum(Salary) as ToplamMaas
    From Employees
)
Select job_id, ToplamMaas
From A
Order By ToplamMaas;

--

    Select job_id, Sum(Salary) as ToplamMaas
    From Employees
    Group By job_id
    Union
    Select 'Genel Toplam', Sum(Salary) as ToplamMaas
    From Employees
    Order By ToplamMaas;
    
--

With A as
(
    Select job_id, Sum(Salary) as ToplamMaas, '1' as "TabloNo"
    From Employees
    Group By job_id
),
B as
(
  Select 'Genel Toplam' as job_id, Sum(Salary) as ToplamMaas,'2' as "TabloNo"
  From Employees
)
Select job_id, ToplamMaas  From A
union
Select job_id, ToplamMaas From B
Order By ToplamMaas;

--******************************************************
--AVG
--******************************************************
Select Avg(Salary) From Employees;

Select Round(Avg(Salary),2) From Employees; -- Round ile 2 hane duyarlý yaptýk

Select length('831775700934579439252336448598130841') from Dual;
-- virgulden sonraki hane uzunlugunu bulduk

--******************************************************
--Max, Min
--******************************************************

Select Max(Salary) From Employees;

Select Min(Salary) From Employees;

--******************************************************
--Count
--******************************************************

Select Count(*) From Employees;

Select Count(Salary) From Employees;

Select Count(commission_pct) From Employees;
-- count sayma isi yapar ve bunu yaparken Count icerisindeki null olanlarý saymaz
-- ancak null'larýn sayýsý lazýmda su sekilde yapabiliriz

-- Null Kontrolu nas?l yap?l?r bakal?m

Select *
From Sales_Customers
Where region = 'WA';

Select *
From Sales_Customers
Where region != 'WA';

Create Table Sales_CustomersB as
Select *
From Sales_Customers;


Select *
From Sales_CustomersB
Where custid in(39,40);

Update Sales_CustomersB
Set region = ''
Where custid in(39,40);

Select *
From Sales_CustomersB
Where custid in(39,40);

Select *
From Sales_CustomersB
Where region = '';

Select *
From Sales_Customers
Where region is Null;

Select *
From Sales_Customers
Where region is Not Null;

Select Count(*)
From Employees
Where commission_pct is null;


Select Count(*)
From Employees
Where commission_pct is not null;

--******************************************************
--STDDEV(Standart Sapma), VARIANCE(Standart Sapmaya gore ortalama)
--******************************************************

Select STDDEV(Salary) From Employees;
Select Length('3909,579730552481921059198878167256201202') From Dual;


Select VARIANCE(Salary) From Employees;
Select Length('15284813,66954681713983424440134015164874') From Dual;

--******************************************************
-- Hepsini bir arada gorelim
--******************************************************

Select
      Sum(Salary),
      Round(Avg(Salary),2) as AVG_,
      Min(Salary),
      Max(Salary),
      Count(Salary),
      Count(*),
      Count(commission_pct),  -- dolu olan komisyonlarýn sayýsýný verir
      Round(STDDEV(Salary),2) STDDEV_,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees;

--******************************************************
-- Group By (Department_id bazýnda bulalým)
--******************************************************

Select
      Sum(Salary),
      Round(Avg(Salary),2) as AVG_,
      Min(Salary),
      Max(Salary),
      Count(Salary),
      Count(*),
      Count(commission_pct),  -- dolu olan komisyonlarýn sayýsýný verir
      Round(STDDEV(Salary),2) STDDEV_,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees
Where Department_id = 10;

-- veya tum department_id ler icin Group By ile bulalým

Select
      Department_id,
      Sum(Salary),
      Round(Avg(Salary),2) as AVG_,
      Min(Salary),
      Max(Salary),
      Count(Salary),
      Count(*),
      Count(commission_pct),  -- dolu olan komisyonlarýn sayýsýný verir
      Round(STDDEV(Salary),2) STDDEV_,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees
Group By Department_id
Order By 1;

Select *
From Employees
Where Department_id is null;

--******************************************************
-- Having
--******************************************************


Select
      Department_id,
      Sum(Salary),
      Round(Avg(Salary),2) as AVG_,
      Min(Salary),
      Max(Salary),
      Count(Salary),
      Count(*),
      Count(commission_pct),  -- dolu olan komisyonlarýn sayýsýný verir
      Round(STDDEV(Salary),2) STDDEV_,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees
Group By Department_id
Having Count(*) > 5
Order By 1;

--




--******************************************************
-- Analitik Sorgular
--******************************************************
-- Calisan Adi, Maasi, Kumulatif Toplam(Calisan adýna gore sýralansýn)

Select
      first_name,
      Salary,
      Sum(Salary) Over(Order By first_name) as TotalSalary      
From Employees;

Select
      first_name,
     -- employee_id,
      Salary,
      Sum(Salary) Over(Order By first_name, employee_id) as TotalSalary      
From Employees;


-- Ancak yukarýdaki sorguda ayný isme sahip olanlar ayný kumulatif toplamý alýr
-- Bunu su sekilde cozeriz

Select
      first_name,
      Salary,
      Sum(Salary) Over(Order By first_name, Employee_id) as TotalSalary      
From Employees;



Select
      job_id,
     -- employee_id,
      Salary,
      Sum(Salary) Over(Order By job_id, employee_id) as TotalSalary      
From Employees;
--******************************************************
-- Calisanin Adi, Maasi, Bolumu, Kumulatif Toplam
-- Bolume gore gruplasýn, maasa gore sýralasýn
--******************************************************

Select
      Department_id,
      first_name,
      Salary,
      Sum(Salary) Over(Partition By Department_id Order By Salary) as TotalSalary      
From Employees;

Select
      Department_id,
      first_name,
      Salary,
      Sum(Salary) Over(Partition By Department_id Order By Salary, Employee_id) as TotalSalary      
From Employees;

Select
      Department_id,
      first_name,
      Salary,
      Sum(Salary) Over(Partition By Department_id Order By Department_id, first_name, Employee_id) as TotalSalary      
From Employees;

-- Sales_Orders tablosunda shipcountry sutununa gore ilerleye freight toplamlar?n? bulunuz
-- orderid, orderdate, freight, shipcountry, RunFreight

Select
        shipcountry,
        orderid,
        orderdate,
        freight,
        Sum(Freight) Over(Partition By shipcountry Order By shipcountry,orderdate, orderid) as RunFreight
From Sales_Orders;


Select
        shipcountry,
        orderid,
        orderdate,
        freight,
        Sum(Freight) Over(Partition By shipcountry Order By orderdate, orderid) as RunFreight
From Sales_Orders;

Select
        shipcountry,
        orderid,
        orderdate,
        freight,
        Sum(Freight) Over(Partition By shipcountry) as RunFreight,
        Sum(Freight) Over() as GenelToplamFreight
From Sales_Orders;


Select Distinct
        shipcountry,
        Sum(Freight) Over(Partition By shipcountry) as ToplamFreight,
        Sum(Freight) Over() as GenelToplamFreight
From Sales_Orders
Order By 1;

-- Yukar?daki sorguda her shipcountry'nin ToplamFreight'?n?n GenelToplamFreight icerisindeki
-- oran?n? bulunuz

Select Distinct
        shipcountry,
        Sum(Freight) Over(Partition By shipcountry) as ToplamFreight,
        Sum(Freight) Over() as GenelToplamFreight,
        (Sum(Freight) Over(Partition By shipcountry)  / Sum(Freight) Over()) * 100 as Oran
From Sales_Orders
Order By 1;

-- Yukar?daki kullan?m yerine CTEs ile ve derived table ile yapal?m

With A as
(
    Select Distinct
            shipcountry,
            Sum(Freight) Over(Partition By shipcountry) as ToplamFreight,
            Sum(Freight) Over() as GenelToplamFreight
    From Sales_Orders
)
Select
        shipcountry,
        ToplamFreight,
        GenelToplamFreight,
        ToplamFreight / GenelToplamFreight * 100 as Oran
From A
Order By 1;

-- derived ile yapal?m

Select
        shipcountry,
        ToplamFreight,
        GenelToplamFreight,
        ToplamFreight / GenelToplamFreight * 100 as Oran
From    (
           Select Distinct
                    shipcountry,
                    Sum(Freight) Over(Partition By shipcountry) as ToplamFreight,
                    Sum(Freight) Over() as GenelToplamFreight
            From Sales_Orders
        ) A
Order By 1;

Select Distinct
        shipcountry,
        Avg(Freight) Over(Partition By shipcountry) as AVGFreight
From Sales_Orders
Order By 1;

Select Distinct
        shipcountry,
        Count(Freight) Over(Partition By shipcountry) as Sayisi
From Sales_Orders
Order By 1;

Select Distinct
        shipcountry,
        Min(Freight) Over(Partition By shipcountry) as MinFreight
From Sales_Orders
Order By 1;

Select Distinct
        shipcountry,
        Max(Freight) Over(Partition By shipcountry) as MaxFreight
From Sales_Orders
Order By 1;


Select
      Department_id,
      first_name,
      Salary,
      Avg(Salary) Over(Partition By Department_id Order By Department_id) as AvgSalary      
From Employees;

-- employees tablosunda her bir job_id icin ToplamSalary Bulunuz

Select
        job_id,
        Sum(Salary) as TotalSalary
From employees
Group By job_id
Order By 1;

Select
        job_id,
        Sum(Salary) Over(Partition By job_id) as TotalSalary
From employees;

Select
        job_id,
        to_char(hire_date, 'YYYY') as Yillar,
        Sum(Salary) as TotalSalary
From employees
Group By job_id,to_char(hire_date, 'YYYY')
Order By 1;

Select distinct
        job_id,
        to_char(hire_date, 'YYYY') as Yillar,
        Sum(Salary) Over(Partition By job_id,to_char(hire_date, 'YYYY')) as TotalSalary
From employees
Order By 1;

Select distinct
        job_id,
        --to_char(hire_date, 'YYYY') as Yillar,
        Sum(Salary) Over(Partition By job_id,to_char(hire_date, 'YYYY')) as TotalSalary
From employees
Order By 1;

--******************************************************
-- Tarih ve Zaman Fonksiyonlarý
--******************************************************

-- Current_Date     -- Session  TimeZone'a gore Tarih ve Saati verir(Yani oturuma gore verecektir)
-- SysDate          -- Database TimeZone'a gore Tarih ve Saati verir
-- SysTimeStamp     -- Zaman Damgasý
                    -- (Efatura, Elektronik imza, Kep,v.s.)
                    -- (tum elektronik islemler izin Zaman Damgasýna ihtiyac vardýr)
-- Tarih Formatlarý
-- Tools > Prefences > Database > NLS altýnda formatlarý gorebiliriz

--******************************************************
-- CurrentDate, SysDate, localtimestamp
--******************************************************


Select Current_Date, SysDate, localtimestamp
From Dual;

Select SessionTimeZone From Dual;

Alter Session Set Time_Zone = '+2:0';

Select Current_Date, SysDate
From Dual;

Alter Session Set Time_Zone = '+14:0';

Select Current_Date, SysDate
From Dual;

Alter Session Set Time_Zone = '+3:0';

Select Current_Date, SysDate
From Dual;

--******************************************************
-- SysTimeStamp
--******************************************************

Select SysTimeStamp
From Dual;

--******************************************************
-- Tarih Formatlarý
--******************************************************

Select
        SysDate,
        To_Char(SysDate,'D') HaftaninKacinciGunu,
        To_Char(SysDate,'DD') AyinKacinciGunu,
        To_Char(SysDate,'DDD') YilinKacinciGunu,
        To_Char(SysDate,'D DD DDD') Result_A,
        To_Char(SysDate,'DAY') GunAdi,
        To_Char(SysDate,'DY') GunAdiKisa,
        To_Char(SysDate,'DD MM YYYY MON') Result_C,
        To_Char(SysDate,'D') Result_D,
        To_Char(SysDate,'D') Result_E
From Dual;


Select
        SysDate,
        To_Char(SysDate,'W') AyinKacinciHaftasi,
        To_Char(SysDate,'WW') YilinKacinciHaftasi,
        To_Char(SysDate,'IW') IsoYilinKacinciHaftasi,
        To_Char(SysDate,'mm') AyNumarasiA,
        To_Char(SysDate,'MM') AyNumarasiB,
        To_Char(SysDate,'MON') AyAdiA,
        To_Char(SysDate,'MONTH') AyAdiB
From Dual;


Select
        SysDate,
        To_Char(SysDate,'Y') Yil_Kisa_Y,
        To_Char(SysDate,'YY') Yil_Kisa_YY,
        To_Char(SysDate,'YYY') Yil_Kisa_YYY,
        To_Char(SysDate,'YYYY') Yil_Uzun,
        To_Char(SysDate,'YEAR') Yil_ingilizce ,
        To_Char(SysDate,'RR') Yuzyil
From Dual;



Select
        SysDate,
        To_Char(SysDate,'HH') HH_,
        To_Char(SysDate,'HH12') HH12_,
        To_Char(SysDate,'HH24') HH24_
From Dual;

Select
        LocalTimeStamp,
        SysDate,
        To_Char(SysDate,'HH24') HH_,
        To_Char(SysDate,'MI') MI_,
        To_Char(SysDate,'SS') SS_,
        To_Char(SysDate,'SSSSS') SSSSS_,
        To_Char(LocalTimeStamp,'FF') FF_
From Dual;


Select
        SysDate,
        To_Char(SysDate,'Q') Q_,
        To_Char(SysDate,'MM') MM_,
        To_Char(SysDate,'MON') MON_,
        To_Char(SysDate,'MONTH') MONTH_,
        To_Char(SysDate,'RM') RM_         -- RM roma rakamý ile kacýncý ay oldugunu verir
From Dual;

Select
        SysDate,
        To_Char(SysDate,'J') J_ -- Milattan once 1 Ocak 4721 tarihinden itibaren kac gun gectigini verir
From Dual;

Select
      To_Char(Current_Date,'DD/MM/YYYY HH24:MI:SS') Current_Date_,
      To_Char(SysDate,'DD/MM/YYYY HH24:MI:SS') SysDate_
From Dual;

/

Alter Session Set Time_Zone = '+2:0';

/
alter session set nls_language = german;
/
select to_char(sysdate, 'DAY') from dual;
select to_char(sysdate, 'd') from dual;
/
select to_char(sysdate, 'd', 'NLS_DATE_LANGUAGE = danish') from dual;
/

alter session set nls_territory = 'DENMARK';
/
select *
from   nls_session_parameters t
where  t.parameter = 'NLS_TERRITORY';
/
select to_char(sysdate, 'd') from dual;

select to_char(sysdate, 'DAY') from dual;

/

alter session set nls_territory = TURKEY;

/
select *
from   nls_session_parameters t
where  t.parameter = 'NLS_TERRITORY';
/

alter session set nls_language = turkish;
select to_char(sysdate, 'DAY') from dual;

Select
      To_Char(Current_Date,'DD/MM/YYYY HH24:MI:SS') Current_Date_,
      To_Char(SysDate,'DD/MM/YYYY HH24:MI:SS') SysDate_
From Dual;


Select Current_Date, SysDate
From Dual;

alter session set nls_language = english;
select to_char(sysdate, 'DAY') from dual;

SELECT SYSDATE AS current_date,
       SYSDATE + 1 AS plus_1_day,
       SYSDATE + 1/24 AS plus_1_hours,
       SYSDATE + 1/24/60 AS plus_1_minutes,
       SYSDATE + 1/24/60/60 AS plus_1_seconds
FROM   dual;

-- ADD_MONTHS
-- ADD_MONTHS(date_expression, month)

SELECT
  ADD_MONTHS( DATE '2016-02-29', 1 )
FROM
  dual;

--
SELECT
  ADD_MONTHS( DATE '2016-02-24', 1 )
FROM
  dual;

--

SELECT
  ADD_MONTHS( DATE '2016-03-31', -1 )
FROM
  dual; 

--

SELECT
  LAST_DAY( ADD_MONTHS(SYSDATE , - 1 ) )
FROM
  dual;

--

Select Trunc(sysdate,'MM') From Dual; -- Ayýn ilk gununu bulur

--

Select ADD_MONTHS( SYSDATE, +6 ) From Dual;
Select ADD_MONTHS( SYSDATE, -6 ) From Dual;
Select ADD_MONTHS( SYSDATE, 8 ) From Dual;

--ORACLE SQL EXAMPLE
SELECT
     SYSDATE,
     ADD_MONTHS(SYSDATE, 1) as Sonuc1,
     LAST_DAY(ADD_MONTHS(SYSDATE, 1)) as Sonuc2,
     SUBStr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)),1,5) as Sonuc3,
     SUBStr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)),1,10) as Sonuc4,
     To_Date(SUBStr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)),1,10),'DD-MM-YYYY') Tarih
FROM DUAL;

-- ADD_MONTHS

Select SYSDATE + interval '8' Month From Dual;

-- Gun, Ay, Yýl, Saat, Dakika,Saniye ekleme iþlemleri
-- Syntax
-- Tarih + interval 'Eklenecek sayý’ Eklemeturu(DAY,MONTH,YEAR,HOUR,MINUTE,SECOND)

Select sysdate + interval  '1' DAY From Dual;
Select sysdate + interval  '1' MONTH From Dual;
Select sysdate + interval  '1' YEAR From Dual;

Select TO_CHAR(sysdate + interval  '1' HOUR,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select TO_CHAR(sysdate + interval  '10' MINUTE,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select
      TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI.SS') AS RESULTA,
      TO_CHAR(sysdate + interval  '30' SECOND,'DD/MM/YYYY HH24:MI.SS') AS RESULTB      
From Dual;

--

Select sysdate + interval  '-1' DAY From Dual;
Select sysdate + interval  '-1' MONTH From Dual;
Select sysdate + interval  '-1' YEAR From Dual;

Select TO_CHAR(sysdate + interval  '-1' HOUR,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select TO_CHAR(sysdate + interval  '-10' MINUTE,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select
      TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI.SS') AS RESULTA,
      TO_CHAR(sysdate + interval  '-30' SECOND,'DD/MM/YYYY HH24:MI.SS') AS RESULTB      
From Dual;

Select sysdate + interval  '1' YEAR From Dual;











