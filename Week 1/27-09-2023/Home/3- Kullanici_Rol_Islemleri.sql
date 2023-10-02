-- Kullanici olusturma
Create User KullaniciAdi identified by Sifre;

-- Baglanti yetkisi vermek.
Grant Connect, Resource to KullaniciAdi;

-- Yetkileri tek tek vermek.
Grant Select on TabloAdi to KullaniciAdi;
Grant Insert on TabloAdi to KullaniciAdi;
Grant Delete on TabloAdi to KullaniciAdi;
Grant Update on TabloAdi to KullaniciAdi;

-- Bu kullanicinin kendi yetkilerini bir baska kullaniciya da vermesini istersek GRANT OPTION kullanmaliyiz.
Grant Select on TabloAdi to KullaniciAdi with Grant Option;

-- Yetkileri satir satir yazmamak icin.
Grant
    Select,
    Insert,
    Update,
    Delete
on TabloAdi to KullaniciAdi with Grant Option;

-- Yetki geri almak.
Revoke Delete on TabloAdi from KullaniciAdi;

-- Birden fazla yetkiyi ayni anda almak.
Revoke 
    Delete, Insert, Select, Update 
on TabloAdi from KullaniciAdi;

-- Yukarida bir user icin yetki verdik. Public olarak hazir bir rol var. Yetkileri bu rol uzerinde verebiliriz.
-- Bu durumda veritabanina baglanma yetkisi olan tum userlar yetkilendirilmis olur.
Grant Select on TabloAdi to Public;

-- BaskaBirTablo uzerinde select yetkisi oldugu icin TabloAdi uzerinde de select yetkisine sahip oldu.
Grant Select on BaskaBirTabloAdi to KullaniciAdi; 

-- Rol olusturma yetkisi verme.
Grant Create Role To OracleData;

-- Rol olusturma.
Create Role INS;
Create Role SEL;

Create Role SELUPD;
Create Role INSDEL;

-- Rollere yetki atama.
Grant Select on OracleData.hr_employees to SEL;
Grant Insert on OracleData.hr_employees to INS;

Grant Select, Update on OracleData.hr_employees to SELUPD;
Grant Insert, Delete on OracleData.hr_employees to INSDEL;

-- Yetkiye sahip rolu kullaniciya atama.
Grant SELUPD to KullaniciAdi;

-- Yetki tanimlanan kullanici yetkiyi ustune almali.
Set Role SELUPD;

-- Kullanicidan yetkiyi geri alma.
Revoke SELUPD from KullaniciAdi;

-- Rolu silme.
Drop Role SELUPD;