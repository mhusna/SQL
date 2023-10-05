-- FONKSIYONLAR --
/*
    -- FONKSIYON SYNTAX --

    Create or replace Function FonksiyonAdi(Parametre ParametreTipi)
    Return DonusTipi
    is
    DegiskenIsmi DegiskenTipi --> OPSIYONEL
    Begin
        Return(DonecekBilgi);
    End;
*/

-- ORNEK: Date tipinde parametre alan ve geriye ay bilgisini donen fonksiyonu yaziniz.
Create or replace Function fnc_getMonth(P_Date Date)
Return Varchar2
is
MonthName Varchar2(15);
Begin
    MonthName := To_Char(sysdate, 'Month');
    Return(MonthName);
End;

/

-- Olusturulan fonksiyonu cagirma.
Select 
    Sysdate,
    fnc_getMonth(Sysdate)
From Dual;