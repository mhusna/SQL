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
    ss.companyname Ship_companyname
From SALES_ORDERS o
Join SALES_CUSTOMERS c on c.custid = o.custid
Join HR_EMPLOYEES e on e.empid = o.empid
Join SALES_ORDERDETAILS od on od.orderid = o.orderid
Join PRODUCTION_PRODUCTS pp on pp.productid = od.productid
Join PRODUCTION_SUPPLIERS ps on pp.supplierid = ps.supplierid
Join PRODUCTION_CATEGORIES pc on pp.categoryid = pc.categoryid
Join SALES_SHIPPERS ss on ss.shipperid = o.shipperid
Order By o.orderid;

-- Yukar?daki sorguyu view haline getirelim.

Select *
From vw_OrdersAll;

/* -------------------------------
View haline gelen sorgudan ve beslendigi
sorgudan sorgular?m?z? ayri ayri yazalim 
ve inceleyelim.
------------------------------- */

/* -------------------------------
ORNEK 1: Her bir categoryname icin toplam
freightlari bulan sorguyu yazalim.
------------------------------- */

-- YONTEM 1: Sorgu Uzerinden
Select 
    pc.categoryname,
    sum(o.freight) as TotalFreight
From SALES_ORDERS o
Join SALES_CUSTOMERS c on c.custid = o.custid
Join HR_EMPLOYEES e on e.empid = o.empid
Join SALES_ORDERDETAILS od on od.orderid = o.orderid
Join PRODUCTION_PRODUCTS pp on pp.productid = od.productid
Join PRODUCTION_SUPPLIERS ps on pp.supplierid = ps.supplierid
Join PRODUCTION_CATEGORIES pc on pp.categoryid = pc.categoryid
Join SALES_SHIPPERS ss on ss.shipperid = o.shipperid
Group By pc.categoryname;

-- YONTEM 2: View Uzerinden
Select 
    categoryname, sum(freight) as Total
From vw_OrdersAll v
Group By categoryname;
---------------------------------

/* -------------------------------
ORNEK 2: Her bir categoryname'in
productname'e göre ToplamFreight
degerlerini bulunuz.
------------------------------- */
Select
    categoryname,
    productname,
    sum(freight) as Total
From vw_OrdersAll
Group By categoryname, productname
Order By categoryname, productname;

/* -------------------------------
ORNEK 3: Yillara gore toplam 
siparisleri bulunuz.
------------------------------- */
Select
    to_char(orderdate, 'YYYY') as orderyear,
    Count(*) as siparissayisi
From vw_ordersAll
Group By to_char(orderdate, 'YYYY')
Order By orderyear;

/* -------------------------------
ORNEK 4: ship_companyname = Shipper ZHISN
olanlarin yillara gore toplam freightlarini
bulun.
------------------------------- */
Select
    to_char(orderdate, 'YYYY') as orderyear,
    Count(*) as siparissayisi
From vw_OrdersAll
Where SHIP_COMPANYNAME = 'Shipper ZHISN'
Group By to_char(orderdate, 'YYYY')
Order By orderyear;

/* -------------------------------
ORNEK 4:Yukaridaki sorguda
siparissayisi > 160 olanlari bulun.
------------------------------- */
Select
    to_char(orderdate, 'YYYY') as orderyear,
    Count(*) as siparissayisi
From vw_OrdersAll
Where SHIP_COMPANYNAME = 'Shipper ZHISN'
Group By to_char(orderdate, 'YYYY')
Having Count(*) > 160
Order By orderyear;

-- Distinct Komutu: Tekrar eden satirlari teke indirger.
Select 
    Country
From Sales_Customers
Order By 1;

Select Distinct
    Country
From Sales_Customers
Order By 1;

-- #################################################################

Select Count(Country) as Sayi
From Sales_Customers;

Select
    Count(Distinct(Country)) as Sayi
From Sales_Customers;

--

Select
    orderid,
    to_char(orderdate, 'YYYY') as orderyear,
    orderyear + 1 as orderyear
From Sales_Orders;

-- Yukaridaki sorgu calismaz.

Select
    orderid,
    to_char(orderdate, 'YYYY') as orderyear,
    to_char(orderdate, 'YYYY') + 1 as orderyear
From Sales_Orders;

-- Veya derived table ile yapalim.

Select 
    orderid,
    orderyear,
    orderyear + 1 as nextyear
From (
        Select
            orderid,
            to_char(orderdate,'YYYY') as orderyear
        From SALES_ORDERS
    ) A;
    
-- Yukaridaki sorguyu CTEs ile yazalim
/*
With SanalTabloAdi as
(
    Calisan Kod
)
Select *
From SanalTabloAdi;
*/

With A as
(
    Select
        orderid,
        to_char(orderdate,'YYYY') as orderyear
    From SALES_ORDERS
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
    Select orderId, custId, empid, orderdate, freight
    From Sales_Orders
)
Select *
From personeller p
Join siparisler s on p.empid = s.empid;

------------------------------------------

With 
TumSiparisler as
(
    Select orderid, custid, empid, orderdate, freight, shipcity, shipcountry
    From sales_orders
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
From (
        Sales_Orders o
        Join hr_employees e on e.empid = o.empid
    )
Group By e.lastname
Having Count(o.orderid) > 50
Order By SiparisSayisi desc;

--

Select 
    orderid,
    orderdate,
    to_char(orderdate, 'YYYY') as Yillar,
    to_char(orderdate, 'MM') as Aylar,
    Case to_char(orderdate, 'MM')
        When '01' Then 'Ocak'        
        When '02' Then '?ubat'
        When '03' Then 'Mart'
        When '04' Then 'Nisan'
        When '05' Then 'May?s'
        When '06' Then 'Haziran'
        When '07' Then 'Temmuz'
        When '08' Then 'A?ustos'
        When '09' Then 'Eylül'
        When '10' Then 'Ekim'
        When '11' Then 'Kas?m'
        When '12' Then 'Aral?k'
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

--

-- Custid 20 olan musterinin empid bazinda yila gore toplam
-- siparis sayisini bulunuz.

Select 
    empid,
    To_Char(orderdate, 'YYYY') as Yillar,
    count(orderid)
From sales_orders
Where custid = 20
Group By empid, To_Char(orderdate, 'YYYY')
Order By 1, 2;

-- Isime gore yapmak istersen.

Select 
    firstname ||' '|| lastname as FullName,
    To_Char(orderdate, 'YYYY') as Yillar,
    count(orderid)
From sales_orders o
Join hr_employees e on e.empid = o.empid
Where custid = 20
Group By firstname ||' '|| lastname, To_Char(orderdate, 'YYYY')
-- Farkl? bir versiyonu
-- Group By firstname, lastname, To_Char(orderdate, 'YYYY')
Order By 1, 2;

--

Select *
From hr.employees;

Create Table Ora_Employees as
Select *
From hr.employees;

--

Select * 
From Ora_Employees;

-- Ora_Employees tablosunda ayni maasi alanlarin sayisi

Select 
    salary as Maas,
    count(employee_id) as KacKisiAliyor
From Ora_Employees
Group By salary
Order By 2 desc;

-- 

Select 
    companyname,
    region,
    city,
    country
From sales_customers
Order By region desc;

--

Select
    companyname,
    region,
    city,
    country
From Sales_Customers
Order By (
            Case When region is not null Then 1 
            End
         ) desc;

--


Select
    companyname,
    region,
    city,
    country,
    Case When region is not null Then 1 End as RegionDurumu
From Sales_Customers
Order By Case When region is not null Then 1 End,4, 3;

-- En son verilen ilk 5 siparisi bulunuz
-- Siralamayi orderdate alanina gore yapinz.

With A as(
    Select *
    From sales_orders
    Order By orderdate desc
)
Select *
From A
Where rownum < 6
Order By orderdate, orderid;

-- ###################################################################

Select 
    orderid,
    custid,
    empid,
    orderdate,
    NTILE(100) Over (Order By orderdate) as NtileOrnek
From sales_orders;

--

With Top_Ntile as
(
    Select 
        orderid,
        custid,
        empid,
        orderdate,
        NTILE(100) Over (Order By orderdate) as NtileOrnek
    From sales_orders
)
Select *
From Top_Ntile
Where NtileOrnek = 1;

-- Tum kolonlar gelmesin istersek

With Top_Ntile as
(
    Select
        orderid,
        custid,
        empid,
        orderdate,
        NTILE(100) Over (Order By orderdate) as NtileOrnek
    From sales_orders
)
Select
    orderid,
    custid,
    empid
From Top_Ntile
Where NtileOrnek = 1;

-- Kosullar ve Operatorler
-- in Kullanimi

Select
    orderid, 
    custid,
    empid,
    orderdate
From sales_orders
Where orderid = 10248 or orderid = 10249 or orderid = 10250;

-- Bunun yerine

Select
    orderid, 
    custid,
    empid,
    orderdate
From sales_orders
Where orderid in(10248, 10250, 10249);

--

Select
    orderid,
    custid,
    empid,
    orderdate
From sales_orders
where orderdate in('05-May-06');

-- Between Komutu

Select
    orderid,
    custid,
    empid,
    orderdate
From sales_orders
Where orderid Between 10300 and 10310;

-- Like

Select *
From hr_employees
Where lastname like 'd%';

Select *
From hr_employees
Where lastname like '%d';

Select *
From hr_employees
Where lastname like '%e%';

Select *
From ora_employees
Where Upper(first_name) like '%A%';

-- Ora_Employees tablosunda
-- job-id'si SA_REF olan, 
-- firstname icerisinde e harfi gecenleri
-- ve salary > 8000 olan kayitlari bulunuz.

Select *
From ora_employees
Where (job_id = 'SA_REP' 
        AND Upper(first_name) like '%E%'
        AND salary > 8000);
        
-- Customer id'si 1 olan ve 

Select *
From sales_orders
Where custid = 1 and empid in (1, 3, 5)
or    custid = 2 and empid in (2, 4, 6);

Select *
From sales_orders
Where (custid = 1 and empid in (1, 3, 5))
or    (custid = 2 and empid in (2, 4, 6));

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
From sales_orders;

-- DECODE IFADESI

Select 
    first_name,
    department_id,
    Decode (department_id,
                    10, 'Yazilim',
                    30, 'Uretim',
                    50, 'Pazarlama',
                    'Diger'
    ) as Departments
From ora_employees
Order By department_id;

--
/* HATA VAR BI BAK
Select
        orderid,
        orderdate,
        To_Char(orderdate, 'MM') as Aylar,
        Decode(To_Char(orderdate, 'MM'),
                        1, 'Ocak',
                        2, 'Subat',
                        3, 'Mart',
                        4, 'Nisan',
                        5, 'Mayis',
                        6, 'Haziran',
                        7, 'Temmuz',
                        8, 'Agustos',
                        9, 'Eylul',
                        10, 'Ekim',
                        11, 'Kasim',
                        12, 'Aralik
        ) as AyAdlari,
        freight
From sales_orders;

*/

--

Select *
From User_Constraints;

--

Select *
From User_Constraints
Where table_name = 'SALES_ORDERS';

--

Desc SALES_ORDERS;