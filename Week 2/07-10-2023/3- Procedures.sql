--*********************************************************************************************
-- SUBPROGRAMS
-- (Procedure, Function)
--*********************************************************************************************

 

/*
  Types of PL/SQL Block
  (PL/SQL Block Turleri)
  1- Unnamed Block(Anonymous Blocks)  -- Nested Subprograms
  2- Named Block(Procedure, Function) -- Stored Subprograms

  Su ana kadar hep Unnamed Block(Anonymous Blocks) olarak calismalar yapm??t?k
  Simdi Named Block(Procedure, Function) olarak calismalar?m?z? yapacag?z

*/

 

/*
        SUBPROGRAMS
    (Procedure, Function)  
    ikiye sekilde yap?labilir
    1- Nested(Unnamed Block icerisinde)

    2- Stored(Veritaban? içerisinde)
        A- Standalone
        B- Package

*/

--*********************************************************************************************
/*
        SUBPROGRAMS(Procedure, Function)  
        1- Nested Procedures

        2- Stored Procedures(Standalone veya Package icinde yaz?labilir)
*/
--*********************************************************************************************
--*********************************************************************************************
-- 1- Nested Procedures
/*
Nested Procedures
Syntax

 

DECLARE
  — Declare and define procedure
  PROCEDURE <Proc_name> ( — Subprogram heading begins
<parameters>
                        ) — Subprogram heading ends
  IS
<variables>
    -- Declarative part begins
  BEGIN — Executable part begins

      EXCEPTION — Exception-handling part begins

 

  END <Proc_name>-

 

BEGIN - Main Block
<Proc_name>(parameter Values); -- Call Proc
END;

 

*/

 

-- Nested Procedures
-- Ornek;
-- Unnamed Block icinde, calisan ismini yazd?ran bir Procedure yazal?m

Declare
    Procedure isim_goster IS
            w_name  Employees.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
    Begin    
            Select last_name INTO w_name From Employees Where Employee_id = 101;
            dbms_output.put_line('ismi = ' || w_name);
    End;  -- isim_goster  ===>>> buraya End isim_goster; diyerek procedure ismini yazabiliriz, opsiyoneldir,
                                 ----------- program ak?s?n? kontrol ederken faydas? olur

Begin -- Main Block
    isim_goster;
End;
/

Declare
    Procedure isim_goster IS
        w_name  Employees.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
    Begin    
        Select last_name INTO w_name From Employees Where Employee_id = 101;
        dbms_output.put_line('ismi = ' || w_name);
    End isim_goster;  -- buraya End isim_goster; diyerek procedure ismini yazabiliriz, opsiyoneldir,
                      -- program ak?s?n? kontrol ederken faydas? olur
Begin
    isim_goster;
End;
/

-- Nested Procedures
-- Ornek;
-- Unnamed Block icinde, calisan ismini guncelleyen(Buyuk Harfe Ceviren) bir Procedure yazal?m

Declare
    Procedure isim_goster IS
        w_name  Employees2.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
    Begin    
        Select last_name INTO w_name From Employees2 Where Employee_id = 101;
        dbms_output.put_line('ismi = ' || w_name);
    End isim_goster;  -- buraya End isim_goster; diyerek procedure ismini yazabiliriz, opsiyoneldir,
                      -- program ak?s?n? kontrol ederken faydas? olur

 

    Procedure isim_guncelle IS
        w_name2  Employees2.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
    Begin    
        Update Employees2
        Set last_name = Upper(last_name)
        Where Employee_id = 101;

        Select last_name INTO w_name2 From Employees2 Where Employee_id = 101;
        dbms_output.put_line('Guncel ismi = ' || w_name2);
    End isim_guncelle;

Begin
    isim_goster;
    isim_guncelle;
    isim_goster;
    rollback;
End;
/

-- veya Update Employees2 Set last_name = Upper(last_name) Where Employee_id = 101;
-- Select last_name INTO w_name2 From Employees2 Where Employee_id = 101;

 

-- Bu 2 komutu tek bir komutta birlestirerek ayn? islemi yapt?rabiliriz
-- Yani once Update edecek sonra update edilen yeni veriyi Select edecek
-- Komutumuz RETURNING
-- Update Employees2 Set last_name = Upper(last_name) Where Employee_id = 101
-- RETURNING last_name INTO w_name2;

Declare
    Procedure isim_goster IS
        w_name  Employees2.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
    Begin    
        Select last_name INTO w_name From Employees2 Where Employee_id = 101;
        dbms_output.put_line('ismi = ' || w_name);
    End isim_goster;  -- buraya End isim_goster; diyerek procedure ismini yazabiliriz, opsiyoneldir,
                      -- program ak?s?n? kontrol ederken faydas? olur

 

    Procedure isim_guncelle IS
        w_name  Employees2.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
    Begin    
        Update Employees2
        Set last_name = Upper(last_name)
        Where Employee_id = 101
        RETURNING last_name INTO w_name;

        dbms_output.put_line('Guncel ismi = ' || w_name);
    End isim_guncelle;

 

Begin -- MAIN BLOCK
    isim_goster;
    isim_guncelle;
    isim_goster;
    rollback;
End;
/
-- yukar?da Procedure icinde tan?mlanan
-- w_name  Employees2.last_name%type; -- Bu local degiskendir, sadece bu procedure icinde gecerlidir
-- Global olmas?n? istiyorsak Declare'den sonra tan?mlamam?z gerekir
-- Yapal?m
--*********************************************************************************************
Declare
    w_name  Employees2.last_name%type; -- Bu Global degiskendir, bu program icinde her yerde kullan?labilir

    Procedure isim_goster IS        
    Begin    
        Select last_name INTO w_name From Employees2 Where Employee_id = 101;
        dbms_output.put_line('ismi = ' || w_name);
    End isim_goster;  -- buraya End isim_goster; diyerek procedure ismini yazabiliriz, opsiyoneldir,
                      -- program ak?s?n? kontrol ederken faydas? olur

 

    Procedure isim_guncelle IS
    Begin    
        Update Employees2
        Set last_name = Upper(last_name)
        Where Employee_id = 101
        RETURNING last_name INTO w_name;

        dbms_output.put_line('Guncel ismi = ' || w_name);
    End isim_guncelle;

 

Begin -- MAIN BLOCK
    isim_goster;
    isim_guncelle;
    isim_goster;
    rollback;
End;
/

Declare
    w_name Employees2.last_name%type;
    
    Procedure isim_goster(p_emp_id IN Employees.Employee_id%type) IS
        Begin
            Select last_name into w_name From Employees2 where employee_id = p_emp_id;
            dbms_output.put_line('ismi: ' || w_name);
        End isim_goster;
    
    Procedure isim_guncelle(p_emp_id IN Employees.Employee_id%type) IS
        Begin
            Update employees2
            Set last_name = Upper(last_name)
            Where employee_id = p_emp_id
            Returning last_name into w_name;
        
           dbms_output.put_line('Guncel ismi: ' || w_name);
        End isim_guncelle;
Begin
    isim_goster(100);
    isim_guncelle(100);
    isim_goster(100);
    rollback;
End;

//

-- Yukar?daki progrman? dinamik hale getirelim ve
-- Department_id'si 90 nolu kay?tlar?n last_name'lerini buyuk harfe cevirelim
-- Bunun icin Cursor kullanal?m

 

Declare
    Cursor c_emp IS (Select Employee_id From Employees Where Department_id = 90);
    -- Department_id'yide klavyeden girilmesini istersek su sekilde yapabiliriz, Yukar?daki sat?r? commentleyelim
    -- Asagidaki satirin commentini kald?ral?m
    -- Cursor c_emp IS (Select Employee_id From Employees Where Department_id = &Department_ID_GIRINIZ);
    r_emp c_emp%rowtype;

    w_name  Employees2.last_name%type; -- Bu Global degiskendir, bu program icinde her yerde kullan?labilir

    Procedure isim_goster(p_emp_id IN Employees.Employee_id%type) IS        
    Begin    
        Select last_name INTO w_name From Employees2 Where Employee_id = p_emp_id;
        dbms_output.put_line('ismi = ' || w_name);
    End isim_goster;

    Procedure isim_guncelle(p_emp_id IN Employees.Employee_id%type) IS
    Begin    
        Update Employees2
        Set last_name = Upper(last_name)
        Where Employee_id = p_emp_id
        RETURNING last_name INTO w_name;

        dbms_output.put_line('Guncel ismi = ' || w_name);
    End isim_guncelle;

 

Begin -- MAIN BLOCK
    Open c_emp;
      Loop
          Fetch c_emp INTO r_emp;
          Exit When c_emp%NotFound;

          isim_goster(r_emp.Employee_id);
          isim_guncelle(r_emp.Employee_id);

      End Loop;
    Close c_emp;

    rollback;
End;
/

Declare
    w_maas Employees.salary%type;
    w_zamli_maas Employees.salary%type := 1.25;
    
    Procedure get_info(
                        p_id IN employees.employee_id%type,
                        p_salary OUT employees.employee_id%type,
                        p_new_salary IN OUT employees.employee_id%type
                      ) IS
    Begin
        Select salary INTO p_salary
        From Employees
        Where Employee_id = p_id;
        p_new_salary := p_new_salary * p_salary;
    End;
Begin
    get_info(100, w_maas, w_zamli_maas);
    dbms_output.put_line('Employee_id: ' || 100 || ' Simdiki maas: ' || w_maas || ' Zaml? Yeni Maas: ' || w_zamli_maas);
End;

/

/*
Nested Procedures Parametrelere De?er Gönderme Yöntemleri
PROCEDURE get_info (a number, b varchar2, c date
  A) Pozisyon Notasyonu
      •	Parametrenin tan?mland??? s?rayla
      •	get_info (x, y, z);
  B) ?sim Notasyonu
      •	Parametrenin ismine göre ( => )
      •	get_info( a => x, b => y, c => z) -- a=>x anlam? ?u; a parametresine x degerini gonder
  C) Kar???k Notasyon
      •	Hem s?raya, hem isme göre -- bu yontemde once Pozisyon Notasyonlar? sonra isim Notasyonlar? kullan?l?r
      •	get_info(x, y, c => z)
*/
-- Simdi Yukar?daki ornegi Department_id'si 60 olanlar icin yapal?m

 

-- Nested Procedures Parametrelere De?er Gönderme Yöntemleri
-- Pozisyon Notasyonu, ?sim Notasyonu, Kar???k Notasyon
-- Herbiri ile ayr? ayr? yapal?m
-- ilk olarak Pozisyon Notasyonu ile yapal?m
Declare
      w_maas        Employees.salary%type;
      w_zamli_maas  Employees.salary%type:=1.25; -- Burada %25 zam istedigimiz icin 1.25 yazd?k
      Procedure get_info(
                          p_id          IN      Employees.Employee_id%type,
                          p_salary      OUT     Employees.salary%type,
                          p_new_salary  IN OUT  Employees.salary%type            
                        ) IS
      Begin
          Select salary INTO p_salary From Employees Where Employee_id = p_id;
          p_new_salary:= p_new_salary * p_salary;
      End;
Begin
    For i IN (Select Employee_id From Employees Where Department_id = 60)
    Loop
        get_info(i.Employee_id,w_maas,w_zamli_maas);
        dbms_output.put_line('Employee_id= ' || i.Employee_id || ' Simdiki Maas = ' || w_maas || ' Zaml? Yeni Maas = ' || w_zamli_maas);    
        w_zamli_maas:=1.25;
    End Loop;
End;
/
-- Nested Procedures Parametrelere De?er Gönderme Yöntemleri
-- Pozisyon Notasyonu, ?sim Notasyonu, Kar???k Notasyon
-- Herbiri ile ayr? ayr? yapal?m
-- Simdi isim Notasyonu ile yapal?m(S?ras? onemli degil)

 

Declare
      w_maas        Employees.salary%type;
      w_zamli_maas  Employees.salary%type:=1.25; -- Burada %25 zam istedigimiz icin 1.25 yazd?k
      Procedure get_info(
                          p_id          IN      Employees.Employee_id%type,
                          p_salary      OUT     Employees.salary%type,
                          p_new_salary  IN OUT  Employees.salary%type            
                        ) IS
      Begin
          Select salary INTO p_salary From Employees Where Employee_id = p_id;
          p_new_salary:= p_new_salary * p_salary;
      End;
Begin
    For i IN (Select Employee_id From Employees Where Department_id = 60) Loop
        --get_info(p_id => i.Employee_id, p_salary => w_maas, p_new_salary => w_zamli_maas);
        -- isim notasyonunda s?ra onemli degil
        get_info(p_salary => w_maas, p_new_salary => w_zamli_maas, p_id => i.Employee_id);
        dbms_output.put_line('Employee_id= ' || i.Employee_id || ' Simdiki Maas = ' || w_maas || ' Zaml? Yeni Maas = ' || w_zamli_maas);    
        w_zamli_maas:=1.25;
    End Loop;
End;
/
-- Nested Procedures Parametrelere De?er Gönderme Yöntemleri
-- Pozisyon Notasyonu, ?sim Notasyonu, Kar???k Notasyon
-- Herbiri ile ayr? ayr? yapal?m
-- Simdi Kar???k Notasyon ile yapal?m
-- KARISIK NOTASYON ile yap?l?rken once Pozisyon Notasyonuna gore sonra isim notasyonuna gore s?ras?yla yazmam?z laz?m
Declare
      w_maas        Employees.salary%type;
      w_zamli_maas  Employees.salary%type:=1.25; -- Burada %25 zam istedigimiz icin 1.25 yazd?k
      Procedure get_info(
                                    p_id          IN      Employees.Employee_id%type,
                                    p_salary      OUT     Employees.salary%type,
                                    p_new_salary  IN OUT  Employees.salary%type            
                                  ) IS
      Begin
          Select salary INTO p_salary From Employees Where Employee_id = p_id;
          p_new_salary:= p_new_salary * p_salary;
      End;
Begin
    For i IN (Select Employee_id From Employees Where Department_id = 60) Loop
        get_info(i.Employee_id, w_maas, p_new_salary => w_zamli_maas);
        dbms_output.put_line('Employee_id= ' || i.Employee_id || ' Simdiki Maas = ' || w_maas || ' Zaml? Yeni Maas = ' || w_zamli_maas);    
        w_zamli_maas:=1.25;
    End Loop;
End;

/

Create or replace procedure MerhabaDunya IS
    Begin
        dbms_output.put_line('merhaba dunya');
    End;

/
Execute MerhabaDunya;
/
Exec MerhabaDunya;
/

-- Stored Procedure bir PL/SQL blogu icinden cagiral?m

 

Declare

 

Begin
  MerhabaDunya;
  MerhabaDunya2;
End;
/

 

-- Ornek; Departments tablosuna haftasonlar? kay?t girisini engelleyen bir Procedure yazal?m
-- Normalde bu tur engellemeler Triggerlar ile yap?l?r,
-- ama biz simdi bunu Stored Procedure ile yapal?m

 

Desc Departments;
/

 

Select TO_CHAR(sysdate, 'DY') From Dual;
Select TO_CHAR(sysdate+1, 'DY') From Dual;

 

Select TO_CHAR(sysdate, 'DAY') From Dual;
Select TO_Date('07/05/2023', 'DD/MM/YYYY') From Dual;
Select TO_CHAR(TO_Date('04/05/2023', 'DD/MM/YYYY'), 'DAY') From Dual;
Select TO_CHAR(TO_Date('05/05/2023', 'DD/MM/YYYY'), 'DAY') From Dual;
Select TO_CHAR(TO_Date('06/05/2023', 'DD/MM/YYYY'), 'DAY') From Dual;
Select TO_CHAR(TO_Date('07/05/2023', 'DD/MM/YYYY'), 'DAY') From Dual;

 

Select TO_CHAR(TO_Date('04/05/2023', 'DD/MM/YYYY'), 'DY') From Dual;
Select TO_CHAR(TO_Date('05/05/2023', 'DD/MM/YYYY'), 'DY') From Dual;
Select TO_CHAR(TO_Date('06/05/2023', 'DD/MM/YYYY'), 'DY') From Dual;
Select TO_CHAR(TO_Date('07/05/2023', 'DD/MM/YYYY'), 'DY') From Dual;
/

 

CREATE OR REPLACE PROCEDURE ins_deptA
              (
                p_dept_id	        IN	    number,   -- Number(4) yazamay?z yani Procedure icinde uzunluk belirtilemez
                p_dept_name	  IN	    VARCHAR2, -- VARCHAR2(30) yazamay?z yani Procedure icinde uzunluk belirtilemez
                p_dept_man_id	IN    	DEPARTMENTS.manager_id%type, -- Referans tipi kullan?labilir
                p_dept_loc_id	  IN	    DEPARTMENTS.location_id%type,-- In yazmak zorunlu degil, yaz?lmazsa IN ' dir
                p_sonuc           OUT VARCHAR2
              ) IS
BEGIN
              IF TO_CHAR(sysdate, 'DY') IN ('CMT', 'PAZ') THEN
                    p_sonuc := 'Cumartesi ve Pazar günleri kayit girilemez!';
              ELSE
                  INSERT INTO DEPARTMENTS(department_id, department_name, manager_id, location_id)
                        VALUES (p_dept_id, p_dept_name, p_dept_man_id, p_dept_loc_id);

                  p_sonuc := 'Kayit Yapildi!';
              END IF;
END;
/
-- Procedure icerisinde (p_sonuc OUT VARCHAR2) yani OUT parametresi oldugu icin
-- Bunu Execute ile direk calistiramay?z, (tabiki farkl? yontemler var ama sade olmas? ac?s?ndan
-- Bunun yerine PL/SQL block icerisinde cagirmal?y?z

 

-- Execute ins_deptA(300,'IT A', 200, 1900); -- Eksik parametre yazd?g?m?z icin hata verecektir
Execute ins_deptA(300,'IT A', 200, 1900,Mesaj); -- Burada Out ile gelen bilgiyi bir degiskene atmam?z gerekir
-- ve bu degiskeni tan?mlamam?z gerekir
-- Bu nedenle PL/SQL block icerisinde cagiral?m
/
Declare
  mesaj Varchar2(200);
Begin
  -- Select * From Departments;
  ins_deptA(300,'IT A', 200, 1900,Mesaj);
  dbms_output.put_line(Mesaj);
End;
/
CREATE OR REPLACE PROCEDURE ins_deptA_Paz
              (
                p_dept_id	        IN	    number,   -- Number(4) yazamay?z yani Procedure icinde uzunluk belirtilemez
                p_dept_name	  IN	    VARCHAR2, -- VARCHAR2(30) yazamay?z yani Procedure icinde uzunluk belirtilemez
                p_dept_man_id	IN    	DEPARTMENTS.manager_id%type, -- Referans tipi kullan?labilir
                p_dept_loc_id	  IN	    DEPARTMENTS.location_id%type,-- In yazmak zorunlu degil, yaz?lmazsa IN ' dir
                p_sonuc           OUT VARCHAR2
              ) IS
BEGIN
              IF TO_CHAR(sysdate, 'DY') IN ('PAZ') THEN
                    p_sonuc := 'Pazar günleri kayit girilemez!';
              ELSE
                  INSERT INTO DEPARTMENTS(department_id, department_name, manager_id, location_id)
                        VALUES (p_dept_id, p_dept_name, p_dept_man_id, p_dept_loc_id);

                  p_sonuc := 'Kayit Yapildi!';
              END IF;
END;
/

Declare
  mesaj Varchar2(200);
Begin
  -- Select * From Departments;
  ins_deptA_PAZ(400,'IT B', 200, 1900,Mesaj);
  dbms_output.put_line(Mesaj);
End;
/

