--------------------------------------------------------
--  File created - Pazar-May�s-14-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table PRODUCTION_PRODUCTS
--------------------------------------------------------

  CREATE TABLE "PRODUCTION_PRODUCTS" 
   (	"PRODUCTID" NUMBER(*,0), 
	"PRODUCTNAME" NVARCHAR2(40), 
	"SUPPLIERID" NUMBER(*,0), 
	"CATEGORYID" NUMBER(*,0), 
	"UNITPRICE" NUMBER(19,4), 
	"DISCONTINUED" NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into PRODUCTION_PRODUCTS
SET DEFINE OFF;
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('1','Product HHYDP','1','1','18','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('2','Product RECZE','1','1','19','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('3','Product IMEHJ','1','2','10','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('4','Product KSBRM','2','2','22','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('5','Product EPEIM','2','2','21,35','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('6','Product VAIIV','3','2','25','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('7','Product HMLNI','3','7','30','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('8','Product WVJFP','3','2','40','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('9','Product AOZBW','4','6','97','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('10','Product YHXGE','4','8','31','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('11','Product QMVUN','5','4','21','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('12','Product OSFNS','5','4','38','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('13','Product POXFU','6','8','6','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('14','Product PWCJB','6','7','23,25','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('15','Product KSZOI','6','2','15,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('16','Product PAFRH','7','3','17,45','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('17','Product BLCAX','7','6','39','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('18','Product CKEDC','7','8','62,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('19','Product XKXDO','8','3','9,2','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('20','Product QHFFP','8','3','81','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('21','Product VJZZH','8','3','10','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('22','Product CPHFY','9','5','21','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('23','Product JLUDZ','9','5','9','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('24','Product QOGNU','10','1','4,5','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('25','Product LYLNI','11','3','14','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('26','Product HLGZA','11','3','31,23','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('27','Product SMIOH','11','3','43,9','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('28','Product OFBNT','12','7','45,6','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('29','Product VJXYN','12','6','123,79','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('30','Product LYERX','13','8','25,89','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('31','Product XWOXC','14','4','12,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('32','Product NUNAW','14','4','32','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('33','Product ASTMN','15','4','2,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('34','Product SWNJY','16','1','14','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('35','Product NEVTJ','16','1','18','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('36','Product GMKIJ','17','8','19','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('37','Product EVFFA','17','8','26','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('38','Product QDOMO','18','1','263,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('39','Product LSOFL','18','1','18','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('40','Product YZIXQ','19','8','18,4','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('41','Product TTEEX','19','8','9,65','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('42','Product RJVNM','20','5','14','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('43','Product ZZZHR','20','1','46','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('44','Product VJIEO','20','2','19,45','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('45','Product AQOKR','21','8','9,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('46','Product CBRRL','21','8','12','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('47','Product EZZPR','22','3','9,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('48','Product MYNXN','22','3','12,75','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('49','Product FPYPN','23','3','20','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('50','Product BIUDV','23','3','16,25','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('51','Product APITJ','24','7','53','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('52','Product QSRXF','24','5','7','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('53','Product BKGEA','24','6','32,8','1');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('54','Product QAQRL','25','6','7,45','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('55','Product YYWRT','25','6','24','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('56','Product VKCMF','26','5','38','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('57','Product OVLQI','26','5','19,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('58','Product ACRVI','27','8','13,25','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('59','Product UKXRI','28','4','55','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('60','Product WHBYK','28','4','34','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('61','Product XYZPE','29','2','28,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('62','Product WUXYK','29','3','49,3','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('63','Product ICKNK','7','2','43,9','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('64','Product HCQDE','12','5','33,25','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('65','Product XYWBZ','2','2','21,05','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('66','Product LQMGN','2','2','17','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('67','Product XLXQF','16','1','14','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('68','Product TBTBL','8','3','12,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('69','Product COAXA','15','4','36','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('70','Product TOONT','7','1','15','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('71','Product MYMOI','15','4','21,5','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('72','Product GEEOO','14','4','34,8','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('73','Product WEUJZ','17','8','15','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('74','Product BKAZJ','4','7','10','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('75','Product BWRLG','12','1','7,75','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('76','Product JYGFE','23','1','18','0');
Insert into PRODUCTION_PRODUCTS (PRODUCTID,PRODUCTNAME,SUPPLIERID,CATEGORYID,UNITPRICE,DISCONTINUED) values ('77','Product LUNZZ','12','2','13','0');
--------------------------------------------------------
--  DDL for Index PK_PRODUCTS
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_PRODUCTS" ON "PRODUCTION_PRODUCTS" ("PRODUCTID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table PRODUCTION_PRODUCTS
--------------------------------------------------------

  ALTER TABLE "PRODUCTION_PRODUCTS" ADD CONSTRAINT "PK_PRODUCTS" PRIMARY KEY ("PRODUCTID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "PRODUCTION_PRODUCTS" MODIFY ("DISCONTINUED" NOT NULL ENABLE);
  ALTER TABLE "PRODUCTION_PRODUCTS" MODIFY ("UNITPRICE" NOT NULL ENABLE);
  ALTER TABLE "PRODUCTION_PRODUCTS" MODIFY ("CATEGORYID" NOT NULL ENABLE);
  ALTER TABLE "PRODUCTION_PRODUCTS" MODIFY ("SUPPLIERID" NOT NULL ENABLE);
  ALTER TABLE "PRODUCTION_PRODUCTS" MODIFY ("PRODUCTNAME" NOT NULL ENABLE);
  ALTER TABLE "PRODUCTION_PRODUCTS" MODIFY ("PRODUCTID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table PRODUCTION_PRODUCTS
--------------------------------------------------------

  ALTER TABLE "PRODUCTION_PRODUCTS" ADD CONSTRAINT "FK_PRODUCTS_CATEGORIES" FOREIGN KEY ("CATEGORYID")
	  REFERENCES "PRODUCTION_CATEGORIES" ("CATEGORYID") ENABLE;
  ALTER TABLE "PRODUCTION_PRODUCTS" ADD CONSTRAINT "FK_PRODUCTS_SUPPLIERS" FOREIGN KEY ("SUPPLIERID")
	  REFERENCES "PRODUCTION_SUPPLIERS" ("SUPPLIERID") ENABLE;
