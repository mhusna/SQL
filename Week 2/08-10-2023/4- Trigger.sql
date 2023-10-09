--*********************************************************************************************
/*
      TRIGGERS

  Herhangi bir durum(event) olustugunda otomatik olarak calisan(tetiklenen)
  PL/SQL programlar?d?r
*/
--*********************************************************************************************

/*
Triggers

 A) DML Triggers(Table Level, Row Level)
            (Insert, Update, Delete) 
      * Before ve
      * After olmak uzere ikiye ayr?l?r

B) Schema Triggers(Create, Drop, Alter)

C) Database Triggers(Logon, Logoff, Shutdown, Startup)
*/

--*********************************************************************************************
/*
A) DML Triggers(Table Level, Row Level)
            (Insert, Update, Delete) 
      * Before ve
      * After olmak uzere ikiye ayr?l?r
*/
--*********************************************************************************************

-- DML TRIGGERS

-- Ornek (Table Level)
-- Mesai saatlari disinda DML islemleri(INSERT, UPDATE, DELETE) yapilamasin

Select TO_CHAR(sysdate, 'HH24:MI') From Dual;
Select TO_CHAR(sysdate, 'DY') From Dual;

/

Create Or Replace Trigger Dml_Departments
    Before insert Or update Or delete On Departments
Begin
    If TO_CHAR(sysdate, 'HH24:MI') not between '08:00' and '18:00' or
       TO_CHAR(sysdate, 'DY') in ('SAT', 'SUN', 'CMT', 'PAZ') Then
            Raise_Application_Error(-20205, 'Mesai saatleri disinda veri isleme yapilamaz!');
    End if;
End;

/
Select * From Departments;
/

Delete from Departments where Department_id = 303;
Rollback;

/

-- Sartlari degistirelim. Oglen 12-13 aras?nda DML yap?lamas?n.
Create Or Replace Trigger Dml_Departments
    Before insert Or update Or delete On Departments
Begin
    If TO_CHAR(sysdate, 'HH24:MI') between '12:00' and '13:00' Then
        Raise_Application_Error(-20205, 'Oglen 12:00 - 13:00 saatlerinde (DML) veri isleme yapilamaz!');
    End if;
End;

/
Select * From Departments Where Department_id = 303;
/

Delete from Departments where Department_id = 303;
Rollback;

/
Select * From Departments Where Department_id = 303;
/

-- Sartlari degistirelim
-- Sal? Gunleri DML yap?lamas?n
Select TO_CHAR(sysdate, 'DY') From Dual;
/

Create Or Replace Trigger Dml_Departments
    Before insert Or update Or delete On Departments
Begin
    If TO_CHAR(sysdate, 'DY') in ('SAL', 'TUE') Then
        Raise_Application_Error(-20205, 'Sal? Gunleri veri isleme yapilamaz!');
    End if;
End;

/

Delete from Departments where Department_id = 303;
Rollback;

/
Select * From Departments Where Department_id = 303;
/

-- Trigger drop etme komutu.
Drop Trigger Dml_Departments;
/

-- Sartlari degistirelim
-- Sal? Gunleri 08-00 - 18.00 d?s?nda DML yap?lamas?n
Create Or Replace Trigger Dml_Departments
  Before insert Or update Or delete On Departments
Begin
    if TO_CHAR(sysdate, 'DY') in ('SAL', 'TUE') and
       TO_CHAR(sysdate, 'HH24:MI') not between '08:00' and '18:00' Then
        Raise_Application_Error(-20205, 'Sal? Gunleri 08:00-18:00 disinda veri isleme yapilamaz!');
    End if;
End;

/

Delete from Departments where Department_id = 303;
Rollback;

/
Select * From Departments Where Department_id = 303;
/

/*
DML Trigger(Table Level)
Örnek 2
    Senaryo : Mesai saatleri d???nda DML i?lemleri (INSERT, UPDATE, DELETE) yap?lamas?n
    Bu senaryoyu di?er tablolara da uygulayal?m.
    Bunun için yap?lan saat ve gün kontrolünü bir STANDALONE PROCEDURE ?eklinde yaz?p bu
    PROCEDURE’? Table Level Trigger içinde çal??t?raca??z
    -- Bu islemi PAKET icinde de yapabiliriz
*/

Create Or Replace Procedure dml_guvenlik_kontrolu is
Begin
        if TO_CHAR(sysdate, 'DY') in ('PAZ', 'SUN') and
           TO_CHAR(sysdate, 'HH24:MI') between '12:00' and '14:00' Then
                Raise_Application_Error(-20205, 'Pazar Gunleri 12-14 aras?nda veri isleme yapilamaz!');
        End if;
End;

/

Create Or Replace Trigger Dml_Departments
  Before insert Or update Or delete On Departments
Begin
    dml_guvenlik_kontrolu;
End;
/

delete from Departments where Department_id = 303;
Rollback;
Select * From Departments Where Department_id = 303;
/

-- Trigger disable etme.
Alter Trigger Dml_Departments Disable;

delete from Departments where Department_id = 303;
Select * From Departments Where Department_id = 303;
Rollback;
Select * From Departments Where Department_id = 303;

-- Trigger enable etme.
Alter Trigger Dml_Departments Enable;

delete from Departments where Department_id = 303;
Select * From Departments Where Department_id = 303;
Rollback;
Select * From Departments Where Department_id = 303;

-- Simdi kosullar? degistirelim
Create Or Replace Procedure dml_guvenlik_kontrolu is
Begin
    if TO_CHAR(sysdate, 'HH24:MI') between '12:00' and '18:00' Then            
            Raise_Application_Error(-20205, '12-18 aras?nda veri isleme yapilamaz!');
    End if;
End;

/

Create Or Replace Trigger Dml_Departments
  Before insert Or update Or delete On Departments
Begin
    dml_guvenlik_kontrolu;
End;

/

delete from Departments where Department_id = 303;
Rollback;
Select * From Departments Where Department_id = 303;

/

Alter Trigger Dml_Departments Disable;

delete from Departments where Department_id = 303;
Select * From Departments Where Department_id = 303;
Rollback;
Select * From Departments Where Department_id = 303;

Alter Trigger Dml_Departments Enable;

delete from Departments where Department_id = 303;
Select * From Departments Where Department_id = 303;

/

Create Table jobs as
Select *
From hr.jobs;

/

Create or Replace Trigger trg_dml_jobs
  Before insert or update or delete ON jobs
Begin
    dml_guvenlik_kontrolu;
End;

/

delete from jobs Where job_id = 'AD_PRES';
Select * From jobs Where job_id = 'AD_PRES';
Rollback;

/

Alter Trigger trg_dml_jobs Disable;

delete from jobs Where job_id = 'AD_PRES';
Select * From jobs Where job_id = 'AD_PRES';
Rollback;

Update jobs
Set JOB_TITLE ='CEO' 
Where job_id = 'AD_PRES';

/

Select * From jobs Where job_id = 'AD_PRES';
Rollback;
Select * From jobs Where job_id = 'AD_PRES';

Alter Trigger trg_dml_jobs Enable;

Update jobs 
Set JOB_TITLE ='CEO' 
Where job_id = 'AD_PRES';
/
Select * From jobs Where job_id = 'AD_PRES';
-- Rollback;
Select * From jobs Where job_id = 'AD_PRES';
/
-- Simdi Employees2 tablosunda yapal?m
Create Table Employees2 as
Select *
From employees;
/
Select * From employees2;
/
Create or Replace Trigger trg_dml_employees2
Before insert or update or delete ON Employees2
Begin
    dml_guvenlik_kontrolu;
End;
/

 

Update employees2 
Set EMAIL = 'kinga' 
Where job_id = 'AD_PRES';
/
Select * From jobs Where job_id = 'AD_PRES';
Rollback;
Select * From employees2 Where job_id = 'AD_PRES';
/
Desc Employees2;
/
Alter Trigger trg_dml_Employees2 Disable;
/

 

Update employees2 Set EMAIL = 'kinga' Where job_id = 'AD_PRES';
Select * From employees2 Where job_id = 'AD_PRES';
Rollback;
Select * From employees2 Where job_id = 'AD_PRES';
/
Alter Trigger trg_dml_Employees2 Enable;
/
Update employees2 Set EMAIL = 'kinga' Where job_id = 'AD_PRES';
Select * From employees2 Where job_id = 'AD_PRES';
-- Rollback;
Select * From employees2 Where job_id = 'AD_PRES';
/

/*
DML Trigger (Audit Trigger - Log Trigger)

 

Ornek 3

 

Senaryo : REGIONS tablosu üzerinde yap?lan DML i?lemlerinin
(INSERT, UPDATE, DELETE) Log kay?tlar?n? tutal?m

 

Bunun için önce Log kay?tlar?n? tutan bir tablo olu?turaca??z
Daha sonra da log kay?tlar? için trigger yazaca??z

 

*/

/*
:NEW ve :OLD ifadeleri

 

Tabloya INSERT edilen ya da UPDATE edilen kolonlar?n YEN? bilgilerine
:NEW.<column_name> ?eklinde eri?ilebilir

 

Tabloda DELETE edilen ya da UPDATE edilmeyen kolonlar?n ESK? bilgilerine
:OLD.<column_name> ?eklinde eri?ilebilir

 

*/

Create Table regions as
Select *
From hr.Regions;

Create Table Regions_Log
(
  Region_id Number,
  Region_Name Varchar2(25),
  KimYapti  Varchar2(30),
  NeZaman   Date,
  NeYapti   Varchar2(10)
);
/

Create Or Replace Trigger trg_Regions_Audit_Log
After insert or update or delete On Regions
For Each Row -- Eger tek bir kolon takip edilecekse kolon ismi yaz?l?r
             -- Biz burada tum kolonlar? takip ediyoruz

 

Declare      -- Eger degisken olacak ise Declare icerisinde belirtebiliriz
    wislem Varchar2(10);
Begin
    wislem:= Case
                      When inserting  Then 'insert'
                      When updating   Then 'update'
                      When deleting   Then 'delete'
                 End;

    if inserting Then
        insert into Regions_Log(Region_id,Region_Name,KimYapti,NeZaman,NeYapti)
                    Values(:NEW.Region_id,:NEW.Region_Name, User, sysdate, wislem);
    End if;

 

    if updating Then

        insert into Regions_Log(Region_id,Region_Name,KimYapti,NeZaman,NeYapti)
                    Values(:OLD.Region_id,:OLD.Region_Name, User, sysdate, wislem || '_OLD');

 

        insert into Regions_Log(Region_id,Region_Name,KimYapti,NeZaman,NeYapti)
                    Values(NVL(:NEW.Region_id,:OLD.Region_id),    -- :NEW.Region_id null degilse kendisi, null ise :OLD.Region_id(2.parametreyi) donderir
                           NVL(:NEW.Region_Name,:OLD.Region_Name),
                           User, sysdate, wislem || 'NEW');   
    End if;

 

    if deleting Then
        insert into Regions_Log(Region_id,Region_Name,KimYapti,NeZaman,NeYapti)
                    Values(:OLD.Region_id,:OLD.Region_Name, User, sysdate, wislem);    
    End if;

End;
/

insert into Regions(Region_id, Region_Name)
            Values(12,'Anadolu');
-- RollBack;         
Commit;
Select * From Regions;
Select * From Regions_Log;

insert into Regions(Region_id, Region_Name)
            Values(13,'Test');
-- RollBack;         
Commit;
Select * From Regions;
Select * From Regions_Log;

Update Regions
Set Region_Name = 'Space Universe'
Where Region_id = 13;
Commit;
Select * From Regions;
Select * From Regions_Log;

Delete Regions
Where Region_id = 13;
Commit;
Select * From Regions;
Select * From Regions_Log;

/

select sys_context('USERENV','OS_USER') client_user,
       sys_context('USERENV','IP_ADDRESS') client_ip,
       SYS_CONTEXT('USERENV','HOST') client_machine, User
from dual;

-- Ornegimizi biraz daha gelistirelim
Create Table Regions2 as
Select * From Regions;
/

Create Table Regions2_Log
(
  Region_id Number,
  Region_Name Varchar2(25),
  KimYapti  Varchar2(30),
  client_user Varchar2(100),
  client_ip Varchar2(20),
  client_machine Varchar2(100),
  NeZaman   Date,
  NeYapti   Varchar2(10)
);
/

Create Or Replace Trigger trg_Regions2_Audit_Log
After insert or update or delete On Regions2
For Each Row -- Eger tek bir kolon takip edilecekse kolon ismi yaz?l?r
             -- Biz burada tum kolonlar? takip ediyoruz

 

Declare      -- Eger degisken olacak ise Declare icerisinde belirtebiliriz
    wislem Varchar2(10);
Begin
    wislem:= Case
                    When inserting  Then 'insert'
                    When updating   Then 'update'
                    When deleting   Then 'delete'
                 End;

    if inserting Then
        insert into Regions2_Log(Region_id,Region_Name,
                         client_user,client_ip,client_machine,
                         KimYapti,NeZaman,NeYapti)
            Values(:NEW.Region_id,:NEW.Region_Name,
                  sys_context('USERENV','OS_USER'),sys_context('USERENV','IP_ADDRESS'),SYS_CONTEXT('USERENV','HOST'),
                  User, sysdate, wislem);
    End if;

 

    if updating Then
        insert into Regions2_Log(Region_id,Region_Name,
                         client_user,client_ip,client_machine,
                         KimYapti,NeZaman,NeYapti)
            Values(:OLD.Region_id,:OLD.Region_Name,
                  sys_context('USERENV','OS_USER'),sys_context('USERENV','IP_ADDRESS'),SYS_CONTEXT('USERENV','HOST'),
                  User, sysdate, wislem || '_OLD');

 

 

        insert into Regions2_Log(Region_id,Region_Name,
                         client_user,client_ip,client_machine,
                         KimYapti,NeZaman,NeYapti)
            Values(NVL(:NEW.Region_id,:OLD.Region_id),NVL(:NEW.Region_Name,:OLD.Region_Name),
                  sys_context('USERENV','OS_USER'),sys_context('USERENV','IP_ADDRESS'),SYS_CONTEXT('USERENV','HOST'),
                  User, sysdate, wislem || '_NEW');

    End if;

 

    if deleting Then
         insert into Regions2_Log(Region_id,Region_Name,
                         client_user,client_ip,client_machine,
                         KimYapti,NeZaman,NeYapti)
            Values(:OLD.Region_id,:OLD.Region_Name,
                  sys_context('USERENV','OS_USER'),sys_context('USERENV','IP_ADDRESS'),SYS_CONTEXT('USERENV','HOST'),
                  User, sysdate, wislem);   
    End if;

End;
/

-- Alter Trigger trg_Regions2_Audit_Log Disable;
-- Delete From Regions2 Where Region_id >=10;
-- Alter Trigger trg_Regions2_Audit_Log Enable;
-- Delete From regions2 Where region_id = 12;
Select * From Regions2;
Select * From Regions2_Log;

insert into Regions2(Region_id, Region_Name)
            Values(12,'SpaceM2');
            
-- RollBack;         
Commit;
Select * From Regions2;
Select * From Regions2_Log;

insert into Regions2(Region_id, Region_Name)
            Values(13,'Test');
-- RollBack;         
Commit;
Select * From Regions2;
Select * From Regions2_Log;


Update Regions2
Set Region_Name = 'Space Universes Multi'
Where Region_id = 12;

 

Commit;
Select * From Regions2;
Select * From Regions2_Log;

 

Delete Regions2
Where Region_id = 13;

 

Commit;
Select * From Regions2;
Select * From Regions2_Log;

/