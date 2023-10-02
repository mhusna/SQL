/* Buradan itibaren rolleri ad?m ad?m yap?n?z */
--------------------------------------------------

-- BIR ORNEK ILE PEKISTIRELIM
-- System olarak baglanalým
Create User TT1 identified by TT1;
Grant connect, resource, unlimited TableSpace to TT1;

Grant Create Role to TT1;

Create User TT2 identified by TT2;
Grant connect, resource, unlimited TableSpace to TT2;

Create User TT3 identified by TT3;
Grant connect, resource, unlimited TableSpace to TT3;

-- TT1 ile connect olalým

Create Table Personel(
  id number,
  Sehir Varchar(2)
);
Alter Table Personel Modify (Sehir Varchar(50));

insert into TT1.Personel Values(1,'istanbul');

Select * From Personel;

Create Role R_Sel_Upd_TT;
Create Role R_Ins_Del_TT;

Grant Select, Update on TT1.Personel to R_Sel_Upd_TT;
Grant Insert, Delete on TT1.Personel to R_Ins_Del_TT;

Grant R_Sel_Upd_TT To TT2;
Grant R_Ins_Del_TT To TT3;

Select * From User_Tab_Privs_Made;

Select * From Personel;

-- TT2 ile connect olalim

Set Role R_Sel_Upd_TT;
Select * From TT1.Personel;

-- TT3 ile connect olalim
-- Yekiyi kendine aliyor.
Set Role R_Ins_Del_TT;
insert into TT1.Personel Values(2,'Bursa');
Commit;

insert into TT1.Personel Values(3,'izmir');
Commit;

-- TT2 ile connect olalim
Select * From TT1.Personel;

Update TT1.Personel
Set SEHIR = 'Adana'
Where id = 3;
Commit;

-- TT1 ile connect olalim

-- R_Sel_Upd rolunden Update Yetkisini alalým

Revoke Update on TT1.Personel From R_Sel_Upd_TT;
-- R_Sel_Upd rolunun Update yetkisi alýndý

-- TT2 ile connect olalým
Select * From TT1.Personel;

Update TT1.Personel
Set SEHIR = 'Adana'
Where id = 3;
Commit;
-- TT2 kullanýcýnda Yukarýdaki islem Update yapmayacaktýr
-- Select yapabilir

-- TT1 ile connect olalim.
-- TT3 kullanýcýsýnýn R_Ins_Del role yetkisini Revoke edelim

Revoke R_Ins_Del_TT From TT3;

-- Rolu Drop edelim

Drop Role R_Ins_Del_TT;

-- Select * From User_Tab_Privs_Made;

-- TT3 ile connect olalým

insert into TT1.Personel Values(9,'Bursa');
Commit;