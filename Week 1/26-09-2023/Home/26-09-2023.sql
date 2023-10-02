-- Surekli olarak kullanacagimiz sorguyu VIEW yapariz.
-- VIEW'ler kalicidirlar.
-- VIEW'de her bir sutunun adi farkli olmalidir, daha sonraki sorgularimizda kolonlari ayirt edebilmek icin.

Create View vw_OrdersAll as
Select 
    sc.companyname Cust_companyname,
    hre.firstname,
    hre.lastname,
    so.orderdate,
    so.freight,
    sod.unitprice,
    sod.qty,
    pp.productname,
    pc.categoryname,
    ps.companyname Supp_companyname,
    ss.companyname Ship_companyname
From sales_orders so
Join sales_customers sc on sc.custid = so.custid
Join hr_employees hre on hre.empid = so.empid
Join sales_orderdetails sod on sod.orderid = so.orderid
Join production_products pp on pp.productid = sod.productid
Join production_suppliers ps on ps.supplierid = pp.supplierid
Join production_categories pc on pc.categoryid = pp.categoryid
Join sales_shippers ss on ss.shipperid = so.shipperid
Order By so.orderid;

-- Olusturulan view'a sorgu yapabiliriz.
Select * From vw_ordersall;

-- ORNEK: Her bir categoryname icin toplam freight degerini bulan sorguyu yazalim.
Select
    categoryname,
    sum(freight)
From vw_ordersall
Group By categoryname;

-- ORNEK: Her bir categoryname'in productname'e gore toplam freight degerlerini bulun.
Select
    categoryname,
    productname,
    sum(freight)
From vw_ordersall
Group By categoryname, productname
Order By categoryname, productname;

-- ORNEK: Yillara gore toplam siparisleri bulunuz.
Select 
    To_Char(orderdate, 'YYYY') as Order_Year,
    Count(*) as Count_of_Order
From vw_ordersall
Group By To_Char(orderdate, 'YYYY')
Order By Order_Year;

-- ORNEK: ship_companyname = 'SHIPPER ZHISN' olanlarin yillara gore toplam freight degerini bulun.
Select
    To_Char(orderdate, 'YYYY') as Order_Year,
    Sum(freight) as Total_Freight
From vw_ordersall
Where ship_companyname = 'Shipper ZHISN'
Group By To_Char(orderdate, 'YYYY')
Order By Order_Year desc;

-- ORNEK: Yukaridaki sorguda siparis sayisi 160'dan buyuk olanlari bulun.
Select
    To_Char(orderdate, 'YYYY') as Order_Year,
    Sum(freight) as Total_Freight,
    Count(*) as Count_of_Order
From vw_ordersall
Where ship_companyname = 'Shipper ZHISN'
Group By To_Char(orderdate, 'YYYY')
Having Count(*) > 160
Order By Order_Year desc;

-- DISTINCT: Tekrar eden satirlari teke indirger.
Select Country From sales_customers;
Select Count(Country) From sales_customers; -- 182 kayit getirir

Select Distinct Country From sales_customers;
Select Count(Distinct(Country)) From sales_customers; -- 21 kayit getirir.

-- Asagidaki sorgu alias'a 1 eklenmek istendigi icin calismayacaktir.
Select 
    orderid as Order_ID,
    To_Char(orderdate, 'YYYY') as Current_Year,
    orderyear + 1 as Next_Year
From sales_orders;

-- Alias yerine islemin / fonksiyonun kendisi yazarsa calisacaktir.
Select 
    orderid as Order_ID,
    To_Char(orderdate, 'YYYY') as Current_Year,
    To_Char(orderdate, 'YYYY') + 1 as Next_Year
From sales_orders;

-- Derived Table ile yazmak istersek islemi / fonksiyonu tekrar yazmamiza gerek yok. Derived Table'dan gelen alias'? kullanabiliriz.
Select
    Order_ID,
    Current_Year,
    Current_Year + 1 as Next_Year
From
(
    Select
        orderid as Order_ID,
        To_Char(orderdate, 'YYYY') as Current_Year
    From sales_orders
) A;

-- CTEs ile cozumu de asagidaki gibi olacaktir.
-- CTEs kullanmak derived table'a karsi tercih edilmelidir cunku okunabilirligi daha kolay ve yapisal kodlama yapmaya imkan veriyor.
With A as
(
    Select
        orderid as Order_ID,
        To_Char(orderdate, 'YYYY') as Current_Year
    From sales_orders
)
Select 
    Order_ID,
    Current_Year,
    Current_Year + 1 as Next_Year
From A;

-- Bir CTEs yapisini bir digerinde kullanabiliriz.
With personeller as
(
    Select 
        empid, 
        firstname || ' ' || lastname as FullName
    From hr_employees
),
siparisler as
(
    Select
        orderid,
        custid,
        empid,
        orderdate,
        freight
    From sales_orders
)
Select 
    *
From personeller p
Join siparisler s on s.empid = p.empid;

-- ORNEK
With TumSiparisler as
(
    Select 
        orderid,
        custid,
        empid,
        orderdate,
        freight,
        shipcity,
        shipcountry
    From sales_orders
),
UsaSiparisleri as
(
    Select
        *
    From TumSiparisler
    Where shipcountry = 'USA'
),
CityToplamlari as 
(
    Select
        shipcity,
        sum(freight) as Total_Freight
        From UsaSiparisleri
        Group By shipcity
)
Select
    *
From CityToplamlari
Order By Total_Freight desc;

-- ORNEK
Select
    hre.lastname,
    Count(so.orderid) as Siparis_Sayisi
From
(
    sales_orders so
    Join hr_employees hre on hre.empid = so.empid
)
Group By hre.lastname
Having Count(so.orderid) > 50
Order By Siparis_Sayisi desc;

-- CASE-WHEN
Select
    orderid,
    orderdate as Tam_Tarih,
    To_Char(orderdate, 'YYYY') as Yil,
    To_Char(orderdate, 'MM') as Ay,
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
    End as Ay_String,
    freight
From sales_orders;

-- SEARCH CASE-WHEN
Select
    orderid,
    orderdate as Tam_Tarih,
    To_Char(orderdate, 'YYYY') as Yil,
    To_Char(orderdate, 'MM') as Ay,
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
    End as Ay_String,
    Case 
        When freight Between 0 and 100 Then '0 - 100 arasi'
        When freight Between 100 and 200 Then '100 - 200 arasi'
        When freight Between 200 and 500 Then '200 - 500 arasi'
        Else
            '500''den buyuk'
    End as Freight
From sales_orders;

-- ORNEK: custid degeri 20 olan musterinin empid bazinda yila gore toplam siparis sayisini bulunuz.
Select
    empid as emp_id,
    To_Char(orderdate, 'YYYY') as Yil,
    Count(orderid) as Siparis_Sayisi
From sales_orders
Where custid = 20
Group By empid, To_Char(orderdate, 'YYYY')
Order By 1, 2;

-- ORNEK: custid degeri 20 olan musterinin fullname bazinda yila gore toplam siparis sayisini bulunuz.
Select
    firstname || ' ' || lastname as FullName,
    To_Char(orderdate, 'YYYY'),
    Count(orderid) as Siparis_Sayisi
From sales_orders so
Join hr_employees hre on hre.empid = so.empid
Where custid > 20
Group By firstname || ' ' || lastname, To_Char(orderdate, 'YYYY')
-- Farkli versiyonu: Group By firstname, lastname, To_Char(orderdate, 'YYYY')
Order By 1, 2;

-- ORNEK: hr.employees tablosunda ayni maasi alanlarin sayisi
Select
    salary as Maas,
    Count(employee_id) Kac_Kisi
From hr.employees
Group By salary
Order By salary desc;

-- ORDER BY icerisinde CASE-WHEN kullanmak
Select
    companyname,
    region,
    city,
    country,
    Case 
        When region is not null Then 1 
        End as Region_Durumu
From Sales_Customers
Order By
    Case
        When region is not null Then 1 
    End, 4, 3;
    
-- ORNEK: En son verilen 5 siparisi bulunuz, siralamayi orderdate alanina gore yapiniz.
With A as
(
    Select
        *
    From sales_orders 
    Order By orderdate desc
)
Select 
    *
From A
Where rownum <= 5
Order By orderdate, orderid;

-- NTILE: NTILE keywordu ile ilgili sutunu parametre olarak verilen kadar parcaya boler.
Select
    orderid,
    custid,
    empid,
    orderdate,
    NTILE(100) Over (Order By orderdate) as NTILE
From sales_orders;

-- ORNEK
With TOP_NTILE as
(
    Select
        orderid,
        custid,
        empid,
        orderdate,
        NTILE(100) Over (Order By orderdate) as Siniflandirma
    From sales_orders
)
Select
    *
From TOP_NTILE
Where Siniflandirma = 1;

-- Kosullar ve Operatorler
-- IN
Select
    orderid,
    custid,
    empid,
    orderdate
From sales_orders
Where orderid in (10248, 10249, 10250);

-- BETWEEN
Select
    orderid,
    custid,
    empid,
    orderdate
From sales_orders
Where orderid Between 10230 and 10310;

-- LIKE
Select * From hr_employees
Where lastname Like '%d';

Select * From hr_employees
Where lastname Like 'd%';

Select * From hr_employees
Where lastname Like '%e%';

Select * From hr_employees
Where Upper(lastname) Like '%A%';

-- ORNEK: hr.employees tablosunda job_id alan? 'SA_REF' olan, first_name icerisinde 'e' harfi gecenleri ve maasi 8000'den buyuk olanlari bulunuz.
Select
    *
From hr.employees
Where 
    job_id = 'SA_REF' And
    Lower(first_name) Like '%e%' And
    salary > 8000;
    
-- ORNEK: custid'si 1 olan ve empid alan? 1, 3, 5 olan yada custid'si 2 olan ve empid alani 2, 4, 6 olan kayitlari getirin.
Select
    *
From sales_orders
Where (custid = 1 and empid in (1, 3, 5))
Or    (custid = 2 and empid in (2,4, 6));

-- ORNEK
Select
    orderid,
    custid,
    empid,
    orderdate,
    freight,
    Case
        When freight < 100 Then '100''den kucuk.'
        When freight Between 100 and 200 Then '100 - 200 arasinda.'
        Else '200''den buyuk.'
    End as Freight_Category
From
    sales_orders;

-- DECODE: CASE-WHEN ile ayni isi yapar.
Select
    first_name,
    department_id,
    Decode (department_id,
                10, 'Yazilim',
                30, 'Uretim',
                50, 'Pazarlama',
                'Diger'
    ) as Departments
From hr.employees
Order By department_id;

-- ORNEK
Select
    orderid,
    orderdate,
    To_Char(orderdate , 'MM') as Ay,
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
                12, 'Aralik'
    ) as Aylar,
    freight
From sales_orders;

-- USER_CONSTRAINTS: Bu tablo constraint listesini goruntulemek icin kullanilir.
Select * From User_Constraints;

-- Where kosulu ile bir tabloya ait constraint'lerin listesini de getirebiliriz.
Select * From User_Constraints Where table_name = 'sales_orders';

-- Bir tabloya ait sutunlarin listesini gormek icin.
desc sales_orders;