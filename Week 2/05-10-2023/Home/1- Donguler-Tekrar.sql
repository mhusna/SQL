-- Ornek tablo olusturalim.
Create Table Kurslar
(
    kurs_id Number,
    egitmen_adi Varchar2(30),
    baslangic_tarihi Date,
    bitis_tarihi Date
);

Alter Table Kurslar Add kurs_adi Varchar2(40);

/

Declare
    r_kurslar Kurslar%ROWTYPE;
Begin
    r_kurslar.egitmen_adi := 'Mehmet Husna Kisla';
    r_kurslar.baslangic_tarihi := Trunc(Sysdate);
    r_kurslar.bitis_tarihi := r_kurslar.baslangic_tarihi + 5;
    
    Loop
        r_kurslar.kurs_id := NVL(r_kurslar.kurs_id, 0) + 1;
        IF(r_kurslar.kurs_id = 6) Then
            Continue;
        End IF;
        
        Select Decode(r_kurslar.kurs_id,
                        1,'Oracle SQL',
                        2,'PL/SQL',
                        3,'MS SQL',
                        4,'TRANSACT SQL',
                        5,'Google Big Query',
                        6,'LOGO TIGER3 ENTERPRISE',
                        7, 'Excel',
                        8, 'Excel VBA',
                        9, 'Power BI')
        Into r_kurslar.kurs_adi
        From Dual;
        
        Insert Into Kurslar
            (kurs_id, kurs_adi, egitmen_adi, baslangic_tarihi, bitis_tarihi)
        Values
            (r_kurslar.kurs_id, r_kurslar.kurs_adi, r_kurslar.egitmen_adi, r_kurslar.baslangic_tarihi, r_kurslar.bitis_tarihi);
        
        r_kurslar.baslangic_tarihi := r_kurslar.bitis_tarihi + 1;
        r_kurslar.bitis_tarihi := r_kurslar.baslangic_tarihi + 5;
        
        Exit When r_kurslar.kurs_id = 9;
    End Loop;
End;

/

-- Yukaridaki ornegi CASE-WHEN ile yapalim.
Declare
    r_kurslar Kurslar%ROWTYPE;
Begin
    r_kurslar.egitmen_adi := 'Mehmet Husna Kisla';
    r_kurslar.baslangic_tarihi := Trunc(Sysdate);
    r_kurslar.bitis_tarihi := r_kurslar.baslangic_tarihi + 5;
    
    Loop
        r_kurslar.kurs_id := NVL(r_kurslar.kurs_id, 0) + 1;
        IF r_kurslar.kurs_id = 6 Then
            Continue;
        End IF;
        
        Case r_kurslar.kurs_id
            When 1 Then r_kurslar.kurs_adi := 'Oracle SQL';
            When 2 Then r_kurslar.kurs_adi := 'PL/SQL';
            When 3 Then r_kurslar.kurs_adi := 'MS SQL';
            When 4 Then r_kurslar.kurs_adi := 'TRANSACT SQL';
            When 5 Then r_kurslar.kurs_adi := 'Google Big Query';
            When 6 Then r_kurslar.kurs_adi := 'LOGO TIGER3 ENTERPRISE';
            When 7 Then r_kurslar.kurs_adi := 'Excel';
            When 8 Then r_kurslar.kurs_adi := 'Excel VBA';
            When 9 Then r_kurslar.kurs_adi :='Power BI';
        End Case;
        
        Insert Into Kurslar
            (kurs_id, kurs_adi, egitmen_adi, baslangic_tarihi, bitis_tarihi)
        Values
            (r_kurslar.kurs_id, r_kurslar.kurs_adi, r_kurslar.egitmen_adi, r_kurslar.baslangic_tarihi, r_kurslar.bitis_tarihi);
        
        r_kurslar.baslangic_tarihi := r_kurslar.bitis_tarihi + 1;
        r_kurslar.bitis_tarihi := r_kurslar.baslangic_tarihi + 5;
        
        Exit When r_kurslar.kurs_id = 9;
    End Loop;
End;

/
-- Range ile For kullanimi
Begin
    For Sayac In 1..5
    Loop
        dbms_output.put_line('Sayac: ' || Sayac);
    End Loop;
End;

/

Begin
    For Sayac In Reverse 1..5
    Loop
        dbms_output.put_line('Sayac: ' || Sayac);
    End Loop;
End;

/

Begin
    For Sayac In 1..5
    Loop
        Exit When Sayac = 3;
        dbms_output.put_line('Sayac: ' || Sayac);
    End Loop;
End;

/

-- Continue-When Kullanimi
Begin
    For Sayac In 1..5
    Loop
        Continue When Sayac = 3;
        dbms_output.put_line('Sayac: ' || Sayac);
    End Loop;
End;

/

-- IF icerisinde continue-when kullanimi.
Begin
    For Sayac In 1..5
    Loop
        IF Sayac = 3 Then
            Continue;
        End IF;
        dbms_output.put_line('Sayac: ' || Sayac);
    End Loop;
End;

/

-- ORNEK: Faktoriyel bulduralim.
Declare
    Faktoriyel Number := 1;
Begin
    For Sayac In 1..5
    Loop
        Faktoriyel := Faktoriyel * Sayac;
    End Loop;
    
    dbms_output.put_line('Faktoryiel: ' || Faktoriyel);
End;

/

-- ORNEK: Faktoriyeli alinacak sayiyi disaridan aliniz.
Declare
    Faktoriyel Number := 1;
    Limit Number;
Begin
    Limit := &FaktoriyeliAlinacakSayi;
    
    For Sayac in 1..Limit
    Loop
        Faktoriyel := Faktoriyel * Sayac;
    End Loop;
    
        dbms_output.put_line('Faktoryiel: ' || Faktoriyel);
End;

/

-- FOREACH Tarzinda For Dongusu --
Begin
    -- Parantez icerisinde gizli cursor var. Cursor herbir satiri incelemektir.
    
    For dpt in (Select
                    department_id,
                    department_name
                From hr.departments
                Order By department_id)
    Loop
        dbms_output.put_line('Dep.No: ' || dpt.department_id ||
                             ' - Dep.Name: ' || dpt.department_name);
    End Loop;
End;

/

-- NESTED FOR --
Begin    
    For dpt in (Select
                    department_id,
                    department_name
                From hr.departments
                Order By department_id)
    Loop
        dbms_output.put_line('--> Dep.No: ' || dpt.department_id ||
                             ' - Dep.Name: ' || dpt.department_name);
                             
        For emp in (Select
                        employee_id,
                        first_name
                    From hr.employees
                    Where department_id = dpt.department_id
                    Order By employee_id)
        Loop
            dbms_output.put_line('      Emp.No: ' || emp.employee_id ||
                             ' - Emp.Name: ' || emp.first_name);
        End Loop;
        dbms_output.put_line('  ');
    End Loop;
End;

/

-- ORNEK: Herbir department'in manager bilgisini yazdirin.
Begin
    For dpt in (Select
                    department_id,
                    department_name,
                    manager_id
                From hr.departments
                Order By department_id)
    Loop
        Continue When dpt.manager_id is null;
        dbms_output.put_line('--> Dep.No: ' || dpt.department_id ||
                             ' - Dep.Name: ' || dpt.department_name);
        
        For emp in (Select
                        employee_id,
                        first_name,
                        last_name
                    From hr.employees
                    Where employee_id = dpt.manager_id
                    Order By employee_id)
        Loop
            dbms_output.put_line('      Manager.No: ' || emp.employee_id ||
                                 ' - Manager.Name: ' || emp.first_name || emp.last_name);
        End Loop;
        dbms_output.put_line('  ');
        
    End Loop;
End;   

/

-- ORNEK: Yoneticisi olan departmanlardaki calisanlarin bilgilerini getirin.
Begin
    For dpt in (Select
                    department_id,
                    department_name,
                    manager_id
                From hr.departments
                Order By department_id)
    Loop
        Continue When dpt.manager_id is null;
        dbms_output.put_line('--> Dep.No: ' || dpt.department_id ||
                             ' - Dep.Name: ' || dpt.department_name);
        
        For emp in (Select
                        employee_id,
                        first_name,
                        last_name
                    From hr.employees
                    Where department_id = dpt.department_id
                    Order By employee_id)
        Loop
            dbms_output.put_line('      Emp.No: ' || emp.employee_id ||
                                 ' - Emp.Name: ' || emp.first_name || emp.last_name);
        End Loop;
        dbms_output.put_line('  ');
        
    End Loop;
End;   

/

-- ORNEK [DO - WHILE]: 24 Nisan 2023 tarihinden ayin sonuna kadar olan gunlerin ismini getiren bir sorgu yazalim.

Declare
    BaslangicTarihi Date;
    BitisTarihi Date;
Begin
    BaslangicTarihi  := To_Date('24/04/2023');
    BitisTarihi := Last_Day(BaslangicTarihi);
    
    While(BaslangicTarihi <= BitisTarihi)
    Loop
        dbms_output.put_line(To_Char(BaslangicTarihi, 'Day') || To_Char(BaslangicTarihi, 'DD/MM/YYYY'));
        BaslangicTarihi := BaslangicTarihi + 1;
    End Loop;
End;

/

-- Yukaridaki sorguda exit when yapalim.
Declare
    BaslangicTarihi Date;
    BitisTarihi Date;
Begin
    BaslangicTarihi  := To_Date('24/04/2023');
    BitisTarihi := Last_Day(BaslangicTarihi);
    
    While(BaslangicTarihi <= BitisTarihi)
    Loop
        dbms_output.put_line(To_Char(BaslangicTarihi, 'Day') || To_Char(BaslangicTarihi, 'DD/MM/YYYY'));
        BaslangicTarihi := BaslangicTarihi + 1;
        Exit When BaslangicTarihi = Last_Day(BaslangicTarihi);
    End Loop;
End;

/

-- Yukaridaki sorguda boolean ornegi yapalim.
Declare
    BaslangicTarihi Date;
    BitisTarihi Date;
    BuyukMu Boolean;
Begin
    BaslangicTarihi  := To_Date('24/04/2023');
    BitisTarihi := Last_Day(BaslangicTarihi);
    BuyukMu := BaslangicTarihi <= BitisTarihi;
    
    While(BuyukMu)
    Loop
        dbms_output.put_line(To_Char(BaslangicTarihi, 'Day') || To_Char(BaslangicTarihi, 'DD/MM/YYYY'));
        BaslangicTarihi := BaslangicTarihi + 1;
        BuyukMu := BaslangicTarihi <= BitisTarihi;
        Exit When BaslangicTarihi = Last_Day(BaslangicTarihi);
    End Loop;
End;

/

-- While True dongusu
Declare
    Sayac Number := 1;
Begin
    While True
    Loop
        dbms_output.put_line(To_Char(sysdate + sayac, 'Day') || ' ' || To_Char((sysdate + sayac), 'DD/MM/YYYY'));
        sayac := sayac + 1;
        Exit When sayac = 5;
    End Loop;
End;