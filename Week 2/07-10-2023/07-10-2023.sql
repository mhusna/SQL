-- Exist

-- sales_customers tablosunda olup siparisi olmayan musterilerin bilgilerini bulunuz.
-- in ile 
Select
    *
From sales_customers c
Where custid not in (
                        Select Distinct
                            custid
                        From sales_orders o
                        Where o.custid = c.custid
                    );

-- Exist ile cozelim.
Select
    *
From sales_customers c
Where Not Exists(
                Select
                    custid
                From sales_orders o
                Where o.custid = c.custid
                );
                
-- Exists in'den daha guclu bir yapiya sahiptir.
-- Siparisi olan musteriler icin Exists yapisi kullanmaliyiz.

-- ORNEK: Ispanya'da siparisi olan musterilerin custid, companyName, country bilgilerini getiriniz.
-- Tables: sales_customers, sales_orders
Select
    custid,
    companyname,
    country
From sales_customers sc
Where Exists(
                Select
                    *
                From sales_orders so 
                Where so.custid = sc.custid
            )
And sc.country = 'Spain';

/
-- Tekrar eden kayitlar var mi ona baktik.
Select
      Rowid,
      custid      
From Sales_Customers
Where Rowid not in (
                      Select Max(Rowid)
                      From Sales_Customers
                      Group By custid                      
                    );
/         
-- Tekrar eden kayitlari sildik.
Delete From Sales_Customers
Where Rowid not in (
                      Select Max(Rowid)
                      From Sales_Customers
                      Group By custid                      
                    );
                    
/

-- ORNEK: Rehber Uygulamasi.
-- Developer - Defined Records + Nested Records (Bunlar? bir arada kullanarak yapal?m)
Declare
    Type r_kisi IS RECORD(
                            ad employees.first_name%TYPE,
                            soyad employees.last_name%TYPE
                        );
    Type contact IS RECORD(
                            kisi r_kisi, -- Bu tanimlamaya nested record denir.
                            telefon employees.phone_number%TYPE
                          );
    rehber contact;
Begin
    rehber.kisi.ad := 'Ali';
    rehber.kisi.soyad := 'TOPACIK';
    rehber.telefon := '0555 998 88 76';
    
    dbms_output.put_line('Ad: ' || rehber.kisi.ad ||
                         '  Soyad: ' || rehber.kisi.soyad ||
                         '  Telefon: ' || rehber.telefon);
End;

/
-- Yukaridaki uygulamayi biraz daha gelistirelim.
-- Developer - Defined Records + Nested Records + Array seklinde gelistirelim.
Declare
    Type r_kisi IS RECORD(
                            ad employees.first_name%TYPE,
                            soyad employees.last_name%TYPE
                        );
    Type contact IS RECORD(
                            kisi r_kisi, -- Bu tanimlamaya nested record denir.
                            telefon employees.phone_number%TYPE
                          );
    Type dizi IS TABLE OF contact; -- Nested Table Data Types with Record
    
    rehber dizi := dizi();
    j Number := 1;
Begin

    rehber.Extend;
    rehber(j).kisi.ad:= 'Ali';
    rehber(j).kisi.soyad:= 'TOPACIK';
    rehber(j).telefon:= '0555 998 88 76';

    dbms_output.put_line('Adi    : ' || rehber(j).kisi.ad);
    dbms_output.put_line('Soyadi : ' || rehber(j).kisi.soyad);
    dbms_output.put_line('Telefon: ' || rehber(j).telefon);
    
    rehber.Extend;
    j:=j+1;
    rehber(j).kisi.ad:= 'Ali-USA';
    rehber(j).kisi.soyad:= 'TOPACIK-USA';
    rehber(j).telefon:= '00 1 555 998 88 76';


    dbms_output.put_line('Adi    : ' || rehber(j).kisi.ad);
    dbms_output.put_line('Soyadi : ' || rehber(j).kisi.soyad);
    dbms_output.put_line('Telefon: ' || rehber(j).telefon);
End;

/

-- Yukaridaki ornegi dongu ile yapalim.
Declare
    Type r_kisi IS RECORD(
                            ad employees.first_name%TYPE,
                            soyad employees.last_name%TYPE
                        );
    Type contact IS RECORD(
                            kisi r_kisi, -- Bu tanimlamaya nested record denir.
                            telefon employees.phone_number%TYPE
                          );
    Type dizi IS TABLE OF contact; -- Nested Table Data Types with Record
    
    rehber dizi := dizi();
    j Number := 0;
Begin
    
    For i IN (Select first_name, last_name, phone_number From Employees Where department_id = 100)
    Loop
        j := j+1;
        
        rehber.Extend;
        rehber(j).kisi.ad:= i.first_name;
        rehber(j).kisi.soyad:= i.last_name;
        rehber(j).telefon:= i.phone_number;
    End Loop;
    
    j := rehber.First;
    While j is not null
    Loop
        dbms_output.put_line('Adi    : ' || rehber(j).kisi.ad);
        dbms_output.put_line('Soyadi : ' || rehber(j).kisi.soyad);
        dbms_output.put_line('Telefon: ' || rehber(j).telefon);
        dbms_output.put_line('********************************************'); 
        j := rehber.Next(j);
    End Loop;
End;

/