-- Ornek Calisma --

-----------------------------------------------------
-- System olarak bir kullanici olusturalim. --
Create User AT1 identified by AT1;

-- Yetki atamasi yaptik.
Grant Connect, resource, unlimited TableSpace to AT1;

-- Rol olusturma yetkisi verdik.
Grant Create Role to AT1;

-----------------------------------------------------
-- System olarak bir kullanici daha olusturalim. --
Create User AT2 identified by AT2;

-- Yetki atamalarini yapalim.
Grant connect, resource, unlimited TableSpace to AT2;

-----------------------------------------------------
-- System olarak bir kullanici daha olusturalim. --
Create User AT3 identified by AT3;

-- Yetki atamalarini yapalim.
Grant connect, resource, unlimited TableSpace to AT3;

-----------------------------------------------------
-- AT1'e baglanalim.
-- Personel tablosu olusturalim.
Create Table Personel
(
    id number,
    Sehir varchar(2)
);

-- Sehir sutununu degistirelim.
Alter Table Personel Modify (Sehir Varchar(50));

-- Kayit ekleyelim.
Insert Into Personel Values(1, 'Istanbul');

-- Tablomuzu goruntuleyelim.
Select * From Personel;

-- Rol olusturalim.
Create Role R_SEL_UPD;
Create Role R_INS_DEL;

-- Rollerin hangi yetkilere sahip olacagini belirtelim.
Grant Select, Update on AT1.Personel to R_SEL_UPD;
Grant Insert, Delete on AT1.Personel to R_INS_DEL;

-- Kullanicilara rol atamasi yapalim.
Grant R_SEL_UPD to AT2;
Grant R_INS_DEL to AT3;

-- Tum yetkileri goruntuleyelim.
Select * From User_Tab_Privs_Made;

-- Tablomuzu hatirlayalim. (Icinde 1 adet kayit var)
Select * From Personel;

-----------------------------------------------------
-- AT2'ye baglanalim.
-- AT2 kullanicisi olarak rolu uzerimize alalim.
Set Role R_SEL_UPD;

-- Yetkimiz olan komutlari calistiralim.
Select * From AT1.personel;

-----------------------------------------------------
-- AT3'e baglanalim.
-- AT3 kullanicisi olarak rolu uzerimize alalim.
Set Role R_INS_DEL;

-- Yetkimiz olan komutlari calistiralim.
Insert Into AT1.Personel Values(2, 'Bursa');
Commit;

Insert Into AT1.Personel Values(3, 'Izmir');
Commit;

-----------------------------------------------------
-- AT2'ye baglanalim.
Select * From AT1.Personel;

-- Yetkimiz olan komutu calistiralim.
Update AT1.Personel Set Sehir = 'Adana' Where id = 3;
Commit;

-----------------------------------------------------
-- AT1'e baglanalim.
-- R_SEL_UPD rolunden Update yetkisini alalim.
Revoke Update on AT1.Personel From R_SEL_UPD;

-----------------------------------------------------
-- AT2'ye baglanalim.
Select * From AT1.Personel;

-- Update komutu calismaz cunku yukarida update yetkisini
-- AT2'nin sahip oldugu RR_SEL_UPD rolunden aldik.  Artik
-- AT2 kullanicisi sadece Select islemi yapabilir.
Update AT1.Personel Set Sehir = 'Adana' Where id = 3;
Commit;

-----------------------------------------------------
-- AT1'e baglanalim.
-- AT3 kullanicisinin R_INS_DEL rol yetkisini revoke edelim.
Revoke R_INS_DEL From AT3;

-- Rolu dtop edelim.
Drop Role R_INS_DEL;

Select * From User_Tab_Privs_Made;

-- AT3 ile connect olalim.
Insert Into AT1.Personel Values(9, 'Bursa');
Commit;