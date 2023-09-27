/*
    Uzerinde islem yapacagimiz gecici
    tabloyu olusturma.
*/

Create Table regions_copy as
Select *
From hr.regions;

--------------------
Select * From regions_copy;
--------------------
Insert Into regions_copy Values(5, 'Africa');
--------------------
Select * From regions_copy;
--------------------
--################--
--------------------
-- ROL OLUSTURMA ISLEMI
-- Once sys'ye baglanmaliyiz cunku admin kullanicisi.
-- Sys olarak giris yaptiktan sonra mhusna kullanicisina
-- role olusturma yetkisi verdik.
Grant Create Role To mhusna;

-- Sonra mhusna kullanicisina gecelim.
Create Role R_SEL;
Create Role R_INS;

Create Role R_SELUPD;
Create Role R_INSDEL;

-- Rolleri tanimladik. Simdi rollerin ne is 
-- yapacagini atayalim.
Grant Select on mhusna.regions_copy to R_SEL;
Grant Insert on mhusna.regions_copy to R_INS;

Grant Select, Update on mhusna.regions_copy to R_SELUPD;
Grant Insert, Delete on mhusna.regions_copy to R_INSDEL;

-- Simdi bu rolleri mhusna kullanicisi olarak uzerimize alalim.
Set Role R_SELUPD;

-- mhusna kullanicisi olarak mhusna_test kullanicisina
-- rol atamasi yaptik.
Grant R_SELUPD to mhusna_test;