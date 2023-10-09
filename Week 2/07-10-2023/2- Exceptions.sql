--*********************************************************************************************
-- Exceptions - Error Handling (istisnalar - Hata Yonetimi)
--*********************************************************************************************

 

/*
  Exceptions Nedir; PL/SQL Runtime Errors(program çal??ma esnas?nda olu?an hatalard?r)

  Exception Gruplar?
    A) Internally Defined Exceptions(Dahili Tan?ml? istisnalar)
        (Err kodu olan fakat ismi olmayan istisnalard?r)
    B) Predefined Exceptions(Tan?ml? istisnalar)
        (Err kodu ve ismi olan istisnalard?r)
    C) User-Defined Exceptions
        (Programc? taraf?ndan yaz?lan istisnalar)  
*/
-- Simdi Bunlar? incelemeye baslayal?m
--*********************************************************************************************
/*
    Exception Gruplar?
    A) Internally Defined Exceptions(Dahili Tan?ml? istisnalar)
        (Err kodu olan fakat ismi olmayan istisnalard?r)

 

Bu istisnalar iki farkl? tan?mlamayla yakalan?p yonetilebilir
    PRAGMA_EXCEPTION_INIT veya
    EXCEPTIONS WHEN OTHERS

    SYNTAX    ;

    Declare
              my_exception exception;
              pragma exception_init(my_exception, -errCode);
    Begin
              ...
              EXCEPTION When my_exception Then
              ...
              EXCEPTION When others Then
    End;
*/
--*********************************************************************************************
-- Ornek; pragma exception_init ile ilgili bir ornek yapal?m

Begin
    Delete From hr.Departments Where department_id = 90;
End;

/

-- Yukaridaki kodu bu hali ile calistirirsak hata verecektir.
-- Simdi verdigi hata kodunu alalim ve programa ekleyelim.
Declare
    my_exception exception;
    pragma exception_init(my_exception, -02292);
Begin
    Delete From hr.Departments Where department_id = 90;
    EXCEPTION When my_exception Then
        dbms_output.put_line('Hata Meydana Geldi : -02292: integrity constraint ... child record found');
End;

/

-- ORNEK: Pragma exception_init'e insert ile bir ornek daha yapalim
-- ve Exception Scope(Exception'lar?n kapsama alan?n? inceleyelim)
-- Regions tablosuna bir kay?t ekleyelim ve ekledigimiz kayd? yeniden ekleyelim

Declare
    my_exception_insert_unique Exception;
    pragma exception_init(my_exception_insert_unique, -00001);
Begin
    insert into hr.Regions Values(10, 'Asya');
    Exception When my_exception_insert_unique Then
        dbms_output.put_line('my_exception_insert_unique Hatas?');
End;

-- Yukar?daki kodu bir kere calistirinca insert gerceklesecek ama
-- ikinci kez calistirinca hata mesaj? gelecek
/

Commit;

/
-- Simdi insert ve delete orneklerini birlestirelim
Declare
    exception_insert_unique Exception;
    pragma exception_init(exception_insert_unique, -00001);
    
    exception_integrity_constraint exception;
    pragma exception_init(exception_integrity_constraint, -02292);
Begin
    insert into hr.Regions Values (10, 'Asya');
    
    Delete From hr.Departments  Where department_id = 90;
    Exception When exception_integrity_constraint Then
        dbms_output.put_line('Hata Meydana Geldi : -02292: integrity constraint ... child record found'); 

    Exception When exception_insert_unique then
        dbms_output.put_line('exception_insert_unique Hatas?');   
End;

-- Yukar?daki sekilde calistirirsak hata meydana gelir
-- Cunku hangi Exception hangisine ait belli degil, Bunu Scope(kapsama) ile belirleyelim
-- yani Begin ... End; blogu ile Exception'lar?n kapsam?n? belirleyelim

-- Internally Defined Exceptions - PRAGMA_EXCEPTION_INIT, Exception SCOPE(Exception'lar?n Kapsama Alan?)

Declare
    exception_insert_unique Exception;
    pragma exception_init(exception_insert_unique,-00001);

    exception_integrity_Constraint exception;
    pragma exception_init(exception_integrity_Constraint, -02292); -- Oracle'da 70.000-80.000'e yak?n hata kodu var

Begin
    insert into Regions Values(10,'Asya'); -- Select * From Regions;

    Begin
        delete From Departments Where department_id = 90;
        EXCEPTION When exception_integrity_Constraint Then
            dbms_output.put_line('Hata Meydane Geldi : -02292: integrity constraint ... child record found');    
    End;

    Exception When exception_insert_unique then
        dbms_output.put_line('exception_insert_unique Hatas?');        
End;
/
-- simdi olmayan bir kayd? ekleyelim ve ne olacag?n? gorelim
Declare
    exception_insert_unique Exception;
    pragma exception_init(exception_insert_unique,-00001);

    exception_integrity_Constraint exception;
    pragma exception_init(exception_integrity_Constraint, -02292); -- Oracle'da 70.000-80.000'e yak?n hata kodu var

Begin
    insert into Regions Values(11,'Antartica'); -- Select * From Regions;

    Begin
        delete From Departments Where department_id = 90;
        EXCEPTION When exception_integrity_Constraint Then
            dbms_output.put_line('Hata Meydane Geldi : -02292: integrity constraint ... child record found');    
    End;

    Exception When exception_insert_unique then
        dbms_output.put_line('exception_insert_unique Hatas?');        
End;
/
-- Simdi hatalar kontrol alt?na al?nd?
-- Eger insert edilen bilgi yok ise insert eder, var ise hata Exception devreye girer
-- Eger insert edildiyse sonraki bloga gecer ve delete isleminde hata meydana gelirse Exception devreye girer

 

-- Internally Defined Exceptions - Tam?ml? olan Exceptionlar?n baz?lar?na bir goz atal?m
-- Tan?ml? olan 70.000 - 80.000 civar?nda Exceptionlar vard?r

 

-- Error mesajlar?n?n oldugu pdf oracle sitesinden download edilebilir
-- https://docs.oracle.com/cd/E96517_01/errmg/error-messages.pdf#page=2019&zoom=100,0,88

 

-- ORA-00000: normal, successful completion, Cause: Normal exit, Action: None
-- ORA-00001: unique constraint (string.string) violated
-- ORA-00902: invalid datatype
-- ORA-00904: string: invalid identifier 
-- ORA-00909: invalid number of arguments v.s.

Rollback;

/

-- Internally Defined Exceptions - (Dahili Tan?ml? istisnalar)
-- OTHERS ve Exception SCOPE  olarak inceleyelim

Begin
    insert into hr.Regions Values(11, 'Asya');
    
    Begin
        delete from hr.departments where department_id = 90;
        Exception When Others Then
            dbms_output.put_line('Delete yaparken Hata Meydane Geldi : ' ||
                                 sqlcode || ' ' || sqlerrm);
        -- Buraya yap?lmas?n? istedigimiz islemleri yazacagiz
    End;
    
    Exception When Others Then
        dbms_output.put_line('insert yaparken hata meydana geldi : ' ||
                                 sqlcode || ' ' || sqlerrm);
    -- Buraya yap?lmas?n? istedigimiz islemleri yazacagiz           
End;

/

Rollback;

/

Begin
    insert into Regions Values(11,'Asya'); -- Select * From Regions;

    Begin
        delete From Departments Where department_id = 90;
        EXCEPTION When OTHERS Then
            dbms_output.put_line('Delete yaparken Hata Meydane Geldi : ' ||
                                 sqlcode || ' ' || sqlerrm);
        -- Buraya yap?lmas?n? istedigimiz islemleri yazacagiz
    End;

    EXCEPTION When OTHERS Then
        dbms_output.put_line('insert yaparken hata meydana geldi : ');
        dbms_output.put_line('sqlcode  : ' || sqlcode);
         dbms_output.put_line('sqlerrm : ' || sqlerrm);
    -- Buraya yap?lmas?n? istedigimiz islemleri yazacagiz                                 
End;

/

--*********************************************************************************************
/*
  Exception Gruplar?
    B) Predefined Exceptions(Tan?ml? istisnalar)
        (Err kodu ve ismi olan istisnalard?r)

  Bu istisnalar ismine ozel Exception yaz?larak yakalan?p yonetilebilir

  Cok fazla var biz en fazla kullan?lanlar?n baz?lar?na bakal?m

Exception Name	  Error Code	Description
--------------    ----------  --------------------------
ACCESS_INTO_NULL  -6530	      Null tan?ml? bir nesneye bir de?er atand???nda olu?ur (Developer- Defined Data Type)
CASE_NOT_FOUND	  -6592	      CASE kullan?ld???nda, seçeneklerden hiçbiri sa?lanm?yor ve ELSE ifadesi yoksa olu?ur
DUP_VAL_ON_INDEX	-0001	      UNIQUE INDEX tan?ml? bir kolona, kolonda var olan bir de?eri atamaya çal???ld???nda olu?ur
INVALID_CURSOR	  -01001	    Aç?k olmayan bir Cursor’dan de?er okunmaya çal???ld???nda olu?ur
INVALID_NUMBER	  -01722	    Say?sal tan?ml? bir kolona ya da de?i?kene String bir de?er atanmaya çal???ld???nda olu?ur
NO_DATA_FOUND	    -01403	    SELECT sonucu herhangi bir kay?t dönmüyorsa, olu?ur
TOO_MANY_ROWS	    -01422	    SELECT sonucu birden fazla kay?t dönüyorsa, olu?ur
VALUE_ERROR	      -06502	    Bir kolona ya da de?i?kene, tan?ml? oldu?u uzunluktan fazla de?er atanmaya çal???ld???nda, olu?ur.

*/

 

/*
    SYNTAX

 

Declare
      ...
Begin
      ...
      ...
      Exception When <exception_name> then
                    ...
                When <exception_name> then
                    ...
                When <exception_name> then
                    ...
End;

 

*/
--*********************************************************************************************
-- Ornek;
-- NO_DATA_FOUND
-- TOO_MANY_ROWS
-- VALUE_ERROR
-- ZERO_DIVIDE
-- Bu Exception'lara bakal?m

 

-- Ornek olarak Employees tablosundan veri okuyal?m

 

-- OracleData user'?na baglanal?m

/

Declare
    rec_emp Employees%RowType;    
Begin
    Select * INTO rec_emp
    From Employees
    Where Employee_id = 100;

    dbms_output.put_line(rec_emp.employee_id || ' ' || rec_emp.first_name);

    Exception When No_Data_Found Then
                   dbms_output.put_line('Kay?t Bulunamad?, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
End;

/

-- yukar?da 100 nolu personeli bulduk
-- simdi olmayan personeli bulal?m ve hatay? yakalayal?m
/
Declare
    rec_emp Employees%RowType;    
Begin
    Select * INTO rec_emp
    From Employees
    Where Employee_id = 999;

    dbms_output.put_line(rec_emp.employee_id || ' ' || rec_emp.first_name);

    Exception When No_Data_Found Then
                   dbms_output.put_line('Kay?t Bulunamad?, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
End;
/

-- Simdi 1 den fazla kay?t okuyal?m
-- Record yapisi sadece tek satir kayit tutabilir.

Declare
    rec_emp Employees%RowType;    
Begin
    Select * INTO rec_emp
    From Employees;

    dbms_output.put_line(rec_emp.employee_id || ' ' || rec_emp.first_name);

    Exception When Too_Many_Rows Then
                   dbms_output.put_line('1den fazla kay?t var, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
End;
/

-- Simdi her ikisini bir arada yazal?m
Declare
    rec_emp Employees%RowType;    
Begin
    Select * INTO rec_emp
    From Employees
    Where Employee_id = 999;

    dbms_output.put_line(rec_emp.employee_id || ' ' || rec_emp.first_name);

    Exception When No_Data_Found Then
                   dbms_output.put_line('Kay?t Bulunamad?, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
              When Too_Many_Rows Then
                   dbms_output.put_line('1den fazla kay?t var, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
End;
/

-- S?f?ra Bolme Hatas? verdirelim
Declare
    val1  Number(5);
Begin
    val1:= 100/0; -- S?f?ra Bolme hatas? meydana gelir

    Exception When Zero_Divide Then
                   dbms_output.put_line('S?f?ra Bolme Hatas?, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);              
End;
/

-- Tan?ml? uzunluktan fazla deger atayal?m
Declare
    val1  Number(5);
Begin
    val1:= 123456;-- Tan?ml? uzunluktan fazla uzun say? girdik, hata meydana gelir

    Exception When Value_Error Then
                   dbms_output.put_line('Fazla buyuk deger girildi, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
End;
/

-- Yukar?da yapt?g?m?z 4 hata mesaj?n? bir arada yazal?m
Declare
    rec_emp Employees%RowType;
    val1  Number(5);
Begin
    val1:= 100/0; -- S?f?ra Bolme hatas? meydana gelir
    val1:= 123456;-- Tan?ml? uzunluktan fazla uzun say? girdik, hata meydana gelir
    Select * INTO rec_emp
    From Employees
    Where Employee_id = 999;

    dbms_output.put_line(rec_emp.employee_id || ' ' || rec_emp.first_name);

    Exception When No_Data_Found Then
                   dbms_output.put_line('Kay?t Bulunamad?, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
              When Too_Many_Rows Then
                   dbms_output.put_line('1den fazla kay?t var, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
              When Zero_Divide Then
                   dbms_output.put_line('S?f?ra Bolme Hatas?, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
              When Value_Error Then
                   dbms_output.put_line('Fazla buyuk deger girildi, SQL Code: ' || sqlcode || ' Error Mesaj: ' || sqlerrm);
End;
/

--*********************************************************************************************
/*
  Exception Gruplar?
    C) User-Defined Exceptions
        (Programc? taraf?ndan yaz?lan istisnalar)

  Tan?ml? istisnalar d???nda, i?leme gore yeni istisnalar olusturulabilir

  SYNTAX

  Declare
<exception_name> EXCEPTION; -- Bu sekilde tan?mlama User_Defined Exception'd?r
  Begin
      ...
      IF <contidion> THEN
            RAISE <exception_name>; -- Bir kosul sagland?g?nda exception_name'e biz yonlendiriyoruz
                                    -- Oncekilerde yonlendirmeler tan?ml? oldugu icin otomatik yap?l?yordu
      END IF;
      ...
      EXCEPTION When <exception_name> then
      ...
  End;
*/        
--*********************************************************************************************

-- Ornek;
-- Bolume gore calisan personel say?s?n? bulan PL/SQL program yazal?m
-- Bolum Numaras?n? runtime esnas?nda girecegiz
/
Declare
      v_dept_id     Employees.Department_id%type;
      v_toplam      Number;
      e_invalid_id  Exception;
Begin
      v_dept_id:= 100;

      Select Count(*) INTO v_toplam
      From Employees
      Where Department_id = v_dept_id;

      dbms_output.put_line(v_dept_id || ' Bolumunde Calisanlar?n Toplam Say?s?: ' || v_toplam);

End;
/

-- department_id klavyeden girilecek sekilde yapal?m
-- ve girilen say?y? negatif ve ayr?ca olmayan bir department_id girelim

Declare
      v_dept_id     Employees.Department_id%type;
      v_toplam      Number;
      e_invalid_id  Exception;
Begin
      v_dept_id:= &Department_id_Giriniz;

      Select Count(*) INTO v_toplam
      From Employees
      Where Department_id = v_dept_id;

      dbms_output.put_line(v_dept_id || ' Bolumunde Calisanlar?n Toplam Say?s?: ' || v_toplam);

End;
/

-- Simdi hata kontrolu yapal?m
Declare
      v_dept_id     Employees.Department_id%type;
      v_toplam      Number;
      e_invalid_id  Exception;
Begin
      v_dept_id:= &Department_ID_Giriniz;

      if v_dept_id > 0 Then
            Select Count(*) INTO v_toplam From Employees Where Department_id = v_dept_id;
            dbms_output.put_line(v_dept_id || ' Bolumunde Calisanlar?n Toplam Say?s?: ' || v_toplam);
      Else
          RAISE e_invalid_id; -- Yani bu hatan?n kodland?g? komut sat?r?na gitmesini istiyoruz
      End if;

      Exception When e_invalid_id Then
           dbms_output.put_line(v_dept_id || ' Girilen Deger Negatif olamaz'); 
End;
/

-- Yukar?daki Exception_Name herhangi bir isim olabilir
-- Ornegin
Declare
      v_dept_id           Employees.Department_id%type;
      v_toplam            Number;
      e_hatali_bolum_no   Exception;
Begin
      v_dept_id:= &Department_ID_Giriniz;

      if v_dept_id > 0 Then
            Select Count(*) INTO v_toplam From Employees Where Department_id = v_dept_id;
            dbms_output.put_line(v_dept_id || ' Bolumunde Calisanlar?n Toplam Say?s?: ' || v_toplam);
      Else
          RAISE e_hatali_bolum_no; -- Yani bu hatan?n kodland?g? komut sat?r?na gitmesini istiyoruz
      End if;      
      Exception When e_hatali_bolum_no Then
           dbms_output.put_line(v_dept_id || ' Girilen Deger Negatif olamaz'); 
End;
/