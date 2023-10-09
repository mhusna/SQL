-- Simdi Tarihi manuel gonderelim ve yeni bir Procedure yapal?m
CREATE OR REPLACE PROCEDURE ins_deptB
    (
      p_tarih	              IN	 Varchar2,
      p_dept_id	          IN 	number,   -- Number(4) yazamay?z yani Procedure icinde uzunluk belirtilemez
      p_dept_name	    IN 	VARCHAR2, -- VARCHAR2(30) yazamay?z yani Procedure icinde uzunluk belirtilemez
      p_dept_man_id	  IN 	hr.DEPARTMENTS.manager_id%type, -- Referans tipi kullan?labilir
      p_dept_loc_id	    IN	hr.DEPARTMENTS.location_id%type,-- In yazmak zorunlu degil, yaz?lmazsa IN ' dir
      p_sonuc             OUT VARCHAR2
    ) IS
BEGIN
    IF TO_CHAR(TO_Date(p_tarih, 'DD/MM/YYYY'), 'DY') IN ('CMT', 'PAZ') THEN
        p_sonuc := 'Cumartesi ve Pazar günleri kayit girilemez!';
    ELSE
      INSERT INTO hr.DEPARTMENTS(department_id, department_name, manager_id, location_id)
    VALUES (p_dept_id, p_dept_name, p_dept_man_id, p_dept_loc_id);
        p_sonuc := 'Kayit Yapildi!';
    END IF;
END;

/

Declare
  mesaj Varchar2(200);
Begin
  -- Select * From Departments;
  ins_deptB('02/10/2023', 303, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('02/10/2023 Tarihine ' || Mesaj);

  ins_deptB('08/10/2023', 304, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('08/10/2023 Tarihine ' || Mesaj);
  Rollback;
End;

/

Select TO_CHAR(sysdate, 'D') From Dual;

Select TO_CHAR(TO_Date('04/05/2023', 'DD/MM/YYYY'), 'D') From Dual;
Select TO_CHAR(TO_Date('05/05/2023', 'DD/MM/YYYY'), 'D') From Dual;
Select TO_CHAR(TO_Date('06/05/2023', 'DD/MM/YYYY'), 'D') From Dual;
Select TO_CHAR(TO_Date('07/05/2023', 'DD/MM/YYYY'), 'D') From Dual;
Select TO_CHAR(TO_Date('08/05/2023', 'DD/MM/YYYY'), 'D') From Dual;

/
-- Hafta sonuna gelen gunu 'D' format?nda integer olarakta ogrenebiliriz
-- Buna uygun bir procedure yazalim
CREATE OR REPLACE PROCEDURE ins_deptC
    (
      p_tarih	      IN	Varchar2,
      p_dept_id	    IN	number,   -- Number(4) yazamay?z yani Procedure icinde uzunluk belirtilemez
      p_dept_name	  IN	VARCHAR2, -- VARCHAR2(30) yazamay?z yani Procedure icinde uzunluk belirtilemez
      p_dept_man_id	IN	hr.DEPARTMENTS.manager_id%type, -- Referans tipi kullan?labilir
      p_dept_loc_id	IN	hr.DEPARTMENTS.location_id%type,-- In yazmak zorunlu degil, yaz?lmazsa IN ' dir
      p_sonuc       OUT VARCHAR2
    ) IS
BEGIN
    IF TO_CHAR(TO_Date(p_tarih, 'DD/MM/YYYY'), 'D') IN (6, 7) THEN
        -- 1 Pazartesi, 2 Sal?, 3 Çar?amba, 4 Per?embe, 5 Cuma, 6 Cumartesi, 7 Pazar 
        p_sonuc := 'Cumartesi ve Pazar günleri kayit girilemez!';
    ELSE
      INSERT INTO hr.DEPARTMENTS(department_id, department_name, manager_id, location_id)
    VALUES (p_dept_id, p_dept_name, p_dept_man_id, p_dept_loc_id);
        p_sonuc := 'Kayit Yapildi!';
    END IF;
END;

/

Declare
  mesaj Varchar2(200);
Begin
  -- Select * From Departments;
  ins_deptC('01/05/2023', 303, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('01/05/2023 Tarihine ' || Mesaj);

  ins_deptC('06/05/2023', 304, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('06/05/2023 Tarihine ' || Mesaj);
  Rollback;
End;

/

-- Exception ekleyelim
-- Buna uygun bir procedure yazal?m
-- Procedure tanimlamasinda IS yerine AS de kullanabiliriz.
CREATE OR REPLACE PROCEDURE ins_deptD
    (
      p_tarih	      IN	Varchar2,
      p_dept_id	    IN	number,   -- Number(4) yazamay?z yani Procedure icinde uzunluk belirtilemez
      p_dept_name	  IN	VARCHAR2, -- VARCHAR2(30) yazamay?z yani Procedure icinde uzunluk belirtilemez
      p_dept_man_id	IN	hr.DEPARTMENTS.manager_id%type, -- Referans tipi kullan?labilir
      p_dept_loc_id	IN	hr.DEPARTMENTS.location_id%type,-- In yazmak zorunlu degil, yaz?lmazsa IN ' dir
      p_sonuc       OUT VARCHAR2
    ) IS
BEGIN
    IF TO_CHAR(TO_Date(p_tarih, 'DD/MM/YYYY'), 'D') IN (6, 7) THEN
        -- 1 Pazartesi, 2 Sal?, 3 Çar?amba, 4 Per?embe, 5 Cuma, 6 Cumartesi, 7 Pazar 
        p_sonuc := 'Cumartesi ve Pazar günleri kayit girilemez!';
    ELSE
      Begin
          INSERT INTO hr.DEPARTMENTS(department_id, department_name, manager_id, location_id)
              VALUES (p_dept_id, p_dept_name, p_dept_man_id, p_dept_loc_id);
            p_sonuc := 'Kayit Yapildi!';
          Exception When Others Then
            p_sonuc := 'Hata Meydana Geldi, sqlcode = ' || sqlcode || ' Mesaj =  ' || sqlerrm;
      End;
    END IF;
END;

/
-- Dogru parametreler ile calismasi.
Declare
  mesaj Varchar2(200);
Begin
  -- Select * From Departments;
  ins_deptD('01/05/2023', 303, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('01/05/2023 Tarihine ' || Mesaj);

  ins_deptD('06/05/2023', 304, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('06/05/2023 Tarihine ' || Mesaj);
  --Rollback;
End;

/

-- Yanlis parametreler ile calismasi.
Declare
  mesaj Varchar2(200);
Begin
  -- Select * From Departments;
  ins_deptD('01/05/2023', 30311, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('01/05/2023 Tarihine ' || Mesaj);

  ins_deptD('06/05/2023', 304, 'IT B', 200, 1900,Mesaj);
  dbms_output.put_line('06/05/2023 Tarihine ' || Mesaj);
  --Rollback;
End;

/

--*********************************************************************************************
-- Parametrelere DEFAULT deger atanmas?
-- isim NOTASYONU ile (=>) Parametrelere deger gondermek
-- Procedure nas?l silinir
-- Bu konularla ilgili bir calisma yapal?m
--*********************************************************************************************
-- Select * From DEPARTMENTS;

CREATE OR REPLACE PROCEDURE ins_deptE
    (
      p_tarih	      IN	Varchar2,
      p_dept_id	    IN	number,
      p_dept_name	  IN	VARCHAR2,
      p_dept_man_id	IN	hr.DEPARTMENTS.manager_id%type DEFAULT 100,-- Deger verilmezse 100 olarak default deger gelir
      p_dept_loc_id	IN	hr.DEPARTMENTS.location_id%type,
      p_sonuc       OUT VARCHAR2
    ) IS
BEGIN
    IF TO_CHAR(TO_Date(p_tarih, 'DD/MM/YYYY'), 'D') IN (6, 7) THEN
        -- 1 Pazartesi, 2 Sal?, 3 Çar?amba, 4 Per?embe, 5 Cuma, 6 Cumartesi, 7 Pazar 
        p_sonuc := 'Cumartesi ve Pazar günleri kayit girilemez!';
    ELSE
      Begin
          INSERT INTO hr.DEPARTMENTS(department_id, department_name, manager_id, location_id)
              VALUES (p_dept_id, p_dept_name, p_dept_man_id, p_dept_loc_id);
            p_sonuc := 'Kayit Yapildi!';
          Exception When Others Then
            p_sonuc := 'Hata Meydana Geldi, sqlcode = ' || sqlcode || ' Mesaj =  ' || sqlerrm;
      End;
    END IF;
END;

/

Declare
  mesaj Varchar2(200);
Begin
  -- Pozisyon Notasyonuna gore veri girelim
  ins_deptE('02/05/2023', 310, 'IT B', 111, 1900,Mesaj);
  dbms_output.put_line('Pozisyon Notasyonuna gore 02/05/2023 Tarihine ' || Mesaj);

  -- isim Notasyonuna gore veri girelim / paramatre s?ras? onemli degil
  -- once s?rayla parametre verelim
  ins_deptE( p_tarih       => '03/05/2023',
             p_dept_id     => 311,
             p_dept_name   => 'IT B',
             p_dept_man_id => 111,
             p_dept_loc_id => 1900,
             p_sonuc       => Mesaj
            );
  dbms_output.put_line('S?ral? isim Notasyonuna gore 03/05/2023 Tarihine ' || Mesaj);

  -- isim Notasyonuna gore veri girelim / paramatre s?ras? onemli degil
  -- once sirasiz parametre verelim
  ins_deptE( 
             p_dept_id     => 312,
             p_dept_name   => 'IT B',
             p_sonuc       => Mesaj,
             p_tarih       => '04/05/2023',
             p_dept_loc_id => 1900,
             p_dept_man_id => 111
            );
  dbms_output.put_line('Farkl? Yerlerde isim Notasyonuna gore 04/05/2023 Tarihine ' || Mesaj);
End;
-- Rollback;

/

-- Default Degere gore Calistiral?m
Declare
  mesaj Varchar2(200);
Begin
  -- isim Notasyonuna gore veri girelim / paramatre s?ras? onemli degil
  ins_deptE( p_tarih       => '03/05/2023',
             p_dept_id     => 311,
             p_dept_name   => 'IT Space',
             --p_dept_man_id => 200,
             p_dept_loc_id => 1900,
             p_sonuc       => Mesaj
            );
  dbms_output.put_line('S?ral? isim Notasyonuna gore 03/05/2023 Tarihine ' || Mesaj);
End;
-- Rollback;

/

