-- ORNEK: sales_orders tablosunda herbir orderid'nin yanina onceki orderid'yi yazdiralim.
Select
    o1.orderid,
    ( 
        Select
            Max(o2.orderid)
        From sales_orders o2
        Where o2.orderid < 10250
    ) as PrevOrderid
From sales_orders o1;

-- ORNEK: Herbir orderid'nin yanina bir sonrakini yazdirin
Select
    o1.orderid,
    ( 
        Select
            Min(o2.orderid)
        From sales_orders o2
        Where o2.orderid > o1.orderid
    ) as NextOrderid
From sales_orders o1
Order By orderid;

-- Ornek 3
-- Yillara gore toplam qty'leri bulunuz ve view haline getiriniz
-- Tarih alan? olarak orderdate kullan?n?z
-- Tablolar: Sales_Orders, Sales_OrderDetails

Select
          To_Char(orderdate,'YYYY'),
          Sum(od.Qty) as TotalQty
From  Sales_Orders o
join    Sales_OrderDetails od  on od.orderid = o.orderid
Group By To_Char(orderdate,'YYYY');
/
-- Yukar?daki sorguyu view haline getirelim
Create or Replace View vw_ReportOrderYearQty as
Select
          To_Char(orderdate,'YYYY') as OrderYear,
          Sum(od.Qty) as TotalQty
From  Sales_Orders o
join    Sales_OrderDetails od  on od.orderid = o.orderid
Group By To_Char(orderdate,'YYYY');
/

Select 
    OrderYear,
    TotalQty,
    Sum(TotalQty) Over(Order By OrderYear)
From vw_ReportOrderYearQty
Order By OrderYear;