-- Continue icin ornek.
Drop Table Kurslar;

/

Create Table Kurslar as
Select * From hr.Kurslar
Where 1=2;

/

Declare
    Kurslar hr.Kurslar%ROWTYPE;
Begin
    Kurslar.Egitmen_Adi := 'Ali Topacik';
    Kurslar.BaslangicTarihi := Trunc(Sysdate); -- Saat'ten kurtardik.
    Kurslar.BitisTarihi := Kurslar.BaslangicTarihi + 5;
    
    LOOP
        Kurslar.Kurs_ID := NVL(Kurslar.Kurs_ID, 0) + 1;
        IF(Kurslar.Kurs_ID = 6) Then
            Continue;
        END IF;
        
        Select Decode(Kurslar.Kurs_ID,
                        1,'Oracle SQL',
                        2,'PL/SQL',
                        3,'MS SQL',
                        4,'TRANSACT SQL',
                        5,'Google Big Query',
                        6,'LOGO TIGER3 ENTERPRISE',
                        7, 'Excel',
                        8, 'Excel VBA',
                        9, 'Power BI')
        Into Kurslar.Kurs_Adi
        From Dual;
        
        Insert Into Kurslar
            (Kurs_ID, Kurs_Adi, Egitmen_Adi, BaslangicTarihi, BitisTarihi)
        Values
            (Kurslar.Kurs_ID, Kurslar.Kurs_Adi, Kurslar.Egitmen_Adi, Kurslar.BaslangicTarihi, Kurslar.BitisTarihi);
            
        Kurslar.BaslangicTarihi := Kurslar.BitisTarihi + 1;
        Kurslar.BitisTarihi := Kurslar.BaslangicTarihi + 5;
        
        Exit When Kurslar.Kurs_ID = 9;
    END LOOP;
End;

/

Select * From Kurslar;

/

-- Yukaridaki ornegi decode yerine simple case-when ile yapalim.
-- Hatali bi bak.
Declare
    Kurslar hr.Kurslar%ROWTYPE;
Begin
    Kurslar.Egitmen_Adi := 'Ali Topacik';
    Kurslar.BaslangicTarihi := Trunc(Sysdate); -- Saat'ten kurtardik.
    Kurslar.BitisTarihi := Kurslar.BaslangicTarihi + 5;
    
    LOOP
        Kurslar.Kurs_ID := NVL(Kurslar.Kurs_ID, 0) + 1;
        IF(Kurslar.Kurs_ID = 6) Then
            Continue;
        END IF;
        
        Case Kurslar.Kurs_ID
            When 1 Then Kurslar.Kurs_Adi := 'Oracle SQL';
            When 2 Then Kurslar.Kurs_Adi := 'PL/SQL';
            When 3 Then Kurslar.Kurs_Adi := 'MS SQL';
            When 4 Then Kurslar.Kurs_Adi := 'TRANSACT SQL';
            When 5 Then Kurslar.Kurs_Adi := 'Google Big Query';
            When 6 Then Kurslar.Kurs_Adi := 'LOGO TIGER3 ENTERPRISE';
            When 7 Then Kurslar.Kurs_Adi := 'Excel';
            When 8 Then Kurslar.Kurs_Adi := 'Excel VBA';
            When 9 Then Kurslar.Kurs_Adi := 'Power BI';
        End Case;

        Insert Into Kurslar
            (Kurs_ID, Kurs_Adi, Egitmen_Adi, BaslangicTarihi, BitisTarihi)
        Values
            (Kurslar.Kurs_ID, Kurslar.Kurs_Adi, Kurslar.Egitmen_Adi, Kurslar.BaslangicTarihi, Kurslar.BitisTarihi);
            
        Kurslar.BaslangicTarihi := Kurslar.BitisTarihi + 1;
        Kurslar.BitisTarihi := Kurslar.BaslangicTarihi + 5;
        
        Exit When Kurslar.Kurs_ID = 9;
    END LOOP;
End;

/

Begin
    For sayac IN 1..5
    Loop
        dbms_output.put_line('Sayac: ' || sayac);
    End Loop;
End;

/

-- Tersten saydirir.
Begin
    For Sayac IN Reverse 1..5 
    Loop
        dbms_output.put_line('Sayac: ' || sayac);
    End Loop;
End;

/

Begin
    For Sayac IN 1..5 
    Loop
        Exit When Sayac = 3;
        dbms_output.put_line('Sayac: ' || sayac);
    End Loop;
End;

/

-- Exit komutunu nereye yazdigimiz onemli.
Begin
    For Sayac IN 1..5 
    Loop
        dbms_output.put_line('Sayac: ' || sayac);
        Exit When Sayac = 3;
    End Loop;
End;

/

-- Continue ifadesi kullanmak.
Begin
    For Sayac IN 1..5
    Loop
        Continue When Sayac = 3;
        dbms_output.put_line('Sayac: ' || sayac);
    End Loop;
End;

/

-- If icerisinde de continue diyebiliriz.
Begin
      For Sayac IN 1..5 Loop
        if Sayac = 3 Then
        -- if Sayac = 3 or Sayac = 4 Then
           Continue;
        End if;
        dbms_output.put_line('Sayac = ' || Sayac);      
      End Loop;  
End;

/

Begin
      For Sayac IN 1..5 Loop
        if Sayac = 3 Then
            Exit;
            -- Exit komutunu burada yazmak zorunda degiliz,
            -- Cunku burada For dongusu var, yani dongunun alt ve ust limiti var
            -- Basic Loop'ta ise limit olmadýgý icin sayac kontrol edilmeli
            -- ve kosullar saglandýgýnda Exit yapýlmalýdýr(if Sayac = 3 Then Exit; End if;)
        End if;
        -- Sayac = 3 oldugunda Kod asagi gitmeyip For-Loop'a geri doner
        
        dbms_output.put_line('Sayac = ' || Sayac);      
      End Loop;  
End;

/

Declare
    Faktoriyel Number := 1;
Begin
    For Sayac in 1..5
    Loop
        Faktoriyel := Faktoriyel * Sayac;
    End Loop;
    
    dbms_output.put_line('Faktoriyel: ' || faktoriyel);
End;

/

Declare
    Faktoriyel Number := 1;
    UstLimit Number := 1;
Begin
    UstLimit := &FaktoriyeliAlinacakSayiyiGirin;
    For Sayac in 1..UstLimit
    Loop
        Faktoriyel := Faktoriyel * Sayac;
    End Loop;
    
    dbms_output.put_line('Faktoriyel: ' || faktoriyel);
End;

/

Begin
    -- Parantez icinde gizli cursor var. Cursor herbir satiri incelemektir.
    For dpt in (
                Select department_id, 
                       department_name 
                from departments 
                order by department_id
                )
    Loop
        dbms_output.put_line('Bolum No: ' || dpt.department_id ||
                             'Bolum Adi: ' || dpt.department_name);
    End Loop;
End;

/

-- ORNEK: For icerisinde for kullanimi.
Begin
    For dpt in (
                Select 
                    department_id, 
                    department_name 
                From departments 
                Order By department_id
                )
    Loop
        dbms_output.put_line('Bolum No: ' || dpt.department_id ||
                             'Bolum Adi: ' || dpt.department_name);
                             
        For emp IN (
                    Select
                        employee_id,
                        first_name,
                        last_name
                    From employees
                    Where department_id = dpt.department_id
                    )
        Loop
            dbms_output.put_line('      Emp.No: ' || emp.employee_id ||
                                 ' Emp.Name: ' || emp.first_name ||
                                 ' ' || emp.last_name);
        End Loop;
        
        dbms_output.put_line('  ');
    End Loop;
End;

/

-- ORNEK: Herbir department'in manager bilgisini yazdirin.
-- Ben yapiyodum hatali.
Declare
   managerId Number; 
Begin
    For dpt IN (Select manager_id, department_id, department_name From departments)
    Loop
        Begin
            Select manager_id Into managerId From departments where manager_id = dpt.manager_id;
            Exception When No_Data_Found Then managerId := null;
        End;
        
        IF managerId is not null Then
            dbms_output.put_line('--> ' || dpt.department_id ||
                                 ' - ' || dpt.department_name);
                                 
            For emp IN (Select employee_id, first_name, last_name From employees where employee_id = managerId)
            Loop
                dbms_output.put_line('  -> Calisan Numarasi: ' || emp.employee_id);
                dbms_output.put_line('  -> Calisan Adi: ' || emp.first_name);
                dbms_output.put_line('  -> Calisan Soyadi: ' || emp.last_name);
                dbms_output.put_line('');
            End Loop;
        END IF;
    End Loop;
End;

/

-- Bu da hocanin ornegi.

Declare
    YoneticiSoyadi Employees.last_name%type;
Begin
    For dpt IN (Select Department_id, Department_Name, manager_id From Departments Order By Department_id)
    Loop
        Begin
                Select last_name into YoneticiSoyadi From Employees Where Employee_id = dpt.Manager_id;
                Exception When no_data_found then YoneticiSoyadi:= null;
        End;
        
            if YoneticiSoyadi is not null then
                dbms_output.put_line(' '); -- her bir bolumden once bos satýr yazacagýz
                dbms_output.put_line(' Bolum No: ' || dpt.Department_id || 
                                     ' Bolum Adi: ' || dpt.Department_Name ||
                                     'Yonetici Soyadi: ' || YoneticiSoyadi);
    
                For emp IN (Select Employee_id, first_Name, Last_Name
                            From Employees
                            Where Department_id = dpt.Department_id) Loop
    
                     dbms_output.put_line('      Emp.No: ' || emp.Employee_id || ' Adi: ' || emp.first_Name || ' Soyadi: ' || emp.Last_Name);                        
                End Loop;
          end if;
    End Loop;
End; 

/

-- ORNEK: While Loop
-- Belirli bir tarihin ve sonraki gunlerin ismini getiren bir sorgu yazalim
-- Ornegin 24 Nisan 2023 hangi gun ve bu ayýn sonuna kadar olan gunleri bulalim
Declare
    Tarih1 Date;
    Tarih2 Date;
Begin
    Tarih1 := To_Date('24/09/2023', 'DD/MM/YYYY');
    Tarih2 := Last_Day(Tarih1);
    
    While(Tarih1 <= Tarih2)
    Loop
        dbms_output.put_line(To_Char(Tarih1, 'Day') || To_Char(Tarih1, 'DD/MM/YYYY'));
        Tarih1 := Tarih1 + 1;
    End Loop;
End;

/

-- Yukaridaki sorguda exit when yapalim.
Declare
    Tarih1 Date;
    Tarih2 Date;
Begin
    Tarih1 := To_Date('24/09/2023', 'DD/MM/YYYY');
    Tarih2 := Last_Day(Tarih1);
    
    While(Tarih1 <= Tarih2)
    Loop
        dbms_output.put_line(To_Char(Tarih1, 'Day') || To_Char(Tarih1, 'DD/MM/YYYY'));
        Tarih1 := Tarih1 + 1;
        
        Exit When Tarih1 > To_Date('29/09/2023', 'DD/MM/YYYY');
    End Loop;
End;

/

-- Yukaridaki sorguda boolean ornegi yapalim.
Declare
    Tarih1 Date;
    Tarih2 Date;
    BuyukMu Boolean;
Begin
    Tarih1 := To_Date('24/09/2023', 'DD/MM/YYYY');
    Tarih2 := Last_Day(Tarih1);
    BuyukMu := Tarih1 <= Tarih2;
    
    While(BuyukMu)
    Loop
        dbms_output.put_line(To_Char(Tarih1, 'Day') || To_Char(Tarih1, 'DD/MM/YYYY'));
        Tarih1 := Tarih1 + 1;
        
        BuyukMu := Tarih1 <= Tarih2;
        Exit When Tarih1 > To_Date('29/09/2023', 'DD/MM/YYYY');
    End Loop;
End;

/

-- While True dongusu
Declare
    sayac number:=1;
Begin

    
    While True
    Loop
      dbms_output.put_line(To_Char(sysdate+sayac,'day') || ' ' || To_Char(sysdate+sayac, 'DD/MM/YYYY'));
      sayac:= sayac + 1;
      
      Exit When sayac = 5;
      -- '29/04/2023' bu tarihten donguden cikar
    End Loop;
End;

/
