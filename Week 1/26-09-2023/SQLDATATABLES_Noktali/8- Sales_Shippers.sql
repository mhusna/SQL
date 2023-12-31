--------------------------------------------------------
--  File created - Pazar-May�s-14-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table SALES_SHIPPERS
--------------------------------------------------------

  CREATE TABLE "SALES_SHIPPERS" 
   (	"SHIPPERID" NUMBER(*,0), 
	"COMPANYNAME" NVARCHAR2(40), 
	"PHONE" NVARCHAR2(24)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into SALES_SHIPPERS
SET DEFINE OFF;
Insert into SALES_SHIPPERS (SHIPPERID,COMPANYNAME,PHONE) values ('1','Shipper GVSUA','(503) 555-0137');
Insert into SALES_SHIPPERS (SHIPPERID,COMPANYNAME,PHONE) values ('2','Shipper ETYNR','(425) 555-0136');
Insert into SALES_SHIPPERS (SHIPPERID,COMPANYNAME,PHONE) values ('3','Shipper ZHISN','(415) 555-0138');
--------------------------------------------------------
--  DDL for Index PK_SHIPPERS
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_SHIPPERS" ON "SALES_SHIPPERS" ("SHIPPERID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table SALES_SHIPPERS
--------------------------------------------------------

  ALTER TABLE "SALES_SHIPPERS" ADD CONSTRAINT "PK_SHIPPERS" PRIMARY KEY ("SHIPPERID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "SALES_SHIPPERS" MODIFY ("PHONE" NOT NULL ENABLE);
  ALTER TABLE "SALES_SHIPPERS" MODIFY ("COMPANYNAME" NOT NULL ENABLE);
  ALTER TABLE "SALES_SHIPPERS" MODIFY ("SHIPPERID" NOT NULL ENABLE);
