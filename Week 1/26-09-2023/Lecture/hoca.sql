

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