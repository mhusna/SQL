-- SAYISAL FONKSIYONLAR
-- Sign: Bir ifadenin / degerin / fonksiyonun isaretini bulur.
-- Abs: Mutlak deger fonksiyonu.
-- Ceil: Aldigi sayisal degeri bir ust tam sayiya cevirir.
-- Floor: Aldigi sayisal degeri bir alt tam sayiya cevirir.
-- Mod: Mod islemi yapar.
-- Power: Bir sayinin ussunu alir.
-- Sqrt: Sayinin karekokunu bulur.
-- Round: Yuvarlama fonksiyonu, aldigi sayisal degeri yuvarlar.

-- SIGN
Select Sign(-3), Sign(3) From Dual;

-- ABS
Select Abs(-10), Abs(10), Abs(123.45), Abs(-123.45) From Dual;

-- ORNEK
Select Sign(-3) * 15 + 5 From Dual;

-- ORNEK
Select
    Sign(-3 * 15 + 5),
    Abs(-3 * 15 + 5),
    Abs(3 * 15 + 5),
    Sign(-3 * 15 + 5 -Abs(-3 * 15 + 5)),
    Sign(-3 * 15 + 5 -Abs(-3 * 15)),
    -3 * 15 + 5, -Abs(-3 * 15)
From Dual;

-- ORNEK
Select
    -3 * 15, -Abs(-3 * 15),
    Sign(-3 * 15 -Abs(-3 * 15)),
    Sign(-3 * 15 +Abs(-3 * 15))
From Dual;

-- ORNEK
Select
    3 * 15,
    Sign(3 * 15 +Abs(-3 * 15))
From Dual;

-- 1'den 11'e kadar olan sayilari elde edelim.
Select Level From dual connect by Level < 12;

-- Negatif sayilar.
Select Level * (-1) From dual connect by Level < 12;

-- Bunda 0 yok.
Select Level From dual connect by Level < 12
union
Select Level * (-1) From dual connect by Level < 12;

-- Bunda 0 var.
Select Level From dual connect by Level < 12
union
Select 0 From Dual
union
Select Level * (-1) From dual connect by Level < 12;

-- Top n kullanimi icin rownumber kullanilir.
-- ORNEK: Employees tablosunda en yuksek maas alan 3 kisinin bilgilerini bulunuz.
With A as
(
    Select 
        first_name, last_name, salary
    From hr.employees
    Order By salary desc
)
Select * From A
Where rownum <= 3;

-- ORNEK: Employees tablosundaki department_id'lere gore maas toplamlari en yuksek olan ilk 3 department_id'yi bulun.
With A as
(
    Select
        department_id,
        sum(salary) as TotalSalary
    From hr.employees
    Group By department_id
    Order By TotalSalary desc
)
Select * From A
Where rownum <= 3;

-- ORNEK: Employees tablosunda job_id'si 'SA_REP', 'AD_PRES' ve maasi 15000'den buyuk olan kayitlari bulun.
Select
    *
From hr.employees
Where ((job_id = 'SA_REP' or job_id = 'AD_PRES') and Salary > 15000);

-- ORNEK: Employees tablosunda maasi 1900 - 2100 arasi kayitlari bulunuz.
Select
    *
From hr.employees
Where salary Between 1900 and 2100;

-- ANY ve ALL
-- Any ve All icin parantez icerisinde bir altsorgudan gelen bilgileri kullanabiliriz.

-- Any: Kume elemanlarinin herhangi birinden buyuk olanlari getir.
Select * From hr.employees
Where department_id > ANY (10);

Select * From hr.employees
Where department_id > ANY (10,40);

Select * From hr.employees
Where department_id < ANY (110, 70);

-- All: Tum kume elemanlarindan buyuk olanlari getir
Select * From hr.employees
Where department_id > ALL (10);

Select * From hr.employees
Where department_id > ALL (10,40);

Select * From hr.employees
Where department_id > ALL (10,40,70); -- Hepsinden buyuk olanlar gelir

Select * From hr.employees
Where department_id < ALL (110);

Select * From hr.employees
Where department_id < ALL (110,70);

Select * From hr.employees
Where department_id < ALL (110,70,40); -- Hepsinden kucuk olanlar gelir