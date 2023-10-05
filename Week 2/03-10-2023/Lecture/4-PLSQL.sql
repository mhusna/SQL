-- PL/SQL
-- OOP (Object Oriented Programming) => Nesne Tabanli Programlamayi destekler

-- Terminoloji

-- PL /SQL (Oracle Database)
-- TSQL (SQL Database)
-- PL/pgSQL (PostgreSQL Database)

-- PL /SQL (Oracle Database)
-- PL /SQL Kod Yapisi

/*
DECLARE (istege bagli)
...
BEGIN (zorunlu)
  ...Calisabilir kod
    EXCEPTION (istege bagli) hata kontrolu icin kullanilir
      ...
END (zorunlu)
*/

-- Types of PL /SQL Block
-- PL /SQL Block Turleri
    -- A) Unnamed Block : Veritabaninda saklanmaz, calisma sirasinda derlenir ve calistirilir
    -- B) Named Block   : Veritabaninda saklanir, Derlenmis hali calistirilir
    --                    (Stored Procedure, Function)
    
-- PL / SQL ile ilk programimizi yazalim
-- cmd'ye baglanalim
-- >sqlplus ile baglanalim    
-- sqlplus / as sysdba;
-- veya
-- sqlplus sys/sys as sysdba;

-- sqlplus içerisinde
-- conn hr/HR; diyerekte hr'a baglaniriz
-- yani conn username/password; girilecektir

Set serveroutput on;

Declare WMessage Varchar2(100);

Begin
    WMessage:='Merhaba Dunya, Hello World';
    DBMS_OUTPUT.PUT_LINE(WMessage);
End;

/*
yazacagýmýz kod Unnamed Block - Anonymous Block tipindedir
buradan cýktýgýmýzda saklanmaz

SQL>Begin
SQL>DBMS_OUTPUT.PUT_LINE('Merhaba Dunya');
SQL>End;
SQL>/ veya r harfine basarýz sonra Enter

SERVEROUTPUT parametresi off durumundadýr bunu oncelikle acalim
SQL>Set SERVEROUTPUT ON; -- Acar
-- SQL>Set SERVEROUTPUT OFF; -- Kapatir

SQL>Set SERVEROUTPUT ON; -- Bu parametre ile cýktýnýn gozukmesi icin parametreyi acalim



SQL>ed ile en son calisan bufferdeki sorguyu acabiliriz
SQL>Begin
DBMS_OUTPUT.PUT_LINE('Merhaba Dunya! Ben Geldim');
End;
seklinde kaydedelim ve

SQL>/ ile calistiralim


-- simdi degisken ile ayný kodu yazalým

SQL>Declare
SQL>WMessage Varchar2(100);

SQL>Begin
SQL>WMessage:='Merhaba Dunya,Hello World'; 
SQL>DBMS_OUTPUT.PUT_LINE(WMessage);
SQL>End;
SQL>/ veya r harfine basarýz sonra Enter

-- simdi ayný islemi SQL Developer ile yapalým

*/

Set SERVEROUTPUT On;

Begin
    DBMS_OUTPUT.PUT_LINE('Merhaba Dunya,Hello World');
End;

Declare
Begin
    DBMS_OUTPUT.PUT_LINE('Merhaba Dunya,Hello World');
End;


Declare
WMessage Varchar2(100);

Begin
WMessage:='Merhaba Dunya,Hello World'; 
DBMS_OUTPUT.PUT_LINE(WMessage);
End;


-- Cikti sonucunu gormemiz icin SERVEROUTPUT parametresini ON yapalým/ON/OFF)

Set SERVEROUTPUT ON;
----- GELINEN Yer
--
Declare
WMessage Varchar2(100);

Begin
WMessage:='Merhaba Dunya,Hello World'; 
DBMS_OUTPUT.PUT_LINE(WMessage);
End;

-- SQL Kurulumu esnasýnda Sample Schemas tabýnda Add Sample Schemas to the database'i secmistik
-- Bu bize HR isimli kullanýcý altýnda ornekleri yukleyecektir
-- Normalde HR kullanýcýsý kilitlidir buna baglantý yapmak istersek hata alýrýz
-- Kilitli olan bir kullanýcýyý acmak icin Alter komutunu kullanacagiz
-- sqlplus ile SYS veya SYSTEM olarak baglanalým

--SQL>sqlplus sys/sys as sysdba;
-- Show user
-- Alter User KullaniciAdi IDENTITY BY KullaniciSifresi ACCOUNT Lock;--(veya Unlock)
-- Alter User HR IDENTITY BY HR ACCOUNT LOCK;   -- Veya
-- Alter User HR IDENTITY BY HR ACCOUNT UNLOCK; -- burada identity yerine identified yazalým

-- Bu komutla hem hesabýn sifresini HR olarak degistiriyoruz hemde unlock yapýyoruz
-- Alter User hr identified by hr account lock; -- bu hesabý kilitler
-- Alter User hr identified by hr account unlock; -- bu hesabýn kilidini acar


-- SYS kullanýcýsý ile baglanýrsak

Alter User hr identified by hr account lock; -- bu ise hesabý kilitler
Alter User hr identified by hr account unlock; -- bu hesabýn kilidini acar

-- ornek
-- icinde bulundugumuz gunun ismini ekrana yazan bir program yazalým

Set SERVEROUTPUT ON;
-- ya bu sekilde acarýz veya
-- View > DBMS OUTPUT secerek acariz
-- View > DBMS OUTPUT secerek acarsak gelen ekranda Yesil Artý'ya týklayalým
-- ve HR icin ekraný acmasýný saglayalým



-- ornek
-- icinde bulundugumuz gunun ismini ekrana yazan bir program yazalým

Set SERVEROUTPUT ON;
-- ya bu sekilde acarýz veya
-- View > DBMS OUTPUT secerek acariz
-- View > DBMS OUTPUT secerek acarsak gelen ekranda Yesil Artý'ya týklayalým
-- ve HR icin ekraný acmasýný saglayalým

Declare
    WGun Varchar2(50);
Begin
    WGun:= To_Char(Sysdate,'DAY');
    DBMS_OUTPUT.PUT_LINE('Bugun ' || WGun);
End;


Begin
    DBMS_OUTPUT.PUT_LINE('Bugun ' || To_Char(Sysdate,'DAY'));
End;
-- Bilginin farkli dillerde gelmesi icin Tools>Preferences>Database>NLS>Date Languages altýnda dillerden ayarlanýr
-- Named Block icin ornek yapalým

-- ornek
-- icinde bulundugumuz gunun ismini ekrana yazan bir program yazalým

-- Set SERVEROUTPUT ON;



Create or Replace Function fnc_Get_Day_Name(P_Tarih Date)
Return Varchar2
is

Begin
   Return(To_Char(P_Tarih,'DAY'));    
End;

/

Select fnc_Get_Day_Name(SYSDATE)
From Dual;

Select 'Bugun '  || fnc_Get_Day_Name(SYSDATE)
From Dual;

-- veya su sekilde de calýstýrabiliriz

Declare
    WGun Varchar2(50);
Begin
    WGun:= fnc_Get_Day_Name(SYSDATE);
    DBMS_OUTPUT.PUT_LINE('Bugun: ' || WGun);
End;