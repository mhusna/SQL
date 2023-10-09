-- Select ile birlikte if komutlari kullanmak cok mantikli degil, exception varsa direk devreye girer.

-- Update ve delete'de exception'a girmez, if-else varsa oraya girer fakat select icin bu gecerli degil.

-- CURSORS --
-- Implicit Cursors(System-Defined Cursors)   -- Sistem tarafýndan tanýmlananlar
-- Explicit Cursors(Developer-Defined Cursors)-- Kullanýcý tarafýndan tanýmlananlar

--*********************************************************************************************
-- Implicit Cursors(System-Defined Cursors)   -- Sistem tarafindan tanimlananlar.
-- Sistem tarafindan hazir olan Cursor'lardir.
-- SQL%FOUND, SQL%NOTFOUND, SQL%ROWCOUNT
--*********************************************************************************************

-- Update ve Delete islemi yapacagiz ama once
-- DML komutlarýndan Select isleminde nasýl etki gosteriyor, inceleyelim
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

-- Yukarýdaki sorguda Exception Select isleminden sonra tetiklenir
-- hata var ise Exception devreye girer ve hatayý gosterir.
-- implicit Cursor'larý Select ifadelerinde kullanmak cok mantýklý degildir
-- Cunku Select ifadesinden sonra Exception(=>no_data_found exception'ý); 
-- SQL%FOUND, SQL%NOTFOUND'tan once tetiklenir

-- Simdi de, DML komutlarýndan Update ve Delete islemi yapacagiz

-- implicit Cursorlardan SQL%FOUND, SQL%NOTFOUND nadiren kullanýlýr ama
-- SQL%ROWCOUNT cursor'ý cok kullanýlýr(if'lerde ve Case'lerde kullanýlýr)

Declare
    rec_emp employees2%rowtype;
Begin
      Update Employees2
      Set Salary = Salary * 1.20
      Where Department_id = 50;
      -- Where Department_id = 500; -- Bununlada deneyelim
      
      if sql%found then
         dbms_output.put_line(sql%rowcount || ' Kayýt Update edildi A');
      else
         dbms_output.put_line('Update edilecek Kayýt Yok A');
      end if;
      
      if sql%notfound then
          dbms_output.put_line('Update edilecek Kayýt Yok B');
      else
          dbms_output.put_line(sql%rowcount || ' Kayýt Update edildi B');
      end if;      

      Delete From Employees2      
      Where Department_id = 100;
      
end;

/

-- Yukarýdaki sorguyu Delete ile inceleyelim
Declare
    rec_emp employees2%rowtype;
Begin
      Delete From Employees2      
      Where Department_id = 60;
      -- Where Department_id = 1000; -- Bununlada deneyelim
      if sql%found then
         dbms_output.put_line(sql%rowcount || ' Kayýt Delete edildi A');
      else
         dbms_output.put_line('Delete edilecek Kayýt Yok A');
      end if;
      
      if sql%notfound then
          dbms_output.put_line('Delete edilecek Kayýt Yok B');
      else
          dbms_output.put_line(sql%rowcount || ' Kayýt Delete edildi B');
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

-- Yukarýdaki en basit haliyle kullandýk
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
    Close c_empl; -- islem sonunda Cursor kapatýyoruz
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
    Close c_empl; -- islem sonunda Cursor kapatýyoruz
End;
/

--*********************************************************************************************
-- Explicit Cursors(Developer-Defined Cursors)-- Kullanýcý tarafýndan tanýmlananlar
    -- Explicit Cursors Attributes
    -- Developer-Defined Cursors Durum Bilgileri
    --   
--*********************************************************************************************
/*

Explicit Cursorlarýn DURUM bilgilerini veren ozellik imlecleri 4 adettir
  %ISOPEN   Boolean tipindedir, Cursor aciksa degeri TRUE degilse FALSE
  %NOTFOUND Boolean tipindedir, FETCH edilecek kayýt kalmadýysa degeri TRUE degilse FALSE
  %FOUND    Boolean tipindedir, FETCH edilecek kayýt varsa      degeri TRUE degilse FALSE
  %ROWCOUNT Number  tipindedir, FETCH edilen kayýt sayýsýný verir
  
*/

--*********************************************************************************************
-- Cursors Durum Bilgileri %ISOPEN, %NOTFOUND, %FOUND, %ROWCOUNT
--*********************************************************************************************

-- %ISOPEN: Cursor acik kalýrsa memory þiþer ve performans kaybý meydana gelir
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
        -- Yukarýdaki her iki yazým da ayný sonucu verir
              
        Exit When c_reg%NotFound or c_reg%rowcount > 3;
        -- Yukarýdaki ise kayýt kalmadýgýnda veya
        -- kayýt sayýsý 3'un uzerine cýktýgýnda Loop'tan cýkar
              
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
                dbms_output.put_line('Yukarýdaki 2 kosuldan birisi gerceklesti!');
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

-- Yukarýdaki sorguda Select icerisinde cok fazla sutun olabilir
-- Bu durumda her biri icin ayrý ayrý degisken tanýmlamak yerine
-- %ROWTYPE ile tek seferde tanýmlamak daha dogru olur

Declare
    Cursor c_reg is
        Select region_id, region_name 
        From Regions 
        Order By region_id;
    
    r_oku c_reg%ROWTYPE; -- Daha once tablo tanýmladýgýmýz gibi Cursorden gelen
                          -- Sutun bilgilerini tek seferde tanýmlayabiliriz
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
-- simdi yukarýdaki sorguda Select icerisinde * ile verileri getirelim
-- Bu durumda tum sutunlar gelecektir

Declare
    Cursor c_reg is Select * From Regions Order By Region_id;
    -- Bu durumda tum sutunlar gelir
    r_oku c_reg%ROWTYPE;  -- Daha once tablo tanýmladýgýmýz gibi Cursorden gelen
                          -- Sutun bilgilerini tek seferde tanýmlayabiliriz
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
-- For Loop ile Az onceki ornegi yukarýdaki yazýma gore biraz daha performanslý yazalým
-- Cursor acmadan, herhangi bir degisken tanýmlamadan yapalým
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
-- Goruldugu gibi daha az kod ile ayný islemi yaptýk
-- Cursor Ornek A1 Yontem 2 ile yapýlan Cursor Ornek A1 Yontem 1'e gore daha performanslýdýr

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
-- Ancak goruldugu gibi sýra numarasýný bu sekilde yazdýramadýk
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
-- Cursor Ornek A1 Yontem 3 ile yapýlan Yontem 2'ye gore Yontem 2 ise Yontem 1'e gore daha performanslýdýr
-- Cok fazla data'nýn oldugu islemlerde, Cursor Ornek A1 Yontem 3_A ve Yontem 3_B  daha performanslý olacaktýr

-- Yontem 1 ile Cursor icin Memoryde yer ayrýlýyor, sonra Open ediliyor
-- Fetch ile her bir dongude kayýt parse ediliyor is bittiginde de Close ediliyor

-- Yontem 2 de ise Sadece Cursor icin Memory'de yer ayrýlýyor, Cursor otomatik acýlýp kapatýlýyor
-- Ayrýca Open, Fetch, Close islemlerine gerek kalmýyor

-- Yontem 3 ise Sorguyu direk Buffer'a(Memory'e alýyor) ve sorgu calisiyor
-- Bu nedenle daha performanslýdýr

-- 3 yontemde ayný sonucu verecektir

--*********************************************************************************************
-- Cursor - FOR UPDATE ve WHERE CURRENT OF Kullanýmý
--*********************************************************************************************
-- Ornek olarak; Maasi 5000'den az olanlara %20 zam yapalým
-- Employee tablosunun kopyasýný olusturalým

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
-- Biz islem yaparken baska kullanicilar, Transactionlar veya programlar tarafýndan
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
-- Ancak yukarýdaki FOR UPDATE ile tum tabloyu kilitlemis oluruz
-- Bunun yerine sadece islem yapacagimiz Salary sutununu kilitleyelim
-- For Update of Salary seklinde yazmamýz lazým

Declare
    Cursor c_emp IS Select * From Employees2 FOR UPDATE Of Salary;
    -- For Update Of Salary dedigimizde sadece Salary kilitlenmis olacaktýr
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

-- Cursor - FOR UPDATE ve WHERE CURRENT OF Kullanýmý
-- Yukarýdaki ornekte
-- Where Employee_id = r_emp.Employee_id; yerine sunu yazabiliriz
-- Where CURRENT OF c_emp; yukaridaki satýrla ayný anlamdadýr
-- en son okunan kaydý guncelle demektir

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
            -- yukaridaki satýrla ayný anlamdadýr
            -- en son okunan kaydý guncelle demektir
            dbms_output.put_line(r_emp.Employee_id || ' Update edildi');
        End if;    
    END LOOP;
    Commit;
End;

/

-- DELETE islemi icinde ayný yontem yapacagýz
-- yani Select * From Employees2 FOR UPDATE; yazacagiz
-- Employee_id >= 204 olan kayýtlarý silelim
Declare
    Cursor c_emp IS Select * From Employees2 Where Employee_id >= 204 FOR UPDATE;
Begin
    For r_emp IN c_emp 
    LOOP
            dbms_output.put_line(r_emp.Employee_id || ' Delete edildi');
            Delete Employees2           
            -- Where Employee_id = r_emp.Employee_id;
            Where CURRENT OF c_emp;
            -- yukaridaki satýrla ayný anlamdadýr
            -- en son okunan kaydý guncelle demektir
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
            -- yukaridaki satýrla ayný anlamdadýr
            -- en son okunan kaydý guncelle demektir
    END LOOP;
    -- RollBack;
    Commit;
End;

/

-- CURSORS WITH PARAMETERS (imleçlerde Parametre Kullanýmý)
--*********************************************************************************************
-- Once Normal yazalým, sonra parametrik yapalým

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

-- Simdi yukarýdaki sorguyu parametrik yazalým
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

-- Yukarýdaki sorguda Cursor icerisine Default deger tanýmlayalým

Declare
      Cursor c_emp(wDept_id Employees.Department_id%type DEFAULT 30)
      IS
          Select Department_id, Employee_id, Last_name
          From Employees
          Where Department_id = wDept_id;
          -- c_emp parantezinde parametre tanýmladýk ve Where kosuluna yazdýk                 

      r_emp c_emp%rowtype;      

Begin
      -- Open c_emp;  -- Parametre DEFAULT 30 verdigimiz icin
                      -- bu sekilde yazabiliriz, bu durumda Defaulttaki degere
                      -- gore sorgu calýsýr, burada 30 nolu departmant bilgileri gelir
                      
         Open c_emp(20); -- Parametre gonderirsek parametreye gore bilgi gelir
      -- Parametrik yazdýk, 20 nolu Department_id bilgisini okuyacagiz
      
      -- Open c_emp();  -- Defaulttaki degere gore sorgu calýsýr
      -- Open c_emp;    -- Defaulttaki degere gore sorgu calýsýr
      
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
-- CURSORS WITH PARAMETERS (imleçlerde Parametre Kullanýmý)(NESTED CURSORS)
--*********************************************************************************************
-- Ornek
-- Lokasyon(Locations) ===> Bolumler(Departments) ===> Calisanlar(Employees)

-- 3 Tablo oldugu icin 3 tane Cursor kullanacagiz,
-- Adým Adým Yazalým

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
-- Yukarýdaki programda Location'larý yazdýrdýk
-- Simdi Departments yazdýralým

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
-- Yukarýdaki programda Location'larý ve Department'larý yazdýrdýk
-- Simdi Employees yazdýralým

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
                                  -- Yukarýdaki 2 komutta ayný isi yapar, Yeni bir satýra gecer
                --**************************
                End Loop;              
              Close c_dep;
      --**************************                    
        End Loop;      
      Close c_loc;
End;
/
-- Simdi Yukarýdaki programý sadelestirelim
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
      r_emp  c_emp%ROWTYPE;-- Bu tur tanýmlamalara
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