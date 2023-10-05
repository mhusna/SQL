-- Output ekraninda cikti gormek icin yaziyoruz.
Set SERVEROUTPUT ON;

-- Tek tirnak kullanarak yaz, cift tirnakta hata veriyor.
Begin
    dbms_output.put_line('Merhabalar, PLSQL ogreniyoruz.');
End;

/

-- ORNEK: Declare ile degisken tanimlayarak mesaj yazdirma.
Declare
    Message Varchar2(100);
Begin
    Message := 'Merhabalar, PLSQL ogreniyoruz';
End;

/

-- ORNEK: Ekrana gun bilgisini yazdiralim.
Begin
    dbms_output.put_line('Bugun: ' || To_Char(sysdate, 'Day'));
End;

/

-- ORNEK: Ekrana gun bilgisini degisken kullanarak yazdirin.
Declare
    Gun Varchar2(20);
Begin
    Gun := To_Char(sysdate, 'Day');
    dbms_output.put_line('Bugun: ' || Gun);
End;    

/

-- ORNEK: Ekrana gun ve ay bilgisini degisken kullanarak yazdirin.
Declare
    Gun Varchar2(10);
    Ay Varchar2(10);
Begin
    Gun := To_Char(sysdate, 'Day');
    Ay := To_Char(sysdate, 'Month');
    
    dbms_output.put_line('Ay: ' || Ay || ' - Gun: ' || Gun);
End;

/