-- String Fonksiyonlar

-- Lower
-- Upper
-- initcap
-- Length
-- Substr(string,m,n)
-- instr(string,?)
-- Replace(string, old_string, new_string)
-- Translate(string, old_character(s), new_character(s))
-- Rpad
-- Lpad
-- Ltrim
-- Rtrim
-- Trim
-- Concat (veya ||)

-- simdi bunlarý inceleyelim

-- Lower: Aldigi parametreyi kucuk yapar.

Select Lower('Ali TOPACIK') From Dual;

Select
    first_name,
    Lower(first_name)
From Employees;

--

SELECT LOWER(email) || '@institutedomain.com' as "Email Address", hire_date
FROM employees
WHERE salary > 9000 AND
      (commission_pct = 0 OR commission_pct IS NULL) AND
      hire_date >= '01-01-2002' AND
      hire_date <= '31-03-2003';
      
-- Upper

Select Upper('Ali TOPACIK') From Dual;

Select
    first_name,
    Upper(first_name)
From Employees;

-- Initcap: Her kelimenin ilk harfini buyuk harfe cevirir.
Select initcap('Merhaba arkadaslar, nasilsiniz') From Dual;

-- ORNEK: Departments tablosundaki her bir departman adini
-- buyuk harfe cevirelim.
Select 
    lower(department_name) as KucukDepartman,
    initcap(department_name) as BuyukDepartman 
From Departments;

--------------------------------------------------------
-- Length: Uzunluk Bulur
-- ORNEK: Departments tablosundaki her bir departman adinin
-- uzunlugunu bulalim.
Select
    department_name,
    Length(department_name)as Uzunluk
From Departments;

--------------------------------------------------------
-- instr(string, ?): string bir ifadede ? yazan karakteri arar.
-- instr()

Select 
    instr('SQL Veri Sorgulama Ve Raporlama Ogreniyorum', 'lama') Result_A,
    instr('SQL Veri Sorgulama Ve Raporlama Ogreniyorum', 'lama', 1, 1) S_1denBasla_birinci,
    instr('SQL Veri Sorgulama Ve Raporlama Ogreniyorum', 'lama', 1, 2) S_1denBasla_ikinci
From Dual;

--------------------------------------------------------
-- Substr: Icerisine verilen string ifadede sundan basla su kadar
-- al demek.

Select 
    Substr('oracle.egitim@gmail.com', 14, 1) as Sonuc
From Dual;

Select 
    Substr('oracle.egitim@gmail.com', 14+1, 5) as Sonuc1,
    Substr('oracle.egitim@gmail.com', 15, 5) as Sonuc2,
    instr('oracle.egitim@gmail.com', '@') as Pozisyon
From Dual;

--------------------------------------------------------

Select 
    instr('oracle.egitim@gmail.com', '@') as Pozisyon,
    Substr('oracle.egitim@gmail.com', instr('oracle.egitim@gmail.com', '@')+1, 5) as Sonuc
From Dual;

--------------------------------------------------------

Select 
    length('oracle.egitim@gmail.com') as uzunluk,
    Substr('oracle.egitim@gmail.com', 15, length('oracle.egitim@gmail.com')) as Sonuc
From Dual;

--------------------------------------------------------
-- Usttekinin dinamik hali
Select 
    length('oracle.egitim@gmail.com') as uzunluk,
    Substr('oracle.egitim@gmail.com', instr('oracle.egitim@gmail.com', '@'), length('oracle.egitim@gmail.com')) as Sonuc
From Dual;

--------------------------------------------------------
Select 
    length('oracle.egitim@gmail.com') as uzunluk,
    instr('oracle.egitim@gmail.com', '@') as pozisyon,
    Substr('oracle.egitim@gmail.com', instr('oracle.egitim@gmail.com', '@') + 1, length('oracle.egitim@gmail.com') - instr('oracle.egitim@gmail.com', '@')) as Sonuc
From Dual;

--------------------------------------------------------
-- CTE versiyonu

With A as
(
    Select 
        length('oracle.egitim@gmail.com') as uzunluk,
        instr('oracle.egitim@gmail.com', '@') as pozisyon
    From Dual
)
Select 
    uzunluk,
    pozisyon,
    Substr('oracle.egitim@gmail.com', pozisyon + 1, uzunluk - pozisyon) as Sonuc
From A;

--------------------------------------------------------
-- Departments Tablosunda department_name'leri ikinci kelimeden
-- itibaren olanlari bulunuz.

-- CTE icerisine department_name eklemeyi unutursan
-- asagida cagiramazsin.
With A as
(
    Select
        department_name,
        length(DEPARTMENT_NAME) as uzunluk,
        instr(DEPARTMENT_NAME, ' ') as pozisyon
    From departments
)
Select
    uzunluk,
    pozisyon,
    Substr(DEPARTMENT_NAME, pozisyon + 1, uzunluk - pozisyon) as Sonuc
From A
Where pozisyon <> 0;

--------------------------------------------------------

Select
    department_name,
    length(department_name) as uzunluk,
    instr(department_name, ' ') as pozisyon,
    Substr(department_name, instr(department_name, ' ') + 1, length(department_name) - instr(department_name, ' ')) as Sonuc
From departments
Where instr(department_name, ' ') <> 0 ;

--------------------------------------------------------
-- Ikinci kelimeden sonrasi gelsin
-- Onemli Ornek INCELE !!!
Select
      Department_Name,
      instr(Department_Name,' ') Konum_1,
      instr(Department_Name,' ',instr(Department_Name,' ')+1) Konum_2,
      Substr(Department_Name,instr(Department_Name,' ') + 1, 100) Result_A,
      Substr(Department_Name,instr(Department_Name,' ',instr(Department_Name,' ')+1) + 1, 100) Result_B
From Departments
Where instr(Department_Name,' ',instr(Department_Name,' ')+1) > instr(Department_Name,' ');

--------------------------------------------------------
-- Replace(string,

Select 
    Replace('SQL Veri Yonetimi, Veri Analizi', 'Veri', 'Data')
From Dual;

--------------------------------------------------------
Select 
    Replace('SQL Veri Yonetimi, Veri Analizi', 'veri', 'Data')
From Dual;

--------------------------------------------------------
Select
    first_name,
    Replace(first_name, 'e', '') ResultA
From Employees;

-------------------------------------------------------
-- first_name icerisinde gecen e'lerin sayisini bulun.
Select
    first_name,
    Lower(first_name) as isimufak,
    Replace(Lower(first_name), 'e', '') ResultA,
    (Length(first_name) - Length(Replace(Lower(first_name), 'e', ''))) e_Sayisi
From Employees;

-------------------------------------------------------
-- CTE versiyonu

With A as
(
    Select
        first_name,
        Lower(first_name) as isimufak,
        Length(first_name) as Uzunluk,
        Replace(Lower(first_name), 'e', '') as isim_E,
        Length(Replace(Lower(first_name),'e','')) as uzunlukE
    From Employees
)
Select
       first_name,
       Uzunluk - uzunlukE as E_lerinSayisi
From A;

-------------------------------------------------------
-- Departments tablosundaki department_name kac keliemden
-- olusuyor.

Select 
    department_name,
    Replace(department_name, ' ', '') as bosluksuz,
    (Length(department_name) - Length(Replace(department_name, ' ', ''))) + 1 as KacKelime
From departments;

-------------------------------------------------------
With A as
(
    Select
        department_name,
        Replace(department_name, ' ', '') as bosluksuz,
        Length(Replace(department_name, ' ', '')) as bosluksuzUzunluk,
        Length(department_name) as boslukluUzunluk
    From departments
)
Select 
    department_name,
    (boslukluUzunluk - bosluksuzUzunluk) + 1 as KacKelime
From A;

--******************************************
-- Translate(string, old_character(s), new_character(s))
-- Select Translate('SQL Veri Yonetimi','ei', 'x.') From Dual;
-- burada e harfini x ile i harfini ise . ile replace eder
-- Replace gibi calisir daha gelismisidir
--******************************************

Select Translate('SQL Veri Yonetimi','e', 'x') From Dual;

Select Translate('SQL Veri Yonetimi','ei', 'x') From Dual;
Select Translate('SQL Veri Yonetimi','ei', 'x.') From Dual;

Select Translate('Super bulus ile super sonuc','upe', 'x') From Dual;

-- Translate, Replace ile bir farki harf harf yapiyo olmasi.
Select Translate('SQL Veri Yonetimi, Veri Analizi','Veri', 'Data')
From Dual;

Select Replace('SQL Veri ve Yonetimi','Veri', 'Data') From Dual;

-------------------------------------------------------
-- Translate ile bir mesaji sifreleyelim ve geri cozelim
-- Algoritma olarak sunu kullanalim
-- Her harf kendinden sonra gelen harf ile degissin

Select
      'SQL Veri Yonetimi' Orjinal_Mesaj,
      Translate('SQL Veri Yonetimi',
      'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz',
      'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza') Sifreli_Mesaj
From Dual;

Select
    'TRM%Yfsi%Zpofuini' as SifreliMesaj,
    Translate('TRM%Yfsi%Zpofuini', 
              'BCDEFGHIJKLMNOPQRSTUVYZA%bcdefghýjklmnopqrstuvyza', 
              'ABCDEFGHIJKLMNOPQRSTUVYZ abcdefghýjklmnopqrstuvyz') as OrjinalMesaj
From Dual;

--******************************************
-- Lpad
--******************************************
-- 12 birimlik bir string olusturuyor ve sonuna
-- SQL ekliyor.
Select Lpad('SQL',12, '*') From Dual;

-------------------------------------------------------
Select 
    first_name,
    LPad(first_name, 20, '*') as LPAD_ORNEK,    
    RPad(first_name, 20, '*') as RPAD_ORNEK
From Employees;

-------------------------------------------------------

Select 
    first_name,
    Lpad(first_name, '15', '*-') as lpad_fname,
    Rpad(first_name, '15', '*-') as rpad_fname
From Employees;

-------------------------------------------------------
Select Replace(RPAD(LPAD('Oracle PL SQL', 18, '*'),23,'*'),' ', '*****') as "Result"
From Dual;

-------------------------------------------------------
-- Ltrim

Select Ltrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;

-- Rtrim
Select RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;

-- Once ltrim sonra rtrim
Select LTrim(RTrim('  SQL   Veri   Yonetimi ve Veri Sorgulama    '))
From Dual;

-- Trim = LTRIM + RTRIM
Select Trim('  SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;

--*SQL   Veri   Yonetimi ve Veri Sorgulama*

Select Trim(' ' From  'SQL   Veri   Yonetimi ve Veri Sorgulama    ')
From Dual;

-- Concat (veya ||)
-- Concat sadece 2 adet parametre alabilir.
-- Concat hem fonksiyon hem de || seklinde kullanilabilir.

Select 'SQL' || '-' || 'Ogreniyorum' from dual;

Select Concat(Concat('SQL', ' '), 'Ogreniyorum') from dual;

-------------------------------------------------------
Select
    first_name,
    job_id
From employees;

-------------------------------------------------------
Select Concat(Concat(first_name, ' is a '), job_id) from employees;

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
-- Tekli Sonuc Fonksiyonlari
-- Sayisal fonksiyonlarda return degeri sayisal
-- Karakter fonksiyonlarda return degeri karakter


-- NVL --> null value kontrolu yapar.
-- NVL(A,B) -- A null degilse A doner, A null ise B doner.

Select 
    first_name,
    Commission_pct,
    NVL(Commission_pct, 0) as SonucA,
    NVL(Commission_pct, '9') as SonucB
    -- NVL(Commission_pct, 'Komisyon')
    -- Komisyon yazarsak hata verir cunku Commission_pct sayisal.
From Employees;

Select 
    region,
    NVL(region, 'Kontrol')
    -- NVL(region, 0)
    -- 0 yazarsak hata vermez ama mantik olarak dogru degildir.
    -- Sol taraftakinin tipi ne ise sag tarafta onu yazmak gerek.
From hr_employees;

-- NVL2(A, B, C): A null ise C yazar, degilse B yazar.
Select
    first_name,
    Commission_pct,
    NVL2(Commission_pct, Commission_pct, 0) as SonucA,
    NVL2(Commission_pct, Commission_pct, '9') as SonucB
From Employees;

Select 
    first_name,
    Commission_pct,
    NVL2(Commission_pct, Salary, 0) as SonucA
From Employees;

Select 
    first_name,
    Salary,
    Commission_pct,
    1 + Commission_pct,
    NVL2(Commission_pct, Salary * (1 + Commission_pct), Salary) Result_A
From Employees;

Select
    region,
    NVL2(region, region, 'Kontrol')
From hr_employees;

-- NULLIF(A,B)
-- Eger A = B ise null doner
-- Eger A <> B ise A'yi doner

Select
    Nullif('Elma', 'Elma'),
    Nullif('Elma', 'Armut')
From Dual;

Select
    Nullif(9999, 9999),
    Nullif(9999, 1234)
From Dual;

Select
    first_name,
    Commission_pct,
    NVL(Commission_pct, 0),
    Salary,
    Salary - NVL(Commission_pct, 0) Salary_C,
    Nullif(Salary, Salary - NVL(Commission_pct, 0)) Result_A
From Employees;

-- GREATEST parametre olarak verilenlerin hangisi buyukse ona dondurur

Select
    Greatest(10, 20, 25, 12, 56)
From dual;

Select
    Greatest('Elma', 'Armut', 'Ananas', 'Zeytin', 'ananas') as Sonuc1,
    Greatest('Patates', 'Domates') as Sonuc2
From Dual;

-- LEAST: Aldigi parametrelerin en kucugunu verir
Select
    Least(10, 20, 25, 12, 56)
From dual;

Select
    Least('Elma', 'Armut', 'Ananas', 'Zeytin', 'ananas') as Sonuc1,
    Least('Patates', 'Domates') as Sonuc2
From Dual;

-- DECODE

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

-- CASE

Select
      first_name,
      department_id,
      Case department_id
           When 10 Then 'Yazýlým'
           When 30 Then 'Uretim'
           When 50 Then 'Pazarlama'
           Else 'Diger'
      End Department
From Employees
Order By 2;

-- UID: Parametre almaz
-- Her bir kullanici icin unique bir kimlik numarasi atanir
-- Bu numara UID ile ogrenilir.

Select UID From Dual;

-- Kullanici adini ogrenmek icin
Select User From Dual;

-- Ziraatte bu calismiyormus
Show User;

-- SYS_CONTEXT: Aldigi parametrelere gore sonuc doner.

Select 
    SYS_CONTEXT('USERENV', 'SESSION_USER') as UserName,
    SYS_CONTEXT('USERENV', 'ISDBA') as ISDBA, --DBA yetkisi varmi diye kontrol ediliyor.
    SYS_CONTEXT('USERENV', 'HOST') as HOST,
    SYS_CONTEXT('USERENV', 'INSTANCE') as INSTANCE,
    SYS_CONTEXT('USERENV', 'IP_ADDRESS') as IP_ADRESSES,
    SYS_CONTEXT('USERENV', 'DB_NAME') as DB_NAME --Kurulumda SID olarak XE verdik
From Dual;


With A as
(
    Select
        hire_date,
        to_char(hire_date, 'FmDay', 'nls_date_language=english') as Gunler
    From employees
)
Select 
    Gunler,
    Count(*) as Sayi
From A
Group By Gunler;


Select
    to_date('08/05/2023', 'DD/MM/YYYY') AA,
    to_char (to_date('08/05/2023', 'DD/MM/YYYY'), 'd') Pazartesi,
    to_char (to_date('09/05/2023', 'DD/MM/YYYY'), 'd') Sal?,
    to_char (to_date('10/05/2023', 'DD/MM/YYYY'), 'd') Carsamba,
    to_char (to_date('11/05/2023', 'DD/MM/YYYY'), 'd') Persembe,
    to_char (to_date('12/05/2023', 'DD/MM/YYYY'), 'd') Cuma,
    to_char (to_date('13/05/2023', 'DD/MM/YYYY'), 'd') Cumartesi,
    to_char (to_date('14/05/2023', 'DD/MM/YYYY'), 'd') Pazar
From Employees;

-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------

Select Sum(Salary) From Employees;

-- Her bir job_id'ye gore salary toplamini bulun.
-- En alta da Genel Toplami yazdir.

With A as 
(
    Select 
        job_id,
        sum(salary) as ToplamMaas,
        1 as TabloNo
    From Employees
    group by job_id
    Union
    Select
        'Genel Toplam',
        sum(salary),
        2 as TabloNo
    From Employees
)
Select 
    job_id,
    ToplamMaas
From A
Order By TabloNo;

-------------------------------------------------------
Select 
    job_id,
    sum(salary) as ToplamMaas
From Employees
Group by job_id
Union
Select
    'Genel Toplam',
    sum(salary) as ToplamMaas
From Employees
Order By ToplamMaas;

-------------------------------------------------------
-- null kontrolu nasil yapilir
Select * 
From hr_employees
Where region is Null;

-------------------------------------------------------
Create Table Sales_CustomersB as
Select *
From Sales_Customers;

Select *
From sales_customersb
Where custid in(39, 40);

Update Sales_Customersb
Set region = ''
Where custid in (39, 40);

-------------------------------------------------------
Select
    Sum(Salary),
    Round(Avg(Salary), 2) as AVG_,
    Min(Salary),
    Max(Salary),
    Count(Salary),
    Count(*), -- Null olanlari da sayar.
    Count(commission_pct), -- Dolu olan komisyonlarin sayisini verir.
    Round(STDDEV(Salary), 2) STDDEV_,
    Round(VARIANCE(Salary), 2) VARIANCE_
From Employees;

-------------------------------------------------------
Select
    first_name,
    Salary,
    Sum(Salary) Over(Order By first_name) as TotalSalary
From Employees;

Select
    first_name,
    -- employee_id,
    Salary,
    Sum(Salary) Over(Order By first_name, employee_id) as TotalSalary
From Employees;

Select
    job_id,
    -- employee_id,
    Salary,
    Sum(Salary) Over(Order By job_id, employee_id) as TotalSalary
From Employees;

-------------------------------------------------------
-- Her yeni department_id'de kendi toplamini yapar.
-- Order By ile rastgele gelmesini onluyoruz.
Select
    department_id,
    first_name,
    Salary,
    Sum(Salary) Over(Partition By department_id Order By Salary, employee_id) as TotalSalary
From Employees;

-------------------------------------------------------
-- Sales_orders tablosunda shipcountry sutununa gore
-- ilerleyen freight toplamlarini bulunuz ve run freight gelsin
-- orderid, orderdate, freight, shipcountry

Select
    orderid,
    orderdate,
    freight, 
    shipcountry,
    Sum(Freight) Over(Partition By shipcountry Order By shipcountry, orderdate, orderid) as RunFreight
From sales_orders;
    
-------------------------------------------------------
Select Distinct
    shipcountry,
    Sum(Freight) Over(Partition By shipcountry Order By shipcountry, orderid) as ToplamFreight,
    Sum(Freight) Over() as GenelToplamFright
From sales_orders
Order By 1;

-------------------------------------------------------
-- Yukaridaki sorguda herbir shipcountry'nin ToplamFreight degerinin
-- GenelToplamFreight icerisindeki oraninin bulunuz
Select Distinct
    shipcountry,
    Sum(Freight) Over(Partition By shipcountry Order By shipcountry) as ToplamFreight,
    Sum(Freight) Over() as GenelToplamFright,
    Sum(Freight) Over(Partition By shipcountry Order By shipcountry) / Sum(Freight) Over()* 100 as Oran
From sales_orders
Order By 1;

-- Yukaridaki kullanim dogru ama CTE kullanmak daha iyi
With A as
(
    Select distinct
        shipcountry,
        Sum(Freight) Over(Partition By shipcountry Order By shipcountry) as ToplamFreight,
        Sum(Freight) Over() as GenelToplamFreight
    From sales_orders
)
Select
    shipcountry,
    ToplamFreight,
    GenelToplamFreight,
    ToplamFreight / GenelToplamFreight * 100 as Oran
From A;

-- Derived Table ile
Select
    shipcountry,
    ToplamFreight,
    GenelToplamFreight,
    ToplamFreight / GenelToplamFreight * 100 as Oran
From
(
    Select distinct
        shipcountry,
        Sum(Freight) Over(Partition By shipcountry Order By shipcountry) as ToplamFreight,
        Sum(Freight) Over() as GenelToplamFreight
    From sales_orders
) A
Order By 1;


Select distinct
        shipcountry,
        AVG(Freight) Over(Partition By shipcountry) as AvgFreight,
        Count(Freight) Over(Partition By shipcountry) as CountFreight,
        Min(Freight) Over(Partition By shipcountry) as MinFreight,
        Max(Freight) Over(Partition By shipcountry) as MaxFreight
From sales_orders;

-------------------------------------------------------
Select
    department_id,
    first_name,
    Salary,
    Sum(Salary) Over(Partition By department_id Order By department_id) as AvgSalary
From Employees;

--- OVER TEKRAR
-- Employees tablosunda her bir job_id icin TotalSalary bulunuz.
Select
    job_id,
    to_char(hire_date, 'YYYY') as Yillar,
    sum(salary) as TotalSalary
from employees
group by job_id, to_char(hire_date, 'YYYY')
order by 1;

-- Bunu window function ile yapalim.
Select distinct
    job_id,
    to_char(hire_date, 'YYYY') as Yillar,
    Sum(Salary) Over(Partition By job_id, to_char(hire_date, 'YYYY')) as TotalSalary
From Employees
Order By 1;

-------------------------------------------------------
--******************************************************
-- Tarih ve Zaman Fonksiyonlarý
--******************************************************

-- Current_Date     -- Session  TimeZone'a gore Tarih ve Saati verir(Yani oturuma gore verecektir)
-- SysDate          -- Database TimeZone'a gore Tarih ve Saati verir
-- SysTimeStamp     -- Zaman Damgasý
                    -- (Efatura, Elektronik imza, Kep,v.s.)
                    -- (tum elektronik islemler izin Zaman Damgasýna ihtiyac vardýr)
-- Tarih Formatlarý
-- Tools > Prefences > Database > NLS altýnda formatlarý gorebiliriz

--******************************************************
-- CurrentDate, SysDate, localtimestamp
--******************************************************
Select Current_Date, SysDate, localtimestamp
From Dual;

Select SessionTimeZone From Dual;

Alter Session Set Time_Zone = '+3:0';

Select Current_Date, SysDate
From Dual;

Alter Session Set Time_Zone = '-14:0';

Select Current_Date, SysDate
From Dual;

Alter Session Set Time_Zone = '+14:0';

Select Current_Date, SysDate
From Dual;

--******************************************************
-- SysTimeStamp
--******************************************************

Select SysTimeStamp
From Dual;

--******************************************************
-- Tarih Formatlari
--******************************************************

Select
        SysDate,
        To_Char(SysDate,'D') HaftaninKacinciGunu,
        To_Char(SysDate,'DD') AyinKacinciGunu,
        To_Char(SysDate,'DDD') YilinKacinciGunu,
        To_Char(SysDate,'D DD DDD') Result_A,
        To_Char(SysDate,'DAY') GunAdi,
        To_Char(SysDate,'DY') GunAdiKisa,
        To_Char(SysDate,'DD MM YYYY MON') Result_C,
        To_Char(SysDate,'D') Result_D,
        To_Char(SysDate,'D') Result_E
From Dual;

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


Select
        SysDate,
        To_Char(SysDate,'Y') Yil_Kisa_Y,
        To_Char(SysDate,'YY') Yil_Kisa_YY,
        To_Char(SysDate,'YYY') Yil_Kisa_YYY,
        To_Char(SysDate,'YYYY') Yil_Uzun,
        To_Char(SysDate,'YEAR') Yil_ingilizce ,
        To_Char(SysDate,'RR') Yuzyil
From Dual;

Select
        SysDate,
        To_Char(SysDate,'HH') HH_,
        To_Char(SysDate,'HH12') HH12_,
        To_Char(SysDate,'HH24') HH24_
From Dual;

Select
        LocalTimeStamp,
        SysDate,
        To_Char(SysDate,'MI') MI_,
        To_Char(SysDate,'SS') SS_,
        To_Char(SysDate,'SSSSS') SSSSS_,
        To_Char(LocalTimeStamp,'FF') FF_
From Dual;

Select
        SysDate,
        To_Char(SysDate,'Q') Q_,
        To_Char(SysDate,'MM') MM_,
        To_Char(SysDate,'MON') MON_,
        To_Char(SysDate,'MONTH') MONTH_,
        To_Char(SysDate,'RM') RM_         -- RM roma rakamý ile kacýncý ay oldugunu verir
From Dual;

Select
        SysDate,
        To_Char(SysDate,'J') J_ -- Milattan once 1 Ocak 4721 tarihinden itibaren kac gun gectigini verir
From Dual;

Select
      To_Char(Current_Date,'DD/MM/YYYY HH24:MI:SS') Current_Date_,
      To_Char(SysDate,'DD/MM/YYYY HH24:MI:SS') SysDate_
From Dual;

/

Alter Session Set Time_Zone = '+2:0';

/
alter session set nls_language = german;
/
select to_char(sysdate, 'd') from dual;
/
select to_char(sysdate, 'd', 'NLS_DATE_LANGUAGE = danish') from dual;
/

alter session set nls_territory = 'DENMARK';
/
select *
from   nls_session_parameters t
where  t.parameter = 'NLS_TERRITORY';
/
select to_char(sysdate, 'd') from dual;

/

alter session set nls_territory = TURKEY;

/
select *
from   nls_session_parameters t
where  t.parameter = 'NLS_TERRITORY';
/
Select
      To_Char(Current_Date,'DD/MM/YYYY HH24:MI:SS') Current_Date_,
      To_Char(SysDate,'DD/MM/YYYY HH24:MI:SS') SysDate_
From Dual;


Select Current_Date, SysDate
From Dual;


SELECT SYSDATE AS current_date,
       SYSDATE + 1 AS plus_1_day,      -- 1 gun ekler
       SYSDATE + 1/24 AS plus_1_hours, -- 1 saat ekler
       SYSDATE + 1/24/60 AS plus_1_minutes, -- 1 dakika ekler
       SYSDATE + 1/24/60/60 AS plus_1_seconds -- 1 saniye ekler
FROM   dual;

-- ADD_MONTHS
-- ADD_MONTHS(date_expression, month)
-- Verdigin tarihe 1 ay ekliyor.
SELECT
  ADD_MONTHS( DATE '2016-02-29', 1 )
FROM
  dual;

--
SELECT
  ADD_MONTHS( DATE '2016-02-24', 1 )
FROM
  dual;

--

SELECT
  ADD_MONTHS( DATE '2016-03-31', -1 )
FROM
  dual; 

--

SELECT
  LAST_DAY( ADD_MONTHS(SYSDATE , - 1 ) )
FROM
  dual;

--

Select Trunc(sysdate,'MM') From Dual; -- Ayýn ilk gununu bulur

--

Select ADD_MONTHS( SYSDATE, +6 ) From Dual;
Select ADD_MONTHS( SYSDATE, -6 ) From Dual;
Select ADD_MONTHS( SYSDATE, 8 ) From Dual;

--ORACLE SQL EXAMPLE
Select
    SYSDATE,
    ADD_MONTHS(SYSDATE, 1) as Sonuc1,
    LAST_DAY(ADD_MONTHS(SYSDATE, 1)) as Sonuc2,
    Substr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)), 1, 5) As Sonuc3,
    Substr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)), 1, 10) As Sonuc4,
    To_Date(Substr(LAST_DAY(ADD_MONTHS(SYSDATE, -1)), 1, 10), 'DD-MM-YYYY') Tarih
From dual;

--


-- ADD_MONTHS


Select SYSDATE + interval '8' Month From Dual;

-- Gun, Ay, Yýl, Saat, Dakika,Saniye ekleme iþlemleri
-- Syntax
-- Tarih + interval 'Eklenecek sayý’ Eklemeturu(DAY,MONTH,YEAR,HOUR,MINUTE,SECOND)

Select sysdate + interval  '1' DAY From Dual;
Select sysdate + interval  '1' MONTH From Dual;
Select sysdate + interval  '1' YEAR From Dual;

Select TO_CHAR(sysdate + interval  '1' HOUR,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select TO_CHAR(sysdate + interval  '10' MINUTE,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select
      TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI.SS') AS RESULTA,
      TO_CHAR(sysdate + interval  '30' SECOND,'DD/MM/YYYY HH24:MI.SS') AS RESULTB      
From Dual;

--

Select sysdate + interval  '-1' DAY From Dual;
Select sysdate + interval  '-1' MONTH From Dual;
Select sysdate + interval  '-1' YEAR From Dual;

Select TO_CHAR(sysdate + interval  '-1' HOUR,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select TO_CHAR(sysdate + interval  '-10' MINUTE,'DD/MM/YYYY HH24:MI.SS') AS RESULTA
From Dual;

Select
      TO_CHAR(sysdate,'DD/MM/YYYY HH24:MI.SS') AS RESULTA,
      TO_CHAR(sysdate + interval  '-30' SECOND,'DD/MM/YYYY HH24:MI.SS') AS RESULTB      
From Dual;

Select sysdate + interval  '1' YEAR From Dual;



--- ORNEK JOIN ICIN
-- Sales_orders tablosundan shippeddate alani siparisin sevk edildigi tarihi gostermektedir.
-- Sevk edilmemis ise null degere sahiptir
-- Sevk edilen ve bekleyen siparislerin sayisini bulunuz.

With A as
(
    Select 
        shipcountry,
        To_Char(orderdate, 'YYYY') as Yillar,
        Case
            When shippeddate is not null Then 'Siparis Gonderildi'
            Else 'Siparis Bekliyor'
        End as SiparisDurumu
    From sales_orders
)
Select 
    SiparisDurumu, Count(*) as SiparisSayisi 
From A
Group By SiparisDurumu;

---------------------------------------------------

With A as
(
    Select 
        shipcountry,
        To_Char(orderdate, 'YYYY') as Yillar,
        Case
            When shippeddate is not null Then 'Siparis Gonderildi'
            Else 'Siparis Bekliyor'
        End as SiparisDurumu
    From sales_orders
)
Select 
    SiparisDurumu, shipcountry, Count(*) as SiparisSayisi 
From A
Group By SiparisDurumu, shipcountry
Order By 1;