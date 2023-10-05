--04102023

Set ServerOutput ON;

Begin
    DBMS_OUTPUT.Put_Line('Merhaba, PL/SQL egitimine hos geldiniz!!!');
End;
/
Declare
Begin
    DBMS_OUTPUT.Put_Line('Merhaba, PL/SQL egitimine hos geldiniz!!!');
End;
/
Declare
    Elma Varchar2(100);
Begin
    Elma:= 'Merhaba, PL/SQL egitimine hos geldiniz!';
    DBMS_OUTPUT.Put_Line(Elma);
End;
/
Begin
    DBMS_OUTPUT.PUT_LINE('Bugun ' || To_Char(Sysdate,'DAY'));
End;
/
Declare
 GunBilgisi Varchar2(100);
Begin
    GunBilgisi:= 'Bugun Gunlerden: ' || To_Char(Sysdate,'DAY');
    DBMS_OUTPUT.PUT_LINE(GunBilgisi);
End;
/
Set ServerOutPut ON;
/
Declare
 AyBilgisi Varchar2(100);
Begin
    AyBilgisi:= 'Bugun Aylardan: ' || To_Char(Sysdate,'MONTH');
    DBMS_OUTPUT.PUT_LINE(AyBilgisi);
End;
/
Declare
 AyBilgisi Varchar2(100);
 GunBilgisi Varchar2(100);
 
Begin
    AyBilgisi:= 'Bugun Aylardan: ' || To_Char(Sysdate,'MONTH');
    GunBilgisi:= 'Bugun Gunlerden: ' || To_Char(Sysdate,'DAY');
    DBMS_OUTPUT.PUT_LINE(AyBilgisi);
    DBMS_OUTPUT.PUT_LINE(GunBilgisi);
    
    DBMS_OUTPUT.PUT_LINE(AyBilgisi || GunBilgisi);
    
End;
/
/*

    Create or Replace Function FoknsiyonAdi(Parametre ve  Turu)
    Return DonecekTipi
    is
    
    Begin
            Return(DonecekBilgi);    
    End;

*/
/
    Create or Replace Function Fn_AyBilgisi(P_Tarih Date)
    Return Varchar2
    is
    
    Begin
            Return(To_Char(P_Tarih,'Month'));    
    End;
/

Select
        sysdate,
        Fn_AyBilgisi(sysdate)
From Dual;
/
    Create or Replace Function Fn_GunBilgisi(P_Tarih Date)
    Return Varchar2
    is
    
    Begin
            Return(To_Char(P_Tarih,'Day'));    
    End;
/

Select
        sysdate,
        Fn_AyBilgisi(sysdate),
        Fn_GunBilgisi(sysdate)
From Dual;
/

-- Exception Handler Section
-- (Hata Yakalama Bolumu)

-- Hata Turleri
  --1) Compile Error(Derleme Esnasýnda)
  --2) Runtime Error(Calisma Esnasýnda)

-- Exception Handler Section ile calisma yapacagiz
-- Bu nedenle Runtime Error(Calisma Esnasýnda) ile ilgilenecegiz


-- Exception Block
/
Create or Replace Function fnc_Bolme( A in Number, B in Number)
Return Number
is
C Number; -- C degiskeni Declare ediyoruz
Begin
      C:= A/B;
      Return(C);
End;
/
Select fnc_Bolme(10,2) From Dual;
/

-- Anonymous Block ile yapalým

Declare
  D Number;
Begin

    D:= fnc_Bolme(10,2);
    DBMS_OUTPUT.PUT_Line(D);
End;

-- simdi hata meydana getirelim
/
Select fnc_Bolme(10,0) From Dual;
/
-- Anonymous Block ile yapalým

Declare
  D Number;
Begin

    D:= fnc_Bolme(10,0);
    DBMS_OUTPUT.PUT_Line(D);
End;
/
-- Burada hatadan dolayý sonucu gormek icin Exception ile hata kontrolu yapalým

Declare
  D Number;
Begin

    D:= fnc_Bolme(10,0);
    DBMS_OUTPUT.PUT_Line(D);
    Exception When Zero_Divide Then
      DBMS_OUTPUT.PUT_Line('0 ile bolme yapýlamaz'); -- veya hata kodunu yazdýralým
      DBMS_OUTPUT.PUT_Line('Hata turu: ' || SQLERRM);
End;
/
Declare
  D Number;
Begin

    D:= fnc_Bolme(10,2);
    DBMS_OUTPUT.PUT_Line(D);
    Exception When Zero_Divide Then
      DBMS_OUTPUT.PUT_Line('0 ile bolme yapýlamaz'); -- veya hata kodunu yazdýralým
      DBMS_OUTPUT.PUT_Line('Hata turu: ' || SQLERRM);
End;
/

-- Simdi Exception Block ile ilgili bir ornek daha yapalým
-- Departments tablosunda department_id gonderelim ve department_name alalým

Select DEPARTMENT_NAME From Departments Where Department_id = 10;

-- Bunu bir function ile yazalým


/
Create or Replace Function fnc_BolumAdi(P_Bolum_id in Number)
Return Varchar2
is
  wBolumAdi Varchar2(100);
Begin

  Select DEPARTMENT_NAME into wBolumAdi
  From Departments
  Where Department_id = P_Bolum_id;
  
  Return(wBolumAdi);
End;
/
Select fnc_BolumAdi(10) From Dual;
/
Select fnc_BolumAdi(20) From Dual;
/
Select fnc_BolumAdi(1000) From Dual;
/

/
Create or Replace Function fnc_Department_Name(P_Department_id in Number)
Return Varchar2
is
  wDepartName Varchar2(100);
Begin
  Select DEPARTMENT_NAME into wDepartName From Departments Where Department_id = P_Department_id;
    Return(wDepartName);
End;
/
-- 
Select fnc_Department_Name(10) From Dual;
Select fnc_Department_Name(20) From Dual;


-- Unnamed Block yani Anonymous olarak yapalým

Set SERVEROUTPUT ON;

Declare
  wMessage Varchar2(100);
Begin
  wMessage:= fnc_Department_Name(10);
  DBMS_OUTPUT.PUT_LINE(wMessage);
End;
/
-- simdide yukarýdaki function icin Exception meydana getirelim
-- olmayan bir bolumu sorgulayalým
Set SERVEROUTPUT ON;
/
Declare
  wMessage Varchar2(100);
Begin
  wMessage:= fnc_Department_Name(2);
  DBMS_OUTPUT.PUT_LINE(wMessage);
End;

-- Exception yazmadigimiz icin hata kontrol edilmemis oluyor
-- Simdi Exception ile kontrol altina alalim
-- Bunu function icinde yapalým

Create or Replace Function fnc_Department_Name(P_Department_id in Number)
Return Varchar2
is
  wDepartName Varchar2(100);
Begin
  Select DEPARTMENT_NAME into wDepartName From Departments Where Department_id = P_Department_id;
    Return(wDepartName);
    Exception When NO_DATA_FOUND Then
      Return(P_Department_id || ' Nolu Bolum Bulunamadi');
End;

--

Declare
  wMessage Varchar2(100);
Begin
  wMessage:= fnc_Department_Name(2);
  DBMS_OUTPUT.PUT_LINE(wMessage);
    
End;
/
Select fnc_Department_Name(30) From Dual;
Select fnc_Department_Name(2) From Dual;

Select fnc_Department_Name(100) From Dual;
/
-- SQL Developer icerisinde Turkce sorun ile karsilasirsak
-- Regedit icerisinde NLS_LANG arattiralim

-- Karsimiza gelen yerde ayarlardaki data degerin P9 ile bitmesi gerekiyor
-- Bende AMERICAN_AMERICA.WE8MSWIN1252 kayýtlý cýkýyor
-- Sizde su sekilde de olabilir
-- AMERICAN_AMERICA.WE8ISO8859P9
-- TURKISH_TURKISH.WE8ISO8859P9 gibi

-- PL / SQL Data Types
  -- A) Scalar Data Types(Char, Varchar2, Number, Boolean, PLS_Integer, Binary_Integer,...)
  -- B) Large Object Data Types(BLOB, CLOB, LONG)
  -- C) Reference Data Types(%TYPE, %ROWTYPE) 
  -- D) Composite(Collections)
        -- (Defined(User-Defined) veri tipleridir,
        -- Diger veri tiplerinden faydalanýlarak, yeni ver tipleri ya da veri tip kolleksiyonu oluþturabiliriz)


--*********************************************************************************************
-- A) Scalar Data Types(Char, Varchar2, Number, Boolean, PLS_Integer, Binary_Integer,...)
--*********************************************************************************************

Set ServerOutput ON;


-- Char, Varchar2

Declare
  wAdi    Char(15);
  wSoyadi Varchar2(15);
Begin
  wAdi    := 'Ali';
  wSoyadi := 'TOPACIK';
  
  
  DBMS_OUTPUT.PUT_LINE(wAdi);
  DBMS_OUTPUT.PUT_LINE(wSoyadi);
  DBMS_OUTPUT.PUT_LINE(wAdi || ' ' || wSoyadi);
  
  DBMS_OUTPUT.PUT_LINE('*' || wAdi || '*');
  DBMS_OUTPUT.PUT_LINE('*' || wSoyadi || '*');
  DBMS_OUTPUT.PUT_LINE('*' || wAdi || '#' || '*' || wSoyadi || '*');
  
  DBMS_OUTPUT.PUT_LINE('*' || wAdi || '* Uzunluk:' || Length(wAdi));
  DBMS_OUTPUT.PUT_LINE('*' || wSoyadi || '* Uzunluk:' || Length(wSoyadi));

End;

-- PLS_Integer, Binary_Integer, Number

-- PLS_Integer, Binary_Integer, OverFlow(Asiri Yuklenme)
-- PLS_Integer Max alabilecegi deger 2147483647

Set SERVEROUTPUT ON;

Declare
  p1  PLS_INTEGER:= 120;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  PLS_INTEGER:= 99;
  
  n1 NUMBER;
Begin
  n1:= p1 + p2;
  
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;

--

Declare
  p1  PLS_INTEGER;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  PLS_INTEGER;
  
  n1 NUMBER;
Begin
  p1:= 222;
  p2:= 100;
  
  n1:= p1 + p2; -- Toplama isi yaparken toplamayý once p1 ve p2 arasýnda yapar
                -- Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atar                  
  
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;
/
-- simdi Overflow yapalým

Declare
  p1  PLS_INTEGER;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  PLS_INTEGER;
  
  n1 NUMBER;
Begin
  p1:= 2147483647;  -- PLS_Integer Max alabilecegi deger 2147483647
  p2:= 1;
  n1:= p1 + p2; -- Toplama isi yaparken toplamayý once p1 ve p2 arasýnda yapar
                -- Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atar                  
                -- Burada PLS_Integer Max alabilecegi deger 2147483647 oldugu icin
                -- buna 1 eklerse max sýnýrý asiyor ve overflow meydana geliyor
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;

-- p2 degiskenini number yapalým ve sonucu gorelim
-- number degiskeni daha fazla deger alabildigi icin
-- p1(PLS_INTEGER) icerigini p2(NUMBER) icinde toplar ve overflow olmadan sonuc verir

Declare
  p1  PLS_INTEGER;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  NUMBER;
  
  n1 NUMBER;
Begin
  p1:= 2147483647;  -- PLS_Integer Max alabilecegi deger 2147483647
  p2:= 1;
  n1:= p1 + p2; -- Toplama isi yaparken toplamayý once p1 ve p2 arasýnda yapar
                -- Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atar                  
                -- Burada PLS_Integer Max alabilecegi deger 2147483647 oldugu icin
                -- buna 1 eklerse max sýnýrý asiyor ve overflow meydana geliyor
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;

-- Simdi de BINARY_INTEGER inceleyelim
-- BINARY_INTEGER Max alabilecegi deger 2147483647
-- PLS_INTEGER; BINARY_INTEGER'e gore daha guclu bir yapýya sahiptir
-- p1(BINARY_INTEGER) icerigini p2(BINARY_INTEGER) kendi icinde
-- uygun olanda toplar

Declare
  p1  BINARY_INTEGER;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  BINARY_INTEGER;
  
  n1 NUMBER;
Begin
  p1:= 2147483646;  -- BINARY_INTEGER Max alabilecegi deger 2147483647
  p2:= 1;
  n1:= p1 + p2; -- Toplama isi yaparken toplamayý once p1 ve p2 arasýnda yapar
                -- Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atar                  
  
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;

-- Simdi de BINARY_INTEGER'da Overflow yapalým
-- p1(BINARY_INTEGER) icerigini p2(BINARY_INTEGER) kendi icinde
-- uygun olanda toplar ve overflow meydana verir

Declare
  p1  BINARY_INTEGER;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  BINARY_INTEGER;
  
  n1 NUMBER;
Begin
  p1:= 2147483647;  -- BINARY_INTEGER Max alabilecegi deger 2147483647
  p2:= 1;
  n1:= p1 + p2; -- Toplama isi yaparken toplamayý once p1 ve p2 arasýnda yapar
                -- Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atar                  
                -- Burada BINARY_INTEGER Max alabilecegi deger 2147483647 oldugu icin
                -- buna 1 eklerse max sýnýrý asiyor ve overflow meydana geliyor
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;

-- Simdi de p2 degiskenini Number yapalým ve bakalým
-- p1(BINARY_INTEGER) icerigini p2(MUMBER) kendi icinde
-- uygun olanda toplar ve overflow hatasý olmadan sonuc verir

Declare
  p1  BINARY_INTEGER;  -- Baslangýc atamalarý Declare kýsmýnda yapýlabilir
  p2  NUMBER;
  
  n1 NUMBER;
Begin
  p1:= 2147483647;  -- BINARY_INTEGER Max alabilecegi deger 2147483647
  p2:= 1;
  n1:= p1 + p2; -- Toplama isi yaparken toplamayý once p1 ve p2 arasýnda yapar
                -- Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atar                  
                -- Burada BINARY_INTEGER Max alabilecegi deger 2147483647 oldugu icin
                -- buna 1 eklerse max sýnýrý asiyor ve overflow meydana geliyor
  DBMS_OUTPUT.PUT_LINE(n1);
  DBMS_OUTPUT.PUT_LINE(To_Char(n1,'999,999,999,999.99'));
 
End;
/
--*********************************************************************************************
-- C) Reference Data Types(%TYPE, %ROWTYPE) 
--*********************************************************************************************

--*********************Reference Data Types****************************************************
-- %TYPE      -- Referans alýnan tablonun kolonuyla dinamik olarak ayný olmasýný saglar
-- %ROWTYPE   -- Referans alýnan tablo veya View ile dinamik olarak ayný olmasýný saglar
-- Sorgunun her ikisinide de tek satýr veri vermesi gerekir


-- %TYPE      -- Referans alýnan tablonun kolonuyla dinamik olarak ayný olmasýný saglar

-- Departments tablosundan Department_id'si 10 olan kayýtlarý listeleyelim

Desc Departments;

Declare
    wDEPARTMENT_ID   NUMBER(4);
    wDEPARTMENT_NAME VARCHAR2(30);
    wMANAGER_ID      NUMBER(6);
    wLOCATION_ID     NUMBER(4);
Begin
  Select * into wDEPARTMENT_ID, wDEPARTMENT_NAME, wMANAGER_ID, wLOCATION_ID
  From Departments
  Where Department_id = 10;
  
  DBMS_OUTPUT.PUT_LINE(wDEPARTMENT_ID || ' ' || wDEPARTMENT_NAME || ' ' || wMANAGER_ID || ' ' || wLOCATION_ID);

End;

-- Yukarýdaki kod blogu calisacaktýr
-- Ancak departments tablosundaki herhangi bir kolonun
-- veritipi veya uzunlugu degistiginde hata meydana gelir
-- yani departments tablosundaki Department_name(30) alanýn ihtiyac halinde 
-- uzunlugu  Department_name(35) oldu diyelim
-- Bu durumda Yukarýdaki Declare icerisinde Department_name(30) oldugu icin
-- Program interrupt olacaktýr
-- Bu tur hatalarýn olmamasý icin %TYPE kullanabiliriz

Declare
    wDEPARTMENT_ID   Departments.DEPARTMENT_ID%TYPE;
    wDEPARTMENT_NAME Departments.DEPARTMENT_NAME%TYPE;
    wMANAGER_ID      Departments.MANAGER_ID%TYPE;
    wLOCATION_ID     Departments.LOCATION_ID%TYPE;
Begin
  Select * into wDEPARTMENT_ID, wDEPARTMENT_NAME, wMANAGER_ID, wLOCATION_ID
  From Departments
  Where Department_id = 10;
  
  DBMS_OUTPUT.PUT_LINE(wDEPARTMENT_ID || ' ' || wDEPARTMENT_NAME || ' ' || wMANAGER_ID || ' ' || wLOCATION_ID);

End;


-- %ROWTYPE   -- Referans alýnan tablo veya View ile dinamik olarak ayný olmasýný saglar

Declare
    r_Dept Departments%ROWTYPE;
Begin
  Select * into r_Dept
  From Departments
  Where Department_id = 10;
  
  DBMS_OUTPUT.PUT_LINE( r_Dept.DEPARTMENT_ID || ' ' ||
                        r_Dept.DEPARTMENT_NAME || ' ' ||
                        r_Dept.MANAGER_ID || ' ' ||
                        r_Dept.LOCATION_ID
                      );
End;
/

/*
  wDEPARTMENT_ID   NUMBER(4);                       -- Klasik Yontem
  wDEPARTMENT_ID   Departments.DEPARTMENT_ID%TYPE;  -- %TYPE Yontemi
  r_Dept Departments%ROWTYPE;                       -- %ROWTYPE Yontemi

-- Klasik Yontem %TYPE ve %ROWTYPE yontemlerine gore daha performanslýdýr

-- %TYPE yontemi %ROWTYPE yontemine gore daha iyidir
-- sebebi ise referans alýnan tabloda yeni bir kolon eklendiginde
-- %ROWTYPE tum kolonlarý donderdiginden bu durum hataya sebep olabilir

*/

-- ############################################################################################################################
-- ##############################################################BURADA KALDIN ##############################################################
-- ############################################################################################################################

--*********************************************************************************************
-- D) Composite(Collections)
--*********************************************************************************************

-- COMPOSITE(Collection) Data Types
-- Developer Defined veya User Defined Veri Tipleri olarak bilinir
-- Record Type ile ilgilenecegiz

-- Asagidaki sorguda *not enough values* hatasý alýrýz
-- Cunku Select * ile 4 kolon geliyor biz ise 3 kolon yazdýk
-- Bunun icin sutun adlarýný teker teker yazmam?z gerekir
-- Select * yerine sutun adlar?n? belirtmek birinci tercihimiz olmal?d?r

Declare
    Type t_dept is Record(
                          DEPT_ID    NUMBER(4),
                          DEPT_NAME  Departments.Department_name%Type,
                          MANAGER_ID Departments.Manager_id%Type Not Null Default 0 -- Constraint eklenebilir
                         );
    r_dept2 t_dept;
Begin
  Select * into r_dept2
  From Departments
  Where Department_id = 10;
  
  DBMS_OUTPUT.PUT_LINE( r_dept2.DEPT_ID || ' ' ||
                        r_dept2.DEPT_NAME || ' ' ||
                        r_dept2.MANAGER_ID
                      );
End;

-- Bunun icin sutun adlarýný teker teker yazmam?z gerekir
-- Select * yerine sutun adlar?n? belirtmek birinci tercihimiz olmal?d?r

/

Declare
    Type t_dept is Record(
                          DEPT_ID    NUMBER(4),
                          DEPT_NAME  Departments.Department_name%Type,
                          MANAGER_ID Departments.Manager_id%Type Not Null Default 0 -- Constraint eklenebilir
                         );
    r_dept2 t_dept;
Begin
  Select DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID into r_Dept2
  From Departments
  Where Department_id = 10;
  
  DBMS_OUTPUT.PUT_LINE( r_Dept2.DEPT_ID || ' ' ||
                        r_Dept2.DEPT_NAME || ' ' ||
                        r_Dept2.MANAGER_ID
                      );
End;

-- Simdi yukaridaki sorgu calisacaktir
--*********************************************************************************************
-- SQL Language Statements
-- PL/SQL icinde kullanýmlarý

--*********************************************************************************************
-- DDL(Create, Alter ve Drop) ve DCL(Grant, Revoke) komutlarý
    -- DYNAMIC SQL(Execute Immediate) oldugundan PL/SQL icerisinde direk/Dogrudan kullanýlamazlar
    -- Bu komutlarý Execute Immediate komutu ile kullabiliriz
    
-- DML(Select, Insert, Update ve Delete) ve TCL(Commit ve Rollback) komutlarý ise
    -- STATIC SQL oldugu icin PL/SQL icerisinde kullanýlabilirler



-- STATIC SQL Kullanýmý
  -- (DML, TCL, Savepoint)

-- Dynamic SQL Kullanýmý(DDL, DCL)
  -- (Execute Immediate)
  
-- Pseudocolumns Kullanýmý  -- Takma Ad anlamýndadýr
  -- (Currval, Nextval) (Sequence)
  
--*********************************************************************************************
-- STATIC SQL Kullanýmý
  -- (DML, TCL, Savepoint)
--*********************************************************************************************
Desc Employees;
/

Create Table Employees2 as
Select * From Employees;
/
Select * From Employees2;
/
Declare
    emp_id            employees2.employee_id%TYPE;
    emp_first_Name    employees2.first_Name%TYPE  := 'Ali';
    emp_Last_Name     employees2.Last_Name%TYPE   := 'TOPACIK';
    emp_email         employees2.email%TYPE   := 'alitopacik@gmail.com';
    emp_Hire_Date     employees2.Hire_Date%TYPE   := '21-11-1973';
    emp_job_id        employees2.job_id%TYPE      := 'PL/SQL';
Begin

  Select NVL(Max(employee_id),0) + 1 into emp_id
  From Employees2;
  
  insert into Employees2(employee_id, first_Name, Last_Name, email, Hire_Date, job_id)
               Values(emp_id, emp_first_Name, emp_Last_Name, emp_email, emp_Hire_Date, emp_job_id);

  Update Employees2
  Set job_id = 'DBA'
  Where Employee_id = emp_id;

/*
  Delete Employees2
  Where Employee_id = emp_id
  Returning employee_id, first_Name, Last_Name, email, Hire_Date, job_id
       into emp_id, emp_first_Name, emp_Last_Name, emp_email, emp_Hire_Date, emp_job_id;
*/


  -- Rollback;
  Commit;
       
  dbms_OUTPUT.PUT_LINE(emp_id || ' ' ||
                       emp_first_Name || ' ' ||
                       emp_Last_Name || ' ' ||
                       emp_email || ' ' ||
                       emp_Hire_Date || ' ' ||
                       emp_job_id);
  
End;
/
Select * From Employees2 Order By 1 Desc;
/
/
Declare
    emp_id            employees2.employee_id%TYPE;
    emp_first_Name    employees2.first_Name%TYPE  := 'Ali';
    emp_Last_Name     employees2.Last_Name%TYPE   := 'TOPACIK';
    emp_email         employees2.email%TYPE   := 'alitopacik@gmail.com';
    emp_Hire_Date     employees2.Hire_Date%TYPE   := '21-11-1973';
    emp_job_id        employees2.job_id%TYPE      := 'PL/SQL';
Begin

  Select NVL(Max(employee_id),0) + 1 into emp_id
  From Employees2;
  
  insert into Employees2(employee_id, first_Name, Last_Name, email, Hire_Date, job_id)
               Values(emp_id, emp_first_Name, emp_Last_Name, emp_email, emp_Hire_Date, emp_job_id);


  -- Rollback;
  Commit;
       
  dbms_OUTPUT.PUT_LINE(emp_id || ' ' ||
                       emp_first_Name || ' ' ||
                       emp_Last_Name || ' ' ||
                       emp_email || ' ' ||
                       emp_Hire_Date || ' ' ||
                       emp_job_id);
  
End;
/
Select * From employees2 Order By 1 desc;
/
Declare
    emp_id            employees2.employee_id%TYPE;
    emp_first_Name    employees2.first_Name%TYPE  := 'Ali';
    emp_Last_Name     employees2.Last_Name%TYPE   := 'TOPACIK';
    emp_email         employees2.email%TYPE   := 'alitopacik@gmail.com';
    emp_Hire_Date     employees2.Hire_Date%TYPE   := '21-11-1973';
    emp_job_id        employees2.job_id%TYPE      := 'ETL';
Begin

  Select NVL(Max(employee_id),0) + 1 into emp_id
  From Employees2;
  
  insert into Employees2(employee_id, first_Name, Last_Name, email, Hire_Date, job_id)
               Values(emp_id, emp_first_Name, emp_Last_Name, emp_email, emp_Hire_Date, emp_job_id);


   Rollback;
  --Commit;
       
  dbms_OUTPUT.PUT_LINE(emp_id || ' ' ||
                       emp_first_Name || ' ' ||
                       emp_Last_Name || ' ' ||
                       emp_email || ' ' ||
                       emp_Hire_Date || ' ' ||
                       emp_job_id);
  
End;
/
Select * From employees2 Order By 1 desc;
/
--*** SavePoint ===> istenilen noktaya RollBack yapmak icin kullanýlýr *********************

Desc Regions;

-- Regions tablosunun bos bir kopyasýný olusturalým
/
Create Table RegionsB as
Select *
From Regions
Where 1=2;
/
--

Select * From RegionsB;
/
-- simdi kodumuzu yazalým ve Savepoint inceleyelim

Begin
    insert into RegionsB(Region_id, Region_Name) Values(1, 'Avrupa');
    SavePoint A;

    insert into RegionsB(Region_id, Region_Name) Values(2, 'Asya');
    SavePoint B;

    Update RegionsB
    Set Region_Name = 'Asia'
    Where Region_id = 2;
    SavePoint C;

    Delete From RegionsB Where Region_id = 2;
    
    -- RollBack;       -- Tum islemleri iptal eder    
    -- "  -- A noktasýndan sonra olan tum islemleri iptal eder
    -- RollBack To B;  -- B noktasýndan sonra olan tum islemleri iptal eder
    -- RollBack To C;  -- C noktasýndan sonra olan tum islemleri iptal eder
    --Commit;
end;
/
-- RollBack;
/
Select * From RegionsB;
/
Delete From RegionsB;
Commit;
/
--*********************************************************************************************
-- Dynamic SQL Kullanýmý(DDL, DCL)
  -- (Execute Immediate)
--*********************************************************************************************


-- Drop Table OrnekTablo;
/
Set ServerOutPut On;
/
Declare

Begin
  
    Execute Immediate 'Create Table OrnekTablo(Urun_id Number(10), Urun_Adi Varchar2(50))';
    
    dbms_output.put_line('Tablo olusturuldu');

End;
/
Desc OrnekTablo;
/
-- Yukarýda Create islemi yaptýk
-- Simdi yukarýdaki sorguyu parametrik yapalým

-- Drop Table OrnekTablo;

Declare
    ddl_komut Varchar2(2000);
Begin
    ddl_komut:= 'Create Table OrnekTablo(Urun_id Number(10), Urun_Adi Varchar2(50))';
    Execute Immediate ddl_komut;
    
    dbms_output.put_line('Tablo olusturuldu');

End;
/
Desc OrnekTablo;
/
-- #################################################################################
-- #################################################################################
-- #################################################################################
-- #################################################################################

-- Yukarýda Create islemi yaptýk, Simde de Alter Yapalým

Declare
    ddl_komut Varchar2(2000);
Begin
    ddl_komut:= 'Alter Table OrnekTablo Add Miktar Number(10,2)';
    Execute Immediate ddl_komut;
    
    dbms_output.put_line('Tablo Alter Edildi');

End;
/
Desc OrnekTablo;
/

-- System ile baglanalým
-- AliT3 User olusturalým ve buna yetki verelim

Declare
    ddl_Create Varchar2(2000);
    ddl_Grant Varchar2(2000);
Begin
    ddl_Create:= 'Create User Yaren1 identified by Yaren1';
    Execute Immediate ddl_Create;

    ddl_Grant:= 'Grant Connect, Resource, Unlimited TABLESPACE To Yaren1';
    Execute Immediate ddl_Grant;
    
    dbms_output.put_line('Yaren1 User olusturuldu ve yetki verildi');
End;
/
-- Simdi Yaren1 User?na sol ust taraftaki yesil Art? ile baglanalim

-- OracleData user?na baglanal?m

-- Yaren1 user icin OrnekTablo'ya Select yetkisi verelim

Declare
    ddl_komut Varchar2(2000);
Begin
    ddl_komut:= 'Grant Select On OrnekTablo To Yaren1';
    Execute Immediate ddl_komut;

    dbms_output.put_line('OrnekTablo icin Yaren1 user''ina SELECT yetkisi verildi');
End;

-- Yaren1 user'ýna Employees tablosu icin Select yetkisi verelim

Declare
    ddl_komut Varchar2(2000);
Begin
    ddl_komut:= 'Grant Select On Employees To Yaren1';
    Execute Immediate ddl_komut;

    dbms_output.put_line('Employees icin Yaren1 user''ina SELECT yetkisi verildi');

End;

-- Simdi Yaren1 User ile baglanalým

Select * From OracleData.OrnekTablo;
Select * From OracleData.Employees;

-- Simdi de Yaren1 kullanýcýsýna verile OrnekTablo yetkisini geri alalým
-- Simdi OracleData User ile baglanalým

Declare
    ddl_komut Varchar2(2000);
Begin
    ddl_komut:= 'Revoke Select On OrnekTablo From Yaren1';
    Execute Immediate ddl_komut;

    dbms_output.put_line('Yaren1 user''ýnýn OrnekTablo''daki Select yetkisi alýndý');
End;

-- Simdi Yaren1 User ile baglanalým

Select * From OracleData.OrnekTablo;
Select * From OracleData.Employees;

-- Simdi OracleData User ile baglanalým
-- OrnekTablo tablosunu drop edelim

Declare
    ddl_komut Varchar2(2000);

Begin
    ddl_komut:= 'Drop Table OrnekTablo';
    Execute Immediate ddl_komut;

    dbms_output.put_line('OrnekTablo Tablosu drop edildi');
End;
/
Desc OracleData.OrnekTablo;
/
Desc OracleData.Employees;
/
-- OracleData userina baglanal?m

--*********************************************************************************************
-- Pseudocolumns Kullanýmý  -- Takma Ad anlamýndadýr
  -- (Currval, Nextval) (Sequence)
  -- Sequence===> Sayý uretecleri
--*********************************************************************************************

Desc Regions;
/

Select * From Regions;

Create Sequence test_seqA Start With 6 increment by 1;
/
--

Declare

Begin
      insert into Regions(Region_id, Region_Name) Values(test_seqA.NextVal, 'Antartica');
      --RollBack;
      Commit;

End;
/
Select test_seqA.CurrVal From Dual;
/
Select * From Regions;

-- Sequenceleri yukarýdaki gibi kullanmak performanslý degildir
-- su sekilde kullanýrsak daha iyi
-- Bir degisken tanýmlarýz. bu sekilde kullaným tum versiyonlarda gecerlidir
-- Direk olaran values icerisinde veya esitligin saginda test_seqA.NextVal kullanmak
-- hem performanslý degil hem tum versiyonlarda kullanýlmaz

-- ornek seq_num ve buna deger atarýz(seq_num:= test_seqA.NextVal) 
-- Degiskene atama ile kullanmak hem performanslý hemde tum versiyonlarda kullanýlabilir
/
Declare
    seq_num Number;

Begin
      seq_num:= test_seqA.NextVal;
      insert into Regions(Region_id, Region_Name) Values(seq_num, 'Amerika');
      
      
      seq_num:= test_seqA.CurrVal;
      Update Regions
      Set Region_Name = 'America'
      Where Region_id = seq_num;    
      
      --RollBack;
      Commit;

End;
/
Select test_seqA.CurrVal From Dual;
/
Select * From Regions;
/
--*********************************************************************************************
-- Conditional Control Statements
-- (Kosullu Akis Kontrolleri)
--*********************************************************************************************

--  IF
-- CASE


--  IF
    -- If Then
    -- If Then Else
    -- If ThenIf

-- CASE
    -- Simple Case
    -- Searched Case    
/*
If Condition_1 Then
                  Statements_1;
End if;                  

--

If Condition_1 Then
                  Statements_1;
Else
                  Statements_2;
End if;

--

If Condition_1 Then
                  Statements_1;
ElsIf Condition_2 Then
                  Statements_2;
ElsIf Condition_3 Then
                  Statements_3;
Else
                  Statements_4;
End if;

--

-- CASE
-- Simple Case

Case Selector
    When Selector_Value_1 Then Statements_1
    When Selector_Value_2 Then Statements_2
    ...
    When Selector_Value_n Then Statements_n
    [Else else_Statements]
End Case;


Searched Case   

Case 
    When Condition_1 Then Statements_1
    When Condition_2 Then Statements_2
    ...
    When Condition_n Then Statements_n
    [Else else_Statements]
End Case;

*/

-- Kosullu Akis Kontrolleri If


Declare
    DogumTarihi   Date;
    Yasi          Number(3);
Begin
    DogumTarihi:= To_Date('21/11/2010','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz
    if Yasi < 15 Then
        dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
    End if;
End;

/

Declare
    DogumTarihi   Date;
    Yasi1          Number;
    Yasi2          Number(3);
Begin
    DogumTarihi:= To_Date('21/11/2010','dd/mm/yyyy');
    Yasi1:= SysDate - DogumTarihi;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz
    dbms_output.put_line(Yasi1);
    
    --DogumTarihi:= To_Date('21/11/1999','dd/mm/yyyy');
    Yasi1:= (SysDate - DogumTarihi)/365;
    
    --DogumTarihi:= To_Date('21/11/1999','dd/mm/yyyy');
    Yasi2:= (SysDate - DogumTarihi)/365;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    dbms_output.put_line(Yasi1);
    dbms_output.put_line(Yasi2);    
    
    
    if Yasi2 < 15 Then
        dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi2);
    End if;
End;
/
-- Kosullu Akýþ Kontrolleri if-then-else

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
Begin
    DogumTarihi:= To_Date('21/11/1999','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz
    if Yasi < 15 Then
        dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
    Else
        dbms_output.put_line('Ben 15 yasýndan Buyugum, Yasim: ' || Yasi);
    End if;
End;

/
-- Kosullu Akýþ Kontrolleri if-then-elseif

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
    
Begin

    DogumTarihi:= To_Date('21/11/2002','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz
    if Yasi < 15 Then
        dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
        dbms_output.put_line('Bayramlarý Severim');
        dbms_output.put_line('Begin-End Blogu zorunlu degildir');
    Elsif Yasi < 30 Then
    Begin
        dbms_output.put_line('Ben 16-30 yasý arasýndayým, Yasim: ' || Yasi);
        dbms_output.put_line('Begin-End Blogu zorunlu degildir');
    End;
    Elsif Yasi < 50 Then
        dbms_output.put_line('Ben 31-50 yasý arasýndayým, Yasim: ' || Yasi);
    Else
        dbms_output.put_line('Ben 50 Yasindan Buyugum, Sayg? Beklerim, Yasim: ' || Yasi);
    
    End if;

End;

/

/
-- Kosullu Akýþ Kontrolleri if Nested (iç içe if kullanýmý)

Declare
    DogumTarihi   Date;
    Yasi          Number(3);  
Begin
    DogumTarihi:= To_Date('21/11/1996','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz
    if Yasi < 15 Then
        dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
    Elsif Yasi < 30 Then
          dbms_output.put_line('Ben 16-30 yasý arasýndayým, Yasim: ' || Yasi);
        
        if Yasi >= 23 Then
          dbms_output.put_line('Ve Nested if icin ornek, 23-30 yasý arasýndayým, Yasim: ' || Yasi);        
        End if;
    Elsif Yasi < 50 Then
        dbms_output.put_line('Ben 31-50 yasý arasýndayým, Yasim: ' || Yasi);
    Else
        dbms_output.put_line('Ben 50 Yasindan Buyugum, Yasim: ' || Yasi);  
    End if;
End;
/

--*********************************************************************************************
-- Kosullu Akýþ Kontrolleri *** CASE(Simple Case - Searched Case)
--*********************************************************************************************
Set SERVEROUTPUT ON;
-- Simple Case:
-- Bir sayýnýn tek mi yoksa cift mi oldugunu bulan kod yazalým

Declare
      Sayi    Number:= 12;
      Mesaj   Varchar2(2000);
Begin
   Case Mod(Sayi,2)
        When 1 Then Mesaj:= 'Tek Sayý, Sayimiz: ' || Sayi;
        Else Mesaj:= 'Cift Sayý, Sayimiz: ' || Sayi;
        -- Sayinin 2 ye bolumunden kalan 1 degilse 0-Sýfýrdýr Else ile kontrol ediyoruz
   End Case;
   
   dbms_output.put_line(Mesaj);    
End;
/
-- Yukarýdaki ornekte sayýyý Ekrandan girelim
-- Ekrandan kullanýcýnýn sayý girmesi icin &(ampersant) isareti kullanýlýr
/
Declare
      Sayi    Number:= &Sayi_Giriniz;
      Mesaj   Varchar2(2000);
Begin
   Case Mod(Sayi,2)
        When 1 Then Mesaj:= 'Tek Sayý, Sayimiz: ' || Sayi;
        Else Mesaj:= 'Cift Sayý, Sayimiz: ' || Sayi;
        -- Sayinin 2 ye bolumunden kalan 1 degilse 0-Sýfýrdýr Else ile kontrol ediyoruz
   End Case;
   
   dbms_output.put_line(Mesaj);    
End;
/
-- Yukaridaki Simple Case ornegini Searched Case ile de yazalim
-- Simple Case icerisinde Nested Case yapabiliriz
-- Ayrýca Simple Case icerisinde Search Case kullanýlabilir

Declare
      Sayi    Number:= &Sayi_Giriniz;
      Mesaj   Varchar2(2000);
Begin
   Case 
        When Mod(Sayi,2) = 1 Then Mesaj:= 'Tek Sayý, Sayimiz: ' || Sayi;
        Else Mesaj:= 'Cift Sayý, Sayimiz: ' || Sayi;
        -- Sayinin 2 ye bolumunden kalan 1 degilse 0-Sýfýrdýr Else ile kontrol ediyoruz
   End Case;
   
   dbms_output.put_line(Mesaj);    
End;
/
Declare
      Sayi    Number(5);
      Mesaj   Varchar2(2000);
Begin
    Sayi:= &Sayi_Giriniz;
   Case 
        When Mod(Sayi,2) = 1 Then Mesaj:= 'Tek Sayý, Sayimiz: ' || Sayi;
        Else Mesaj:= 'Cift Sayý, Sayimiz: ' || Sayi;
        -- Sayinin 2 ye bolumunden kalan 1 degilse 0-Sýfýrdýr Else ile kontrol ediyoruz
   End Case;
   
   dbms_output.put_line(Mesaj);    
End;
/
-- Baska bir ornek yapalým

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
Begin
    DogumTarihi:= To_Date('21/11/2012','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;   
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    Case Yasi
          When 15 Then dbms_output.put_line('Ben 15 yasýndayým, Yasim: ' || Yasi);
          When 30 Then dbms_output.put_line('Ben 30 yasýndayým, Yasim: ' || Yasi);
          When 50 Then dbms_output.put_line('Ben 50 yasýndayým, Yasim: ' || Yasi);
          Else dbms_output.put_line('Yasim 15,30 ve 50 den farklýdýr, Yasim: ' || Yasi);
    End Case;    
End;
/
-- Searched Case:

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
Begin
    DogumTarihi:= To_Date('21/11/2012','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;   
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    Case 
          When Yasi < 15 Then dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
          When Yasi < 30 Then dbms_output.put_line('Ben 16-30 yasý arasýndayým, Yasim: ' || Yasi);
          When Yasi < 50 Then dbms_output.put_line('Ben 31-50 yasý arasýndayým, Yasim: ' || Yasi);
          Else dbms_output.put_line('Ben 50 Yasindan Buyugum, Yasim: ' || Yasi);
    End Case;    
End;

/

-- Yukarýdaki sonucu degisken ile kullanalým

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
    Mesaj         Varchar2(2000);
Begin
    DogumTarihi:= To_Date('21/11/2012','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;   
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    Case 
          When Yasi < 15 Then Mesaj := 'Ben 15 yasýndan kucugum';
          When Yasi < 30 Then Mesaj := 'Ben 16-30 yasý arasýndayým';
          When Yasi < 50 Then Mesaj := 'Ben 31-50 yasý arasýndayým';
          Else                Mesaj := 'Ben 50 Yasindan Buyugum';
    End Case;
    dbms_output.put_line(Mesaj || ', Yasim: ' || Yasi);   
End;
/
-- Simdi Case icerisinde Case kullanalým
-- Case Nested Case ornegi yapalým

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
    Mesaj         Varchar2(2000);
Begin
    DogumTarihi:= To_Date('21/11/2002','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;   
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    Case 
          When Yasi < 15 Then Mesaj := 'Ben 15 yasýndan kucugum';
          When Yasi < 30 Then Mesaj := 'Ben 16-30 yasý arasýndayým';
              Case
                    When yasi < 24 Then Mesaj:= Mesaj || ' ve 24 yasindan da kucugum!';
                    Else Mesaj := Mesaj || ' ve 24''ten Buyugum';
              End Case;
          When Yasi < 50 Then Mesaj := 'Ben 31-50 yasý arasýndayým';
          Else                Mesaj := 'Ben 50 Yasindan Buyugum';
    End Case;
    dbms_output.put_line(Mesaj || ', Yasim: ' || Yasi);   
End;
/

--*********************************************************************************************
-- Iterative Control Statements : Loops
-- (Tekrarlý ifadeler: Donguler)
--*********************************************************************************************
/*

  Basic Loop
  For Loop
  While Loop
  
*/

  -- ***** Basic Loop *****
/*
LOOP
    STATEMENT 1;
    STATEMENT 2;
    [if condition then
      Exit; Continue
    end if;]
    
    [Exit When Exit_Condition]
    [Continue When Continue_Condition]  
    
    STATEMENT N;
END LOOP;

*/
-- Basic Loop ile For Loop arasýndaki fark
-- Basic Loop'ta if kosulu koymak zorundayýz yoksa sonsuz donguye girer
-- For Loop'ta ise belirli bir sayac oldugu icin koymak zorunda degiliz


  -- ***** For Loop *****
/*
FOR loop_Counter IN
            [REVERSE] lower_limit... upper_limit
LOOP
    STATEMENT 1;
    STATEMENT 2;
    [if condition then
      Exit; Continue
    end if;]
    
    [Exit When Exit_Condition]
    [Continue When Continue_Condition]  
    
    STATEMENT N;
END LOOP;
*/  

  -- ***** While Loop *****

/*

WHILE Condition LOOP
    STATEMENT 1;
    STATEMENT 2;
    [if condition then
      Exit; Continue
    end if;]
    
    [Exit When Exit_Condition]
    [Continue When Continue_Condition]  
    
    STATEMENT N;
END LOOP;
*/   
  
  -- ***** Cursors *****  
/* BUNU AYRICA INCELEYECEGIZ */  
  
--*********************************************************************************************
-- Iterative Control Statements : Basic Loops
--*********************************************************************************************

/

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      dbms_output.put_line('Sayac : ' || Sayac);
      
        if Sayac = 5 then
            Exit;
        end if;        
    END LOOP;  
End;

/

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      dbms_output.put_line('Sayac : ' || Sayac);
      
        Exit When Sayac = 5;
    END LOOP;  
End;       

/

-- Tek sayýlarý yazdýran bir kod yazalým

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      
        if mod(Sayac,2) = 0 then
            Continue;
        -- Anlamý su; Eger Sayý cift sayý ise Loop'un basladýgý yere geri don ve devam et
        end if;        

      dbms_output.put_line('Sayac : ' || Sayac);

        if Sayac = 5 then
            Exit;
        end if; 
        
    END LOOP;  
End;

/
-- Yukarýdaki ornegi Continue When Continue_Condition ile yapalým

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      
        Continue When mod(Sayac,2) = 0;
        -- Anlamý su; Eger Sayý cift sayý ise Loop'un basladýgý yere geri don ve devam et        

      dbms_output.put_line('Sayac : ' || Sayac);

        if Sayac = 5 then
            Exit;
        end if;         
    END LOOP;  
End;
/
-- veya soyle yazalým

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;      
        Continue When mod(Sayac,2) = 0;
        -- Anlamý su; Eger Sayý cift sayý ise Loop'un basladýgý yere geri don ve devam et
      dbms_output.put_line('Sayac : ' || Sayac);

        Exit When Sayac = 5;        
    END LOOP;  
End;
/
-- Basic Loop ===> Ornek
-- Kurslar isimli Bir Tablo Olusturalým
-- ve icerisine 6 Adet kayýt girelim

-- Drop Table Kurslar;

Create Table Kurslar
(
  Kurs_id         Number(3),
  Kurs_Adi        Varchar2(30),
  Egitmen_Adi     Varchar2(30),
  BaslangicTarihi Date,
  BitisTarihi     Date  
);

/

Declare
    Rec_Kurs  Kurslar%RowType;
Begin    
    Rec_Kurs.Egitmen_Adi := 'Ali TOPACIK';
    Rec_Kurs.BaslangicTarihi  := Trunc(SysDate);
    Rec_Kurs.BitisTarihi  := Rec_Kurs.BaslangicTarihi + 5;

    LOOP
              Rec_Kurs.Kurs_id := NVL(Rec_Kurs.Kurs_id,0) + 1;
              
              Select Decode(Rec_Kurs.Kurs_id,1,'Oracle SQL',
                                             2,'PL/SQL',
                                             3,'MS SQL',
                                             4,'TRANSACT SQL',
                                             5,'Google Big Query',
                                             6,'Power BI',
                                             7, 'Excel',
                                             8, 'Excel VBA',
                                             9, 'LOGO TIGER3 ENTERPRISE'
                           )
                into Rec_Kurs.Kurs_Adi
              From Dual;
          
          insert into Kurslar(Kurs_id, Kurs_Adi, Egitmen_Adi, BaslangicTarihi, BitisTarihi)
                 Values(Rec_Kurs.Kurs_id, Rec_Kurs.Kurs_Adi, Rec_Kurs.Egitmen_Adi, Rec_Kurs.BaslangicTarihi, Rec_Kurs.BitisTarihi);
      
          Rec_Kurs.BaslangicTarihi  := Rec_Kurs.BitisTarihi + 1;
          Rec_Kurs.BitisTarihi  := Rec_Kurs.BaslangicTarihi + 5;
          Exit When Rec_Kurs.Kurs_id = 9;        
        
    END LOOP;
    Commit;
End;
/

Select *
From Kurslar;
/
-- Sales_Orders Tablosunda
-- 2007(orderdate alan? kullan?n?z) y?l?ndaki USA ulkesinin sipari?lerini
-- bulan sorguyu yaz?n?z

Select *
From Sales_Orders
Where To_Char(orderdate,'YYYY')= 2007 and shipcountry = 'USA';

-- Sales_Orders Tablosunda
-- 2007(orderdate alan? kullan?n?z) y?l?ndaki USA ulkesinin sipari?lerini veren
-- 1,2,4,6,9 nolu empid'lerin sipari?lerini bulunuz


Select *
From Sales_Orders
Where   To_Char(orderdate,'YYYY')= 2007 and 
        shipcountry = 'USA' and
        empid in(1,2,4,6,9);

/        

-- Ornek
-- Sales_Orders tablosunda
-- 2007 y?l?nda Toplam Freight degeri en yuksek olan
-- ilk 3 eleman?n 2008 y?l? verilerini bulunuz
        
With
A as
(
    Select empid
    From Sales_Orders
    Where To_Char(orderdate,'YYYY') = 2007
    Group By empid
    Order By sum(Freight) desc
)
Select *
From Sales_Orders
Where   To_Char(orderdate,'YYYY') = 2008 and
        empid in(
                    Select *
                    From A
                    Where ROWNUM <= 3
               );

/

Select *
From Sales_Orders
Where   To_Char(orderdate,'YYYY') = 2008 and
        empid in(1,3,4); 
