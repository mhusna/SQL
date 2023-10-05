-- INNER JOIN --
Select
    *
From CityJoin cj
Join CustomersJoin cu On cu.cityid = cj.cityid;

-- LEFT JOIN --
-- Soldaki tablodan tum elemanlari, sagdaki tablodan da soldaki tablonun eslesen satiriyla ilgili bilgileri yazar, eger karsilik yoksa null yazar.
------------------------------------------------
Select
    *
From CityJoin cj
Left Join CustomersJoin cu On cu.cityid = cj.cityid;

-- RIGHT JOIN --
-- Sa?daki tablodan tum elemanlari, soldaki tablodan da sagdaki tablonun eslesen satiriyla ilgili bilgileri yazar, eger karsilik yoksa null yazar.
------------------------------------------------
Select
    *
From CityJoin cj
Right Join CustomersJoin cu On cu.cityid = cj.cityid;

-- FULL JOIN --
-- Inner join + left join + right join.
-- Once inner join yaparak ortak kayitlari yazar, sonra left join'e gore yazar, sonra da right join'e gore yazar. Ayni satir icin hem left hem right joine gore yazar.
------------------------------------------------
Select
    *
From CityJoin cj
Full Join CustomersJoin cu On cu.cityid = cj.cityid;

-- CROSS JOIN --
-- Bir tablodaki herbir satir ile diger tablodaki tum satirlari carpar ve yazar.
------------------------------------------------
Select
    *
From CityJoin
Cross Join CustomersJoin;

-- SELF JOIN --
------------------------------------------------
Select
    e1.employee_id as "Calisan id",
    e1.first_name || ' ' || e1.last_name,
    e2.employee_id as "Manager id",
    e2.first_name || ' ' || e2.last_name
From hr.employees e1
Join hr.employees e2 on e1.manager_id = e2.employee_id;

-- NATURAL JOIN --
------------------------------------------------
-- Ortak alanlar uzerinden inner join islemi gerceklestirir.
-- Ortak alanlari belirtmemize gerek yok.
Select
    *
From CityJoin
Natural Join CustomersJoin;