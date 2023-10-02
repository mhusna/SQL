Select
    department_name,
    Replace(department_name, ' ', '') "BosluklariSil"
From departments;


-- ORNEK: Kac kelimeden olusuyor ?
Select
    department_name,
    Replace(department_name, ' ', '') "BosluklariSil",
    (Length(department_name) - Length(Replace(department_name, ' ', ''))) + 1 KelimeSayisi
From departments;

-- REPLACE
Select
      first_name,
      Job_id,
      Replace(Job_id,'IT','BT') Result_A,
      Replace(Job_id,'IT','BIL') Result_B                
From Employees;

-- TRANSLATE
-- Translate, replace'nin gelismisidir.
-- Translate, harf harf degistirme yaparken, Replace bir butun olarak degistirir.
-- Buyuk - kucuk harf duyarliligi vardir.

-- ORNEK: e harfini x ile degistirir, fakat i'nin karsiligi olmadigi icin birsey yapmayacak.
Select Translate('SQL Veri Yonetimi','ei', 'x') From Dual;

-- ORNEK: e yerine x, i yerine . yazar.
Select Translate('SQL Veri Yonetimi','ei', 'x.') From Dual;

-- ORNEK: Translate ile mesaj sifreleme.
Select
    'SQL Veri Yonetimi' as OriginalMessage,
    Translate
    (
        'SQL Veri Yonetimi',
        'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz',
        'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza'
    ) as CryptedMessage
From Dual;

-- ORNEK: Sifreli mesaji cozmek, sifreleme yontemi biliniyorsa**.
Select
      'TRM%Yfsi%Zpofuini' as CryptedMessage,
      Translate
      (
        'TRM%Yfsi%Zpofuini',
        'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza',
        'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz'
      ) as OriginalMessage
From Dual;

-- LPAD: String ifadeyi verilen uzunluga gore tamamlar ve SOL bastan bosluklari verilen karakter ile tamamlar.
Select Lpad('SQL', 12, '*') From Dual;

-- RPAD: String ifadeyi verilen uzunluga gore tamamlar ve SAG bastan bosluklari verilen karakter ile tamamlar.
Select Rpad('SQL',12, '*') From Dual;

-- ORNEK
Select
      first_name,
      LPad(first_name, 20, '*') LPad_Ornek,
      RPad(first_name, 20, '*') RPad_Ornek
From employees;

-- ORNEK
SELECT 
    REPLACE(RPAD(LPAD('Oracle PL SQL', 18, '*'), 23, '*'), ' ', '*****') AS "Result"
FROM DUAL;

-- ORNEK
SELECT
      LPAD('Oracle PL SQL', 18, '*') AS "ResultA",
      RPAD(LPAD('Oracle PL SQL', 18, '*'),23,'*') AS "ResultB",
      REPLACE(RPAD(LPAD('Oracle PL SQL', 18, '*'),23,'*'),' ', '*****') AS "ResultC"
FROM DUAL;

-- LTRIM
Select LTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ') From Dual;

-- RTRIM
Select RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ') From Dual;

-- ORNEK
Select LTrim(RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    '))
From Dual;

-- TRIM
Select Trim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ') From Dual;


-- CONCAT() veya ||: Concat ikiden fazla parametre almaz.
Select 'SQL' || ' ' || 'Ogreniyorum' From Dual;

Select Concat('SQL','Ogreniyorum') From Dual;

Select Concat(Concat('SQL',' '),'Ogreniyorum') From Dual;

-- TEKIL SONUC FONKSIYONLARI
-- NVL(A, B): A null degil ise A yaz, null ise B yaz. 
-- A ve B'nin tipinin ayni olmasi gerekir yoksa hata verir.
Select
    first_name,
    commission_pct,
    NVL(commission_pct, 0) as SonucA,
    NVL(commission_pct, '9') as SonucB
From employees;

-- NVL2(A,B,C): A null degilse B yazar, null ise C yazar.
-- A'nin tipi ne ise B ve C de ayni tipte olmalidir.
Select
      first_name,
      Commission_pct,
      NVL2(Commission_pct, Commission_pct, 0) as SonucA,
      NVL2(Commission_pct, Commission_pct, '9') as SonucB
From Employees;

-- ORNEK
Select
      first_name,
      Salary,
      Commission_pct,
      1+ commission_pct,
      NVL2(Commission_pct, Salary * (1+ commission_pct), Salary) Result_A
From Employees;

-- NULLIF(A, B): Eger A = B ise null doner, degilse A doner.
Select
      Nullif('Elma','Elma'),
      Nullif('Elma','Armut')
From Dual;

-- ORNEK
Select
      first_name,      
      Salary,
      Salary - NVL(Commission_pct,0) Salary_C,
      To_Char(Salary) || ' = ' || To_Char(Salary - NVL(Commission_pct,0)) || ' esit ise null degilse:' || To_Char(Salary),
      Nullif(Salary, Salary - NVL(Commission_pct,0)) Result_A
From Employees;

-- GREATEST: Icerisine aldigi birden fazla parametre icerisinden en buyugunu doner.
Select
    Greatest(100, 110, 95, 200)
From Dual;

-- ORNEK
Select
    Greatest('Elma', 'Armut', 'Muz', 99)
from Dual;

-- LEAST: Icerisine aldigi birden fazla parametre icerisinden en kucugunu doner.
Select
    Greatest(100, 110, 95, 200)
From Dual;

-- ORNEK
Select
    Least('Elma', 'Armut', 'Muz', 99)
from Dual;

-- DECODE var arada.
Select
      first_name,
      department_id,
      Decode(department_id,
                            10,'Yazýlým',
                            30,'Uretim',
                            50,'Pazarlama',
                            'Diger'
            ) Department
From Employees
Order By 2;


-- UID: Parametre almaz.
-- Her bir kullanici icin unique bir kimlik numarasi atar.
-- Bu numara UID ile ogrenilir.
Select UID From Dual;

-- Hangi user oldugunu gosterir.
Select User From Dual;
Show User;

-- SYS_CONTEXT: Loglama islemi icin gereklidir.
-- Aldigi parametrelere gore sonuc dondurur.

Select SYS_CONTEXT('userenv','Session_User') as UserName From Dual;

Select
      SYS_CONTEXT('USERENV','SESSION_USER') as UserName1,
      SYS_CONTEXT('USERENV','session_user') as UserName2,
      SYS_CONTEXT('userenv','session_user') as UserName3
From Dual;

Select
      SYS_CONTEXT('USERENV','SESSION_USER') as UserName,
      SYS_CONTEXT('USERENV','ISDBA') as ISDBA,           -- DBA yetkisi varmý diye kontrol ediyoruz
      SYS_CONTEXT('USERENV','HOST') as HOST,
      SYS_CONTEXT('USERENV','INSTANCE') as INSTANCE,
      SYS_CONTEXT('USERENV','IP_ADDRESS') as IP_ADRESSES,
      SYS_CONTEXT('USERENV','DB_NAME') as DB_NAME         -- Kurulumda SID olarak XE vermistim
From Dual;

Select
      SYS_CONTEXT('USERENV','SESSION_USER') as UserName,
      SYS_CONTEXT('USERENV','ISDBA') as ISDBA,
      SYS_CONTEXT('USERENV','HOST') as HOST,
      SYS_CONTEXT('USERENV','INSTANCE') as INSTANCE,
      SYS_CONTEXT('USERENV','INSTANCE_NAME"') as INSTANCE_NAME,
      SYS_CONTEXT('USERENV','IP_ADDRESS') as IP_ADRESSES,
      SYS_CONTEXT('USERENV','DB_NAME') as DB_NAME,
      SYS_CONTEXT('USERENV','OS_USER') as OS_USER,
      SYS_CONTEXT('USERENV','SERVICE_NAME') as SERVICE_NAME,
      SYS_CONTEXT('USERENV','SESSION_EDITION_NAME') as SESSION_EDITION_NAME
From Dual;

Select
      SYS_CONTEXT('USERENV','ACTION') as ACTION,
      SYS_CONTEXT('USERENV','CLIENT_INFO') as CLIENT_INFO,
      SYS_CONTEXT('USERENV','CURRENT_SCHEMAID') as CURRENT_SCHEMAID,
      SYS_CONTEXT('USERENV','CURRENT_SCHEMA') as CURRENT_SCHEMA,
      SYS_CONTEXT('USERENV','CURRENT_SQL') as CURRENT_SQL,
      SYS_CONTEXT('USERENV','CURRENT_USER') as CURRENT_USER,
      SYS_CONTEXT('USERENV','DB_DOMAIN') as DB_DOMAIN,
      SYS_CONTEXT('USERENV','GLOBAL_UID') as GLOBAL_UID,
      SYS_CONTEXT('USERENV','LANGUAGE') as LANGUAGE
From Dual;

Select
      SYS_CONTEXT('USERENV','NLS_CALENDAR') as NLS_CALENDAR,
      SYS_CONTEXT('USERENV','NLS_CURRENCY') as NLS_CURRENCY,
      SYS_CONTEXT('USERENV','NLS_DATE_FORMAT') as NLS_DATE_FORMAT,
      SYS_CONTEXT('USERENV','NLS_DATE_LANGUAGE') as NLS_DATE_LANGUAGE,
      SYS_CONTEXT('USERENV','NLS_SORT') as NLS_SORT,
      SYS_CONTEXT('USERENV','NLS_TERRITORY') as NLS_TERRITORY,
      SYS_CONTEXT('USERENV','SERVER_HOST') as SERVER_HOST,
      SYS_CONTEXT('USERENV','SERVICE_NAME') as SERVICE_NAME
From Dual;

select *
from   nls_session_parameters;

select *
from   nls_session_parameters
where  PARAMETER = 'NLS_TERRITORY';

select t.value,
       case 
          when t.value != 'DENMARK' then to_char(sysdate-1, 'd') || ' A'
          else to_char(sysdate, 'd') || ' B'
       end as Sonuc
from   nls_session_parameters t
where  t.parameter = 'NLS_TERRITORY';

-- FMDAY
select 
      to_char (sysdate, 'FmDay', 'nls_date_language=english'),
      case to_char (sysdate, 'FmDay', 'nls_date_language=english')
          when 'Monday' then 1
          when 'Tuesday' then 2
          when 'Wednesday' then 3
          when 'Thursday' then 4
          when 'Friday' then 5
          when 'Saturday' then 6
          when 'sunday' then 7
      end d
  from dual;
  
select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english'),
      case to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english')
          when 'Monday' then 1
          when 'Tuesday' then 2
          when 'Wednesday' then 3
          when 'Thursday' then 4
          when 'Friday' then 5
          when 'Saturday' then 6
          when 'Sunday' then 7
      end d
  from employees;

select 
      first_name, last_name, hire_date,
      to_char (HIRE_DATE, 'FmDay', 'nls_date_language=english') as Gunler,
      to_char (HIRE_DATE, 'FmMonth', 'nls_date_language=english') as Aylar
from employees;

-- ORNEK: Employees tablosunda ayni tarihte ise alinanlari bulunuz.
Select
    To_Char(hire_date, 'YYYY') as Yil,
    To_Char(hire_date, 'MM') as Ay,
    To_Char(hire_date, 'DD') as Gun,
    count(*) as Kac_Kisi_Alindi
From employees
group by To_Char(hire_date, 'YYYY'), To_Char(hire_date, 'MM'), To_Char(hire_date, 'DD')
order by 1, 2, 3 desc;

-- ORNEK: Employees tablosunda haftanin ayni gunleri ise girenleri bulunuz.
With A as
(
    Select
        To_Char(hire_date, 'FmDay') as Gunler
    From employees
)
Select 
    Gunler,
    Count(*) as Sayisi
From A
Group By Gunler;

-- ORNEK
select 
      to_char (sysdate, 'FmDay', 'nls_date_language=turkish'),
      to_char (to_date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish'),
      case to_char (to_date('12-05-2023','DD/MM/YYYY'), 'FmDay', 'nls_date_language=turkish')
          when 'Pazartesi' then 1
          when 'Sal?' then 2
          when 'Çar?amba' then 3
          when 'Per?embe' then 4
          when 'Cuma' then 5
          when 'Cumartesi' then 6
          when 'Pazar' then 7
      end d
  from dual;

-- ORNEK
select 
      to_date('08/05/2023','DD/MM/YYYY') AA,
      to_char (to_date('07-05-2023','DD/MM/YYYY'), 'd') Pazar,
      to_char (to_date('08-05-2023','DD/MM/YYYY'), 'd') Pazartesi,
      to_char (to_date('09-05-2023','DD/MM/YYYY'), 'd') Sali,
      to_char (to_date('10-05-2023','DD/MM/YYYY'), 'd') Çarsamba,
      to_char (to_date('11-05-2023','DD/MM/YYYY'), 'd') Persembe,
      to_char (to_date('12-05-2023','DD/MM/YYYY'), 'd') Cuma,
      to_char (to_date('06-05-2023','DD/MM/YYYY'), 'd') Cumartesi            
  from dual;
  
-- Cmd, Admin modda ac.
-- Gelen ekrana su kodu yaz: sqlplus sys/sys as sysdba;
-- Sonra: Select SYS_CONTEXT('USERENV', 'TERMINAL') as TERMINAL From Dual;

Select SYS_CONTEXT('USERENV', 'TERMINAL') as TERMINAL From Dual;

-- ISTATISTIK FONKSIYONLARI
-- Bu fonksiyonlar hem geleneksel kumeleme  hem de analitik sorgulamada kullaniliyor.

-- SUM
Select sum(salary) From Employees;

-- ORNEK: Job_id'ye gore toplam maaslari bulun.
Select
    job_id,
    sum(salary) as ToplamMaas
From Employees
Group By job_id;

-- ORNEK: Yukaridaki sorgunun en altina genel toplami yazdirin.
-- YONTEM 1
With Sorgu as
(
    Select job_id, sum(salary) as ToplamMaas, '1' as TabloNo
    From Employees
    Group By job_id
    UNION
    Select 'GenelToplam', sum(salary), '2' as TabloNo
    From Employees
)
Select
    *
From Sorgu
Order By TabloNo asc;

-- YONTEM 2
With A as
(
    Select job_id, Sum(Salary) as ToplamMaas, '1' as "TabloNo"
    From Employees
    Group By job_id
),
B as
(
    -- job_id buraya kesin eklenmeli.
  Select 'Genel Toplam' as job_id, Sum(Salary) as ToplamMaas,'2' as "TabloNo"
  From Employees
)
Select job_id, ToplamMaas  From A
union
Select job_id, ToplamMaas From B
Order By ToplamMaas;

-- AVG: Sum gibi calisir, group by yapmazsan genel avg bulur. Max-min de ayni sekilde.
Select Avg(Salary) From Employees;

Select Round(Avg(Salary), 2) From Employees;

-- MAX 
Select Max(Salary) From Employees;

-- MIN
Select Min(Salary) From Employees;

-- COUNT
Select Count(Salary) From Employees;

-- ONEMLI: Count sayma isi yapar ve bunu yaparken tablo icerisindeki null olanlari saymaz.
-- ORNEK: Bu ornekte null olanlari saymaz.
Select * From Sales_Customers Where region != 'WA';

-- NULL KONTROLU
Select * From Sales_CustomersB Where region = '';

Select * From Sales_Customers Where region is Null;

Select * From Sales_Customers Where region is Not Null;

-- STDDEV: Standart Sapma
Select STDDEV(Salary) From Employees;

-- Tum sayinin uzunlugunu doner.
Select Length('3909,579730552481921059198878167256201202') From Dual;

-- VARIANCE: Standart sapmaya gore ortalama
Select VARIANCE(Salary) From Employees;

-- !!!ONEMLI: Sorgularda sutun adlarini degistirmek icin alias kullanilir. Uretilen sutunlar icin kesinlikle Alias kullanmayi unutmayiniz.
-- !!!ONEMLI: Where'den sonra group by kullanilir. Ve group by'a having yapilir.

-- ORNEK
Select
      Sum(Salary),
      Round(Avg(Salary),2) as AVG_,
      Min(Salary),
      Max(Salary),
      Count(Salary),
      Count(*),
      Count(commission_pct),  -- dolu olan komisyonlarýn sayýsýný verir
      Round(STDDEV(Salary),2) STDDEV_,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees;

-- ORNEK: department_id bazinda bulalim.
Select
      Department_id as BolumNo,
      Sum(Salary) as ToplamMaas,
      Round(Avg(Salary),2) as AVG_,
      Min(Salary) as Min_,
      Max(Salary) as Max_,
      Count(Salary) as Sayisi1,
      Count(*) as Sayisi2,
      Count(commission_pct) as Commission,  -- dolu olan komisyonlarin sayisini verir.
      Round(STDDEV(Salary),2) STDDEV_ ,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees
Group By Department_id
Order By 1;

-- ORNEK: 5'ten fazla olanlari getirin.
Select
      Department_id as BolumNo,
      Sum(Salary) as ToplamMaas,
      Round(Avg(Salary),2) as AVG_,
      Min(Salary) as Min_,
      Max(Salary) as Max_,
      Count(Salary) as Sayisi1,
      Count(*) as Sayisi2,
      Count(commission_pct) as Commission,
      Round(STDDEV(Salary),2) STDDEV_ ,
      Round(VARIANCE(Salary),2) VARIANCE_
From Employees
Group By Department_id
Having Count(*) > 5
Order By 1;

-- ANALITIK SORGULAR
-- ORNEK
Select
    first_name,
    employee_id,
    salary,
    sum(salary) over(order by first_name, employee_id) as TotalSalary
From employees;

-- ORNEK: Genel toplami verir.
Select
      first_name || ' ' || last_name as FullName,
     -- employee_id,
      Salary,
      Sum(Salary) Over() as GenelToplam      
From Employees;

-- ORNEK: Calisanin adi, maasi, bolumu, kumulatif toplam.
-- Bolume gore gruplayin, maasa gore siralayin.
Select
    department_id,
    first_name,
    salary,
    Sum(salary) Over(Partition By department_id Order By Salary, employee_id) as TotalSalary
    -- order by'da employee_id kullanilmazsa ayni tutari  iki farkli kisi icin yaziyor.
From employees;

-- ORNEK 2
Select
    department_id,
    first_name,
    salary,
    Sum(salary) Over(Partition By department_id Order By department_id, first_name, salary, employee_id) as TotalSalary
    -- order by'da employee_id kullanilmazsa ayni tutari  iki farkli kisi icin yaziyor.
From employees;

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

-- Tarih Ve Zaman Fonksiyonlari
-- Current_Date     -- Session (Bilgisayarinin)  TimeZone'a gore Tarih ve Saati verir(Yani oturuma gore verecektir)
-- SysDate          -- Database (Veritabaninin) TimeZone'a gore Tarih ve Saati verir
-- SysTimeStamp     -- Zaman Damgasý
                    -- (Efatura, Elektronik imza, Kep,v.s.)
                    -- (tum elektronik islemler izin Zaman Damgasýna ihtiyac vardýr)
-- Tarih Formatlarý
-- Tools > Prefences > Database > NLS altýnda formatlarý gorebiliriz

Select Current_Date, SysDate, localtimestamp
From Dual;

-- Greenwich'e gore +2 saatine gecer.
Alter Session Set Time_Zone = '+2:0';

Select Current_Date, SysDate From Dual;


-- Tarih Formatlari
-- ORNEK
Select
        SysDate,
        To_Char(SysDate,'D') HaftaninKacinciGunu,
        To_Char(SysDate,'DD') AyinKacinciGunu,
        To_Char(SysDate,'DDD') YilinKacinciGunu,
        To_Char(SysDate,'D DD DDD') Result_A,
        To_Char(SysDate,'DAY') GunAdi,
        To_Char(SysDate,'DY') GunAdiKisa,
        To_Char(SysDate,'DD MM YYYY MON') Result_C,
        To_Char(SysDate,'DD MM YYYY MONTH') Result_C2,
        To_Char(SysDate,'DD-MM-YYYY-MONTH') Result_C3,
        To_Char(SysDate,'D') Result_D,
        To_Char(SysDate,'D') Result_E
From Dual;

-- ORNEK
Select
        SysDate,
        To_Char(SysDate,'W') AyinKacinciHaftasi,
        To_Char(SysDate,'WW') YilinKacinciHaftasi,
        To_Char(SysDate,'IW') IsoYilinKacinciHaftasi,
        To_Char(SysDate,'mm') AyNumarasiA,
        To_Char(SysDate,'MM') AyNumarasiB,
        To_Char(SysDate,'MON') AyAdiA,
        To_Char(SysDate,'MONTH') AyAdiB
From Dual;

-- ORNEK
Select
        SysDate,
        To_Char(SysDate,'Y') Yil_Kisa_Y,
        To_Char(SysDate,'YY') Yil_Kisa_YY,
        To_Char(SysDate,'YYY') Yil_Kisa_YYY,
        To_Char(SysDate,'YYYY') Yil_Uzun,
        To_Char(SysDate,'YEAR') Yil_ingilizce ,
        To_Char(SysDate,'RR') Yuzyil
From Dual;

-- ORNEK
Select
        SysDate,
        To_Char(SysDate,'HH') HH_,
        To_Char(SysDate,'HH12') HH12_,
        To_Char(SysDate,'HH24') HH24_
From Dual;

-- ORNEK
Select
        LocalTimeStamp,
        SysDate,
        To_Char(SysDate,'HH24') HH_,
        To_Char(SysDate,'MI') MI_,
        To_Char(SysDate,'SS') SS_,
        To_Char(SysDate,'SSSSS') SSSSS_,
        To_Char(LocalTimeStamp,'FF') FF_
From Dual;

-- ORNEK
Select
        SysDate,
        To_Char(SysDate,'Q') Q_,
        To_Char(SysDate,'MM') MM_,
        To_Char(SysDate,'MON') MON_,
        To_Char(SysDate,'MONTH') MONTH_,
        To_Char(SysDate,'RM') RM_         -- RM roma rakami ile kacinci ay oldugunu verir
From Dual;

-- ORNEK: Yillarin ceyreklere gore freight topamlarinin bulunmasi.
-- Table: sales_orders.
-- YONTEM 1
Select
    To_Char(orderdate, 'YYYY') as Yil,
    To_Char(orderdate, 'Q') as Ceyrek,
    sum(freight) as Toplam
From sales_orders
Group By To_Char(orderdate, 'YYYY'), To_Char(orderdate, 'Q')
Order By 1, 2;

-- YONTEM 2
Select Distinct
    To_Char(orderdate, 'YYYY') as Yil,
    To_Char(orderdate, 'Q') as Ceyrek,
    sum(freight) Over(Partition by To_Char(orderdate, 'YYYY'), To_Char(orderdate, 'Q')) as TotalFreigth
From sales_orders
Order By 1, 2;

-- ORNEK: Yillarin ceyreklere ve aylara gore freight topamlarinin bulunmasi.
-- YONTEM 1
Select
    To_Char(orderdate, 'YYYY') as Yil,
    To_Char(orderdate, 'Q') as Ceyrek,
    To_Char(orderdate, 'MM') as Ay,
    sum(freight) as Toplam
From sales_orders
Group By To_Char(orderdate, 'YYYY'), To_Char(orderdate, 'Q'), To_Char(orderdate, 'MM')
Order By 1, 2, 3;

-- YONTEM 2
Select Distinct
    To_Char(orderdate, 'YYYY') as Yil,
    To_Char(orderdate, 'Q') as Ceyrek,
    To_Char(orderdate, 'MONTH') as Ay,
    sum(freight) Over(Partition by To_Char(orderdate, 'YYYY'), To_Char(orderdate, 'Q'), To_Char(orderdate, 'MM')) as TotalFreigth
From sales_orders
Order By 1, 2, 3;

-- Detayli zaman bilgisi.
Select
      To_Char(Current_Date,'DD/MM/YYYY HH24:MI:SS') Current_Date_,
      To_Char(SysDate,'DD/MM/YYYY HH24:MI:SS') SysDate_
From Dual;

-- Zaman ekleme.
SELECT SYSDATE AS SYSDATE_,
       SYSDATE + 1 AS plus_1_day,
       SYSDATE + 1/24 AS plus_1_hours,
       SYSDATE + 1/24/60 AS plus_1_minutes,
       SYSDATE + 1/24/60/60 AS plus_1_seconds
FROM dual;

-- ADD_MONTHS(date_expression, month)
-- Ay ekleme
SELECT
  ADD_MONTHS( DATE '2016-02-29', 1 )
FROM dual;

-- Ay cikarma
SELECT
  ADD_MONTHS( DATE '2016-03-31', -1 )
FROM dual; 

-- LAST_DAY: Ayin son gununu bulur.
SELECT
  LAST_DAY( ADD_MONTHS(SYSDATE , - 1 ) )
FROM dual;

-- TRUNC: Ayin ilk gununu bulur
Select Trunc(sysdate,'MM') From Dual;

-- ORNEK
SELECT
     SYSDATE,
     ADD_MONTHS(SYSDATE, 1) as Sonuc1,
     LAST_DAY(ADD_MONTHS(SYSDATE, 1)) as Sonuc2,
     SUBStr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)),1,5) as Sonuc3,
     SUBStr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)),1,10) as Sonuc4,
     To_Date(SUBStr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)),1,10),'DD-MM-YYYY') Tarih
FROM DUAL;

-- Ay eklemenin bir baska yolu.
Select SYSDATE + interval '8' Month From Dual;

-- Gun, Ay, Yýl, Saat, Dakika,Saniye ekleme iþlemleri
-- Syntax
-- Tarih + interval 'Eklenecek sayi' Eklemeturu(DAY,MONTH,YEAR,HOUR,MINUTE,SECOND)
Select sysdate + interval  '1' DAY From Dual;
Select sysdate + interval  '1' MONTH From Dual;
Select sysdate + interval  '1' YEAR From Dual;

-- ORNEK
Select TO_CHAR(sysdate + interval  '1' HOUR,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

-- ORNEK
Select TO_CHAR(sysdate + interval  '10' MINUTE,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

-- ORNEK
Select
      TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI.SS') AS RESULTA,
      TO_CHAR(sysdate + interval  '30' SECOND,'DD/MM/YYYY HH24:MI.SS') AS RESULTB      
From Dual;

-- ORNEK
Select sysdate + interval  '-1' DAY From Dual;
Select sysdate + interval  '-1' MONTH From Dual;
Select sysdate + interval  '-1' YEAR From Dual;

-- ORNEK
Select TO_CHAR(sysdate + interval  '-1' HOUR,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

-- ORNEK
Select TO_CHAR(sysdate + interval  '-10' MINUTE,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

-- ORNEK
Select
      TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI.SS') AS RESULTA,
      TO_CHAR(sysdate + interval  '-30' SECOND,'DD/MM/YYYY HH24:MI.SS') AS RESULTB      
From Dual;

-- ORNEK
Select sysdate + interval  '1' YEAR From Dual;

-- ORNEK: sales_orders tablosundan shippeddate alani siparisin sevk edildigi tarihi gostermektedir.
-- Sevk edilmemis ise null degere sahiptir.
-- Sevk edilen ve bekleyen siparislerin sayisini bulunuz.
With Sonuc as
(
    Select
        shippeddate,
        Case
            When shippeddate is not null Then 'Sevk Edildi'
            Else 'Bekleyen'
        End as SiparisDurumu
    From Sales_Orders
)
Select
    SiparisDurumu,
    Count(*) as Sayi
From Sonuc
Group By SiparisDurumu;

-- Derived table yontemi
Select
    SiparisDurumu,
    Count(*) as Sayi
From 
(
    Select
        shippeddate,
        Case
            When shippeddate is not null Then 'Sevk Edildi'
            Else 'Bekleyen'
        End as SiparisDurumu
    From Sales_Orders
) A
Group By SiparisDurumu;

--
With Sonuc as
(
    Select
        shipcountry as Ulke,
        shippeddate,
        Case
            When shippeddate is not null Then 'Sevk Edildi'
            Else 'Bekleyen'
        End as SiparisDurumu
    From Sales_Orders
)
Select
    Ulke,
    SiparisDurumu,
    Count(*) as SiparisSayisi
From Sonuc
Group By Ulke, SiparisDurumu
Order By 1, 2 desc;