-- Herbir personelin adi, soyadi yani fullname yazalim, yanina toplam freight degerlerini yazalim.

-- Bu sorguyu hem join ile hem subquery ile yapalim.
-- Tables: hr_employees, sales_orders

-- Join ile cozum

Select
    e.empid,
    e.firstname || ' ' || e.lastname as "Full Name",
    Sum(freight) as TotalFreight
From sales_orders so
Join hr_employees e on e.empid = so.empid
Group By e.empid, e.firstname || ' ' || e.lastname
Order By e.empid;

-- Subquery ile cozum
Select
        e.empid,
        e.firstname || ' ' || e.lastname as "Full Name",
        (
            Select
                Sum(Freight)
            From sales_orders
            Where empid = e.empid
        ) as Totalfreight
From hr_employees e
Order By e.empid;


-- Saglamas?n? minus ile yapal?m

Select 
        firstname || ' ' || lastname as FullName,
        Sum(o.Freight) as TotalFreight
From Sales_Orders o
join hr_employees e on e.empid = o.empid
Group By firstname, lastname

minus

Select
        --e.empid,
        firstname || ' ' || lastname as FullName,
        (
            Select Sum(o.freight) as TotalFreight
            From Sales_Orders o
            Where empid = e.empid
        ) as TotalFreight
From hr_employees e
Order By FullName;

-- Sonuc bos kume geldigi icin
-- bilgilerin ayn? oldugunu anl?yoruz