-- REPLACE --
Select 
    department_name as Bosluklu,
    Replace(department_name, ' ', '') as Bosluksuz
From hr.departments;

-- ORNEK: Departman adinin kac kelimeden olustugunu bulunuz.
Select
    department_name as DepartmanAdi,
    Replace(department_name, ' ', '') as Bosluksuz,
    Length(department_name) - Length(Replace(department_name, ' ', '')) + 1 as KacKelime
From hr.departments
Order By KacKelime desc;

-- ORNEK
Select
    first_name,
    job_id,
    Replace(job_id, 'IT', 'BT') as Result
From hr.employees;

-- TRANSLATE --

-- ORNEK
Select 
    Translate('SQL Veri Yonetimi', 'e', 'a')
From Dual;

-- ORNEK
Select 
    Translate('SQL Veri Yonetimi', 'ei', 'x.')
From Dual;

-- ORNEK: Mesaj sifreleme
Select
    Translate
    (
        'Password1234*',
        'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz',
        'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza'
    ) as CryptedMessage
From Dual;

-- ORNEK: Sifreli mesaji cozme
Select
    Translate
    (
        'Qbttwpse1234*',
        'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza',
        'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz'
    ) as EncryptedMessage
From Dual;

-- LPAD --
Select LPAD('SQL', 12, '*') From Dual;

-- RPAD --
Select RPAD('SQL', 12, '*') From Dual;

-- ORNEK
Select
    LPAD('ORACLE PL SQL', 18, '*') LPAD,
    RPAD(LPAD('ORACLE PL SQL', 18, '*'), 23, '*') "RPAD TO LPAD",
    Replace(RPAD(LPAD('Oracle PL SQL', 18, '*'), 23, '*'), ' ', '*****') as Result
From Dual;

-- LTRIM
Select 
    LTRIM('     SQL veri yonetimi ve veri sorgulama..')
From Dual;

-- RTRIM
Select 
    LTRIM('SQL veri yonetimi ve veri sorgulama..        ')
From Dual;

-- ORNEK
Select
    LTRIM(RTRIM('       SQL veri yonetimi ve veri sorgulama..       '))
From Dual;

-- TRIM
Select
    TRIM('       SQL veri yonetimi ve veri sorgulama..       ')
From Dual;

-- CONCAT() veya ||
Select 
    'SQL' ||' '||'Ogreniyorum'
From Dual;

-- ORNEK
Select
    Concat('SQL', ' Ogreniyorum')
From Dual;

-- ORNEK
Select
    Concat(Concat('SQL', ' '), 'Ogreniyorum')
From Dual;

-- TEKIL SONUC FONKSIYONLARI
-- NVL(A, B): A null degil ise A yazar, null ise B yazar.
Select
    first_name,
    commission_pct,
    NVL(commission_pct, 0) as Result
From hr.employees;

-- NVL2(A, B, C): A null degilse B yazar, null ise C yazar.
Select
    first_name,
    commission_pct,
    NVL2(commission_pct, 0, 1) as Result
From hr.employees;

-- ORNEK
Select
    first_name,
    salary,
    commission_pct,
    1 + commission_pct,
    NVL2(commission_pct, salary * (1 + commission_pct), salary) Sonuc
From hr.employees;

-- FMDAY
Select
    To_Char(sysdate, 'FmDay', 'nls_date_language=english'),
    Case To_Char(sysdate, 'FmDay', 'nls_date_language=english')
        When 'Monday' Then 1
        When 'Tuesday' Then 2
        When 'Wednesday' Then 3
        When 'Thursday' Then 4
        When 'Friday' Then 5
        When 'Saturday' Then 6
        When 'Sunday' Then 7
    End D
From Dual;

-- ORNEK: Employees tablosunda ayni gun ise alinanlari bulunuz.
Select
    To_Char(hire_date, 'FmDay', 'nls_date_language=english'),
    Count(*) as KacKisi
From hr.employees
Group By To_Char(hire_date, 'FmDay', 'nls_date_language=english');

-- ORNEK: Ayni tarihte ise girenleri bulunuz.
Select
    To_Char(hire_date, 'YYYY') as Yil,
    To_Char(hire_date, 'MM') as Ay,
    To_Char(hire_date, 'DD') as Gun,
    Count(*) KacKisi
From hr.employees
Group By To_Char(hire_date, 'YYYY'), To_Char(hire_date, 'MM'), To_Char(hire_date, 'DD')
Order By 1, 2, 3, 4 desc;

-- ORNEK
Select 
      To_Char (sysdate, 'FmDay', 'nls_date_language=turkish'),
      To_Char (To_Date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish'),
      case to_char (to_date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish')
          when 'Pazartesi' then 1
          when 'Sali' then 2
          when 'Carsamba' then 3
          when 'Persembe' then 4
          when 'Cuma' then 5
          when 'Cumartesi' then 6
          when 'Pazar' then 7
      end d
From dual;

-- ISTATISTIK FONKSIYONLARI
-- ORNEK: job_id'ye gore toplam maaslari bulun.
Select
    job_id,
    sum(salary)
From hr.employees
Group By job_id
Order By 2 desc;

-- ORNEK: Yukaridaki sorgunun en altina genel toplami yazdirin.
With A as
(
    Select
        job_id,
        sum(salary) as Maas,
        '1' as TabloNo
    From hr.employees
    Group By job_id
),
B as
(
    Select
        'Genel Toplam' as job_id,
        sum(salary) as Maas,
        '2' as TabloNo
    From hr.employees
)
Select job_id, Maas From A
Union
Select job_id, Maas From B
Order By Maas;

-- ORNEK: Bu ornekte null olanlari saymaz.
Select * From Sales_Customers Where region != 'WA';

-- NULL KONTROLU
Select * From sales_customers Where region = '';

Select * From Sales_Customers Where region is Null;

Select * From Sales_Customers Where region is Not Null;

-- ORNEK
Select
      Sum(Salary),
      Round(Avg(Salary),2) as AVG_,
      Min(Salary),
      Max(Salary),
      Count(Salary),
      Count(*),
      Count(commission_pct),  -- dolu olan komisyonlarin sayisini verir.
      Round(STDDEV(Salary),2) STDDEV_,
      Round(VARIANCE(Salary),2) VARIANCE_
From hr.Employees;

-- ANALITIK SORGULAR
-- ORNEK
Select
    first_name,
    employee_id,
    salary,
    sum(salary) over(order by first_name, employee_id) as TotalSalary
From hr.employees;

-- ORNEK
Select
    first_name || ' ' || last_name as FullName,
    Salary,
    sum(salary) Over() as Toplam
From hr.employees;

-- ORNEK: Calisanin adi, maasi, bolumu, kumulatif toplam.
-- Bolume gore gruplayin, maasa gore siralayin.
Select
    first_name,
    department_id,
    salary,
    sum(salary) Over(Partition By department_id order by salary, employee_id) as TotalSalary
    -- Order By'da employee_id kullanilmazsa ayni tutari iki farkli kisi icin yazar.
From hr.employees;


-- ######################################

-- ORNEK 2
Select
    department_id,
    first_name,
    salary,
    Sum(salary) Over(Partition By department_id Order By department_id, first_name, salary, employee_id) as TotalSalary
    -- order by'da employee_id kullanilmazsa ayni tutari  iki farkli kisi icin yaziyor.
From hr.employees;

-- ORNEK: sales_orders tablosunda shipcountry sutununa gore ilerleyen freight toplamlarini bulunuz.
-- orderid, orderdate, freight, shipcountry, RunFreight
Select
    orderid,
    orderdate,
    shipcountry,
    freight,
    Sum(freight) Over(partition by shipcountry order by shipcountry, freight, orderdate, orderid) as RunFreight
From sales_orders;

-- ORNEK: Ulke toplamlarinin genel toplama oranini bulunuz.
With A as
(
    Select distinct
        shipcountry,
        Sum(freight) Over(partition by shipcountry) as RunFreight,
        Sum(freight) Over() as GenelToplamFreight
    From sales_orders
)
Select
    shipcountry,
    RunFreight,
    GenelToplamFreight,
    RunFreight / GenelToplamFreight * 100 as Oran
From A;

-- ORNEK
-- YONTEM 1
Select
        job_id,
        Sum(Salary) as TotalSalary
From employees
Group By job_id
Order By 1;

-- YONTEM 2
Select Distinct
        job_id,
        Sum(Salary) Over(Partition By job_id) as TotalSalary
From employees
Order By 1;