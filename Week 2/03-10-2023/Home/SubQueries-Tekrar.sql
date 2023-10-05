-- SubQueries --
-- Kolon Seviyesinde SubQuery --
-- Select icerisinde yazilan subquery'nin tek kolon ve tek satir dondurmesi gerekir.
-------------------------------------
Select
    hre.employee_id as "Employee Id",
    hre.first_name || ' ' || hre.last_name as "Full Name",
    hre.department_id as "Department Id",
    (
        Select
            d.department_name
        From
            hr.departments d
        Where d.department_id = hre.department_id
    ) as "Department Name"
From hr.employees hre;

-- ORNEK: Herbir personelin toplam freight degerini bulunuz.
Select
    hre.firstname || ' ' || hre.lastname as "Full Name",
    (
        Select
            sum(freight)
        From sales_orders so
        Where so.empid = hre.empid
    ) as "Toplam Freight"
From hr_employees hre;

-- ORNEK: Herbir personelin toplam freigtini bulunuz, daha sonra genel toplami yazdiriniz.
Select
    hre.firstname || ' ' || hre.lastname as "Full Name",
    (
        Select
            sum(freight)
        From sales_orders so
        Where so.empid = hre.empid
    ) as "Toplam Freight",
    (
        Select
            sum(freight)
        From sales_orders
    ) as "Genel Toplam"
From hr_employees hre; 

-- Yukaridaki sorguyu join ile yapin
-- CALISMIYOR.
With A as
(
    Select
        hre.firstname || ' ' || hre.lastname as "Full Name",
        sum(freight) as "Toplam",
        '1' as TabloNo
    From hr_employees hre
    Join sales_orders so on so.empid = hre.empid
    Group By hre.firstname || ' ' || hre.lastname
    UNION
    Select
        'Genel Toplam',
        sum(freight) as "Genel Toplam",
        '2' as TabloNo
    From sales_orders
)
Select
    *
From A
Order By TabloNo asc;





;