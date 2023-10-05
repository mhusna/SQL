Select * From CityJoin;

Select * From CustomersJoin;

-- JOIN (INNER JOIN) --
Select
    *
From cityjoin cj
join customersjoin cu on cu.cityid = cj.cityid;

-- LEFT JOIN (LEFT OUTER JOIN): Soldaki tabloyu koru yani tum elemanlarini yazar, sagdaki tabloda olanlari yazar olmayanlara null basar.
Select
    *
From cityjoin cj
left join customersjoin cu on cu.cityid = cj.cityid;

-- Ustteki ile ayni sonucu verir, outer yazip yazmamak fark etmez.
Select
    *
From cityjoin cj
left outer join customersjoin cu on cu.cityid = cj.cityid;

-- RIGHT JOIN (RIGHT OUTER JOIN): Sagdaki tabloyu korur, soldaki tabloda olanlari yazar olmayanlara null basar.
Select
    *
From cityjoin cj
right join customersjoin cu on cu.cityid = cj.cityid;

-- Ayni sonuc
Select
    *
From cityjoin cj
right outer join customersjoin cu on cu.cityid = cj.cityid;

-- FULL JOIN (FULL OUTER JOIN): Inner join + left join + right join.
-- Yani inner join yaparak ortak kayitlari yazar, sonra left join'e gore yazar
-- sonra da right join'e gore yazar. Ayni satir icin hem left hem right join yazar.
Select
    *
From cityjoin cj
full join customersjoin cu on cu.cityid = cj.cityid;

-- Ayni sonuc
Select
    *
From cityjoin cj
full outer join customersjoin cu on cu.cityid = cj.cityid;

-- CROSS JOIN: Bir tablodaki her bir satir ile, diger tablodaki tum satirlari carpar ve yazar.
Select
    *
From cityjoin
Cross join customersjoin;

-- SELF JOIN --
Select
    e1.employee_id as Calisan_ID,
    Concat(Concat(e1.first_name, ' '), e1.last_name) as "Calisan Adi",
    e2.employee_id as Manager_ID,
    Concat(Concat(e2.first_name, ' '), e2.last_name) as "Manager Adi"
From Employees  e1
Join Employees e2 on e1.manager_id = e2.employee_id;

-- NATURAL JOIN --
-- Ortak alanlar uzerinden inner join islemi gerceklestirir.
-- Inner join ile ayni sonucu verir.
-- Ortak alanlari bizim belirtmemize gerek yok.
Select
    *
From cityjoin
Natural join customersjoin;