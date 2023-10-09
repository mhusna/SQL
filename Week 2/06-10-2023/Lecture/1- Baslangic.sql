Set serveroutput ON;

/

--*********************************************************************************************
-- Sys Ref Cursors
-- SYS_REFCURSORS
--*********************************************************************************************
-- Cursorlar� simdiye kadar Cursor anahtar kelimesi ile kulland�k

-- Cursorlar; Cursor anahtar kelimesi kullanmadan da tan�mlanabilir
-- Yani bir degisken tipi(Data Type) gibi tan�myalabiliriz

-- Ornek: Calisanlar�n maaslar�n� %30 zaml� gosteren bir program yaz�n�z

Declare
    imlec SYS_REFCURSOR;
    eski_maas Employees.Salary%TYPE;
    yeni_maas Employees.Salary%TYPE;
Begin
    Open imlec For(Select salary, salary * 1.30 From Employees Where department_id = 100);
    Loop
        Fetch imlec Into eski_maas, yeni_maas;
        Exit When imlec%notfound;
        dbms_output.put_line('Eski maas: ' || eski_maas ||
                             ' - Yeni maas: ' || yeni_maas);
    End Loop;
End;

/

-- Veya sorguyu bir degisken icerisine koyabiliriz.

Declare
    imlec SYS_REFCURSOR;
    wquery Varchar2(2000);
    eski_maas Employees.Salary%TYPE;
    yeni_maas Employees.Salary%TYPE;
Begin
    wquery := 'Select salary, salary * 1.30 From Employees Where department_id = 100';
    Open imlec For wquery;
    Loop
        Fetch imlec Into eski_maas, yeni_maas;
        Exit When imlec%notfound;
        dbms_output.put_line('Eski maas: ' || eski_maas ||
                             ' - Yeni maas: ' || yeni_maas);
    End Loop;
    Close imlec;
End;

/

-- Yukaridaki sorguya update ekleyelim.
-- CALISMIYOR BAK !!
Declare
    imlec SYS_REFCURSOR;
    wquery Varchar2(2000);
    eski_maas Employees2.Salary%TYPE;
    yeni_maas Employees2.Salary%TYPE;
    emp_id Employees2.employee_id%TYPE;
Begin
    wquery := 'Select salary, salary * 1.30 From Employees2 Where department_id = 100';
    Open imlec for wquery;
        Loop
            Fetch imlec into emp_id, eski_maas, yeni_maas;
            Exit When imlec%notfound;
            
            Update Employees2 
            Set Salary = Salary * 1.30
            Where employee_id = emp_id;
            
            dbms_output.put_line('Calisan No: ' || emp_id ||
                                 ' - Eski maas: ' || eski_maas ||
                                 ' - Yeni maas: ' || yeni_maas);
        End Loop;
    Close imlec;
End;

/
--*********************************************************************************************
-- Composite Data Types (Karma Veri Tipleri)
--*********************************************************************************************
-- Hazir veri tiplerinden faydalanilarak
-- yeni veri tipleri olusturmaya Composite Data Types denir

-- 2 Turludur
  -- A) Collection Data Types
  -- B) Record Data Types


  -- A) Collection Data Types
      --  1)Associative Array Index By Table  -- PL/SQL Table ismi verilmektedir
      --  2)Nested Table                      -- PL/SQL Table ismi verilmektedir  
      --  3)Varray(Variable Size Array-Degi�ken Uzunluklu Dizi)
      
      --*** Yukar�daki A)===> 1) ve 2) -- PL/SQL Table ismi verilmektedir
      
  -- B) Record Data Types
      -- 1) Table-Bases Records               -- %ROWTYPE ismi verilmektedir
      -- 2) Cursor-Bases Records              -- %ROWTYPE ismi verilmektedir
      -- 3) Developer-Define Records

      --*** Yukar�daki B)===> 1) ve 2) -- %ROWTYPE ismi verilmektedir

-- Simdi Bunlar� inceleyelim

  -- A) Collection Data Types
      --  1)Associative Array Index By Tables  -- PL/SQL Table ismi verilmektedir
 
 
      
-- Syntax su sekildedir;
-- TYPE <Veritipi_ismi> IS TABLE OF <deger_veri_tipi> INDEX BY <index_veri_tipi>

Declare 
    Type t_dizi is table of Pls_Integer Index By Pls_Integer;
    dizi t_dizi;
Begin
    -- Dizi'nin 1. elemanina 15 sayisini atiyoruz.
    dizi(1) := 15;
    dbms_output.put_line(dizi(1));
    
    dizi(2) := 35;
    dbms_output.put_line(dizi(2));
    
     dizi(3) := 150;
    dbms_output.put_line(dizi(3));
End;

/

-- ORNEK: Sayilarin karesini bulalim.
Declare
    Type t_dizi is table of Pls_Integer Index By Pls_Integer;
    kare t_dizi;
Begin
    kare(2) := 2*2;
    dbms_output.put_line(kare(2));
    
    kare(3) := 3*3;
    dbms_output.put_line(kare(3));
End;

/

-- Simdi yukariyi bir donguye koyalim.
Declare
    Type t_dizi is table of Pls_Integer Index By Pls_Integer;
    kare t_dizi;
Begin
    For i in 1..5
    Loop    
        kare(i) := i * i;
        dbms_output.put_line(kare(i));
    End Loop;
End;

/

-- Ayni islemi Power ile yapalim.
Declare
    Type t_dizi is table of Pls_Integer Index By Pls_Integer;
    kare t_dizi;
Begin
    For i in 1..5
    Loop    
        kare(i) := Power(i, 2);
        dbms_output.put_line(kare(i));
    End Loop;
End;

/

-- Yukaridaki ornekte kup alalim.
Declare
    Type t_dizi is table of Pls_Integer Index By Pls_Integer;
    kup t_dizi;
Begin
    For i in 1..5
    Loop    
        kup(i) := Power(i, 3);
        dbms_output.put_line(kup(i));
    End Loop;
End;

/

-- Simdi once diziye atama yapalim, daha sonra diziden okuma yapalim.
Declare
    Type t_dizi Is Table Of Pls_Integer Index By Pls_Integer;
    kup t_dizi;
Begin
    For i in 1..10
    Loop
        kup(i) := Power(i, 3);
    End Loop;
    
    For i in 1..10
    Loop
        dbms_output.put_line(i || ' sayisinin kupu: ' || kup(i));
    End Loop;
End;

/

-- Ayni ornegi While ile yapalim.
Declare
    Type t_assoc_num Is Table Of Pls_Integer Index By Pls_Integer;
    kup t_assoc_num;
    j Number;
Begin
    For i in 1..10
    Loop
        kup(i) := Power(i, 3);
    End Loop;
    
    -- Dizinin ilk indexini bulalim ve j'ye atayalim..
    j := kup.First;
    
    While j is not null
    Loop
        dbms_output.put_line(j || ' sayisinin kupu: ' || kup(j));
        
        -- Next komutu ile de bir sonraki index degerini bulalim.
        j := kup.Next(j);
    End Loop;
End;

/

-- Index'i integer, degeri varchar yapalim.
Declare
    Type t_assc Is Table Of Employees.Last_Name%TYPE Index By Pls_Integer;
    last_name t_assc;
    
    j Number;
Begin
    j := 0;
    For i in (Select last_name From Employees Where rownum <= 10)
    Loop
        j := j + 1;
        last_name(j) := i.last_name;
        
        dbms_output.put_line('last_name(' || j || ')=' || last_name(j));
    End Loop;
End;

/

-- Index'i varchar, degeri de varchar yapalim.
Declare
    Type t_assc Is Table Of Varchar2(35) Index By Varchar2(10);
    wjobs t_assc;
Begin
    For i in (Select job_id, job_title From Jobs)
    Loop
        wjobs(i.job_id) := i.job_title;
        dbms_output.put_line('wjobs(' || i.job_id || ') = ' || wjobs(i.job_id));
    End Loop;
End;

/

-- Veya once atayalim sonra okuyalim.
Declare
    Type t_assc Is Table Of Varchar2(35) Index By Varchar2(10);
    wjobs t_assc;
    j Number;
Begin
    For i in (Select job_id, job_title From Jobs)
    Loop
        wjobs(i.job_id) := i.job_title;
    End Loop;
    
    For j in (Select job_id From Jobs)
    Loop
        dbms_output.put_line('wjobs(' || j.job_id || ') = ' || wjobs(j.job_id));
    End Loop;
End;

/

-- Simdi Collection Data Types'�n Nested Table konusuna gecelim
-- A) Collection Data Types
      --  2)Nested Table                      -- PL/SQL Table ismi verilmektedir  

/*
 Associative Array Index By Tables icerisinde INDEX tipini belirliyebiliyorduk
 integer olabilir, String olabilir
 ama Nested Table'da INDEX belirleyemiyoruz, Cunku daima integer'd�r
 */
 
 -- ORNEK: Ogrenci ve sinav puanini bir dizide tutacagiz.
 Declare
    -- Index belirtmeden tanimlayalim.
    -- Burada tip tanimliyoruz.
    Type ndt_isimler Is Table Of Varchar2(10); 
    Type ndt_puanlar Is Table Of Integer;
    
    -- Burada da yukarida tanimladigimiz tip ile degisken olusturuyoruz.
    
    isimler ndt_isimler;
    puanlar ndt_puanlar;
 Begin
    -- Asagidaki kullanim constructor metod olarak adlandirilir.
    isimler := ndt_isimler('Ali', 'Yaren', 'Pinar', 'Ahmet', 'Bedir');
    puanlar := ndt_puanlar(100, 99, 85, 97, 93);
    
    -- Count dizideki eleman sayisini bulan dizi metodudur.
    dbms_output.put_line('Toplam ogrenci sayisi: ' || isimler.Count);
    
    For i in 1..isimler.Count
    Loop
        dbms_output.put_line('Ogrenci: ' || isimler(i) || ' Puan: ' || puanlar(i));
    End Loop;
 End;

/

-- Nested Table veri tiplerine 2. bir ornek yapalim.
-- ORNEK: Personel isimlerini bir dizide tutalim ve bunu bir Cursor ile yapalim.

Declare
    Cursor c_employees Is Select first_name From Employees;
    
    Type ndt_list Is Table Of Employees.first_name%TYPE;
    
    -- name_list ndt_list; -- Kurucu metod yontemi atamadan 
                        -- bunu bu sekilde calistirirsak hata aliriz
                        -- "Reference to uninitialized collection" hatas� al�r�z,
                        -- Bu nedenle kurucu metod ile tan�mlamam�z gerekir
                        
    name_list ndt_list := ndt_list();
    counter integer := 0;
Begin
    For n in c_employees
    Loop
        counter := counter + 1;
        
        -- Veri girebilmek icin diziyi genisletiyoruz.
        name_list.extend;
        name_list(counter) := n.first_name;
        dbms_output.put_line('Employees(' || counter || '):' || name_list(counter));
    End Loop;
End;

/

-- ORNEK: Personel isimlerini ve soyisimlerini bir dizide tutalim.
-- Index By olmadigi icin new tarzi bir yapi kullanmaliyiz.
Declare
    Cursor c_employees Is Select first_name, last_name From Employees;
    
    -- Type ndt_list IS TABLE OF Employees.first_name%Type; 
    -- Bunu degil Cursor'i referans alacag�z
    Type ndt_list IS TABLE OF c_employees%RowType;
    
    name_list ndt_list:= ndt_list();
    counter integer:=0;
Begin
    For n IN c_employees
    Loop
          counter := counter + 1;
          name_list.extend; -- veri girebilmek icin diziyi genisletiyoruz
          name_list(counter).first_name := n.first_name;
          name_list(counter).last_name := n.last_name;
          dbms_output.put_line('Employees(' || counter || '):' || 
                               name_list(counter).first_name || ' ' || 
                               name_list(counter).last_name);    
    End Loop;
End;

/

-- Simdi Collection Data Types'�n Varray konusuna gecelim
  -- A) Collection Data Types
      --  3)Varray(Variable Size Array-Degi�ken Uzunluklu Dizi)
      --  Varray Data Types
-- Varray Data Types-Syntax
TYPE type_name IS VARRAY (Size_Limit) OF element_type;
/
-- Ornek; 10 Boyutlu ve her bir h�cresinde 1 karakter de�er alan VARRAY veri tipi
TYPE puanlar IS VARRAY(10) Char(1);         TYPE tan�m�
-- Yani puanlar dizisi 10 boyutlu ve her bir boyuz 1 karakter uzunlugundad�r
/
TYPE puanlar IS VARRAY(10) Char(1);               -- TYPE tan�m�
puan puanlar:= puanlar('A','L','I','S','Q','L');  -- Constructor
-- Veya atamay� sonrada yapabiliriz yani su sekilde olabilir
puan puanlar:= puanlar();  -- Constructor
-- Bos parantez ile Constructor yap�s�n� kurar�z sonrada atamalar� yapar�z

puan puanlar:= puanlar('A','L','I','S','Q','L');  -- Constructor
-- Bu sekilde yapt���m�zda 10 Boyutlu array'l�k diziye 6 deger atad�k,
-- kalan 4 tanesi(bos degil, null degil) hicbir sey atanmam�s anlam�na gelir
-- kalan yerlere atama yapmak istersek .extend ile diziyi geni�letmemiz gerekir ve
-- atama yapabiliriz

-- Ornek yapal�m;
-- Futbol tak�mlar�n�n isimlerini ve s�ralamalar�n� bir dizide tutal�m
/*
    TYPE takimlar IS ARRAY(10) Varchar2(30);
    -- Varray'da 10 tane ile diziyi s�n�rlad�k, onceki 2 tan�mlamada da yani
    -- Associative Array Index By Tables ve Nested Tables'larda s�n�r yoktu
    -- Ama Varray'de s�n�r var
*/    
-- Nested Table ve Varray'lerde index tamsay� oldugu icin belirtmiyoruz
/
Declare
    TYPE takimlar IS ARRAY(10)OF Varchar2(30);
    -- takim takimlar := takimlar(); -- Constructor ile kurucu yap�y� yapt�k, sonrada atama yapabiliriz
    -- veya su sekilde de yapabiliriz
    takim takimlar := takimlar('GS','FB','BJK','TS');-- 10 Boyutlu dizinin 4 tanesini atad�k
Begin
    dbms_output.put_line('2001');
    dbms_output.put_line('----');
    
    For i IN 1.. takim.count
    Loop
      dbms_output.put_line(i || '.Tak�m ' || takim(i));    
    End Loop;    
End;
/
-- Yukar�daki programda takim.count yerine atanan 4 tane deger icin 4 yazarsakta calisir
-- ama 5 yazarsak hata verir,
-- her ne kadar dizi 10 olsada sadece 4 tane atand� ve extend ile 5. veri girilmeden
-- 5 defa dongu donmez, hata olmamas� icin takim.count ile kullanmak daha dogru olur
-- Yeni bir sayfada bu program� calistiralim

-- Asagidaki sorgu dongunun ust limiti 5 verildigi icin hata verecektir
-- cunku 4 elemanl? oldugu icin ust sinir 4 olabilir veya takim.count olabilir
Declare
    TYPE takimlar IS ARRAY(10) OF Varchar2(30);
    takim takimlar := takimlar('GS','FB','BJK','TS');-- 10 Boyutlu dizinin 4 tanesini atad�k
Begin
    dbms_output.put_line('2001');
    dbms_output.put_line('----');
    
    For i IN 1..5 Loop
      dbms_output.put_line(i || '.Tak�m ' || takim(i));    
    End Loop;    
End;
/
-- "Subscript beyond count" hatas� verecektir
-- Simdi 5 yerine 4 yazal�m, dogru calisacakt�r
Declare
    TYPE takimlar IS ARRAY(10)OF Varchar2(30);
    takim takimlar := takimlar('GS','FB','BJK','TS');-- 10 Boyutlu dizinin 4 tanesini atad�k
Begin
    dbms_output.put_line('2001');
    dbms_output.put_line('----');
    
    For i IN 1..4 Loop
      dbms_output.put_line(i || '.Tak�m ' || takim(i));    
    End Loop;    
End;
/
-- Yukar�daki ornegimizi gelistirelim
-- Ornek 2;

Declare
    TYPE takimlar IS ARRAY(10)OF Varchar2(30);
    takim takimlar := takimlar('GS','FB','BJK','TS');-- 10 Boyutlu dizinin 4 tanesini atad�k
Begin
    dbms_output.put_line('2001');
    dbms_output.put_line('----');
    
    For i IN 1..takim.count
    Loop
      dbms_output.put_line(i || '.Tak�m ' || takim(i));    
    End Loop;
    
    -- diziye 5. eleman ekleyelim ve 4. eleman� guncelleyelim
    takim.extend;
    takim(5):= 'Bursa Spor';
    takim(4):= 'izmir Spor';  -- 4. eleman� guncelledik
    
    dbms_output.new_line;
    
     For i IN 1..takim.count
     Loop
      dbms_output.put_line(i || '.Tak�m ' || takim(i));    
     End Loop;
    
    -- Dizinin elemanlar�n� yeniden tan�mlayal�m
    
    takim := takimlar('BursaSpor','DemirSpor','izmirSpor');
    -- dizi onceki sat�rlarda 5 boyutlu dizi haline gelmisti
    -- ama yukar�daki sat�rla s�f�rdan 3 boyutlu hale getirdik
    
    dbms_output.new_line;
    
     For i IN 1..takim.count
     Loop
      dbms_output.put_line(i || '.Tak�m ' || takim(i));    
    End Loop;    
End;
/
-- Simdi yukar�da gordugumuz 3 yap� icin farkl�l�klara bakal�m
-- Resmi slayt olarak ekleyebiliriz
  -- A) Collection Data Types
    -- 1)Associative Array Index By Table  tan�mlama DB'de olmas� gerekmiyorsa(Esnek ve s�n�rs�z index ise)
    -- 2)Nested Table                      tan�mlama DB'de olmas� gerekiyorsa (Esnek ve s�n�rs�z index ise)
    -- 3)Varray(Variable Size Array)       tan�mlama DB'de olmas� gerekiyorsa (S�n�rl� index ise)
      --(Degi�ken Uzunluklu Dizi)

-- Simdi yukar�daki 3 yap�y� ayn� ornek icerisinde kullanal�m ve konuyu daha iyi kavrayal�m
Declare
    TYPE t_nested IS TABLE OF     Varchar2(30); -- dizi.extend ile s�n�rs�z geni�letilebilir, INDEX integer'd�r
    TYPE t_varray IS VARRAY(5) OF Varchar2(30); -- dizi.extend ile Max 5 e kadar geni�letilebilir, INDEX integer'd�r
                                                -- Cunku Varray(5) olarak tan�mlad�k
    -- TYPE t_varray IS VARRAY(5) OF Number(16,2);    
    
    TYPE t_assoc_array_num  IS TABLE OF Number       INDEX BY Pls_Integer;
    TYPE t_assoc_array_str  IS TABLE OF Varchar2(30) INDEX BY Pls_Integer;
    TYPE t_assoc_array_str2 IS TABLE OF Varchar2(30) INDEX BY Varchar2(100);    
    
    ndt_var t_nested; -- ndt yani nested data types k�saltmas�n� kulland�m, herhangi bir isim olabilir
    varr_var t_varray;
    
    assoc_var1 t_assoc_array_num;
    assoc_var2 t_assoc_array_str;
    assoc_var3 t_assoc_array_str2;
Begin
    ndt_var:= t_nested('SQL','PL/SQL','DBA');
    varr_var:= t_varray(99.5,12,59,96);
    
    assoc_var1(99) := 30;
    assoc_var1(10) := 40;
    
    assoc_var2(20) := 'Elma';
    assoc_var2(29) := 'Muz';
    
    assoc_var3('izmir') := 'Ege Bolgesi';    
End;

/

-- Simdi yukaridakileri yazdiralim
Declare
    -- Dizi.extend ile sinirsiz genisletilebilir. Index integer'dir.
    Type t_nested Is Table Of Varchar2(30);
    
    -- Dizi.extend ile max 5'e kadar genisletilebilir Index integer'dir.
    Type t_varray Is Varray(5) Of Varchar2(30);
    
    TYPE t_assoc_array_num  IS TABLE OF Number       INDEX BY Pls_Integer;
    TYPE t_assoc_array_str  IS TABLE OF Varchar2(30) INDEX BY Pls_Integer;
    TYPE t_assoc_array_str2 IS TABLE OF Varchar2(30) INDEX BY Varchar2(100);    

    ndt_var t_nested; -- ndt yani nested data types k�saltmas�n� kulland�m, herhangi bir isim olabilir
    varr_var t_varray;
    
    assoc_var1 t_assoc_array_num;
    assoc_var2 t_assoc_array_str;
    assoc_var3 t_assoc_array_str2;
Begin    
    ndt_var:= t_nested('SQL','PL/SQL','DBA');
    varr_var:= t_varray(99.5,12,59,96);
    
    assoc_var1(99) := 30;
    assoc_var1(10) := 40;
    
    assoc_var2(20) := 'Elma';
    assoc_var2(29) := 'Muz';
    
    assoc_var3('izmir') := 'Ege Bolgesi';

    dbms_output.put_line('*** Nested Table ***');
    For i in 1..ndt_var.count
    Loop
      dbms_output.put_line('Nested Table : ' || ndt_var(i));
    End Loop;
    dbms_output.new_line;    
    
    dbms_output.put_line('*** Varray Table ***');    
    For i in 1..varr_var.count
    Loop
      dbms_output.put_line('Varray Table : ' || varr_var(i));
    End Loop;
    dbms_output.new_line;
    
      dbms_output.put_line('*** Associative Table ***');
      dbms_output.put_line('Associative Table Number ve Integer : ' || assoc_var1(10));
      dbms_output.put_line('Associative Table Number ve Integer :  : ' || assoc_var1(99));

      dbms_output.put_line('Associative Table String ve Integer : ' || assoc_var2(20));
      dbms_output.put_line('Associative Table String ve Integer : ' || assoc_var2(29));

      dbms_output.put_line('Associative Table String ve String : ' || assoc_var3('izmir')); 
End;

/

-- A) Collection Data Types
-- Hangi ortamlarda tan�mlanabilirler?  
    -- 1)Associative Array Index By Tables  Veritaban� icerisinde tan�mlanamaz, Sadece PL/SQL bloklar�nda tan�mlanabilir
    -- 2)Nested Tables                      Veritaban� icerisinde tan�mlanabilir, PL/SQL bloklar�nda tan�mlanabilir
    -- 3)Varrays(Variable Size Array)       Veritaban� icerisinde tan�mlanabilir, PL/SQL bloklar�nda tan�mlanabilir
      --(Degi�ken Uzunluklu Dizi)

-- Veritaban�nda tan�ml� veri tipleri listesini ve kaynak kodlar�n� nas�l gorebiliriz
-- ALL_TYPES, DBA_TYPES, USER_TYPES ( Bunlar VIEW'd�r)

-- Bunlari SYS altinda yap.
Select * From User_TYPES;
/
Select * From DBA_TYPES;
/
Select * From ALL_TYPES;
/

-- Onceki program uzerinde devam edelim
-- Ve Nested Tables ile Varray Tables tan�mlamalar�n� Database icinde yapal�m
-- Nested Tables ve Varray Tables tan�mlamalar� hem Database icinde hemde PL/SQL icinde yap�labilir
-- Ancak Associative Array Index By Tables tan�mlamalar� sadece PL/SQL icinde yap�labilir

Create or Replace TYPE t_nested IS TABLE OF     Varchar2(30);
/
Create or Replace TYPE t_varray IS VARRAY(5) OF Varchar2(30);
/
Create TYPE t_varrayB IS VARRAY(5) OF Varchar2(30);
/
Create or Replace TYPE t_varrayB IS VARRAY(5) OF Varchar2(30);
-- or Replace zorunlu degildir
/
-- Yukar�dakiler Database icerisinde olustu, kontrol edelim

Select * From User_Types;
/
-- Ancak Associative Array Index By Tables Database icerisinde tan�mlamaya kalkarsak hata verir
-- Derlenir ama hatal� derlenir, yapal�m sonrada Drop edelim
Create or Replace TYPE t_assoc_array_num IS TABLE OF Number INDEX BY Pls_Integer;
/
/*
    TYPE T_ASSOC_ARRAY_NUM compiled
    Errors: check compiler log
    Seklinde hata ald�k
*/

-- Database icerisinde olustu, ama hatali olustu, kontrol edelim ve silelim
/
Select * From User_Types;
/
Drop Type t_assoc_array_num;
/

Select * From User_Types;
/
-- Peki yapt�g�m�z tan�mlamalar�n hangisinin Nested veya hangisinin Varray oldugunu nas�l gorebiliriz
-- Bunun icin USER_SOURCE view'�ndan faydanalacagiz

Select * From USER_SOURCE WHERE TYPE = 'TYPE';
-- Drop Type Adres_T;
/
Declare
    TYPE t_assoc_array_num  IS TABLE OF Number       INDEX BY Pls_Integer;
    TYPE t_assoc_array_str  IS TABLE OF Varchar2(30) INDEX BY Pls_Integer;
    TYPE t_assoc_array_str2 IS TABLE OF Varchar2(30) INDEX BY Varchar2(100);    
    
    ndt_var t_nested;
    varr_var t_varray;
    
    assoc_var1 t_assoc_array_num;
    assoc_var2 t_assoc_array_str;
    assoc_var3 t_assoc_array_str2;
Begin
    ndt_var:= t_nested('SQL','PL/SQL','DBA');
    varr_var:= t_varray(99.5,12,59,96);
    
    assoc_var1(99) := 30;
    assoc_var1(10) := 40;
    
    assoc_var2(20) := 'Elma';
    assoc_var2(29) := 'Muz';
    
    assoc_var3('izmir') := 'Ege Bolgesi';

    dbms_output.put_line('*** Nested Table ***');
    For i in 1..ndt_var.count Loop
      dbms_output.put_line('Nested Table : ' || ndt_var(i));
    End Loop;
    dbms_output.new_line;    
    
    dbms_output.put_line('*** Varray Table ***');    
    For i in 1..varr_var.count Loop
      dbms_output.put_line('Varray Table : ' || varr_var(i));
    End Loop;
    dbms_output.new_line;
    
      dbms_output.put_line('*** Associative Table ***');
      dbms_output.put_line('Associative Table Number ve Integer : ' || assoc_var1(10));
      dbms_output.put_line('Associative Table Number ve Integer :  : ' || assoc_var1(99));

      dbms_output.put_line('Associative Table String ve Integer : ' || assoc_var2(20));
      dbms_output.put_line('Associative Table String ve Integer : ' || assoc_var2(29));

      dbms_output.put_line('Associative Table String ve String : ' || assoc_var3('izmir'));    
End;
/

-- Collection Data Types'larda kullan�lan metodlar
-- Delete,  (Procedure) Dizi eleman�n� siler
-- Trim,    (Procedure) Dizinin son eleman�n� siler
-- Extend,  (Procedure) Diziye yeni eleman ekler
-- Exists,  (Function ) Eleman�n varl���n� kontrol eder(True/False)
-- First,   (Function ) Dizinin ilk indeksini return eder
-- Last,    (Function ) Dizinin son indeksini return eder
-- Count,   (Function ) Dizinin eleman say�s�n� return eder
-- Limit,   (Function ) Dizinin max. eleman say�s�n� return eder
-- Prior,   (Function ) Belirtilen dizinden �nceki dizini return eder
-- Next,    (Function ) Sonraki indeksi return eder

-- Delete indexin icerisindeki degeri siler.
-- Trim komple indexi ucurur.

-- Ornekler

-- Delete,  (Procedure) Dizi eleman�n� siler

-- Delete       Dizinin tum elemanlar�n� siler
-- Delete(n)    Dizinin n. eleman�n� siler
-- Delete(m,n)  Dizinin m.ve n. dahil aradaki t�m elemanlar� siler

Declare
    Type ndt_sayilar IS TABLE OF Integer;
    dizi ndt_sayilar := ndt_sayilar(10,20,29,34,99,101,120,140,160);
Begin
    dbms_output.new_line;
    dbms_output.put_line('Orjinal -----');
    For i in 1..dizi.count Loop
        dbms_output.put_line('Dizi(' || i || ')=' || dizi(i));
    End Loop;
    
    dizi.Delete(2);
    dbms_output.new_line;
    dbms_output.put_line('2. Eleman Silindi -----');
    For i in 1..dizi.count Loop
        if dizi.Exists(i) Then
            dbms_output.put_line('Dizi(' || i || ')=' || dizi(i));
        Else
            dbms_output.put_line('Dizi(' || i || ')= Yok');
        End if;        
    End Loop;
    
    dizi(2):= '499';
    dbms_output.new_line;
    dbms_output.put_line('2. Eleman Eklendi -----');
    For i in 1..dizi.count Loop
        if dizi.Exists(i) Then
            dbms_output.put_line('Dizi(' || i || ')=' || dizi(i));
        Else
            dbms_output.put_line('Dizi(' || i || ')= Yok');
        End if;        
    End Loop;
    
    dizi.Delete(3,5); -- dizinin 3 ile 5 aras�ndaki elemanlar�n� siler
    dbms_output.new_line;
    dbms_output.put_line('3,4,5 aras� Elemanlar Silindi -----');
    dbms_output.put_line('Kalan Kay�t Say�s� = ' || dizi.count);
    For i in 1..dizi.count + 3 Loop -- 3 tane eleman silindigi icin count 3 eksildi hepsini gostermesi icin + 3 yazd�k
        if dizi.Exists(i) Then
            dbms_output.put_line('Dizi(' || i || ')=' || dizi(i));
        Else
            dbms_output.put_line('Dizi(' || i || ')= Yok');
        End if;        
    End Loop;

    dizi.Delete; -- Dizinin Tum elemanlar�n� siler
    dbms_output.new_line;
    dbms_output.put_line('Dizinin Tum elemanlar� Silindi -----');
    dbms_output.put_line('Kalan Kay�t Say�s� = ' || dizi.count);
    For i in 1..dizi.count Loop -- tum elemanlar silindigi icin bu count = 0 d�r ve Loop'a girmez
        if dizi.Exists(i) Then
            dbms_output.put_line('Dizi(' || i || ')=' || dizi(i));
        Else
            dbms_output.put_line('Dizi(' || i || ')= Yok');
        End if;        
    End Loop;
end;

/

-- Trim,    (Procedure) Dizinin son eleman�n� siler
-- Trim(n), (Procedure) Dizinin son n tane eleman�n� siler

-- Trim ile delete ayn� isi yap�yor gozuksede
-- Trim dizideki elemanlar� tamamen ortadan kald�r�r
-- Delete ise dizinin silinen hucresini tan�ms�z hale getirir

Declare
    Type varr_type IS VARRAY(10) OF Integer;
    var1 varr_type := varr_type(10,20,29,34,99,101,120,140,160);
Begin
    dbms_output.new_line;
    dbms_output.put_line('Orjinal -----');
    For i in 1..var1.count Loop
        dbms_output.put_line('var1(' || i || ')=' || var1(i));
    End Loop;
    
    var1.Trim;  -- Dizinin son eleman�n� tamamen siler

    dbms_output.new_line;
    dbms_output.put_line('Trim Dizinin son eleman�n� tamamen siler');
    For i in 1..var1.count Loop
        dbms_output.put_line('var1(' || i || ')=' || var1(i));
    End Loop;
    
    var1.Trim(3);  -- Dizinin son 3 eleman�n� tamamen siler

    dbms_output.new_line;
    dbms_output.put_line('Trim(3) Dizinin son 3 eleman�n� tamamen siler');
    For i in 1..var1.count Loop
        dbms_output.put_line('var1(' || i || ')=' || var1(i));
    End Loop;       
End;
/
-- Trim ile Delete aras�ndaki farka bakal�m

Declare
    Type varr_type IS VARRAY(10) OF Integer;
    var1 varr_type := varr_type(10,20,29,34,99,101,120,140,160);
Begin
    dbms_output.new_line;
    dbms_output.put_line('Orjinal -----');
    For i in 1..var1.count Loop
        dbms_output.put_line('var1(' || i || ')=' || var1(i));
    End Loop;
    
    var1.Trim(3);     -- Dizinin son 3 hucresini tamamen siler ama Drop ederek siler
    -- var1.Delete;     Bu ise Dizinin Tum hucrelerinin icerigini siler ama hucre kal�r
    -- Var1.Delete(2)   VARRAY dizi yonteminde  kullan�lamaz, yani parametreli kullan�lamaz
    -- Var1.Delete(2,4) VARRAY dizi yonteminde  kullan�lamaz, yani parametreli kullan�lamaz
    -- Var1.Delete(2)   Nested Table'larda kullan�labilir
    -- Var1.Delete(2,4) Nested Table'larda kullan�labilir
    
    dbms_output.new_line;
    dbms_output.put_line('Trim(3) Dizinin son 3 eleman�n� tamamen siler');
    For i in 1..var1.count Loop
        dbms_output.put_line('var1(' || i || ')=' || var1(i));
    End Loop;
    
    var1.delete;
    
    dbms_output.new_line;
    dbms_output.put_line('Delete Dizinin tum hucrelerinin icerigini siler');
    dbms_output.put_line('Kalan Dizi elemanlar�n�n Say�s� = ' || var1.count);
    For i in 1..6 Loop
        if var1.exists(i) Then
              dbms_output.put_line('var1(' || i || ')=' || var1(i));
        Else
              dbms_output.put_line('var1(' || i || ')= tan�ms�z'); -- yani hucreler duruyor ama tan�ms�z
        End if;
    End Loop;    
End;

/

-- Extend,  (Procedure) Diziye yeni eleman ekler
/*
  Bu Method hem nested hemde varray'de kullan�labilir
  Extend;       Diziye de�eri null olan 1 eleman ekler
  Extend(n);    Diziye de�eri null olan n eleman ekler
  Extend(n,i);  Diziye i.Eleman�n n kopyas�n� ekler(Dizi tan�m�nda Not Null olmas� gerekir) 
*/

Declare
      TYPE ndt_type IS TABLE OF INTEGER;
      var1 ndt_type:=ndt_type(10,20,30);
      i Integer;
Begin
      i:= var1.first;
      While i is not null
      Loop
          dbms_output.put_line('var1(' || i || ')= ' || var1(i));
          i:= var1.next(i);
      End Loop;
End;
/
-- Yukar�daki programa Extend ile 1 s�radaki 10 say�s�n� 2 defa ekleyelim

Declare
      TYPE ndt_type IS TABLE OF INTEGER;
      var1 ndt_type:=ndt_type(10,20,30);
      i Integer;
Begin
      i:= var1.first;
      While i is not null Loop
          dbms_output.put_line('var1(' || i || ')= ' || var1(i));
          i:= var1.next(i);
      End Loop;
     
      dbms_output.put_line('*** simdi Extend(2,1) yapal?m ve sonucu gorelim***'); 
      var1.Extend(2,1); -- 1. eleman olan 10 say�s�ndan 2 tane dizinin sonuna ekler
 
      i:= var1.first;
      While i is not null Loop
          dbms_output.put_line('var1(' || i || ')= ' || var1(i));
          i:= var1.next(i);
      End Loop;
End;
/
-- Yukar�daki programa Extend ile tek veri ekleyelim
Declare
      TYPE ndt_type IS TABLE OF INTEGER;
      var1 ndt_type:=ndt_type(10,20,30);
      i Integer;
Begin
      i:= var1.first;
      While i is not null Loop
          dbms_output.put_line('var1(' || i || ')=' || var1(i));
          i:= var1.next(i);
      End Loop;
      
      dbms_output.put_line('*** simdi Extend(2,1) yapal?m ve sonucu gorelim***'); 
      
      var1.Extend(2,1); -- 1. eleman olan 10 say�s�ndan 2 tane dizinin sonuna ekler
 
      i:= var1.first;
      While i is not null Loop
          dbms_output.put_line('var1(' || i || ')=' || var1(i));
          i:= var1.next(i);
      End Loop;
      
      dbms_output.put_line('*** simdi Extend yapal?m ve sonucu gorelim***'); 
      
      var1.Extend; -- Diziyi 1 hucre genisletir
      var1(6) :=99;-- Genisleyen diziye 99 say�s�n� ekliyoruz
    
      i:= var1.first;
      While i is not null Loop
          dbms_output.put_line('var1(' || i || ')=' || var1(i));
          i:= var1.next(i);
      End Loop;      
End;
/

-- Simdi Yukar�daki kodu Procedure ile sadelestirelim
-- Yani tekrar tekrar kullan�lan dongu degerini Procedure yapal�m ve cag�ral�m

Declare
      TYPE ndt_type IS TABLE OF INTEGER;
      var1 ndt_type:=ndt_type(10,20,30);
      
      Procedure Yaz IS
            i Integer;
      Begin
            i:= var1.first;
            While i is not null Loop
                dbms_output.put_line('var1(' || i || ')=' || var1(i));
                i:= var1.next(i);
            End Loop;
                dbms_output.put_line('-----------------');
      End Yaz;
Begin
      Yaz;
      
      var1.Extend(2,1); -- 1. eleman olan 10 say�s�ndan 2 tane dizinin sonuna ekler
 
      Yaz;
      
      var1.Extend; -- Diziyi 1 hucre genisletir
      var1(6) :=99;-- Genisleyen diziye 99 say�s�n� ekliyoruz
      
      Yaz;    
End;
/

-- Fonksiyon kesinlikle return eder, procedure istersek eder istemezsek etmez.
-- Eger bir isi procedure ile yapabilirsen onunla yap. Fonksiyon performans yer.
-- Procedure is akisidir, fonksiyonlari procedure icerisinde cagiririz.

Declare
      TYPE ndt_type IS TABLE OF INTEGER;
      var1 ndt_type:=ndt_type(10,20,30);
      
      Procedure Yaz IS
          i Integer;
      Begin
            i:= var1.first;
            While i is not null Loop
                dbms_output.put_line('var1(' || i || ')=' || var1(i));
                i:= var1.next(i);
            End Loop;
                dbms_output.put_line('-----------------');
      End Yaz;
Begin
      Yaz;
      
      var1.Extend(2,1); -- 1. eleman olan 10 say�s�ndan 2 tane dizinin sonuna ekler
      Yaz;
      
      var1.Extend; -- Diziyi 1 hucre genisletir
      var1(6) :=99;-- Genisleyen diziye 99 say�s�n� ekliyoruz      
      Yaz;
      
      dbms_output.put_line('*** Delete(5) islemi yap?yoruz***');
      var1.Delete(5);
      Yaz;

      dbms_output.put_line('*** Extend(3 islemi yap?yoruz***');     
      var1.Extend(3); -- Diziyi 3 hucre genisletir
      Yaz;
End;
/
-- Type tan�mlamas�n� Nested Table ile not null demeden de kullanabiliriz
-- ama Varray Table ile NOT NULL kullanmak zorunday�z
Declare
      TYPE ndt_type IS TABLE OF INTEGER NOT NULL;
      var1 ndt_type:=ndt_type(10,20,30);
      
      Procedure Yaz IS
          i Integer;
      Begin
            i:= var1.first;
            While i is not null Loop
                dbms_output.put_line('var1(' || i || ')=' || var1(i));
                i:= var1.next(i);
            End Loop;
                dbms_output.put_line('-----------------');
      End Yaz;
Begin
      Yaz;
      
      var1.Extend(2,1); -- 1. eleman olan 10 say�s�ndan 2 tane dizinin sonuna ekler
      Yaz;
      
      var1.Extend; -- Diziyi 1 hucre genisletir
      var1(6) :=99;-- Genisleyen diziye 99 say�s�n� ekliyoruz      
      Yaz;
      
      var1.Delete(5);
      Yaz;
      
      var1.Extend(3); -- Diziyi 3 hucre genisletir
      Yaz;
End;
/
-- Simdi Yukar�daki ornegi VARRAY ile yapal�m

-- Type tan�mlamas�n� Nested Table ile not null demeden de kullanabiliriz
-- ama Varray Table ile NOT NULL kullanmakta fayda var, baz� islemlerde hata ile kars�lasabiliriz
-- ornek olarak bunu var1.Extend(2,1); hata verebilir
Declare
      TYPE varr_type IS VARRAY(10) OF INTEGER NOT NULL;                                                      
      var1 varr_type:=varr_type(10,20,30);
      
      Procedure Yaz IS
          i Integer;
      Begin
            i:= var1.first;
            While i is not null Loop
                dbms_output.put_line('var1(' || i || ')=' || var1(i));
                i:= var1.next(i);
            End Loop;
                dbms_output.put_line('-----------------');
      End Yaz;
Begin
      Yaz;
      
      var1.Extend(2,1); -- 1. eleman olan 10 say�s�ndan 2 tane dizinin sonuna ekler
      Yaz;
      
      var1.Extend; -- Diziyi 1 hucre genisletir
      var1(6) :=99;-- Genisleyen diziye 99 say�s�n� ekliyoruz      
      Yaz;
            
      var1.Extend(3); -- Diziyi 3 hucre genisletir
      Yaz;

      --var1.Delete(5);-- Varray ile Parametre kullan�lmaz
      var1.Delete;-- Varray ile Parametre kullan�lmaz
      dbms_output.put_line('***');
      Yaz;
      dbms_output.put_line('***');
End;

/

-- Exists,  (Function ) Eleman�n varl���n� kontrol eder(True/False)

Declare
      TYPE ndt_type IS TABLE OF Char(1);                                        
      var1 ndt_type:=ndt_type('P','L','/','S','Q','L');
Begin
      For i IN 1..6 Loop
          if var1.exists(i) Then
              dbms_output.put_line('var1(' || i || ')=' || var1(i));
          Else
              dbms_output.put_line('var1(' || i || ')= Eleman yok');
          End if;          
      End Loop;
          dbms_output.put_line('-----------------');
          
      var1.Delete(3);     
      For i IN 1..6
      Loop
          if var1.exists(i) Then
              dbms_output.put_line('var1(' || i || ')=' || var1(i));
          Else
              dbms_output.put_line('var1(' || i || ')= Eleman yok');
          End if;          
      End Loop;
          dbms_output.put_line('-----------------');      
End;
/
-- First,   (Function ) Dizinin ilk indeksini return eder
-- Last,    (Function ) Dizinin son indeksini return eder
-- Count,   (Function ) Dizinin eleman say�s�n� return eder
-- Limit,   (Function ) Dizinin max. eleman say�s�n� return eder

-- First, Last, Count ve Limit metodlar�n� ayn� ornek icerisinde inceleyelim
-- Oncelikle ornegimizi VARRAY ile yapal�m
-- Sonra Nested Table ve Associative Array Index By Table ile yapar�z

Declare
    Type varray_type IS VARRAY(15) OF Number;
    varr varray_type:= varray_type(10,22,35,49,50,99);
    
    Procedure Yaz IS
    
    Begin
        dbms_output.put_line('Varray.Count = ' || varr.Count);  -- Dizinin eleman say�s�n� verir
        dbms_output.put_line('Varray.Limit = ' || varr.Limit);  -- Dizinin boyutunu verir. Sadece VARRAY'lerde calisir
        dbms_output.put_line('Varray.first = ' || varr.first);  -- Dizinin ilk eleman�n�n INDIS'ini verir
        dbms_output.put_line('Varray.Last = ' || varr.Last);    -- Dizinin son eleman�n�n INDIS'ini  verir
    
    End Yaz;
Begin
    dbms_output.put_line('Orjinal Degerler');
    Yaz;
    
    varr.Extend; -- dizinin sonuna 1 tane ekler
    dbms_output.put_line('varr.Extend sonras�');
    Yaz;
    
    varr.Extend(2); -- dizinin sonuna 2 tane ekler
    dbms_output.put_line('varr.Extend(2) sonras�');
    Yaz;

    varr.Extend(5,4); -- dizinin 4 hucresindeki 49 de�erini dizinin sonuna 5 tane ekler
    dbms_output.put_line('varr.Extend(5,4) sonras�');
    Yaz;    

    varr.Trim; -- dizinin sonundaki hucreyi drop eder
    dbms_output.put_line('varr.Trim sonras�');
    Yaz;

   varr.Trim(2); -- dizinin sonundaki 2 hucreyi drop eder
    dbms_output.put_line('varr.Trim(2) sonras�');
    Yaz;
End;
/
-- Yukar�daki ornegimizi Nested Table ile yapal�m

Declare
    Type ndt_type IS TABLE OF Number;
    var1 ndt_type:= ndt_type(10,22,35,49,50,99);
    
    Procedure Yaz IS
    
    Begin
        dbms_output.put_line('var1.Count = ' || var1.Count);  -- Dizinin eleman say�s�n� verir
        dbms_output.put_line('var1.Limit = ' || var1.Limit);  -- Sadece VARRAY'lerde calisir, Burada bos gelir, Cunku limitsizdir, s�n�rs�zd�r
        dbms_output.put_line('var1.first = ' || var1.first);  -- Dizinin ilk eleman�n�n INDIS'ini verir
        dbms_output.put_line('var1.Last = ' || var1.Last);    -- Dizinin son eleman�n�n INDIS'ini  verir
    
    End Yaz;
Begin
    dbms_output.put_line('Orjinal Degerler');
    Yaz;
    
    var1.Extend; -- dizinin sonuna 1 tane ekler
    dbms_output.put_line('var1.Extend sonras�');
    Yaz;
    
    var1.Extend(2); -- dizinin sonuna 2 tane ekler
    dbms_output.put_line('var1.Extend(2) sonras�');
    Yaz;

    var1.Extend(5,4); -- dizinin 4 hucresindeki 49 de�erini dizinin sonuna 5 tane ekler
    dbms_output.put_line('var1.Extend(5,4) sonras�');
    Yaz;    

    var1.Trim; -- dizinin sonundaki hucreyi drop eder
    dbms_output.put_line('var1.Trim sonras�');
    Yaz;

   var1.Trim(2); -- dizinin sonundaki 2 hucreyi drop eder
    dbms_output.put_line('var1.Trim(2) sonras�');
    Yaz;
End;
/
-- Yukar�daki ornegimizi Associative Array Index By Table ile yapal�m

Declare
    Type Assc_type IS TABLE OF Number INDEX BY Pls_Integer; -- Sadece Integer yazarsak Associative'de hata verir
    -- var_assc Assc_type:= Assc_type(10,22,35,49,50,99); -- Associative Array Index By Table'larda Kurucu Method olmaz
                                                          -- Sadece Nested Table ve Varray'lerde kurucu method olur
    var_assc Assc_type;
    Procedure Yaz IS
    
    Begin
        dbms_output.put_line('var_assc.Count = ' || var_assc.Count);  -- Dizinin eleman say�s�n� verir
        dbms_output.put_line('var_assc.Limit = ' || var_assc.Limit);  -- Sadece VARRAY'lerde calisir, Burada bos gelir, Cunku limitsizdir, s�n�rs�zd�r
        dbms_output.put_line('var_assc.first = ' || var_assc.first);  -- Dizinin ilk eleman�n�n INDIS'ini verir
        dbms_output.put_line('var_assc.Last = ' || var_assc.Last);    -- Dizinin son eleman�n�n INDIS'ini  verir
    
    End Yaz;
Begin
    var_assc(1):= 10;
    var_assc(2):= 19;
    var_assc(3):= 20;
    var_assc(4):= 30;
    var_assc(5):= 40;
    var_assc(6):= 49;
    
    dbms_output.put_line('Orjinal Degerler');
    Yaz;
    
    -- var1.Extend; var1.Extend(2); -- Associative Array'lerde calismaz, bunun yerine direk atama yapabiliriz
    var_assc(7):= 59;
    var_assc(8):= 60;
    var_assc(9):= 99;
    dbms_output.put_line('***** var_assc(7) sonras� *****');
    Yaz;
    
    -- var_assc.Trim; -- Associative Array'lerde calismaz, bunun yerine Delete kullan�r�z
    var_assc.Delete(3); -- Dizinin 3. hucresindeki i�eri�i siler
    dbms_output.put_line('***** var_assc.Delete(3) Sonras� *****');
    Yaz;
    
    var_assc.Delete(1); -- Dizinin ilk/first hucresindeki i�eri�i siler
                        -- first metodu bu durumda tan�ms�z olan 1.hucredeki verinin degil,
                        -- ilk dolu olan hucrenin indis degerini verir
    dbms_output.put_line('***** var_assc.Delete(1) Sonras� ***** first metoduna dikkat edelim');
    Yaz;    
End;

/

-- Assc icin trim calismaz ve delete, trim gorevi gorur.

-- Count, Limit, first, last Bunlar fonksiyon oldugu icin tek bas�na kullan�lmaz, inceleyelim
Declare
    Type Assc_type IS TABLE OF Number INDEX BY Pls_Integer; 
    var_assc Assc_type;
    Sayi Pls_Integer;
    
    Procedure Yaz IS
    
    Begin
        dbms_output.put_line('var_assc.Count = ' || var_assc.Count);  -- Dizinin eleman say�s�n� verir
        dbms_output.put_line('var_assc.Limit = ' || var_assc.Limit);  -- Sadece VARRAY'lerde calisir, Burada bos gelir, Cunku limitsizdir, s�n�rs�zd�r
        dbms_output.put_line('var_assc.first = ' || var_assc.first);  -- Dizinin ilk eleman�n�n INDIS'ini verir
        dbms_output.put_line('var_assc.Last = ' || var_assc.Last);    -- Dizinin son eleman�n�n INDIS'ini  verir    
    End Yaz;
Begin
    var_assc(1):= 10;
    var_assc(2):= 19;
    var_assc(3):= 20;
     
    dbms_output.put_line('Orjinal Degerler');
    Yaz;
    -- var_assc.Count; -- Count, Limit, first, last Bunlar fonksiyon oldugu icin tek bas�na bu sekilde kullan�lmaz
    -- bir degiskene atay�p kullanabiliriz, veya dbms_output.put_line(var_assc.Count); seklinde yazabiliriz
    Sayi:= var_assc.Count;    
    dbms_output.put_line(Sayi);
    dbms_output.put_line(var_assc.Count);


    -- ama var_assc.Delete bir procedure oldugu icin direk kullan�labilir
    var_assc.Delete(3);    
    Yaz;    
End;
/
-- Prior,   (Function ) Belirtilen dizinden �nceki dizini return eder
-- Next,    (Function ) Sonraki indeksi return eder

-- Ornegimizi VARRAY veri tipinde yapal�m
-- Bu islemler Associative Array ve Nested Table'larda kullan�labilir


Declare
    Type varr_type IS VARRAY(10) OF Number; 
    v_sayi varr_type:= varr_type();
Begin
    v_sayi.Extend(4); -- Diziyi 4 hucre olarak genislettik
    v_sayi(1):= 10;
    v_sayi(2):= 19;
    v_sayi(3):= 20;
    v_sayi(4):= 99;
     
    dbms_output.put_line('v_sayi.Prior(3) = ' || v_sayi.Prior(3));  -- 3.indis'ten onceki  indis degerini verir
    dbms_output.put_line('v_sayi.Next(3)  = ' || v_sayi.Next(3));   -- 3.indis'ten sonraki indis degerini verir
    
    dbms_output.put_line('v_sayi.Prior(6) = ' || v_sayi.Prior(6));  -- 6.indis'ten onceki  dolu olan son indis degerini verir
    dbms_output.put_line('v_sayi.Next(6)  = ' || v_sayi.Next(6));   -- 3.indis'ten sonraki indis degerini verir, olmad�g� icin bos gelir

    dbms_output.put_line('v_sayi.Prior(v_sayi.first) = ' || v_sayi.Prior(v_sayi.first));  -- ilk indis'ten onceki indis degerini verir,  olmad�g� icin bos gelir
    dbms_output.put_line('v_sayi.Next(v_sayi.Last)   = ' || v_sayi.Next (v_sayi.Last));   -- son indis'ten sonraki indis degerini verir, olmad�g� icin bos gelir

End;
/
-- Bu islemleri Nested Table ile yapal�m

Declare
    Type ndt_type IS TABLE OF Number; 
    v_sayi ndt_type:= ndt_type();
Begin
    v_sayi.Extend(4); -- Diziyi 4 hucre olarak genislettik
    v_sayi(1):= 10;
    v_sayi(2):= 19;
    v_sayi(3):= 20;
    v_sayi(4):= 99;
     
    dbms_output.put_line('v_sayi.Prior(3) = ' || v_sayi.Prior(3));  -- 3.indis'ten onceki  indis degerini verir
    dbms_output.put_line('v_sayi.Next(3)  = ' || v_sayi.Next(3));   -- 3.indis'ten sonraki indis degerini verir
    
    dbms_output.put_line('v_sayi.Prior(6) = ' || v_sayi.Prior(6));  -- 6.indis'ten onceki  dolu olan son indis degerini verir
    dbms_output.put_line('v_sayi.Next(6)  = ' || v_sayi.Next(6));   -- 3.indis'ten sonraki indis degerini verir, olmad�g� icin bos gelir

    dbms_output.put_line('v_sayi.Prior(v_sayi.first) = ' || v_sayi.Prior(v_sayi.first));  -- ilk indis'ten onceki indis degerini verir,  olmad�g� icin bos gelir
    dbms_output.put_line('v_sayi.Next(v_sayi.Last)   = ' || v_sayi.Next (v_sayi.Last));   -- son indis'ten sonraki indis degerini verir, olmad�g� icin bos gelir

End;
/
-- Bu islemleri Associative Array ile yapal�m

Declare
    Type assc_type IS TABLE OF Number INDEX BY Pls_Integer; 
    --v_sayi assc_type:= assc_type(); -- Associative Array'larda kurucu atama olmaz
    v_sayi assc_type;
Begin
    -- v_sayi.Extend(4); -- Diziyi 4 hucre olarak genisletme islemi Associative Array'larda olmaz
    v_sayi(1):= 10;
    v_sayi(2):= 19;
    v_sayi(3):= 20;
    v_sayi(4):= 99;
     
    dbms_output.put_line('v_sayi.Prior(3) = ' || v_sayi.Prior(3));  -- 3.indis'ten onceki  indis degerini verir
    dbms_output.put_line('v_sayi.Next(3)  = ' || v_sayi.Next(3));   -- 3.indis'ten sonraki indis degerini verir
    
    dbms_output.put_line('v_sayi.Prior(6) = ' || v_sayi.Prior(6));  -- 6.indis'ten onceki  dolu olan son indis degerini verir
    dbms_output.put_line('v_sayi.Next(6)  = ' || v_sayi.Next(6));   -- 3.indis'ten sonraki indis degerini verir, olmad�g� icin bos gelir

    dbms_output.put_line('v_sayi.Prior(v_sayi.first) = ' || v_sayi.Prior(v_sayi.first));  -- ilk indis'ten onceki indis degerini verir,  olmad�g� icin bos gelir
    dbms_output.put_line('v_sayi.Next(v_sayi.Last)   = ' || v_sayi.Next (v_sayi.Last));   -- son indis'ten sonraki indis degerini verir, olmad�g� icin bos gelir
End;
/


--*********************************************************************************************
-- Composite Data Types
--*********************************************************************************************

/*
-- Composite Data Types
-- 2 Turludur
  -- A) Collection Data Types --(Bunlar� inceledik)
  -- B) Record Data Types     --(Bunlar� inceleyelim)

  -- B) Record Data Types
      -- 1) Table-Bases Records               -- %ROWTYPE ismi verilmektedir
      -- 2) Cursor-Bases Records              -- %ROWTYPE ismi verilmektedir
      -- 3) Developer-Define Records

      --*** Yukar�daki B)===> 1) ve 2) -- %ROWTYPE ismi verilmektedir

-- Simdi Bunlar� inceleyelim
*/

--*********************************************************************************************
-- B) Record Data Types(Kay�t Veri Turleri)
    -- 1) Table-Bases Records(Referans Veri Tipleri)      -- %ROWTYPE ismi verilmektedir
--*********************************************************************************************
/*
  Table-Bases Records - SYNTAX
  Declare
        ...
        <degisken_ismi>   <table_name>%rowtype;
        ...
  Begin
  
  End;
  
*/
-- Ornek; En yuksek maas alan kisinin ismini, soy ismini ve maa��n� yazd�ral�m
/
Declare
      calisanlar employees%rowtype;
Begin
    Select * INTO calisanlar
    From Employees
    Where Salary = (Select Max(Salary) From Employees);
    
    dbms_output.put_line('First Name : ' || calisanlar.First_Name);
    dbms_output.put_line('Last Name  : ' || calisanlar.Last_Name);
    dbms_output.put_line('Salary     : ' || calisanlar.Salary);
End;
/

--*********************************************************************************************
-- B) Record Data Types
      -- 2) Cursor-Bases Records              -- %ROWTYPE ismi verilmektedir
--*********************************************************************************************

/*
  Cursor-Bases Records - SYNTAX
  
Declare
    CURSOR <cursor_ismi> IS SELECT ....;
    <degisken_ismi>   <cursor_ismi>%rowtype;
Begin
    ...
End;

*/

-- Ornek; Ortalama maa�tan daha d���k maa� alanlar� listeleyelim

Declare
    CURSOR c_oku IS SELECT employee_id, first_name, last_name, Salary
                    From Employees
                    Where Salary <(Select AVG(Salary) From Employees);
    calisanlar c_oku%rowtype;                    
Begin
    Select AVG(Salary)
        INTO calisanlar.Salary
    From Employees; -- ortalama maas� calisanlar.Salary degiskeni icerisine att�k
    dbms_output.put_line('*** ORTALAMA MAA� : ***' || calisanlar.Salary);
    Open c_oku;
      Loop
        fetch c_oku into calisanlar;
        Exit When c_oku%NotFound;
        dbms_output.put_line(' Employee_id : ' || calisanlar.employee_id || 
                             ', First Name  : ' || calisanlar.first_name ||
                             ', Last Name   : ' || calisanlar.last_name || 
                             ', Salary      : ' || calisanlar.Salary);
      
      End Loop;    
    Close c_oku;
End;
/
-- Yukar�daki Ornekte dbms_output.put_line yerine
-- dbms_output.put kullan�rsak yeni sat�ra gecmez ayn� sat�rda kal�r
-- Yeni sat�ra gecmesi icin dbms_output.new_line yazabiliriz

Declare
    CURSOR c_oku IS SELECT employee_id, first_name, last_name, Salary
                    From Employees
                    Where Salary <(Select AVG(Salary) From Employees);
    calisanlar c_oku%rowtype;                    
Begin
    Select AVG(Salary) INTO calisanlar.Salary From Employees; -- ortalama maas� calisanlar.Salary degiskeni icerisine att�k
    dbms_output.put_line('*** ORTALAMA MAA� : ***' || calisanlar.Salary);
    Open c_oku;
      Loop
        fetch c_oku into calisanlar;
        Exit When c_oku%NotFound;
        dbms_output.put(' Employee_id : ' || calisanlar.employee_id || 
                             ', First Name  : ' || calisanlar.first_name ||
                             ', Last Name   : ' || calisanlar.last_name || 
                             ', Salary      : ' || calisanlar.Salary);
        dbms_output.new_line;
      End Loop;    
    Close c_oku;
End;
/
-- veya su sekilde yazal�m

Declare
    CURSOR c_oku IS SELECT employee_id, first_name, last_name, Salary
                    From Employees
                    Where Salary <(Select AVG(Salary) From Employees);
    calisanlar c_oku%rowtype;                    

Begin
    Select AVG(Salary) INTO calisanlar.Salary From Employees; -- ortalama maas� calisanlar.Salary degiskeni icerisine att�k
    dbms_output.put_line('*** ORTALAMA MAA� : ***' || calisanlar.Salary);

    Open c_oku;
      Loop
        fetch c_oku into calisanlar;
        Exit When c_oku%NotFound;

        dbms_output.put(' Employee_id : ' || calisanlar.employee_id);
        dbms_output.put(',First Name  : ' || calisanlar.first_name);
        dbms_output.put(',Last Name   : ' || calisanlar.last_name);
        dbms_output.put(',Salary      : ' || calisanlar.Salary);
        dbms_output.new_line;

      End Loop;    
    Close c_oku;
End;
/
--*********************************************************************************************
-- B) Record Data Types
      -- 3) Developer-Define Records(User-Define Records olarakta bilinir)
      --(Uygulama Gelistirici Taraf�ndan Gelistirilen Kay�tlard�r)

/*
  Developer-Define Records - SYNTAX

Declare
      TYPE <type_name> IS RECORD
      (
          field_name1 datatype1 [NOT NULL][:= DEFAULT EXPRESSION],
          field_name2 datatype2 [NOT NULL][:= DEFAULT EXPRESSION],
          ...
          field_nameN datatypeN [NOT NULL][:= DEFAULT EXPRESSION]
      );
      
      variable_name TYPE_NAME;
Begin
      ...
End;
*/

-- Ornek; Sistem zaman bilgilerini konsola yazd�ran bir program yazal�m
-- Bilgiler developer-defined records veri tipinde tutulacakt�r

Declare
      TYPE r_zaman_type IS RECORD
                                  (
                                      curr_date Date,
                                      curr_day  VarChar2(12),
                                      curr_time VarChar2(8):= '00:00:00'
                                  );
      
      v_zaman r_zaman_type;
Begin
    Select sysdate INTO v_zaman.curr_date From Dual;
    
    v_zaman.curr_day  := To_Char(v_zaman.curr_date,'DAY');
    v_zaman.curr_time := To_Char(v_zaman.curr_date,'HH24:MI:SS');
    
    dbms_output.put_line('Tarih : ' || To_Char(v_zaman.curr_date,'DD/MM/YYYY'));
    dbms_output.put_line('G�n   : ' || v_zaman.curr_day);
    dbms_output.put_line('Zaman : ' || v_zaman.curr_time);
End;
/
