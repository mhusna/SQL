-- Select ile birlikte if komutlari kullanmak cok mantikli degil, exception varsa direk devreye girer.

-- Update ve delete'de exception'a girmez, if-else varsa oraya girer fakat select icin bu gecerli degil.

-- CURSORS --
-- Implicit Cursors(System-Defined Cursors)   -- Sistem taraf�ndan tan�mlananlar
-- Explicit Cursors(Developer-Defined Cursors)-- Kullan�c� taraf�ndan tan�mlananlar

--*********************************************************************************************
-- Implicit Cursors(System-Defined Cursors)   -- Sistem tarafindan tanimlananlar.
-- Sistem tarafindan hazir olan Cursor'lardir.
-- SQL%FOUND, SQL%NOTFOUND, SQL%ROWCOUNT
--*********************************************************************************************

-- Update ve Delete islemi yapacagiz ama once
-- DML komutlar�ndan Select isleminde nas�l etki gosteriyor, inceleyelim
-- Gecici bir Tablo olusturalim.

Drop Table Employees2;

/

Create Table Employees2 as
Select * From Employees;

/

Declare
    rec_emp Employees%ROWTYPE;
Begin
    Select *
    Into rec_emp
    From employees2
    Where employee_id = 100;
    
    if sql%found then
        dbms_output.put_line('A - Kayit var. Kayit sayisi: ' || sql%rowcount);
    else
        dbms_output.put_line('A - Kayit yok.');
    end if;
    
    if sql%notfound then
        dbms_output.put_line('B - Kayit yok.');
    else
        dbms_output.put_line('B - Kayit var. Kayit sayisi: ' || sql%rowcount);
    end if;
    
    Exception When NO_DATA_FOUND Then
        dbms_output.put_line('Exception - Kayit yok.');
End;

/

-- Kayit yoksa direk exception'a girer.

Declare
    rec_emp Employees%ROWTYPE;
Begin
    Select *
    Into rec_emp
    From employees2
    Where employee_id = 1000;
    
    if sql%found then
        dbms_output.put_line('A - Kayit var. Kayit sayisi: ' || sql%rowcount);
    else
        dbms_output.put_line('A - Kayit yok.');
    end if;
    
    if sql%notfound then
        dbms_output.put_line('B - Kayit yok.');
    else
        dbms_output.put_line('B - Kayit var. Kayit sayisi: ' || sql%rowcount);
    end if;
    
    Exception When NO_DATA_FOUND Then
        dbms_output.put_line('Exception - Kayit yok.');
End;

/

-- Yukar�daki sorguda Exception Select isleminden sonra tetiklenir
-- hata var ise Exception devreye girer ve hatay� gosterir.
-- implicit Cursor'lar� Select ifadelerinde kullanmak cok mant�kl� degildir
-- Cunku Select ifadesinden sonra Exception(=>no_data_found exception'�); 
-- SQL%FOUND, SQL%NOTFOUND'tan once tetiklenir

-- Simdi de, DML komutlar�ndan Update ve Delete islemi yapacagiz

-- implicit Cursorlardan SQL%FOUND, SQL%NOTFOUND nadiren kullan�l�r ama
-- SQL%ROWCOUNT cursor'� cok kullan�l�r(if'lerde ve Case'lerde kullan�l�r)

Declare
    rec_emp employees2%rowtype;
Begin
      Update Employees2
      Set Salary = Salary * 1.20
      Where Department_id = 50;
      -- Where Department_id = 500; -- Bununlada deneyelim
      
      if sql%found then
         dbms_output.put_line(sql%rowcount || ' Kay�t Update edildi A');
      else
         dbms_output.put_line('Update edilecek Kay�t Yok A');
      end if;
      
      if sql%notfound then
          dbms_output.put_line('Update edilecek Kay�t Yok B');
      else
          dbms_output.put_line(sql%rowcount || ' Kay�t Update edildi B');
      end if;      

      Delete From Employees2      
      Where Department_id = 100;
      
end;

/

-- Yukar�daki sorguyu Delete ile inceleyelim
Declare
    rec_emp employees2%rowtype;
Begin
      Delete From Employees2      
      Where Department_id = 60;
      -- Where Department_id = 1000; -- Bununlada deneyelim
      if sql%found then
         dbms_output.put_line(sql%rowcount || ' Kay�t Delete edildi A');
      else
         dbms_output.put_line('Delete edilecek Kay�t Yok A');
      end if;
      
      if sql%notfound then
          dbms_output.put_line('Delete edilecek Kay�t Yok B');
      else
          dbms_output.put_line(sql%rowcount || ' Kay�t Delete edildi B');
      end if;      

end;

-- rollback;
/

-- Tanimlanan cursor acilmali, acilan cursor da kapatilmali. Yoksa arkada hafiza yer.

-- Loop icerisinde fetch kullandigimiz icin herbir satiri tek tek okuyor.

Declare
    Cursor c_emp1 is
        Select employee_id, first_name, last_name From employees;
        
    emp_id Employees.employee_id%TYPE;
    f_name Employees.first_name%TYPE;
    l_name Employees.last_name%TYPE;
Begin
    Open c_emp1;
        Loop 
            Fetch c_emp1 into emp_id, f_name, l_name;
            Exit When c_emp1%notfound;
                dbms_output.put_line('ID: ' || emp_id ||
                                     ' - F.Name: ' || f_name ||
                                     ' - L.Name: ' || l_name);
        End Loop;
    Close c_emp1;
End;

/

-- Yukar�daki en basit haliyle kulland�k
-- Cursor icerisine istedigimiz Select islemini aktarabiliriz
-- Where olabilir, Join olabilir v.s.
-- Ornek

/

Declare
      Cursor c_empl is Select
                              Rpad(Job_id,10,' ') Job_id,
                              Sum(Salary) TotalSalary
                        From Employees
                        Group By Job_id
                        Order By 2 Desc;

      wJob_id       Varchar2(10);
      wTotalSalary  Employees.Salary%type;
Begin
    Open c_empl;  -- Cursor aciyoruz
        Loop
            Fetch c_empl into wJob_id, wTotalSalary;
            Exit When c_empl%notfound;
            
            dbms_output.put_line(' Job_id : '      || wJob_id     || -- ' || ' ||
                                 ' TotalSalary : ' || wTotalSalary
                                );
        End Loop;
    Close c_empl; -- islem sonunda Cursor kapat�yoruz
End;

/

-- ORNEK

Declare
    Cursor c_reg is
        Select region_id, region_name From Regions;
        
    r_id Regions.Region_id%TYPE;
    r_name Regions.Region_name%TYPE;
Begin
    Open c_reg;
        Loop
            Fetch c_reg into r_id, r_name;
            Exit When c_reg%NotFound;
            
            dbms_output.put_line('Region ID: ' || r_id ||
                                 ' Region Name: ' || r_name);
        End Loop;
    Close c_reg;
End;

/

-- ######################################################################
-- ######################################################################
-- ######################################################################

-- Yukaridaki sorguya sira numarasi ekleyelim.
-- Sira numarasi eklemek icin hazir cursor'lardan %rowcount'u kullanalim.
-- rowcount ilk basta 1'dir, her okumada bir artar.

Declare
    Cursor c_reg is
        Select region_id, region_name From Regions;
        
    r_id Regions.Region_id%TYPE;
    r_name Regions.Region_name%TYPE;
Begin
    Open c_reg;
        Loop
            Fetch c_reg into r_id, r_name;
            Exit When c_reg%NotFound;
            
            dbms_output.put_line('Sira No: ' || c_reg%rowcount ||
                                 ' Region ID: ' || r_id ||
                                 ' Region Name: ' || r_name);
        End Loop;
    Close c_reg;
End;

/

-- Ornek

Declare
      Cursor c_empl is Select
                              Rpad(Job_id,10,' ') Job_id,
                              Sum(Salary) TotalSalary
                        From Employees
                        Group By Job_id
                        Order By 2 Desc;

      wJob_id       Varchar2(10);
      wTotalSalary  Employees.Salary%type;
Begin
    Open c_empl;  -- Cursor aciyoruz
        Loop
            Fetch c_empl into wJob_id, wTotalSalary;
            Exit When c_empl%notfound;
            
            dbms_output.put_line(' Sira No : '     || c_empl%rowcount ||
                                 ' Job_id : '      || wJob_id         || -- ' || ' ||
                                 ' TotalSalary : ' || wTotalSalary
                                );
        End Loop;
    Close c_empl; -- islem sonunda Cursor kapat�yoruz
End;
/

--*********************************************************************************************
-- Explicit Cursors(Developer-Defined Cursors)-- Kullan�c� taraf�ndan tan�mlananlar
    -- Explicit Cursors Attributes
    -- Developer-Defined Cursors Durum Bilgileri
    --   
--*********************************************************************************************
/*

Explicit Cursorlar�n DURUM bilgilerini veren ozellik imlecleri 4 adettir
  %ISOPEN   Boolean tipindedir, Cursor aciksa degeri TRUE degilse FALSE
  %NOTFOUND Boolean tipindedir, FETCH edilecek kay�t kalmad�ysa degeri TRUE degilse FALSE
  %FOUND    Boolean tipindedir, FETCH edilecek kay�t varsa      degeri TRUE degilse FALSE
  %ROWCOUNT Number  tipindedir, FETCH edilen kay�t say�s�n� verir
  
*/

--*********************************************************************************************
-- Cursors Durum Bilgileri %ISOPEN, %NOTFOUND, %FOUND, %ROWCOUNT
--*********************************************************************************************

-- %ISOPEN: Cursor acik kal�rsa memory �i�er ve performans kayb� meydana gelir
-- o nedenle kontrollu bir sekilde acip kapatalim

Declare
    Cursor c_reg is 
        Select Region_id, Region_Name From Regions;
   
    wRegion_id    Regions.Region_id%type;
    wRegion_Name  Regions.Region_Name%type;
Begin
    IF Not c_reg%ISOPEN Then
        Open c_reg;
    End IF;
 
    Loop
        Fetch c_reg into wRegion_id, wRegion_Name;
        -- Exit When c_reg%NotFound; -- veya Exit When Not c_reg%Found;
        -- Yukar�daki her iki yaz�m da ayn� sonucu verir
              
        Exit When c_reg%NotFound or c_reg%rowcount > 3;
        -- Yukar�daki ise kay�t kalmad�g�nda veya
        -- kay�t say�s� 3'un uzerine c�kt�g�nda Loop'tan c�kar
              
        dbms_output.put_line(' Sira No : '      || c_reg%rowcount  ||
                             ' Region ID : '    || wRegion_id      ||
                             ' Region Name : '  || wRegion_Name
                            );    
    End Loop;  
    
    IF c_reg%ISOPEN Then
        Close c_reg;
    End IF;
End;

/

Declare
    Cursor c_reg is Select Region_id, Region_Name From Regions;
    wRegion_id    Regions.Region_id%type;
    wRegion_Name  Regions.Region_Name%type;
Begin
  if Not c_reg%ISOPEN Then
    Open c_reg;
  End if;
 
      Loop
              Fetch c_reg into wRegion_id, wRegion_Name;
             
              -- Exit When Not c_reg%Found or c_reg%rowcount > 3;
              
              if Not c_reg%Found or c_reg%rowcount > 3 Then
                dbms_output.put_line('*************************************');
                dbms_output.put_line('Not c_reg%Found or c_reg%rowcount > 3');
                dbms_output.put_line('Yukar�daki 2 kosuldan birisi gerceklesti!');
                Exit;
              end if;
              
              dbms_output.put_line(' Sira No : '      || c_reg%rowcount  ||
                                   ' Region ID : '    || wRegion_id      ||
                                   ' Region Name : '  || wRegion_Name
                                  );    
      End Loop;  
  if c_reg%ISOPEN Then
    Close c_reg;
  End if;
End;

/

--*********************************************************************************************
-- Cursors and Records(Reference Data Type %ROWTYPE)
--*********************************************************************************************

-- Yukar�daki sorguda Select icerisinde cok fazla sutun olabilir
-- Bu durumda her biri icin ayr� ayr� degisken tan�mlamak yerine
-- %ROWTYPE ile tek seferde tan�mlamak daha dogru olur

Declare
    Cursor c_reg is
        Select region_id, region_name 
        From Regions 
        Order By region_id;
    
    r_oku c_reg%ROWTYPE; -- Daha once tablo tan�mlad�g�m�z gibi Cursorden gelen
                          -- Sutun bilgilerini tek seferde tan�mlayabiliriz
Begin
    IF Not c_reg%isopen Then
        Open c_reg;
    End IF;
    
    Loop
        Fetch c_reg into r_oku;
        Exit When Not c_reg%found;
        
        dbms_output.put_line(' Sira No : '      || c_reg%rowcount  ||
                             ' Region ID : '    || r_oku.Region_id      ||
                             ' Region Name : '  || r_oku.Region_Name
                             ); 
    End Loop;
    
    IF c_reg%isopen Then
        Close c_reg;
    End IF;
End;

/

-- Cursor Ornek A1 Yontem 1;
-- simdi yukar�daki sorguda Select icerisinde * ile verileri getirelim
-- Bu durumda tum sutunlar gelecektir

Declare
    Cursor c_reg is Select * From Regions Order By Region_id;
    -- Bu durumda tum sutunlar gelir
    r_oku c_reg%ROWTYPE;  -- Daha once tablo tan�mlad�g�m�z gibi Cursorden gelen
                          -- Sutun bilgilerini tek seferde tan�mlayabiliriz
Begin
  if Not c_reg%ISOPEN Then
    Open c_reg;
  End if;
 
      Loop
              Fetch c_reg into r_oku;
             
              Exit When Not c_reg%Found;
              
              dbms_output.put_line(' Sira No : '      || c_reg%rowcount  ||
                                   ' Region ID : '    || r_oku.Region_id      ||
                                   ' Region Name : '  || r_oku.Region_Name
                                  );    
      End Loop;  
  if c_reg%ISOPEN Then
    Close c_reg;
  End if;
End;

/
-- Cursor Ornek A1 Yontem 2;
--*********************************************************************************************
-- Cursor and FOR LOOP
--*********************************************************************************************
-- For Loop ile Az onceki ornegi yukar�daki yaz�ma gore biraz daha performansl� yazal�m
-- Cursor acmadan, herhangi bir degisken tan�mlamadan yapal�m
-- For Loop islemi otomatik olarak Cursor'u OPEN eder ve is bittiginde CLOSE eder

Declare
    Cursor c_reg is Select * From Regions Order By Region_id;
Begin
    For r_oku IN c_reg
    Loop
              dbms_output.put_line(' Sira No : '      || c_reg%rowcount  ||
                                   ' Region ID : '    || r_oku.Region_id      ||
                                   ' Region Name : '  || r_oku.Region_Name
                                  );    
    End Loop;  
End;
/
-- Goruldugu gibi daha az kod ile ayn� islemi yapt�k
-- Cursor Ornek A1 Yontem 2 ile yap�lan Cursor Ornek A1 Yontem 1'e gore daha performansl�d�r

-- Cursor Ornek A1 Yontem 3_A

Declare
    
Begin
    For r_oku IN (Select * From Regions Order By Region_id)
    Loop
              dbms_output.put_line(--' Sira No : '      || r_oku%rowcount  ||
                                   ' Region ID : '    || r_oku.Region_id      ||
                                   ' Region Name : '  || r_oku.Region_Name
                                  );    
    End Loop;  
End;
/
-- Cursor Ornek A1 Yontem 3_B
-- Ancak goruldugu gibi s�ra numaras�n� bu sekilde yazd�ramad�k
-- O nedenle degisken ile cozelim
Declare
    i Number:=0;
Begin
    For r_oku IN (Select * From Regions Order By Region_id)
    Loop
              i:= i + 1;
              dbms_output.put_line(' Sira No : '      || i  ||
                                   ' Region ID : '    || r_oku.Region_id      ||
                                   ' Region Name : '  || r_oku.Region_Name
                                  );    
    End Loop;  
End;
/
-- Cursor Ornek A1 Yontem 3 ile yap�lan Yontem 2'ye gore Yontem 2 ise Yontem 1'e gore daha performansl�d�r
-- Cok fazla data'n�n oldugu islemlerde, Cursor Ornek A1 Yontem 3_A ve Yontem 3_B  daha performansl� olacakt�r

-- Yontem 1 ile Cursor icin Memoryde yer ayr�l�yor, sonra Open ediliyor
-- Fetch ile her bir dongude kay�t parse ediliyor is bittiginde de Close ediliyor

-- Yontem 2 de ise Sadece Cursor icin Memory'de yer ayr�l�yor, Cursor otomatik ac�l�p kapat�l�yor
-- Ayr�ca Open, Fetch, Close islemlerine gerek kalm�yor

-- Yontem 3 ise Sorguyu direk Buffer'a(Memory'e al�yor) ve sorgu calisiyor
-- Bu nedenle daha performansl�d�r

-- 3 yontemde ayn� sonucu verecektir

--*********************************************************************************************
-- Cursor - FOR UPDATE ve WHERE CURRENT OF Kullan�m�
--*********************************************************************************************
-- Ornek olarak; Maasi 5000'den az olanlara %20 zam yapal�m
-- Employee tablosunun kopyas�n� olustural�m

Drop Table Employees2;

Create Table Employees2 as
Select * From Employees;

/

-- For Update Yontem 1
Declare
    Cursor c_emp is
        Select * From Employees;
Begin
    For r_emp in c_emp
    Loop
        IF r_emp.Salary < 5000 Then
            Update Employees2
            Set Salary = Salary * 1.20
            Where employee_id = r_emp.employee_id;
        End IF;
    End Loop;
    
    Commit;
End;

/

-- Ancak yukaridaki ornekte
-- Biz islem yaparken baska kullanicilar, Transactionlar veya programlar taraf�ndan
-- kayit lock edilmis olabilir,
-- Bu nedenle islemi ne icin yaptigimizi belirtip Lock islemini gerceklestirmemiz lazim
-- Bu amacla FOR UPDATE kullanacagiz

Declare
    Cursor c_emp IS Select * From Employees2 FOR UPDATE;
    -- Ancak bu sekilde tum tabloyu kilitlemis oluruz
Begin
    For r_emp IN c_emp
    LOOP
        if r_emp.Salary < 5000 Then
            
            Update Employees2
            Set Salary = Salary * 1.20
            Where Employee_id = r_emp.Employee_id;
            
        End if;    
    END LOOP;
    Commit;
End;
/
-- Ancak yukar�daki FOR UPDATE ile tum tabloyu kilitlemis oluruz
-- Bunun yerine sadece islem yapacagimiz Salary sutununu kilitleyelim
-- For Update of Salary seklinde yazmam�z laz�m

Declare
    Cursor c_emp IS Select * From Employees2 FOR UPDATE Of Salary;
    -- For Update Of Salary dedigimizde sadece Salary kilitlenmis olacakt�r
Begin
    For r_emp IN c_emp
    LOOP
        if r_emp.Salary < 5000 Then
            
            Update Employees2
            Set Salary = Salary * 1.20
            Where Employee_id = r_emp.Employee_id;
            
        End if;    
    END LOOP;
    Commit;
End;
/

Select * From Employees2 Where Salary < 5000;

/

-- Cursor - FOR UPDATE ve WHERE CURRENT OF Kullan�m�
-- Yukar�daki ornekte
-- Where Employee_id = r_emp.Employee_id; yerine sunu yazabiliriz
-- Where CURRENT OF c_emp; yukaridaki sat�rla ayn� anlamdad�r
-- en son okunan kayd� guncelle demektir

Declare
    Cursor c_emp IS Select * From Employees2 FOR UPDATE Of Salary;
Begin
    For r_emp IN c_emp
    LOOP
        if r_emp.Salary < 5500 Then
            
            Update Employees2
            Set Salary = Salary * 1.20
            -- Where Employee_id = r_emp.Employee_id;
            Where CURRENT OF c_emp;
            -- yukaridaki sat�rla ayn� anlamdad�r
            -- en son okunan kayd� guncelle demektir
            dbms_output.put_line(r_emp.Employee_id || ' Update edildi');
        End if;    
    END LOOP;
    Commit;
End;

/

-- DELETE islemi icinde ayn� yontem yapacag�z
-- yani Select * From Employees2 FOR UPDATE; yazacagiz
-- Employee_id >= 204 olan kay�tlar� silelim
Declare
    Cursor c_emp IS Select * From Employees2 Where Employee_id >= 204 FOR UPDATE;
Begin
    For r_emp IN c_emp 
    LOOP
            dbms_output.put_line(r_emp.Employee_id || ' Delete edildi');
            Delete Employees2           
            -- Where Employee_id = r_emp.Employee_id;
            Where CURRENT OF c_emp;
            -- yukaridaki sat�rla ayn� anlamdad�r
            -- en son okunan kayd� guncelle demektir
    END LOOP;
    -- RollBack;
    Commit;
End;

/

Declare
    Cursor c_emp IS Select * From Employees2 Where Employee_id <= 110 FOR UPDATE;
Begin
    For r_emp IN c_emp
    LOOP
            dbms_output.put_line(r_emp.Employee_id || ' Delete edildi');
            Delete Employees2           
             Where Employee_id = r_emp.Employee_id;
            --Where CURRENT OF c_emp;
            -- yukaridaki sat�rla ayn� anlamdad�r
            -- en son okunan kayd� guncelle demektir
    END LOOP;
    -- RollBack;
    Commit;
End;

/

-- CURSORS WITH PARAMETERS (imle�lerde Parametre Kullan�m�)
--*********************************************************************************************
-- Once Normal yazal�m, sonra parametrik yapal�m

Declare
      Cursor c_emp IS Select Department_id, Employee_id, Last_name
                      From Employees
                      Where Department_id = 20;                      
      r_emp c_emp%rowtype;      
Begin
      Open c_emp;      
        LOOP
          Fetch c_emp INTO r_emp;
          Exit When c_emp%NotFound;
          
          dbms_output.put_line(' Department_id : '  || r_emp.Department_id ||
                               ' Employee_id : '    || r_emp.Employee_id   ||
                               ' Last_name : '      || r_emp.Last_name
                              );                
        END LOOP;      
      Close c_emp;
End;

/

-- Simdi yukar�daki sorguyu parametrik yazal�m
Declare
    Cursor c_emp(dept_id Employees.Department_id%type)
    IS
        Select
            department_id,
            employee_id,
            last_name
        From Employees
        Where department_id = dept_id;
    
    r_emp c_emp%ROWTYPE;
Begin
    Open c_emp(20);
    Loop
        Fetch c_emp Into r_emp;
        Exit When c_emp%notfound;
        
        dbms_output.put_line(' Department_id : '  || r_emp.Department_id ||
                               ' Employee_id : '    || r_emp.Employee_id   ||
                               ' Last_name : '      || r_emp.Last_name
                              );  
    End Loop;
    
    Close c_emp;
End;

/

-- Parametreye default deger verebiliriz. Boylece parametre gondermeden cagirsak bile calisir.

-- Yukar�daki sorguda Cursor icerisine Default deger tan�mlayal�m

Declare
      Cursor c_emp(wDept_id Employees.Department_id%type DEFAULT 30)
      IS
          Select Department_id, Employee_id, Last_name
          From Employees
          Where Department_id = wDept_id;
          -- c_emp parantezinde parametre tan�mlad�k ve Where kosuluna yazd�k                 

      r_emp c_emp%rowtype;      

Begin
      -- Open c_emp;  -- Parametre DEFAULT 30 verdigimiz icin
                      -- bu sekilde yazabiliriz, bu durumda Defaulttaki degere
                      -- gore sorgu cal�s�r, burada 30 nolu departmant bilgileri gelir
                      
         Open c_emp(20); -- Parametre gonderirsek parametreye gore bilgi gelir
      -- Parametrik yazd�k, 20 nolu Department_id bilgisini okuyacagiz
      
      -- Open c_emp();  -- Defaulttaki degere gore sorgu cal�s�r
      -- Open c_emp;    -- Defaulttaki degere gore sorgu cal�s�r
      
        LOOP
          Fetch c_emp INTO r_emp;
          Exit When c_emp%NotFound;
          
          dbms_output.put_line(' Department_id : '  || r_emp.Department_id ||
                               ' Employee_id : '    || r_emp.Employee_id   ||
                               ' Last_name : '      || r_emp.Last_name
                              );                
        END LOOP;      
      Close c_emp;
End;

/

--*********************************************************************************************
-- CURSORS WITH PARAMETERS (imle�lerde Parametre Kullan�m�)(NESTED CURSORS)
--*********************************************************************************************
-- Ornek
-- Lokasyon(Locations) ===> Bolumler(Departments) ===> Calisanlar(Employees)

-- 3 Tablo oldugu icin 3 tane Cursor kullanacagiz,
-- Ad�m Ad�m Yazal�m

Declare
      Cursor c_loc IS Select Location_id, City From Locations Order By City;
      r_loc  c_loc%ROWTYPE;
Begin
      Open c_loc;
        Loop
          Fetch c_loc INTO r_loc;
          Exit When c_loc%NotFound;
          dbms_output.put_line('Lokasyon : ' || r_loc.City || '(' || r_loc.Location_id || ')');
        End Loop;
      
      Close c_loc;
End;
/
-- Yukar�daki programda Location'lar� yazd�rd�k
-- Simdi Departments yazd�ral�m

Declare
      Cursor c_loc IS Select Location_id, City From Locations Order By City;
      r_loc  c_loc%ROWTYPE;
      
      
      Cursor c_dep(p_loc_id Departments.Location_id%type) IS
                  Select Department_id, Department_Name, Location_id
                  From Departments
                  Where Location_id = p_loc_id
                  Order By Department_Name;
      r_dep  c_dep%ROWTYPE;
      
Begin
      Open c_loc;
        Loop
          Fetch c_loc INTO r_loc;
          Exit When c_loc%NotFound;
          dbms_output.put_line('Lokasyon : ' || r_loc.City || '(' || r_loc.Location_id || ')');
      --**************************
      -- Simdi Department icin cursor acalim
              Open c_dep(r_loc.Location_id);
                Loop
                  Fetch c_dep INTO r_dep;
                  Exit When c_dep%NotFound;
                  dbms_output.put_line('        (' || r_loc.Location_id || ')' ||
                                       ' Department : ' || r_dep.Department_Name ||
                                       '(' || r_dep.Department_id || ')'
                                       );
                End Loop;              
              Close c_dep;
        End Loop;      
      Close c_loc;
End;
/
-- Yukar�daki programda Location'lar� ve Department'lar� yazd�rd�k
-- Simdi Employees yazd�ral�m

Declare
      Cursor c_loc IS Select Location_id, City From Locations Order By City;
      r_loc  c_loc%ROWTYPE;     
      
      Cursor c_dep(p_loc_id Departments.Location_id%type) IS
                  Select Department_id, Department_Name, Location_id
                  From Departments
                  Where Location_id = p_loc_id
                  Order By Department_Name;
      r_dep  c_dep%ROWTYPE;

     Cursor c_emp(p_dep_id Employees.Employee_id%type) IS
                  Select Employee_id, First_Name, Last_Name, Department_id
                  From Employees
                  Where Department_id = p_dep_id
                  Order By Employee_id;
      r_emp  c_emp%ROWTYPE;      
Begin
      Open c_loc;
        Loop
          Fetch c_loc INTO r_loc;
          Exit When c_loc%NotFound;
          dbms_output.put_line('Lokasyon : ' || r_loc.City || '(' || r_loc.Location_id || ')');
      --**************************
      -- Simdi Department icin cursor acalim
              Open c_dep(r_loc.Location_id);
                Loop
                  Fetch c_dep INTO r_dep;
                  Exit When c_dep%NotFound;
                  dbms_output.put_line('        (' || r_loc.Location_id || ')' ||
                                       ' Department : ' || r_dep.Department_Name ||
                                       '(' || r_dep.Department_id || ')'
                                       );
                      --**************************
                      -- Simdi Employees icin cursor acalim
                              Open c_emp(r_dep.Department_id);
                                Loop
                                  Fetch c_emp INTO r_emp;
                                  Exit When c_emp%NotFound;
                                  dbms_output.put_line('                '                  ||
                                                       'Employee_Name : ' || r_emp.First_Name  || ' ' ||
                                                                             r_emp.Last_Name   || ' ' ||
                                                       'Employee_id: ' || r_emp.Employee_id ||
                                                       '(' || r_emp.Department_id || ')');
                                End Loop;
                              Close c_emp;
                                  dbms_output.put_line(' ');-- Dongu bittiginde bos satir ekliyorum,
                                                            -- istersen ekleyebilirsin, Tercihe gore
                                  dbms_output.new_line;-- dbms_output.put_line(' ');
                                  -- Yukar�daki 2 komutta ayn� isi yapar, Yeni bir sat�ra gecer
                --**************************
                End Loop;              
              Close c_dep;
      --**************************                    
        End Loop;      
      Close c_loc;
End;
/
-- Simdi Yukar�daki program� sadelestirelim
Declare
      Cursor c_loc IS Select Location_id, City From Locations Order By City;
      r_loc  c_loc%ROWTYPE;
            
      Cursor c_dep(p_loc_id Departments.Location_id%type) IS
                  Select Department_id, Department_Name, Location_id
                  From Departments
                  Where Location_id = p_loc_id
                  Order By Department_Name;
      r_dep  c_dep%ROWTYPE;

     Cursor c_emp(p_dep_id Employees.Employee_id%type) IS
                  Select Employee_id, First_Name, Last_Name, Department_id
                  From Employees
                  Where Department_id = p_dep_id
                  Order By Employee_id;
      r_emp  c_emp%ROWTYPE;-- Bu tur tan�mlamalara
                           -- Record veri tipi veya Referans veri tipi denir
      
Begin
      Open c_loc;
        Loop
          Fetch c_loc INTO r_loc;
          Exit When c_loc%NotFound;
          dbms_output.put_line('Lokasyon : ' || r_loc.City || '(' || r_loc.Location_id || ')');
      -- Simdi Department icin cursor acalim
              Open c_dep(r_loc.Location_id);
                Loop
                  Fetch c_dep INTO r_dep;
                  Exit When c_dep%NotFound;
                  dbms_output.put_line('        (' || r_loc.Location_id || ')' ||
                                       ' Department : ' || r_dep.Department_Name
                                       );
                      -- Simdi Employees icin cursor acalim
                              Open c_emp(r_dep.Department_id);
                                Loop
                                  Fetch c_emp INTO r_emp;
                                  Exit When c_emp%NotFound;
                                  dbms_output.put_line('                '                  ||
                                                       r_emp.First_Name  || ' ' || r_emp.Last_Name   ||
                                                       '(' || r_emp.Employee_id || ')');                                                        
                                End Loop;
                              Close c_emp;
                End Loop;              
              Close c_dep;
        End Loop;      
      Close c_loc;
End;
/

Begin
      Open c_loc;
        Loop
          Fetch c_loc INTO r_loc;
          Exit When c_loc%NotFound;
          dbms_output.put_line('Lokasyon : ' || r_loc.City || '(' || r_loc.Location_id || ')');
      -- Simdi Department icin cursor acalim
              Open c_dep(r_loc.Location_id);
                Loop
                  Fetch c_dep INTO r_dep;
                  Exit When c_dep%NotFound;
                  dbms_output.put_line('        (' || r_loc.Location_id || ')' ||
                                       ' Department : ' || r_dep.Department_Name
                                       );
                      -- Simdi Employees icin cursor acalim
                              Open c_emp(r_dep.Department_id);
                                Loop
                                  Fetch c_emp INTO r_emp;
                                  Exit When c_emp%NotFound;
                                  dbms_output.put_line('                ' || r_emp.AdiSoyadi   ||
                                                       '(' || r_emp.Employee_id || '-'
                                                           || r_emp.Job_id || '-'
                                                           || to_Char(r_emp.hire_date,'dd/mm/yyyy') || ')');                                                        
                                End Loop;
                              Close c_emp;
                End Loop;              
              Close c_dep;
        End Loop;      
      Close c_loc;
End;