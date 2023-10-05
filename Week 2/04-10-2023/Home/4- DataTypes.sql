-- PL/SQL DATA TYPES --
-- 1) Scalar Data Types: Char, Varchar2, Number, Boolean, PLS_INTEGER, Binary_INTEGER, ..
-- 2) Large Object Data Types: BLOB, CLOB, LONG
-- 3) Reference Data Types: %TYPE, %ROWTYPE
-- 4) Composite (Collections): User-defined veri tipleridir, diger veri tiplerinden faydalanarak yeni veri tipleri yada veri tipi koleksiyonu olusturabiliriz.

----------------------------
-- 1) SCALAR DATA TYPES --
----------------------------
-- Char, Varchar2
Declare
    Adi Char(15);
    Soyadi Varchar2(15);
Begin
    Adi := 'Ali';
    Soyadi := 'Topacik';

    dbms_output.put_line(adi);
    dbms_output.put_line(soyadi);
    dbms_output.put_line(adi || soyadi);
    
    dbms_output.put_line(adi || '*');
    dbms_output.put_line(soyadi || '#');
    
    dbms_output.put_line(adi || ' uzunluk: ' || Length(adi));
    dbms_output.put_line(soyadi || ' uzunluk: ' || Length(soyadi));
End;

/

-- Pls_Integer, Overflow (Asiri Yukleme)
-- PlsInteger Max alabilecegi deger 2147483647
Declare
    p1 PLS_INTEGER := 120;
    p2 PLS_INTEGER := 99;
    
    n1 NUMBER;
Begin
    n1 := p1 + p2;
    
    dbms_output.put_line(n1);
    dbms_output.put_line(To_Char(n1, '999,999,999,999.99'));
End;

/

-- Toplama islemi yaparken toplamayi once p1 ve p2 arasinda yapar. Bunlardan hangisi uygunsa onun uzerine ekler ve sonra n'ye atama yapar.

-- Overflow
Declare
    p1 PLS_INTEGER;
    p2 PLS_INTEGER;
    
    n1 NUMBER;
Begin
    p1 := 2147483647;
    p2 := 1;
    n1 := p1 + p2;
    
    dbms_output.put_line(n1);
    dbms_output.put_line(To_Char(n1, '999,999,999,999.99'));
End;

/

-- Yukaridaki ornekte p1 alabilecegi max degere sahip p2 ile toplaninca overflow meydana geliyor.

-- Simdi p2 degiskenini number yapalim, number pls_integer'dan daha buyuk oldugu icin overflow olmadan sonucu gorebilicez.
Declare
    p1 PLS_INTEGER;
    p2 NUMBER;
    
    n1 NUMBER;
Begin
    p1 := 2147483647;
    p2 := 1;
    
    n1 := p1 + p2;
    
    dbms_output.put_line(n1);
    dbms_output.put_line(To_Char(n1, '999,999,999,999.99'));
End;

/

-- Binary_Integer: 2147483647
-- Binary_Integer, Pls_Integer'e gore daha guclu bir yapiya sahiptir. Toplama islemini gene kendi icinde uygun olan sekilde yapar.

Declare
    p1 BINARY_INTEGER;
    p2 BINARY_INTEGER;
    
    n1 NUMBER;
Begin
    p1 := 2147483646;
    p2 := 1;
    
    n1 := p1 + p2;
    
    dbms_output.put_line(n1);
    dbms_output.put_line(To_Char(n1,'999,999,999,999.99'));
End;

/

-- Binary_Integer'de Overflow
Declare
    p1 BINARY_INTEGER;
    p2 BINARY_INTEGER;
    
    n1 NUMBER;
Begin
    p1 := 2147483647;
    p2 := 1;
    
    n1 := p1 + p2;
    
    dbms_output.put_line(n1);
    dbms_output.put_line(To_Char(n1,'999,999,999,999.99'));
End;

/

-- Eger p2'yi Number yaparsak overflow duzelir.
Declare
    p1 BINARY_INTEGER;
    p2 NUMBER;
    
    n1 NUMBER;
Begin
    p1 := 2147483647;
    p2 := 1;
    
    n1 := p1 + p2;
    
    dbms_output.put_line(n1);
    dbms_output.put_line(To_Char(n1,'999,999,999,999.99'));
End;

/

-----------------------------
-- 3) REFERENCE DATA TYPES --
-----------------------------
-- %TYPE: Referans alinan tablonun kolonuyla dinamik olarak ayni olmasini saglar.
-- %ROWTYPE: Referans alinan tablo veya view ile dinamik olarak ayni olmasini saglar.
-- Her iki sorguda da tek satir vermesi gerekir.

-- %TYPE
Declare
    departmentId NUMBER(4);
    departmentName VARCHAR2(30);
    managerId NUMBER(6);
    locationId NUMBER(4);
Begin
    Select *
    Into 
        departmentId, 
        departmentName, 
        managerId, 
        locationId
    From hr.departments
    Where department_id = 10;
    
    dbms_output.put_line(departmentId || ' ' || departmentName || ' ' || managerId || ' ' || locationId);
End;

/

-- Yukaridaki kod blogu calisacaktir ancak departments tablosundaki herhangi bir kolonun veritipi veya uzunlugu degistiginde hata meydana gelir. Bu tur hatalari onlemek icin %TYPE kullanabiliriz.

-- ORNEK: Departments tablosundan Department_id'si 10 olan kayitlari listeleyelim.
Declare
    departmentId hr.departments.department_id%TYPE;
    departmentName hr.departments.department_name%TYPE;
    managerId hr.departments.manager_id%TYPE;
    locationId hr.departments.location_id%TYPE;
Begin
    Select *
    Into
        departmentId,
        departmentName,
        managerId,
        locationId
    From hr.departments
    Where department_id = 10;
    
    dbms_output.put_line(departmentId || ' ' || departmentName || ' ' || managerId || ' ' || locationId);
End;

/

-- %ROWTYPE
Declare
    r_dept hr.departments%ROWTYPE;
Begin
    Select *
    Into r_dept
    From hr.Departments
    Where department_id = 10;
    
    dbms_output.put_line(r_dept.department_id || ' ' || r_dept.department_name || ' ' || r_dept.manager_id || ' ' || r_dept.location_id);
End;

/

/*
    department_id   Number(4);                        -- Klasik Yontemi
    department_id   departments.department_id%TYPE    -- %TYPE Yontemi
    r_dept          departments%ROWTYPE               -- %ROWTYPE Yontemi
    
    Klasik Yontem > %TYPE
    %TYPE > %ROWTYPE
    
    Klasik yontem, %type ve %rowtype yontemlerine gore daha performanslidir.
    %type yontemi %rowtype yontemine gore daha iyidir.
    Sebebi ise referans alinan tabloda yeni bir kolon eklendiginde %rowtype tum kolonlari dondurdugunden bu durum hataya sebep olabilir.
*/

/

-------------------------------
-- 4) COMPOSITE(COLLECTIONS) --
-------------------------------
-- Developer-defined veya user-defined veri tipleri olarak bilinir. Record Type ile ilgilenecegiz.

-- Asagidaki sorguda 'not enough values' hatasi aliriz. Cunku * ile 4 kolon geliyor biz ise 3 kolon yazdik. 
Declare
    Type t_dept is Record(
        dept_id Number(4),
        dept_name hr.departments.department_name%TYPE,
        manager_id hr.departments.manager_id%TYPE not null Default 0 -- Constraint eklenebilir.
    );
    
    r_dept2 t_dept;
Begin
    Select *
    Into r_dept2
    From hr.departments
    Where department_id = 10;
    
    dbms_output.put_line(r_dept2.dept_id || ' ' ||
                        r_dept2.dept_name || ' ' ||
                        r_dept2.manager_id);
End;

/

-- Bunun icin sutun adlarini teker teker yazmamiz gerekir. Select * yerine sutun adlarini belirtmek  birinci tercihimiz olmalidir.

Declare
    Type t_dept is Record(
        dept_id Number(4),
        dept_name hr.departments.department_name%TYPE,
        manager_id hr.departments.manager_id%TYPE not null Default 0 -- Constraint eklenebilir.
    );
    
    r_dept2 t_dept;
Begin
    Select 
        department_id,
        department_name,
        manager_id
    Into r_dept2
    From hr.departments
    Where department_id = 10;
    
    dbms_output.put_line(r_dept2.dept_id || ' ' ||
                        r_dept2.dept_name || ' ' ||
                        r_dept2.manager_id);
End;

/