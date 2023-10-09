Set autotrace ON;
Select shipcountry, shipcity
From Orders
Where shipcountry='USA'  and
      shipcity='Seattle' and
      To_Char(orderdate,'YYYY') = 2007;
-- TABLE ACCESS FULL| ORDERS |

 

Set autotrace ON;
Select * From Orders
Where shipcountry='USA'  and
      shipcity='Seattle' and
      To_Char(orderdate,'YYYY') = 2007;
-- TABLE ACCESS FULL| ORDERS
/
Create index ixord_ccy On Orders(shipcountry, shipcity,orderdate);
/
Set autotrace ON;
Select shipcountry, shipcity, To_Char(orderdate,'YYYY') From Orders
Where shipcountry='USA'  and
      shipcity='Seattle' and
      To_Char(orderdate,'YYYY') = '2007';
-- INDEX RANGE SCAN| IXORD_CCY
/
Set autotrace ON;
Select shipcountry, shipcity, freight From Orders
Where shipcountry='USA'  and
      shipcity='Seattle' and
      To_Char(orderdate,'YYYY') = '2007';
/*
|   0 | SELECT STATEMENT            |           |     1 |    44 |     3   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| ORDERS    |     1 |    44 |     3   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IXORD_CCY |     1 |       |     2   (0)| 00:00:01 |
*/
/
Create index ixord_cccy On Orders(shipcountry, shipcity,custid,orderdate);
/
Set autotrace ON;
Select shipcountry, shipcity, custid From Orders
Where shipcountry='USA'  and
      shipcity='Seattle' and
      To_Char(orderdate,'YYYY') = '2007';
-- INDEX RANGE SCAN| IXORD_CCCY
/
Set autotrace ON;
Select shipcountry, shipcity, custid From Orders
Where lower(shipcountry)='USA'  and
      lower(shipcity)='seattle' and
      To_Char(orderdate,'YYYY') = '2007';
-- INDEX FAST FULL SCAN| IXORD_CCCY
/
select * from index_stats;
-- ilk kullan?mda bos gelir
/
ANALYZE INDEX ixord_cccy VALIDATE STRUCTURE;

 

select * from index_stats;

 

SELECT
        name,
        height,
        lf_rows,
        del_lf_rows,
        (del_lf_rows/lf_rows)*100 as rebuild_orani
FROM INDEX_STATS;

 

/
-- Drop Table Datab;
Create Table DataB as
SELECT LOCATION_ID as id,
            STREET_ADDRESS as DISTRICT,
            POSTAL_CODE,
            CITY,
            STATE_PROVINCE as STATE,
            COUNTRY_ID
FROM hr.LOCATIONS ;
/
Select *
From DataB;
/
Set autotrace on;

 

Create index ixid on DataB(id);

 

Set autotrace on;
Select id
From DATAB;

 

Set autotrace on;
Select id
From DATAB
WHERE id = 2000;

 

Create index ixscd1 On DATAB(STATE,	CITY,	DISTRICT);

 

Set autotrace on;
Select STATE,	CITY,	DISTRICT, ID-- ADET, FIYAT, TUTAR
From DATAB
Where State='Washington' and City = 'Seattle';

 

create table testObj as select * from all_objects;

 

Set Timing on;
Set AutoTrace on;
Select Count(*) From TestObj;

 

Set Timing on;
Set AutoTrace on;
Select * From TestObj;

 

Select * From index_stats;
Analyze index ixscd1 Validate structure;

 

-- SYS ile baglanal?m
-- Diger kullan?c?lar icin baglanal?m

 

Select * From index_stats;
Analyze index ixscd1 Validate structure;

 

Select * From sys.all_indexes;

 

Select * From sys.all_indexes
Where TABLE_NAME = 'EMPLOYEES'

 

Select * From all_indexes
Where TABLE_NAME = 'EMPLOYEES'

 

Select * From sys.all_indexes
Order By Owner;

 

Select *
From sys.all_indexes
Where owner = 'ALI1' and TABLE_NAME = 'EMPLOYEES'
Order By Owner;
/

 

Select *
From sys.all_ind_columns
Where INDEX_OWNER = 'ALI1' and TABLE_NAME = 'EMPLOYEES'
Order By INDEX_OWNER;

 

-- Query
-- A. Tables accessible to the current user

 

select ind.index_name,
       ind_col.column_name,
       ind.index_type,
       ind.uniqueness,
       ind.table_owner as schema_name,
       ind.table_name as object_name,
       ind.table_type as object_type       
from sys.all_indexes ind
inner join sys.all_ind_columns ind_col on ind.owner = ind_col.index_owner
                                    and ind.index_name = ind_col.index_name
-- excluding some Oracle maintained schemas
where ind.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS', 
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN', 
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 'WKSYS',
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC')
order by ind.table_owner,
         ind.table_name,
         ind.index_name,
         ind_col.column_position;
-- Yukar?daki sorguyu view haline getirelim
Create view vw_indexbilgileri as
select ind.index_name,
       ind_col.column_name,
       ind.index_type,
       ind.uniqueness,
       ind.table_owner as schema_name,
       ind.table_name as object_name,
       ind.table_type as object_type       
from sys.all_indexes ind
inner join sys.all_ind_columns ind_col on ind.owner = ind_col.index_owner
                                    and ind.index_name = ind_col.index_name
-- excluding some Oracle maintained schemas
where ind.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS', 
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN', 
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 'WKSYS',
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC')
order by ind.table_owner,
         ind.table_name,
         ind.index_name,
         ind_col.column_position;
/     

 

Select *
From vw_indexbilgileri
Where schema_name = 'HR';

 

-- B. If you have privilege on dba_indexes and dba_ind_columns

 

select ind.index_name,
       ind_col.column_name,
       ind.index_type,
       ind.uniqueness,
       ind.table_owner as schema_name,
       ind.table_name as object_name,
       ind.table_type as object_type       
from sys.dba_indexes ind
inner join sys.dba_ind_columns ind_col on ind.owner = ind_col.index_owner
                                    and ind.index_name = ind_col.index_name
-- excluding some Oracle maintained schemas
where ind.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS',
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN',
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 'WKSYS',
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC')
order by ind.table_owner,
         ind.table_name,
         ind.index_name,
         ind_col.column_position;

/*
Columns

 

  index_name - index name
  column_name - column name
  index_type - index type
  uniqueness - column indicating whether the index is unique or not
  schema_name - indexed object's owner, schema name
  object_name - indexed object's name
  object_type - indexed object's type

 

Rows

 

  One row represents one column of an index in a database
  Scope of rows:  (A) all indexes on objects accessible to the current user in Oracle database,
                  (B) all indexes on objects in Oracle database

  Ordered by schema name, object name, index name, index column sequence number
*/

 

/*
  1 ) Indeksler view’larda kullan?labilir mi?
      Bu sorunun cevab? asl?nda çokta zor de?il.
      View , bir sorgu cümleci?inden ibarettir.
      Tablonuzda indeks olu?turduysan?z ve view olu?tururken kulland???n?z sorguda
      indeksi kullanmas?n? sa?lad?ysan?z view indeks kullan?r aksi halde kullanamaz

  2) Indeksler ve NULL : Bitmap indeksler ile clustered indexler hariç 
     B*Tree yap?s?ndaki indeksler NULL bar?nd?rmazlar.
     Bunu ?öyle ispat etmek mümkün
*/
create table t2 (x int, str varchar2(15));
/
create unique index idx_t2 on t2(x);
/
Declare
Begin
             insert into t2 values(1,'bir');
             insert into t2 values(2,'iki');
             insert into t2 values(3,'uc');
             insert into t2 values(null,'bos');
             commit;
End;               
/
Declare
    sqlStr varchar2(500);
Begin
             sqlStr := 'analyze index idx_t2 validate structure';
             execute immediate sqlStr;
End;    
/
select * from index_stats;
/

 

select name, lf_rows from index_stats;
/
/*
  NAME               LF_ROWS
  IDX_T2            3

 

  Görüldü?ü üzere T2 tablosunun (x) kolonuna unique indeks uygulad?k,
  4 sat?r ekledik ama kontrol etti?imizde 4 de?il 3 sat?r?n indeksli oldugunu gördük.
  (x) kolonu NULL de?eri ald??? için indekslenmemi?tir.

 

  Yine T2 tablosundan “x” kolonu için sorgu yapal?m :
*/
Set AutoTrace On;
select * from t2 where x = 1;     -- sorgusunda “index unique scan” ile 1 satir gelirken

 

Set AutoTrace On;
select * from t2 where x is null; --  sorgusunda “table Access full” ile 1 satir gelmi?tir.
/*
Yani indeks olu?turdu?umuz “x” kolonu için NULL sorgusu yapt?g?m?zda indeks kullan?lmam??t?r.
Bunun sebebi yukar?da da de?indi?imiz indekslerin NULL de?er içermemesidir.

 

2 ya da daha fazla kolon üzerinde indeks olu?turdugumuz durumlarda da kolonlardan en az birinin NOT NULL olup de?er içermesi gerekir ki indeks kullan?labilsin.NOT :  Özellikle unique indeks olu?turmak istedi?imizde “NOT NULL” k?s?t? koymak indeksi verimli kullanmam?z? sa?layacakt?r.Parent tablonun primary key alan?nda yap?lacak bir update ya da parent tablodan bir sat?r?n silinmesi child tabloda bir “table lock” olu?mas?na neden olacakt?r.Bu durumda da child tablo üzerinde hiç bir ?ekilde DML i?lemi yap?lmas?na izin verilmeyecektir.Bu da “deadlock” probleminin olu?mas?na davetiye ç?kar?r.Indekslenmemi? foreign key’ler a?a??daki durumlarda da probleme yol açar :

 

3) Indeksler ve Foreign key : Foreign key’in indekslenip indekslenmemesi konusu asl?nda 
   tamamen tasar?m?n?z ile ilgilidir.
   Foreign key indekslenmedi?inde bizleri bekleyen en büyük problem belkide “deadlock” olu?mas?d?r.
   Peki bu nas?l olur?Bunu anlamak için önce ?u bilgileri tekrar edelim :“child table” foreign key bar?nd?ran tablodur, “parent table” ise  foreign key’in gösterdi?i alan?n bulundugu tablodur.

 

i) Child tablo da “ON DELETE CASCADE” özelli?i olsun ve foreign key’de indeks bulunmas?n.Bu durumda parent tabloda bir verinin silinmesi durumunda child tabloda bir “full table scan” yap?lmas?na sebeb olunur.

 

ii) Parent tablodan child tabloya dogru olan sorgularda.EMP / DEPT örne?i verilebilir.EMP child table, DEPT ise parent tablodur ve örnegin depname = ‘XXX’ olan çal??anlar? getir gibi bir sorguda s?k?nt? ya?ayabilirsiniz :
     Select * from emp, dept
     where emp.deptno = dept.deptno
     and dept.depname = ‘XXX’Peki tersi durumlar, yani foreign key de?erinin indekslenmesine gerek olmayan durumlar neler olabilir ? :
    a) Parent tablodan bir veri silinmeyece?inde
    b) Parent tablonun primary/unique key de?eri update edilmeyece?inde
    c) Parent tablo ile child tablo foreign key de?eri üzerinden sorgulanmayaca??nda.
       Bu ?artlarda foreign key indeklemeye gerek yoktur bu sayede DML i?lemlerimizde
       gereksiz yere indekslenmeden dolay? bir yava?lamaya sebeb olmayacakt?r. 
*/       

 

 

Explain Plan for Select * From OracleDataA.Sales_Orders Where shipcountry = 'USA' and shipcity = 'Seattle';
/
Select * From Table(dbms_xplan.display);

 

Select * From all_indexes Where Table_Name='DATAB2';

 

 

Set AutoTrace ON;
Select * From OracleDataA.Sales_Orders Where shipcountry = 'USA' and shipcity = 'Seattle';
/
Select * From Table(dbms_xplan.display);

 

/

 

Explain Plan for Select * From OracleDataA.Sales_Orders;
/
Select * From Table(dbms_xplan.display);

 

 

--************************************************************************************************************
-- Index Ornekleri
--************************************************************************************************************

 

create table SalesIndex
(
  id int,
  order_id int,
  product_code varchar2(3),
  amount int,
  Date_of_sale date
);
/

 

-- Select DBMS_RANDOM.VALUE(Min_Value,Max_Value) From Dual;
Select DBMS_RANDOM.VALUE(1,2) From Dual; -- 1 ile 2 aras? deger uretir
Select DBMS_RANDOM.VALUE(3,9) From Dual; -- 3 ile 9 aras? deger uretir

 

/

 

INSERT INTO SalesIndex
    Select
        rownum,
        FLOOR(DBMS_RANDOM.VALUE(90,9000)),
        DBMS_RANDOM.STRING('U',3),
        FLOOR(DBMS_RANDOM.VALUE(90,9000)),
        TRUNC(SYSDATE)-FLOOR(DBMS_RANDOM.VALUE(10,900))
    From DUAL
        CONNECT BY LEVEL <=100000;
-- Yukaridaki kod ile 1 den baslayarak 100.000 Kay?t ekler
/

 

 

SELECT Count(*) FROM SalesIndex;

 

INSERT INTO SalesIndex
    Select
        rownum + 100000,
        FLOOR(DBMS_RANDOM.VALUE(90,9000)),
        DBMS_RANDOM.STRING('U',3),
        FLOOR(DBMS_RANDOM.VALUE(90,9000)),
        TRUNC(SYSDATE)-FLOOR(DBMS_RANDOM.VALUE(10,900))
    From DUAL
        CONNECT BY LEVEL <=200000;
-- Yukaridaki kod ile 100.001 den baslayarak 200.000 Kay?t ekler

 

/

 

INSERT INTO SalesIndex
    Select
        rownum + 300000,
        FLOOR(DBMS_RANDOM.VALUE(90,9000)),
        DBMS_RANDOM.STRING('U',3),
        FLOOR(DBMS_RANDOM.VALUE(90,9000)),
        TRUNC(SYSDATE)-FLOOR(DBMS_RANDOM.VALUE(10,900))
    From DUAL
        CONNECT BY LEVEL <=99;
-- Yukaridaki kod ile 300.001 den baslayarak 99 Kay?t ekler
SELECT * FROM SalesIndex WHERE ID >=300000 ;

 

EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1 ;
/
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/

 

create unique index idx_sales_id on SalesIndex(id);
/
analyze index idx_sales_id validate structure;
/
EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1 ;
/
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/
select * from user_segments; --where segment_name= 'IDX_SALES_ID';

 

EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1000 ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

--USABLE AND NONUSABLE INDEX
ALTER INDEX idx_sales_id UNUSABLE;
EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1000 ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
select * from user_segments where segment_name='IDX_SALES_ID'

 

ALTER INDEX idx_sales_id REBUILD;
select * from user_segments where segment_name='IDX_SALES_ID';
EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1000 ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

-- Visible and invisible index
ALTER INDEX idx_sales_id invisible;
Select * from user_segments where segment_name='IDX_SALES_ID';
EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1000 ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

ALTER INDEX idx_sales_id visible;
EXPLAIN PLAN FOR SELECT * FROM SalesIndex WHERE ID=1000 ;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

-- **********************************************************************************************
-- Bir ornek üzerinde devam edelim
-- **********************************************************************************************

 

 

Select * From all_objects;
SELECT * FROM ALL_INDEXES;

 

-- Drop Table index_demo;
Create Table index_demo as 
Select * From all_objects;

 

Select * From all_objects;
Select * From index_demo;
SELECT * FROM ALL_INDEXES;

 

Select Count(*) From all_objects;
Select Count(*) From index_demo;
SELECT Count(*) FROM ALL_INDEXES;

 

SELECT * FROM ALL_INDEXES WHERE TABLE_NAME='INDEX_DEMO';

 

EXPLAIN PLAN FOR
  SELECT * FROM index_demo WHERE OBJECT_NAME='DUAL';

 

SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

 

Alter Table index_demo add constraint PK_INDEX_DEMO primary key(OWNER,OBJECT_NAME,OBJECT_TYPE,OBJECT_ID);

 

SELECT * FROM ALL_INDEXES WHERE TABLE_NAME='INDEX_DEMO';

 

Select * From index_demo;
Create Unique index idx_object_id on index_demo(OBJECT_ID);
SELECT * FROM ALL_INDEXES WHERE TABLE_NAME='INDEX_DEMO';

 

SELECT * FROM index_demo WHERE OBJECT_NAME='DUAL';
SELECT Owner, OBJECT_NAME, Object_Type
FROM index_demo
WHERE OBJECT_NAME='DUAL';

 

EXPLAIN PLAN FOR
  SELECT * FROM index_demo WHERE OBJECT_NAME='DUAL';

 

SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR SELECT * FROM index_demo WHERE OBJECT_NAME='DUAL' AND OWNER='SYS';
SELECT * FROM TABLE (DBMS_XPLAN.DISPLAY);

 

--OWNER,OBJECT_NAME,OBJECT_TYPE,OBJECT_ID
--OWNER,OBJECT_NAME,OBJECT_TYPE
--OWNER,OBJECT_NAME
--OWNER

 

-- Drop table trans_demo;
create table trans_demo
(
  id int,
  salary int,
  dept_no int
);
/

 

insert into trans_demo
select rownum,trunc(DBMS_RANDOM.VALUE(100,9000)),trunc(DBMS_RANDOM.VALUE(1,10)) FROM DUAL
CONNECT BY LEVEL <=100000;
/

 

EXPLAIN PLAN FOR select * from trans_demo where id =10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

CREATE UNIQUE INDEX IDX_tran_demo ON trans_demo(ID);

 

EXPLAIN PLAN FOR select * from trans_demo where id =10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select * from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select count(1) from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select * from trans_demo where id =1000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

 

-- * ile tum kolonlar? Select edelim
EXPLAIN PLAN FOR
    SELECT *          
    FROM index_demo
    ORDER BY OBJECT_TYPE;

 

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

-- * ile tum kolonlar? Select etmek fazla veri trafigi olusturur, ihtiyac olan kolonlar? sadece cekmeliyiz
-- Ayr?ca index yukar?daki ornekte devreye girmedi

 

EXPLAIN PLAN FOR
    SELECT OWNER,OBJECT_NAME,OBJECT_ID,OBJECT_TYPE
    FROM index_demo
    ORDER BY OBJECT_TYPE;

 

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- Yukar?daki ornekte index devreye girdi ve
-- belirli kolonlar Select edildigi icin maliyet kazanc saglad?k

 

EXPLAIN PLAN FOR
    SELECT OWNER,OBJECT_NAME,OBJECT_ID,OBJECT_TYPE
    FROM index_demo;
    --ORDER BY OBJECT_TYPE
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

-- indexte yer almayan bir kolonuda Select edelim ve Execution Plan? gorelim
EXPLAIN PLAN FOR
SELECT OWNER, OBJECT_NAME, OBJECT_ID, OBJECT_TYPE, data_object_id
FROM index_demo;
-- ORDER BY OBJECT_TYPE
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- Goruldugu gibi index devreye girmedi
-- ve Table Access Full yapt?

 

EXPLAIN PLAN FOR
SELECT OWNER,OBJECT_NAME,OBJECT_ID,OBJECT_TYPE
FROM index_demo
ORDER BY OWNER; I
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR
SELECT OWNER,OBJECT_NAME,OBJECT_ID,OBJECT_TYPE
FROM index_demo
ORDER BY OBJECT_ID;

 

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR
SELECT OWNER,OBJECT_NAME,OBJECT_ID
FROM index_demo
ORDER BY OBJECT_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR
SELECT OWNER,OBJECT_NAME
FROM index_demo
ORDER BY OBJECT_ID;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR
    Select * From trans_demo Where id=1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select count(1) from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select count(*) from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

/*
EXPLAIN PLAN FOR SELECT * FROM Customer_details_idx WHERE CUSTOMER_ID=1 AND REGION = 'AP';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

SELECT * FROM customer_details_idx WHERE CUSTOMER_ID=1 AND REGION ='AP'
UNION
SELECT * FROM customer_details_idx WHERE CUSTOMER_ID=1 AND REGION ='EMEA'
*/

 

drop table trans_demo cascade constraints;
-- tablomuzu droplayal?m ve id icin not null ekleyelim
-- unique indexler null degeri indexe dahil eder
-- dolay?s?yla not null diyelim
-- ve insert islemleri dahil hepsini yeniden yapal?m

 

create table trans_demo
(
    id int not null,
    salary int,
    dept_no int
);

 

insert into trans_demo
select rownum,trunc(DBMS_RANDOM.VALUE(100,9000)),trunc(DBMS_RANDOM.VALUE(1,10)) FROM DUAL
CONNECT BY LEVEL <=100000;
/
CREATE UNIQUE INDEX IDX_tran_demo ON trans_demo(ID);

 

EXPLAIN PLAN FOR select * from trans_demo where id =10;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select count(1) from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select * from trans_demo where id =1000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select count(1) from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

--drop table trans_demo cascade constraints;

 

EXPLAIN PLAN FOR
select * from trans_demo where id=1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

EXPLAIN PLAN FOR select count(1) from trans_demo;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

-- ******************************************************************************
-- indexlere su ac?danda ornekle verelim
/*
Oracle - Indexler Hakk?nda detayl? bilgi 
Yap?lan bir sorguda istedi?imiz ko?ullardaki verileri en k?sa zamanda elde etmek isteriz.Bunu sa?laman?n yollar?na “Access path”  ad? veriliyor.
Bunlar?n ba??nda da belki de en çok bilineni ve genellikle de en etkili olan? indekslerdir.
Oracle’?n her yeni sürümünde farkl? indeks yap?lar? ile kar??la?mak mümkün.
Mesela bitmap indeksler ile fonksiyon bazl?(function-based index) indeksler örnek olarak söylenebilir.
Burada bu konulara girilmeyecek s?k kullan?lan indekslerin “genel” özelliklerinden k?saca bahsedilecektir.

 

NOT : Indeksler sorgularda genellikle kurtar?c? ya da en etklili yol olarak bilinse de uygun kullan?lmad?klar?nda hepimizin gözünü korkutan –ki  her zaman böyle de?ildir- tüm tablonun taranmas?(Full Table Scan) i?leminden daha çok zaman ald??? durumlar olabilmektedir.

 

?imdi k?saca indekslere bir göz atal?m : Indeks kullan?m?n? anlamak için önce B*Tree yap?s? hakk?nda bilgi sahibi olmakta fayda var.

 

btreeB*Tree yap?s?nda 3 farkl? seviyeden bahsedilir.
  Bunlar?n ilki en tepede duran “Root”’tur.
  En altta da “leaf” denilen seviye ve 
  bu ikisi aras?nda da “branch” (lar) bulunur.

  Örne?in “root” de?erimiz 50 olsun.
    Bundan küçükleri sola,  büyükleri sa?a,
    branch tada boyle bir ayr?m yapt?g?mz? dü?ünerek yeniden bir dallanma gerçekle?tirdi?imizde (leaf) , 
    kabaca bir B Tree olu?turmu? oluruz.
    (Bu yap?n?n etkili kullan?m? için dengeli bir yap?da tutulmas? gerekmektedir.
    Yani veriler bir tarafa dogru y???lma yapmamal?d?r.)
    En etkili avantaj? a?aç üzerinde milyonlarca kay?t olsa bile 
    en fazla 2 ya da 3 I/O ile bir kayda ula?man?n mümkün olmas?d?r.
    (Dezavantaj ise bir dü?ümün silinmesi ya da de?i?tirilmesi durumunda 
    a?ac?n yeniden organize edilmesi ihtiyac?n?n olmas?d?r.)

    Örne?in T tablomuzda “id” kolonu üzerinde “index” oldugunu varsayarsak indeks olu?turmak için a?a??daki gibi yazabiliriz :

 

    Oracle ac?s?ndan bu a?ac?n önemine gelecek olursak , 
    Oracle indeks yap?s?n?  bu a?aç yap?s? üzerine oturtmu?tur.
    Yani bir kolon üzerinde bir indeks olu?turdu?unuzda bu indeks (kolon de?eri) ve 
    o verinin bulundugu sat?r bilgisi(rowid) bu a?açta uygun yere yerle?tirilir.
    (ROWID,verinin fiziksel adresidir).
    Leaf seviyesinde ya tek bir de?er olur ya da bir de?er aral??? bilgisi bulunur.
    Ama hepsi s?ral?d?r. Leaf seviyeler birbirine linkli liste mant???na göre ba?l?d?r.
*/


 

CREATE INDEX t_id_idx ON t(id);

 

--Peki bu a?amada neler ya?an?r? “id” kolonunun de?erleri artan s?rada dizilir.Degeri ve tablodaki sat?r adresi(rowid) bilgisi saklan?r, bu ?ekilde indeksimiz olu?turulmu? olur.A?a??daki sorguya bakal?m :

 

select * from T where id = 12345;

 

--sorgusunda normal ?artlarda indeks tarama (index scan) yap?l?r, önce “id” de?eri indeksten bulunur ve sat?r?n?n rowid bilgisine ula??l?r ve rowid bilgisi ile tabloya nokta at??? yap?larak veriler getirilir. “….where id between 200 and 300…” gibi bir sorguda “leaf” ler üzerinde gezilerek aral?k (range) bilgisine ula??l?r.B Tree indeks yap?s?nda tekil(unique) olmayan bir indeks de?eri yoktur.

 

--NOT : indeks tekil (unique) bir indeks ise tekillik sa?lamak sorun olmaz ama e?er indeks tekil de?ilse bu tekillik Oracle taraf?ndan indeks de?eri yan?na rowid bilgisi eklenerek sa?lan?r.Tekil durumunda indekse gore bir s?ra olu?turulur, tekil de?il ise bu s?ralama 2 de?ere göre birden yap?l?r.

 

--K?saca indeksler bu ?ekilde.Ama bunun yan?nda “index-Unique Scan, Index-Range Scan, Index-Skip Scan, Index-Full ScanIndex-Fast Full  Scan , Index Join, Index Rebuild” konular?na bakman?z? tavsiye ederim.


 

--1 ) Indeksler view’larda kullan?labilir mi? Bu sorunun cevab? asl?nda çokta zor de?il.View , bir sorgu cümleci?inden ibarettir.Tablonuzda indeks olu?turduysan?z ve view olu?tururken kulland???n?z sorguda indeksi kullanmas?n? sa?lad?ysan?z view indeks kullan?r aksi halde kullanamaz.

 

--2) Indeksler ve NULL : Bitmap indeksler ile clustered indexler hariç B*Tree yap?s?ndaki indeksler NULL bar?nd?rmazlar.Bunu ?öyle ispat etmek mümkün :
Drop table t2;
create table t2 (x int, str varchar2(15));
create unique index idx_t2 on t2(x);

 

declare
begin
             insert into t2 values(1,'bir');
             insert into t2 values(2,'iki');
             insert into t2 values(3,'uc');
             insert into t2 values(null,'bos');
             commit;
end;               

 

--

 

--
declare
sqlStr varchar2(500);
begin
             sqlStr := 'analyze index idx_t2 validate structure';
             execute immediate sqlStr;
end;    

 

Set ServerOutPut ON;
Set AutoTrace ON;
select name, lf_rows from index_stats;

 

EXPLAIN PLAN FOR 
  select name, lf_rows from index_stats;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

--NAME               LF_ROWS
--IDX_T2            3

 

--Görüldü?ü üzere T2 tablosunun (x) kolonuna unique indeks uygulad?k, 4 sat?r ekledik ama kontrol etti?imizde 4 de?il 3 sat?r?n indeksli oldugunu gördük.(x) kolonu NULL de?eri ald??? için indekslenmemi?tir.

 

--Yine T2 tablosundan “x” kolonu için sorgu yapal?m :

 

select * from t2 where x = 1;     -- sorgusunda “index unique scan” ile 1 satir gelirken

 

EXPLAIN PLAN FOR 
  select * from t2 where x = 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

select * from t2 where x is null; -- sorgusunda “table Access full” ile 1 satir gelmi?tir.Yani indeks olu?turdu?umuz “x” kolonu için NULL sorgusu yapt?g?m?zda indeks kullan?lmam??t?r.Bunun sebebi yukar?da da de?indi?imiz indekslerin NULL de?er içermemesidir.
EXPLAIN PLAN FOR 
  select * from t2 where x is null;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

 

--2 ya da daha fazla kolon üzerinde indeks olu?turdugumuz durumlarda da kolonlardan en az birinin NOT NULL olup de?er içermesi gerekir ki indeks kullan?labilsin.NOT :  Özellikle unique indeks olu?turmak istedi?imizde “NOT NULL” k?s?t? koymak indeksi verimli kullanmam?z? sa?layacakt?r.Parent tablonun primary key alan?nda yap?lacak bir update ya da parent tablodan bir sat?r?n silinmesi child tabloda bir “table lock” olu?mas?na neden olacakt?r.Bu durumda da child tablo üzerinde hiç bir ?ekilde DML i?lemi yap?lmas?na izin verilmeyecektir.Bu da “deadlock” probleminin olu?mas?na davetiye ç?kar?r.Indekslenmemi? foreign key’ler a?a??daki durumlarda da probleme yol açar :


 

--3) Indeksler ve Foreign key : Foreign key’in indekslenip indekslenmemesi konusu asl?nda tamamen tasar?m?n?z ile ilgilidir.Foreign key indekslenmedi?inde bizleri bekleyen en büyük problem belkide “deadlock” olu?mas?d?r.Peki bu nas?l olur?Bunu anlamak için önce ?u bilgileri tekrar edelim :“child table” foreign key bar?nd?ran tablodur, “parent table” ise  foreign key’in gösterdi?i alan?n bulundugu tablodur.

 

 

--i) Child tablo da “ON DELETE CASCADE” özelli?i olsun ve foreign key’de indeks bulunmas?n.Bu durumda parent tabloda bir verinin silinmesi durumunda child tabloda bir “full table scan” yap?lmas?na sebeb olunur.

 

--ii) Parent tablodan child tabloya dogru olan sorgularda.EMP / DEPT örne?i verilebilir.EMP child table, DEPT ise parent tablodur ve örnegin depname = ‘XXX’ olan çal??anlar? getir gibi bir sorguda s?k?nt? ya?ayabilirsiniz :

     Select * from emp, dept
     where emp.deptno = dept.deptno
     and dept.depname = 'XXX'; -- Peki tersi durumlar, yani foreign key de?erinin indekslenmesine gerek olmayan durumlar neler olabilir ? :
    -- a) Parent tablodan bir veri silinmeyece?inde
    -- b) Parent tablonun primary/unique key de?eri update edilmeyece?inde
    -- c) Parent tablo ile child tablo foreign key de?eri üzerinden sorgulanmayaca??nda.Bu ?artlarda foreign key indeklemeye gerek yoktur bu sayede DML i?lemlerimizde gereksiz yere indekslenmeden dolay? bir yava?lamaya sebeb olmayacakt?r.

 

 

-- *******************************************************************************