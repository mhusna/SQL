--------------------------------------------------------
--  File created - Pazar-Mayýs-14-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CITYJOIN
--------------------------------------------------------

  CREATE TABLE "CITYJOIN" 
   (	"CITYID" NUMBER, 
	"CITYNAME" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into CITYJOIN
SET DEFINE OFF;
Insert into CITYJOIN (CITYID,CITYNAME) values ('1','Kansas City');
Insert into CITYJOIN (CITYID,CITYNAME) values ('2','Newyork');
Insert into CITYJOIN (CITYID,CITYNAME) values ('3','Houston');
