-- Fonksiyonlar

-- Say�sal Fonksiyonlar,
-- Karakter Fonksiyonlar,
-- Tekil Sonuc Fonksiyonlar�,
-- istatistik Fonksiyonlar,
-- Tarih ve Zaman Fonksiyonlar�

-- Say�sal Fonksiyonlar;

-- Sign : Bir ifadenin/de�erin/fonksiyonun i�aretini bulur
-- Abs  : Mutlak deger Fonksiyonu

-- Ceil   : Ald��� Say�sal degeri Yukar� tam say�ya cevirir
-- Floor  : Ald��� Say�sal degeri Asagi tam say�ya cevirir

-- Mod    : Moduler aritmetik, ozellikle bir say�n�n ciftmi tekmi olduguna bakar�z

-- Power  : ussel fonksiyon
-- SQRT   : Say�n�n karekokunu bulur
-- Round  : Yuvarlama fonksiyonu, ald��� say�sal degeri yuvarlar

-- Ornekler

Select Sign(-3), Sign(3) From Dual;

Select Salary, Sign(Salary) From EmployeesCopy;

Select Abs(-10), Abs(10), Abs(123.45),Abs(-123.45) From Dual;

Select Sign(-3) * 15 + 5 From Dual;

Select
    Sign(-3 * 15 + 5),
    Abs(-3 * 15 + 5),
    Abs(3 * 15 + 5),
    Sign(-3 * 15 + 5 -Abs(-3 * 15 + 5)),
    Sign(-3 * 15 + 5 -Abs(-3 * 15)),
    -3 * 15 + 5, -Abs(-3 * 15)
From Dual;

Select
    -3 * 15, -Abs(-3 * 15),
    Sign(-3 * 15 -Abs(-3 * 15)),
    Sign(-3 * 15 +Abs(-3 * 15))
From Dual;

Select
    3 * 15,
    Sign(3 * 15 +Abs(-3 * 15))
From Dual;

--


-- Ceil, Floor


Select Ceil(123.456), Ceil(-5.6) From Dual;
Select Ceil(123.006), Ceil(-5.6) From Dual;

Select Floor(123.456), Floor(-5.6) From Dual;
Select Floor(123.856), Floor(-5.6) From Dual;


-- Mod, Power, Sqrt
Select Mod(5,2) From Dual;
-- 5 say�s�n�n 2 ye bolumunden kalan� verir

Select Mod(100,9) From Dual;

-- 1 den 11 e kadar olan bir say� elde edelim
Select Level From Dual connect by Level < 12;

Select Level*-1 From Dual connect by Level < 12;

Select Level From Dual connect by Level < 12;

Select Level*-1 From Dual connect by Level < 12
Union
Select Level From Dual connect by Level < 12;

Select Level*-1 From Dual connect by Level < 12
Union
Select 0 From Dual
Union
Select Level From Dual connect by Level < 12;


------------------------------------------------------


Select
    Level,
    Mod(100, Level) -- 100 say�s�n�n Level'a bolumunden kalan say�y� verir
From Dual connect by Level < 12;

-- Power
Select Power(3,2) From Dual; -- 3 say�s�n�n karesini verir
Select Power(2,3) From Dual; -- 2 say�s�n�n kupunu verir
Select Power(3,4) From Dual; -- 3 say�s�n�n 4. kuvvetini verir

-- SQRT -- karekok verir

Select
      SQRT(25),
      SQRT(625),
      SQRT(100)
From Dual;

Select
      Power(3,4),
      SQRT(Power(3,4))
From Dual;

-- Round

Select
      Round(1234.456789),  -- 0 yaz�lmasada olabilir
      Round(1234.456789,0),
      Round(1234.56789,0),
      Round(1234.456789,1),
      Round(1234.456789,2),
      Round(1234.456789,3),
      Round(1234.456789,4),
      Round(1234.4599,5)
From Dual;

Select
      Round(1234.456789),  -- 0 yaz�lmasada olabilir
      Round(1234.456789,0),
      Round(1234.456789,-1),
      Round(1234.456789,-2),
      Round(1234.456789,-3)
From Dual;

Select
      Round(1234.56789),  -- 0 yaz�lmasada olabilir
      Round(1234.56789,0),
      Round(1234.56789,-1),
      Round(1234.56789,-2),
      Round(1234.56789,-3),
      Round(1234.56789,-4),
      Round(1234.56789,-5)
From Dual;

Select
      Round(5679.56789) Result_A,  -- 0 yaz�lmasada olabilir
      Round(5679.56789,0) Result_0,
      Round(5679.56789,-1) Result_1,
      Round(5679.56789,-2) Result_2,
      Round(5679.56789,-3) Result_3,
      Round(5679.56789,-4) Result_4,
      Round(5679.56789,-5) Result_5
From Dual;