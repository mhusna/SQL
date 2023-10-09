--*********************************************************************************************
/*
  Standalone Functions

  Recursive Function
  (Yinelemeli- Kendi Kendini ça??ran fonksiyon)
*/
--*********************************************************************************************

-- Ornek;
-- Faktoriyel hesab? yapan bir function yazal?m
-- ve bu function kendi kendini ca??rarak bu i?i yaps?n
Create Or Replace Function Faktoriyel(n integer)
Return integer IS
    wfact integer;
Begin
  if    n = 0 Then
    wfact:= 1;
  Elsif n = 1 Then
    wfact:= 1;
  Elsif n < 0 Then
    wfact:= null;
  Else
    wfact:= n * faktoriyel(n-1);
  End if;
  Return(wfact);
End;

/

Select '5! = ' || faktoriyel(5)  From Dual;
Select '0! = ' || faktoriyel(0)  From Dual;
Select '1! = ' || faktoriyel(1)  From Dual;
Select '-5!= ' || faktoriyel(-5) From Dual;
Select '9! = ' || faktoriyel(9)  From Dual;

/

--*********************************************************************************************
/*
PACKAGES
PL/SQL Nesnelerinin, bir isim alt?nda toplanm?? mant?ksal kolleksiyonudur

 

Package ?çinde Hangi PL/SQL Nesneleri Bulunabilir?
    Developer-Defined Data Types
    Variables
    Constants (Sabitler) Ornegin pi say?s?, zam oran? v.s.
    Cursors
    Functions
    Procedures
*/
--*********************************************************************************************
/*
Packages

 


  Package Specification (Tan?mlama Bölümü)
      •	Paket içinde yer alacak Functions ve Procedures ba?l?k bilgilerini ve
      •	PUBLIC De?i?kenler, Sabitler, Developer Data- Types, Cursors tan?mlar?n? içerir.

 

  Package Body(Çal??abilir Kodlar Bölümü) 
      •	Paket içinde yer alan Functions ve Procedures için Executable kodlar? ve
      •	PRIVATE De?i?kenler, Sabitler, Developer Data-Types, Cursors tan?mlar?n? içerir.

 

*/

 

 

--*********************************************************************************************
/*
Syntax 

Package Specification(Tan?mlama Bölümü)

 

CREATE OR REPLACE PACKAGE package_name IS
    [declarations of variables and types]
    [specifications of cursors]
    [specifications of function]
    [specifications of procedure]
END [package_name];

 

Package Body(Çal??abilir Kodlar Bölümü) 

CREATE OR REPLACE PACKAGE BODY package_name IS
    [declarations of variables and types]
    [specifications of cursors]
    [specifications of function]        
          BEGIN
              ...
          END;

    [specifications of procedure]        
          BEGIN
              ...              
          END;
END [package_name];
*/

 

/*
Package Nesnesine nas?l referans verilir

 

Packageismi.Nesneismi
*/

 

/*
Package icindeki Function ve Procedure nas?l calistirilir

 

Variable_Name:= Paketismi.Functionismi(parametreler);

 

Paketismi.Procedureismi(parametreler);
*/

 

/*
Package Kullanman?n Avantajlar?
    Modularity(Moduler olmas?/Merkezi bir yerden yonetilebilir olmas?)
    Overloading(Birden fazla ayn? isimde ve esit say?da
                parametrik Fonksiyonlar ve Procedure'lar tan?mlanabilir
                Sadece parametrelerin veritipleri degisir)
    Better Performance (paket ilk kullan?mda diskten Memory'e yerlesir ve direk memoryden calisir
                        o yuzden daha iyi performans gosterir)
*/
--*********************************************************************************************

 

--*********************************************************************************************
/*
Package Specification(Tan?mlama Bölümü)
Örnek 1

 

Çok kullan?lan nesnelerin tan?mland??? bir PACKAGE örne?i olu?turaca??z.

 

Not: Paket içinde FUNCTION ve PROCEDURE olmayacaksa, BODY k?sm?n? tan?mlamaya gerek yoktur.

 

*/
--*********************************************************************************************
CREATE OR REPLACE PACKAGE myTypes AS
    TYPE empData IS RECORD
                                          (
                                            emp_id employees.employee_id%type,
                                            f_name employees.first_name%type
                                          );

    PI CONSTANT NUMBER(3,2) := 3.14;

    TYPE cursor_type IS REF CURSOR; -- Bos bir cursor olusturuyoruz

    myException Exception;

 

END myTypes;
/

 

 

-- Ornek 2
-- Paket icinde tan?ml? nesnelerin PL/SQL bloklar?nda kullan?m?

 

DECLARE
    wempdata	myTypes.empData;  -- myTypes paketi icerisindeki empData olarak tan?ml? Record anlam?ndad?r
    c_cursor	myTypes.cursor_type;
    r	number := 5;  -- Yar?capi r olan dairenin alan?n? bulal?m (pi * r2)

BEGIN
    OPEN c_cursor FOR SELECT employee_id, first_name FROM EMPLOYEES;
        LOOP
            FETCH c_cursor INTO wempdata;
            EXIT WHEN c_cursor%NOTFOUND;
            dbms_output.put_line(wempdata.emp_id || ' ' || wempdata.f_name);
        END LOOP;
    CLOSE c_cursor;

     dbms_output.put_line('pi Sayisi = ' || myTypes.PI);
    dbms_output.put_line(r || ' Yaricapli dairenin alani = ' || myTypes.PI * POWER(r, 2) );
END;
/
-- Ornek
-- Paket icinde PROCEDURE tan?m?

 

CREATE OR REPLACE PACKAGE myTypesB AS
    TYPE empData IS RECORD
    (
      emp_id employees.employee_id%type,
      f_name employees.first_name%type
    );

    PI CONSTANT NUMBER(3,2) := 3.14;    
    TYPE cursor_type IS REF CURSOR; -- Bos bir cursor olusturuyoruz
    myException Exception;

    Procedure Calisanlar(p_dept_id Employees.Department_id%type);

 

END myTypesB;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesB AS
    Procedure Calisanlar(p_dept_id Employees.Department_id%type) is
        wempdata	myTypesB.empData;     -- myTypesB paketi icerisindeki empData olarak tan?ml? Record anlam?ndad?r
        c_cursor	myTypesB.cursor_type;
        -- c_cursor	cursor_type; -- Body icinde kullanacaksak paket ad? yazmadanda yapabiliriz


    Begin
        OPEN c_cursor FOR SELECT employee_id, first_name FROM EMPLOYEES Where Department_id = p_dept_id;
            LOOP
                FETCH c_cursor INTO wempdata;
                EXIT WHEN c_cursor%NOTFOUND;
                dbms_output.put_line(wempdata.emp_id || ' ' || wempdata.f_name);
            END LOOP;
        CLOSE c_cursor;    
    End;
END myTypesB;
/

 

Execute myTypesB.Calisanlar(60);
Exec myTypesB.Calisanlar(60);
Exec myTypesB.Calisanlar(50);
/

 

DECLARE    
BEGIN    
    myTypesB.Calisanlar(60);
END;
/
BEGIN    
    myTypesB.Calisanlar(60);
END;
/

-- Ornek
-- Paket icinde BODY k?sm?nda PROCEDURE tan?mlarken paket ad?n? yazmadan ayn? ornegi yapal?m

 

CREATE OR REPLACE PACKAGE myTypesC AS
    TYPE empData IS RECORD
    (
      emp_id employees.employee_id%type,
      f_name employees.first_name%type
    );

    PI CONSTANT NUMBER(3,2) := 3.14;    
    TYPE cursor_type IS REF CURSOR; -- Bos bir cursor olusturuyoruz
    myException Exception;

    Procedure Calisanlar(p_dept_id Employees.Department_id%type);

 

END myTypesC;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesC AS
    Procedure Calisanlar(p_dept_id Employees.Department_id%type) is
        wempdata	empData;     -- myTypesC paketi icerisindeki empData olarak tan?ml? Record anlam?ndad?r
        c_cursor	cursor_type; -- Body icinde kullanacaksak paket ad? yazmadanda yapabiliriz

    Begin
        OPEN c_cursor FOR SELECT employee_id, first_name FROM EMPLOYEES Where Department_id = p_dept_id;
            LOOP
                FETCH c_cursor INTO wempdata;
                EXIT WHEN c_cursor%NOTFOUND;
                dbms_output.put_line(wempdata.emp_id || ' ' || wempdata.f_name);
            END LOOP;
        CLOSE c_cursor;    
    End;
END myTypesC;
/

 

Execute myTypesC.Calisanlar(60);
/

 

-- Paket icinde FUNCTION kullan?m?

 

CREATE OR REPLACE PACKAGE myTypesD AS
    TYPE empData IS RECORD
    (
      emp_id employees.employee_id%type,
      f_name employees.first_name%type
    );

    PI CONSTANT NUMBER(3,2) := 3.14;    
    TYPE cursor_type IS REF CURSOR; -- Bos bir cursor olusturuyoruz
    myException Exception;

    Procedure Calisanlar(p_dept_id Employees.Department_id%type);
    Function DaireninAlani(r Number) Return Number;
END myTypesD;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesD AS
    Procedure Calisanlar(p_dept_id Employees.Department_id%type) is
        wempdata	empData;     -- myTypesD paketi icerisindeki empData olarak tan?ml? Record anlam?ndad?r
        c_cursor	cursor_type; -- Body icinde kullanacaksak paket ad? yazmadanda yapabiliriz

    Begin
        OPEN c_cursor FOR SELECT employee_id, first_name FROM EMPLOYEES Where Department_id = p_dept_id;
            LOOP
                FETCH c_cursor INTO wempdata;
                EXIT WHEN c_cursor%NOTFOUND;
                dbms_output.put_line(wempdata.emp_id || ' ' || wempdata.f_name);
            END LOOP;
        CLOSE c_cursor;    
    End;

    Function DaireninAlani(r Number) Return Number is
        wsonuc Number;
    Begin
        wsonuc:= myTypesD.PI * POWER(r, 2);
        Return(wsonuc);
    End;
END myTypesD;
/

 

Select ' Yaricapli dairenin alani = ' || myTypesD.DaireninAlani(5) From Dual;
/

 

Declare
Begin
    dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesD.DaireninAlani(5));
End;
/

 

Begin
    dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesD.DaireninAlani(5));
End;
/
-- Simdi sadece function olarak sade bir paket yapal?m

 

CREATE OR REPLACE PACKAGE myTypesE AS
    PI CONSTANT NUMBER(3,2) := 3.14;    
    Function DaireninAlani(r Number) Return Number;
END myTypesE;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesE AS

    Function DaireninAlani(r Number) Return Number is
        wsonuc Number;
    Begin
        wsonuc:= myTypesE.PI * POWER(r, 2);
        Return(wsonuc);
    End;
END myTypesE;
/

 

Select ' Yaricapli dairenin alani = ' || myTypesE.DaireninAlani(5) From Dual;
/

 

 

Declare
Begin
    dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesE.DaireninAlani(5));
End;
/

 

Begin
    dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesE.DaireninAlani(5));
End;
/

 

-- Yukar?daki ornegin body k?sm?ndaki Function icerisinde paket ad? yazmadan PI sayis?na ulasal?m

 

CREATE OR REPLACE PACKAGE myTypesL AS
    PI CONSTANT NUMBER(3,2) := 3.14;    
    Function DaireninAlani(r Number) Return Number;
END;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesL AS

    Function DaireninAlani(r Number) Return Number is
        wsonuc Number;
    Begin
        wsonuc:= PI * POWER(r, 2);  -- Ayn? paket icinde oldugu icin myTypesL yazmadanda PI sabitini cagirabiliriz
        Return(wsonuc);
    End;
END;
/

 

 

Select ' Yaricapli dairenin alani = ' || myTypesL.DaireninAlani(5) From Dual;
/

 

Begin
    dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesL.DaireninAlani(5));
End;
/

 

Declare
  Sonuc Number;
Begin
    Sonuc:= myTypesL.DaireninAlani(5);
    dbms_output.put_line(' Yaricapli dairenin alani = ' || Sonuc);
End;
/

-- Function icinde procedure cagr?labilir
-- Procedure icinde function cagrilabilir

 

CREATE OR REPLACE PACKAGE myTypesM AS
    PI CONSTANT NUMBER(3,2) := 3.14;    

    Procedure Calisanlar;

    Function DaireninAlani(r Number) Return Number;
END myTypesM;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesM AS
    Function DaireninAlani(r Number) Return Number is
        wsonuc Number;
    Begin
        wsonuc:= myTypesM.PI * POWER(r, 2);
        Return(wsonuc);
    End;

 

    Procedure Calisanlar is        
    Begin
        dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesM.DaireninAlani(5));
    End;

END myTypesM;
/

 

Execute myTypesM.Calisanlar;
/

 

-- Body k?sm?nda once function ve procedure farketmez
-- Yani s?ras? onemli degildir
-- Hangisi olursa olsun calisir

 

CREATE OR REPLACE PACKAGE myTypesM2 AS
    PI CONSTANT NUMBER(3,2) := 3.14;       
    Procedure Calisanlar;
    Function DaireninAlani(r Number) Return Number;
END myTypesM2;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesM2 AS
    Procedure Calisanlar is        
    Begin
        dbms_output.put_line(' Yaricapli dairenin alani = ' || myTypesM2.DaireninAlani(5));
        -- veya
        -- dbms_output.put_line(' Yaricapli dairenin alani = ' || DaireninAlani(5));
    End;

 

    Function DaireninAlani(r Number) Return Number is
        wsonuc Number;
    Begin
        wsonuc:= myTypesM2.PI * POWER(r, 2);
        Return(wsonuc);
    End;    
END myTypesM2;
/

 

Execute myTypesM2.Calisanlar;
/

 

-- Begin End Blogunun sonunda paket ismini yazmasakta olur

 

CREATE OR REPLACE PACKAGE myTypesM3 AS
    PI CONSTANT NUMBER(3,2) := 3.14;       
    Procedure Calisanlar;
    Function DaireninAlani(r Number) Return Number;
END;
/

 

CREATE OR REPLACE PACKAGE BODY myTypesM3 AS
    Procedure Calisanlar is        
    Begin
        dbms_output.put_line(' Yaricapli dairenin alani = ' || DaireninAlani(5));
    End;

 

    Function DaireninAlani(r Number) Return Number is
        wsonuc Number;
    Begin
        wsonuc:= PI * POWER(r, 2);
        Return(wsonuc);
    End;    
END;
/

 

Execute myTypesM3.Calisanlar;
/