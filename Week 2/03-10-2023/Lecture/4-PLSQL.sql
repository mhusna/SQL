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

-- sqlplus i�erisinde
-- conn hr/HR; diyerekte hr'a baglaniriz
-- yani conn username/password; girilecektir

Set serveroutput on;

Declare WMessage Varchar2(100);

Begin
    WMessage:='Merhaba Dunya, Hello World';
    DBMS_OUTPUT.PUT_LINE(WMessage);
End;

/*
yazacag�m�z kod Unnamed Block - Anonymous Block tipindedir
buradan c�kt�g�m�zda saklanmaz

SQL>Begin
SQL>DBMS_OUTPUT.PUT_LINE('Merhaba Dunya');
SQL>End;
SQL>/ veya r harfine basar�z sonra Enter

SERVEROUTPUT parametresi off durumundad�r bunu oncelikle acalim
SQL>Set SERVEROUTPUT ON; -- Acar
-- SQL>Set SERVEROUTPUT OFF; -- Kapatir

SQL>Set SERVEROUTPUT ON; -- Bu parametre ile c�kt�n�n gozukmesi icin parametreyi acalim



SQL>ed ile en son calisan bufferdeki sorguyu acabiliriz
SQL>Begin
DBMS_OUTPUT.PUT_LINE('Merhaba Dunya! Ben Geldim');
End;
seklinde kaydedelim ve

SQL>/ ile calistiralim


-- simdi degisken ile ayn� kodu yazal�m

SQL>Declare
SQL>WMessage Varchar2(100);

SQL>Begin
SQL>WMessage:='Merhaba Dunya,Hello World'; 
SQL>DBMS_OUTPUT.PUT_LINE(WMessage);
SQL>End;
SQL>/ veya r harfine basar�z sonra Enter

-- simdi ayn� islemi SQL Developer ile yapal�m

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


-- Cikti sonucunu gormemiz icin SERVEROUTPUT parametresini ON yapal�m/ON/OFF)

Set SERVEROUTPUT ON;
----- GELINEN Yer
--
Declare
WMessage Varchar2(100);

Begin
WMessage:='Merhaba Dunya,Hello World'; 
DBMS_OUTPUT.PUT_LINE(WMessage);
End;

-- SQL Kurulumu esnas�nda Sample Schemas tab�nda Add Sample Schemas to the database'i secmistik
-- Bu bize HR isimli kullan�c� alt�nda ornekleri yukleyecektir
-- Normalde HR kullan�c�s� kilitlidir buna baglant� yapmak istersek hata al�r�z
-- Kilitli olan bir kullan�c�y� acmak icin Alter komutunu kullanacagiz
-- sqlplus ile SYS veya SYSTEM olarak baglanal�m

--SQL>sqlplus sys/sys as sysdba;
-- Show user
-- Alter User KullaniciAdi IDENTITY BY KullaniciSifresi ACCOUNT Lock;--(veya Unlock)
-- Alter User HR IDENTITY BY HR ACCOUNT LOCK;   -- Veya
-- Alter User HR IDENTITY BY HR ACCOUNT UNLOCK; -- burada identity yerine identified yazal�m

-- Bu komutla hem hesab�n sifresini HR olarak degistiriyoruz hemde unlock yap�yoruz
-- Alter User hr identified by hr account lock; -- bu hesab� kilitler
-- Alter User hr identified by hr account unlock; -- bu hesab�n kilidini acar


-- SYS kullan�c�s� ile baglan�rsak

Alter User hr identified by hr account lock; -- bu ise hesab� kilitler
Alter User hr identified by hr account unlock; -- bu hesab�n kilidini acar

-- ornek
-- icinde bulundugumuz gunun ismini ekrana yazan bir program yazal�m

Set SERVEROUTPUT ON;
-- ya bu sekilde acar�z veya
-- View > DBMS OUTPUT secerek acariz
-- View > DBMS OUTPUT secerek acarsak gelen ekranda Yesil Art�'ya t�klayal�m
-- ve HR icin ekran� acmas�n� saglayal�m



-- ornek
-- icinde bulundugumuz gunun ismini ekrana yazan bir program yazal�m

Set SERVEROUTPUT ON;
-- ya bu sekilde acar�z veya
-- View > DBMS OUTPUT secerek acariz
-- View > DBMS OUTPUT secerek acarsak gelen ekranda Yesil Art�'ya t�klayal�m
-- ve HR icin ekran� acmas�n� saglayal�m

Declare
    WGun Varchar2(50);
Begin
    WGun:= To_Char(Sysdate,'DAY');
    DBMS_OUTPUT.PUT_LINE('Bugun ' || WGun);
End;


Begin
    DBMS_OUTPUT.PUT_LINE('Bugun ' || To_Char(Sysdate,'DAY'));
End;
-- Bilginin farkli dillerde gelmesi icin Tools>Preferences>Database>NLS>Date Languages alt�nda dillerden ayarlan�r
-- Named Block icin ornek yapal�m

-- ornek
-- icinde bulundugumuz gunun ismini ekrana yazan bir program yazal�m

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

-- veya su sekilde de cal�st�rabiliriz

Declare
    WGun Varchar2(50);
Begin
    WGun:= fnc_Get_Day_Name(SYSDATE);
    DBMS_OUTPUT.PUT_LINE('Bugun: ' || WGun);
End;