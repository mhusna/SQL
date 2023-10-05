-- Kosullu Akýþ Kontrolleri if Nested (iç içe if kullanýmý)

Declare
    DogumTarihi   Date;
    Yasi          Number(3);  
Begin
    DogumTarihi:= To_Date('21/11/1996','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz
    if Yasi < 15 Then
        dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
    Elsif Yasi < 30 Then
          dbms_output.put_line('Ben 16-30 yasý arasýndayým, Yasim: ' || Yasi);
        
        if Yasi >= 23 Then
          dbms_output.put_line('Ve Nested if icin ornek, 23-30 yasý arasýndayým, Yasim: ' || Yasi);        
        End if;
    Elsif Yasi < 50 Then
        dbms_output.put_line('Ben 31-50 yasý arasýndayým, Yasim: ' || Yasi);
    Else
        dbms_output.put_line('Ben 50 Yasindan Buyugum, Yasim: ' || Yasi);  
    End if;
End;
/

--*********************************************************************************************
-- Kosullu Akýþ Kontrolleri *** CASE(Simple Case - Searched Case)
--*********************************************************************************************

-- Simple Case:
-- Bir sayýnýn tek mi yoksa cift mi oldugunu bulan kod yazalým
Declare
    Sayi Number := 12;
    Mesaj Varchar2(2000);
Begin
    Case Mod(Sayi, 2)
        When 1 Then Mesaj := 'Sayi tektir, sayi: ' || Sayi;
        Else Mesaj := 'Sayi cifttir, sayi: ' || Sayi;
    End case;
    
    dbms_output.put_line(mesaj);
End;

/

-- Yukaridaki ornekte sayiyi ekrandan girelim
-- Ekrandan kullanicinin sayi girmesi icin &(ampersant) isareti kullanilir.
Declare
    Sayi Number := &Sayi_Giriniz;
    Mesaj   Varchar2(2000);
Begin
    Case Mod(Sayi,2)
        When 1 Then Mesaj := 'Sayi tektir, sayi: ' || Sayi;
        Else Mesaj := 'Sayi cifttir, sayi: ' || Sayi;
   End Case;
   
   dbms_output.put_line(mesaj);    
End;

/
-- Yukaridaki Simple Case ornegini Searched Case ile de yazalim
-- Simple Case icerisinde Nested Case yapabiliriz
-- Ayrica Simple Case icerisinde Search Case kullanilabilir.

Declare
      Sayi    Number:= &Sayi_Giriniz;
      Mesaj   Varchar2(2000);
Begin
   Case 
        When Mod(Sayi,2) = 1 Then Mesaj:= 'Tek Sayý, Sayimiz: ' || Sayi;
        Else Mesaj:= 'Cift Sayý, Sayimiz: ' || Sayi;
        -- Sayinin 2 ye bolumunden kalan 1 degilse 0-Sýfýrdýr Else ile kontrol ediyoruz
   End Case;
   
   dbms_output.put_line(Mesaj);    
End;

/

Declare
      Sayi    Number(5);
      Mesaj   Varchar2(2000);
Begin
    Sayi:= &Sayi_Giriniz;
   Case 
        When Mod(Sayi,2) = 1 Then Mesaj:= 'Tek Sayý, Sayimiz: ' || Sayi;
        Else Mesaj:= 'Cift Sayý, Sayimiz: ' || Sayi;
        -- Sayinin 2 ye bolumunden kalan 1 degilse 0-Sýfýrdýr Else ile kontrol ediyoruz
   End Case;
   
   dbms_output.put_line(Mesaj);    
End;
/

-- ORNEK
Declare
    dogumtarihi date;
    yasi Number(3);
Begin
    dogumtarihi := To_Date('21/11/2012', 'dd/mm/YYYY');
    yasi := (sysdate - dogumtarihi) / 365;
    
    -- Bu bize gun cinsinden deger getirir, 365'e bolersek yil buluruz.
        Case yasi
            When 15 Then dbms_output.put_line('Ben 15 yasindayim, yasim: ' || yasi);
            When 30 Then dbms_output.put_line('Ben 30 yasindayim, yasim: ' || yasi);
            When 50 Then dbms_output.put_line('Ben 50 yasindayim, yasim: ' || yasi);
            Else dbms_output.put_line('Yasim 15, 30 ve 50''den farklidir, yasim: ' || yasi);
        End Case;  
End;

/

-- Searched Case
Declare
    DogumTarihi   Date;
    Yasi          Number(3);
Begin
    DogumTarihi:= To_Date('21/11/2012','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;   
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    Case 
          When Yasi < 15 Then dbms_output.put_line('Ben 15 yasýndan kucugum, Yasim: ' || Yasi);
          When Yasi < 30 Then dbms_output.put_line('Ben 16-30 yasý arasýndayým, Yasim: ' || Yasi);
          When Yasi < 50 Then dbms_output.put_line('Ben 31-50 yasý arasýndayým, Yasim: ' || Yasi);
          Else dbms_output.put_line('Ben 50 Yasindan Buyugum, Yasim: ' || Yasi);
    End Case;    
End;

/

-- Yukarýdaki sonucu degisken ile kullanalým

Declare
    DogumTarihi   Date;
    Yasi          Number(3);
    Mesaj         Varchar2(2000);
Begin
    DogumTarihi:= To_Date('21/11/2012','dd/mm/yyyy');
    Yasi:= (SysDate - DogumTarihi)/365;   
    -- bu bize gun cinsinden deger donderir, Bunu 365'e Bolersek Yil buluruz

    Case 
          When Yasi < 15 Then Mesaj := 'Ben 15 yasýndan kucugum';
          When Yasi < 30 Then Mesaj := 'Ben 16-30 yasý arasýndayým';
          When Yasi < 50 Then Mesaj := 'Ben 31-50 yasý arasýndayým';
          Else                Mesaj := 'Ben 50 Yasindan Buyugum';
    End Case;
    dbms_output.put_line(Mesaj || ', Yasim: ' || Yasi);   
End;

/

-- Simdi Case icerisinde Case kullanalim
-- ORNEK
Declare
    DogumTarihi date;
    yasi Number(3);
    mesaj Varchar2(1000);
Begin
    DogumTarihi := To_Date('21/11/2002', 'dd/mm/YYYY');
    Yasi := (Sysdate - DogumTarihi) / 365;
    
    Case
        When Yasi < 15 Then Mesaj := 'Ben 15 yasindan kucugum';
        When Yasi < 30 Then Mesaj := 'Ben 16-30 yasi arasindayim';
            Case
                When yasi < 24 Then Mesaj:= Mesaj || ' ve 24 yasindan da kucugum!';
                Else Mesaj := Mesaj || ' ve 24''ten Buyugum';
            End Case;
        When Yasi < 50 Then Mesaj := 'Ben 31-50 yasý arasýndayým';
        Else                Mesaj := 'Ben 50 Yasindan Buyugum';
    End Case;
    
    dbms_output.put_line(Mesaj || ', Yasim: ' || Yasi);   
End;

/

--*********************************************************************************************
-- Iterative Control Statements : Loops
-- (Tekrarlý ifadeler: Donguler)
--*********************************************************************************************
/*

  Basic Loop
  For Loop
  While Loop
  
*/

  -- ***** Basic Loop *****
/*
LOOP
    STATEMENT 1;
    STATEMENT 2;
    [if condition then
      Exit; Continue
    end if;]
    
    [Exit When Exit_Condition]
    [Continue When Continue_Condition]  
    
    STATEMENT N;
END LOOP;

*/
-- Basic Loop ile For Loop arasýndaki fark
-- Basic Loop'ta if kosulu koymak zorundayýz yoksa sonsuz donguye girer
-- For Loop'ta ise belirli bir sayac oldugu icin koymak zorunda degiliz


  -- ***** For Loop *****
/*
FOR loop_Counter IN
            [REVERSE] lower_limit... upper_limit
LOOP
    STATEMENT 1;
    STATEMENT 2;
    [if condition then
      Exit; Continue
    end if;]
    
    [Exit When Exit_Condition]
    [Continue When Continue_Condition]  
    
    STATEMENT N;
END LOOP;
*/  

  -- ***** While Loop *****

/*

WHILE Condition LOOP
    STATEMENT 1;
    STATEMENT 2;
    [if condition then
      Exit; Continue
    end if;]
    
    [Exit When Exit_Condition]
    [Continue When Continue_Condition]  
    
    STATEMENT N;
END LOOP;
*/   
  
  -- ***** Cursors *****  
/* BUNU AYRICA INCELEYECEGIZ */  
  
--*********************************************************************************************
-- Iterative Control Statements : Basic Loops
--*********************************************************************************************

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      dbms_output.put_line('Sayac : ' || Sayac);
      
        if Sayac = 5 then
            Exit;
        end if;        
    END LOOP;  
End;

/

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      dbms_output.put_line('Sayac : ' || Sayac);
      
    Exit When Sayac = 5;
    END LOOP;  
End;       

/

-- Tek sayýlarý yazdýran bir kod yazalým

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      
        if mod(Sayac,2) = 0 then
            Continue;
        -- Anlamý su; Eger Sayý cift sayý ise Loop'un basladýgý yere geri don ve devam et
        end if;        

      dbms_output.put_line('Sayac : ' || Sayac);

        if Sayac = 5 then
            Exit;
        end if; 
        
    END LOOP;  
End;

/
-- Yukarýdaki ornegi Continue When Continue_Condition ile yapalým

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;
      
        Continue When mod(Sayac,2) = 0;
        -- Anlamý su; Eger Sayý cift sayý ise Loop'un basladýgý yere geri don ve devam et        

      dbms_output.put_line('Sayac : ' || Sayac);

        if Sayac = 5 then
            Exit;
        end if;         
    END LOOP;  
End;
/
-- veya soyle yazalým

Declare
    Sayac integer;
Begin
    LOOP
      Sayac := NVL(Sayac,0) + 1;      
        Continue When mod(Sayac,2) = 0;
        -- Anlamý su; Eger Sayý cift sayý ise Loop'un basladýgý yere geri don ve devam et
      dbms_output.put_line('Sayac : ' || Sayac);

        Exit When Sayac = 5;        
    END LOOP;  
End;
/

-- BASIC LOOP ORNEGI
Create Table Kurslar
(
  Kurs_id         Number(3),
  Kurs_Adi        Varchar2(30),
  Egitmen_Adi     Varchar2(30),
  BaslangicTarihi Date,
  BitisTarihi     Date  
);

/

Declare
    Rec_Kurs  Kurslar%RowType;
Begin    
    Rec_Kurs.Egitmen_Adi := 'Ali TOPACIK';
    Rec_Kurs.BaslangicTarihi  := Trunc(SysDate); -- Ayin ilk gununu doner.
    Rec_Kurs.BitisTarihi  := Rec_Kurs.BaslangicTarihi + 5;

    LOOP
              Rec_Kurs.Kurs_id := NVL(Rec_Kurs.Kurs_id, 0) + 1;
              
              Select Decode(Rec_Kurs.Kurs_id,1,'Oracle SQL',
                                             2,'PL/SQL',
                                             3,'MS SQL',
                                             4,'TRANSACT SQL',
                                             5,'Google Big Query',
                                             6,'Power BI',
                                             7, 'Excel',
                                             8, 'Excel VBA',
                                             9, 'LOGO TIGER3 ENTERPRISE'
                           )
                into Rec_Kurs.Kurs_Adi
              From Dual;
          
          insert into Kurslar(Kurs_id, Kurs_Adi, Egitmen_Adi, BaslangicTarihi, BitisTarihi)
                 Values(Rec_Kurs.Kurs_id, Rec_Kurs.Kurs_Adi, Rec_Kurs.Egitmen_Adi, Rec_Kurs.BaslangicTarihi, Rec_Kurs.BitisTarihi);
      
          Rec_Kurs.BaslangicTarihi  := Rec_Kurs.BitisTarihi + 1;
          Rec_Kurs.BitisTarihi  := Rec_Kurs.BaslangicTarihi + 5;
          Exit When Rec_Kurs.Kurs_id = 9;        
        
    END LOOP;
    Commit;
End;
/

Select * From Kurslar;

/

-- sales_orders tablosunda 2007 yilindaki USA ulkesinin siparislerini bulan sorguyu yaziniz.
Select
    *
From sales_orders
Where To_Char(orderdate, 'YYYY') = 2007
And shipcountry = 'USA';


Select
    *
From sales_orders
Where To_Char(orderdate, 'YYYY') = 2007
And shipcountry = 'USA'
And empid in (1, 2, 4, 6, 9);

-- ORNEK: sales_orders tablosunda 2007 yilinda toplam freight degeri en yuksek olan, ilk 3 elemanin 2008 yili verilerini bulunuz.

Select
    *
From sales_orders
Where empid in (
            Select
                empid
            From
            (
                Select
                    empid,
                    sum(freight) as ToplamFreight
                From sales_orders
                Where To_Char(orderdate, 'YYYY') = 2007
                Group By empid
                Order By ToplamFreight desc
            )
            Where rownum <= 3
)
and To_Char(orderdate, 'YYYY') = 2008
Order By empid;