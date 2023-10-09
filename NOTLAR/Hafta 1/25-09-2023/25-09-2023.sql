-- Sys altinda asagidaki islemleri yapalim.

-- Kullan?c? Olusturma
Create User KullaniciAdi identified by Sifre;

-- Connect Yetkisi
Grant connect, resource to KullaniciAdi;

-- Tüm yetkiler
Grant All Privileges to KullaniciAdi;

-- KOMUTLAR --
-- Tablodaki Tum Satirlari Getirmek
Select * From Employees;

-- Tablodaki Belirli Sutunlari Getirmek
Select
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
From Employees;

-- WHERE: Belli kritere sahip kullanicilara ait istedigimiz sutunlari gormemizi saglar.
-- WHERE ile aggregate(sum, count, min, max) gibi fonksiyonlar kullanilmaz.
Select
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
From Employees
Where job_id = 'IT_PROG';

-- GROUP BY: Verileri istedigimiz sutuna / sutunlara gore gruplamak icin kullaniriz.
-- GROUP BY ifadesinde hangi sutuna / sutunlara gore gruplama yapiyorsak SELECT ifadesinde de o kullanilmali.
-- GROUP BY ifadesinden gelen sanal tabloyu filtrelemek icin HAVING ifadesi kullanilir.
-- HAVING'de alias kullanilamaz, fakat ORDER BY'da kullanilabilir.
Select
    job_id,
    sum(salary) as "Toplam Maas"
From Employees
Group By job_id;

-- ORNEK: Maaslari *TOPLAMI* 20.000'den buyuk meslekleri bulalim ve buyukten kucuge siralayalim.
Select
    job_id,
    sum(salary) as "Toplam Maas"
From Employees
Group By job_id
Having sum(salary) > 20000
Order By "Toplam Maas" desc;

-- JOIN: Ortak sutunlari kullanarak iki tabloyu birbirine baglar.
Select
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.job_id,
    emp.salary
From Employees emp
Join Departments dep on dep.department_id = emp.department_id;

-- Ayni sorguda birden fazla join islemi yapabiliriz.
Select
    emp.employee_id,
    emp.first_name,
    emp.last_name,
    emp.salary,
    jbs.job_title,
    dep.department_name,
    loc.postal_code,
    loc.state_province,
    cou.country_name,
    reg.region_name
From Employees emp
Join Jobs jbs On jbs.job_id = emp.job_id
Join Departments dep On dep.department_id = emp.department_id
Join Locations loc On loc.location_id = dep.location_id
Join Countries cou On cou.country_id = loc.country_id
Join Regions reg On reg.region_id = cou.region_id;

-- ORNEK: Yukaridaki sorguda region_name alanina gore toplam salary'i bulun.
Select
    reg.region_name,
    sum(Salary) as "Total Salary"
From Employees emp
Join Jobs jbs On jbs.job_id = emp.job_id
Join Departments dep On dep.department_id = emp.department_id
Join Locations loc On loc.location_id = dep.location_id
Join Countries cou On cou.country_id = loc.country_id
Join Regions reg On reg.region_id = cou.region_id
Group By reg.region_name
Order By "Total Salary" Desc;

-- ## Kirilim Ornegi ##
-- ORNEK: Yukaridaki sorguda region_name'lerin country_name'e gore toplam salary bilgisini bulun.
Select
    reg.region_name,
    cou.country_name,
    sum(Salary) as "Total Salary"
From Employees emp
Join Jobs jbs On jbs.job_id = emp.job_id
Join Departments dep On dep.department_id = emp.department_id
Join Locations loc On loc.location_id = dep.location_id
Join Countries cou On cou.country_id = loc.country_id
Join Regions reg On reg.region_id = cou.region_id
Group By 
    reg.region_name, 
    cou.country_name
Order By 1, 2 Desc;

-- ## Kirilim Ornegi ##
-- ORNEK: Yukaridaki sorguda region_name'lerin once country_name'e gore sonra state_province'ye gore toplam salary bilgisini bulun.
Select
    reg.region_name,
    cou.country_name,
    loc.state_province,
    sum(Salary) as "Total Salary"
From Employees emp
Join Jobs jbs On jbs.job_id = emp.job_id
Join Departments dep On dep.department_id = emp.department_id
Join Locations loc On loc.location_id = dep.location_id
Join Countries cou On cou.country_id = loc.country_id
Join Regions reg On reg.region_id = cou.region_id
Group By 
    reg.region_name, 
    cou.country_name, 
    loc.state_province
Order By 1, 2, 3 Desc;

-- ## Kirilim Ornegi ##
-- ORNEK: Yukaridaki sorguda region_name'lerin once country_name, state_province, city, department'e gore toplam salary bilgisini bulun.
Select
    reg.region_name,
    cou.country_name,
    loc.state_province,
    dep.department_name,
    sum(emp.Salary) as "Total Salary"
From Employees emp
Join Jobs jbs On jbs.job_id = emp.job_id
Join Departments dep On dep.department_id = emp.department_id
Join Locations loc On loc.location_id = dep.location_id
Join Countries cou On cou.country_id = loc.country_id
Join Regions reg On reg.region_id = cou.region_id
Group By 
    reg.region_name, 
    cou.country_name, 
    loc.state_province,
    dep.department_name
Order By 1, 2, 3, 4 Desc;