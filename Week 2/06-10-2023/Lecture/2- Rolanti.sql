-- 1) sales_orders tablosunda en son verilen siparis bilgilerini getiriniz.
With A  as
(
    Select
        *
    From sales_orders
    Order By orderid Desc
)
Select
    *
From A
Where rownum = 1;

-- 2) Join ve subquery ile personel last_name'i D ile baslayanlarin siparislerini bulunuz.

-- Tables: hr_employees, sales_orders
-- Join
Select
    hr.lastname,
    so.orderid,
    so.empid
From sales_orders so
Join hr_employees hr on hr.empid = so.empid
Group By hr.lastname, so.orderid, so.empid
Having hr.lastname like 'D%'
Order By so.empid;

-- Subquery
Select
    *
From sales_orders
Where empid in(
    Select
        empid
    From hr_employees
    Where lastname like 'D%'
);

-- 3) Join ve subquery ile Usa musterilerinin siparislerini listeleyen sorguyu yaziniz.
-- Tables: sales_orders, sales_customers.

-- Join ile cozum
Select
    hr.country,
    so.orderid
From hr_employees hr
Join sales_orders so on hr.empid = so.empid
Group By hr.country, so.orderid
Having hr.country = 'USA';

-- Subquery
Select
    *
From sales_orders so
Where so.empid in 
    (Select
        empid
     From hr_employees
     Where country = 'USA');
     
-- 4) sales_customers tablosunda olup siparisi olmayan musterilerin bilgisini bulunuz.
Select
    *
From sales_customers
MINUS
Select
    *
From sales_customers
Where custid in
    (Select
        custid
     From sales_orders
     Where orderid is null);
-- Yukaridaki ornekte alt sorguda where yazmak yerine not in dersek de olur.
     
-- Right join
Select
    *
From sales_customers sc 
Right join sales_orders so on sc.custid = so.custid;

-- Ornek5
-- Sales_Orders tablosunda en son tarihte  verilen siparis bilgilerini getiriniz.
-- Belki en son tarihte birden fazla siparis var.
Select
    *
From sales_orders
Where orderdate = (
                    Select Max(orderdate) 
                    From sales_orders
                  );

-- Ornek6
-- Sales_Orders tablosunda her bir musterinin en son tarihte verdigi siparis bilgilerini getiriniz

-- Alt sorgu ile cozelim.
Select
    *
From sales_orders o1
Where o1.orderdate = (
                    Select Max(o2.orderdate) 
                    From sales_orders o2
                    Where o2.custid in o1.custid
                  )
Order By o1.custid;

-- CTEs ile cozelim.
With MaxOrderDate as
(
    Select
        custid,
        max(orderdate) as SonTarih
    From sales_orders
    Group By custid
)
Select
    *
From sales_orders o1 
Join MaxOrderDate o2 on o2.custid = o1.custid 
Where o1.orderdate = o2.SonTarih
Order By o1.custid;

-- Ornek7
-- Sales_OrderDetails tablosunda qty'si 90 olanlar?n product bilgilerini ve qty bilgilerini getiriniz

-- Join ile yapalim
Select
    pp.productname,
    so.orderid,
    so.qty,
    so.unitprice
From sales_orderdetails so
Join production_products pp on so.productid = pp.productid
Where so.qty = 90; 

-- SubQuery ile yapalim.
Select
    so.orderid,
    so.qty,
    so.unitprice,
    (
        Select
            productname as UrunAdi
        From production_products pp
        Where pp.productid = so.productid
    ) as "Urun Adi"
From sales_orderdetails so
Join production_products pp on so.productid = pp.productid
Where so.qty = 90; 