-- EXCEPTION HANDLER --

-- Hata Turleri
--      1- Compile Error (Derleme Esnasinda)
--      2- Runtime Error (Calisma Esnasinda)

-- Exception Handler Section ile calisma yapacagiz. Bu yüzden Runtime Error ile ilgilenecegiz.
-- Bir fonksiyon tanimlayarak baslayalim.
Create or replace Function fnc_divide(A in Number, B in Number)
Return Number
is
C Number;
Begin
    C := A/B;
    Return(C);
End;

/

-- Normal bir sekilde fonksiyonu cagiralim.
Select fnc_divide(10, 2) From Dual;

/

-- Anonymous Block ile fonksiyonu cagiralim.
Declare
    D Number;
Begin
    D := fnc_divide(10, 2);
    dbms_output.put_line(D);
End;

/

-- 10 ve 0 degerleri icin fonksiyon hata verecektir.
-- Hata adi: divisor is equal to zero.
Select fnc_divide(10, 0) From Dual;

-- Ayni parametreler ile anonymous block kullanarak fonksiyonu cagiralim.
Declare
    D Number;
Begin
    D := fnc_divide(10, 0);
    dbms_output.put_line(D);
End;

/

-- Hatayi gormek icin Exception kullanalim.
Declare
    D Number;
Begin
    D := fnc_divide(10, 0);
    dbms_output.put_line(D);
    Exception When Zero_Divide Then
        dbms_output.put_line('0 ile bolme yapilamaz.');
        dbms_output.put_line('Hata mesaji: ' || SQLERRM);
End;

/

-- ORNEK: Parametre olarak department_id alan ve bu id'ye gore department_name'i donen fonksiyonu yaziniz.
Create or replace Function fnc_getDepartmentName(p_departmentId in Number)
Return Varchar2
is
DepartmentName Varchar2(30);
Begin
    Select 
        department_name
    Into DepartmentName
    From hr.departments
    Where department_id = p_departmentId;
                          
    Return(DepartmentName);
End;

/

-- Fonksiyonu normal bir sekilde cagiralim.
Select fnc_getDepartmentName(100) From Dual;

/

-- Fonksiyonu anonymous block ile cagiralim.
Declare
    DepartmentName Varchar2(30);
Begin
    DepartmentName := fnc_getDepartmentName(100);
    dbms_output.put_line(DepartmentName);
End;

/

-- Bu ornekte tabloda olmayan bir id degerinin girilmesine karsin hata kontrolu yapmamiz gerekmekte.
-- Hata kontrollerini function icerisinde de yapabiliriz.
Create or replace Function fnc_getDepartmentNameWithException(P_departmentId Number)
Return Varchar2
is
DepartmentName Varchar2(30);
Begin
    Select
        department_name
    Into DepartmentName
    From hr.departments
    Where department_id = P_departmentId;
    
    Return(DepartmentName);
    Exception When No_Data_Found Then
        Return(p_departmentId || ' no''lu bolum bulunamadi.');
End;

/

-- Normal bir sekilde fonksiyonu cagiralim.
Select fnc_getdepartmentnamewithexception(1) From Dual;

/

-- Anonymous block ile fonksiyonu cagiralim.
Declare
    Result Varchar2(30);
Begin
    Result := fnc_getdepartmentnamewithexception(1);
    dbms_output.put_line(Result);
End;