--------------------------------------------------------
--  File created - wtorek-maja-24-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence CLIENT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MAIN"."CLIENT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence DESTINATION_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MAIN"."DESTINATION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence OFFER_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MAIN"."OFFER_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Sequence OFFER_TYPE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MAIN"."OFFER_TYPE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table CLIENT
--------------------------------------------------------

  CREATE TABLE "MAIN"."CLIENT" 
   (	"CLIENT_ID" NUMBER, 
	"EMAIL" VARCHAR2(100 BYTE) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
  GRANT DELETE ON "MAIN"."CLIENT" TO "WEB";
  GRANT INSERT ON "MAIN"."CLIENT" TO "WEB";
  GRANT SELECT ON "MAIN"."CLIENT" TO "WEB";
  GRANT UPDATE ON "MAIN"."CLIENT" TO "WEB";
--------------------------------------------------------
--  DDL for Table COUNTRY_API_ERROR
--------------------------------------------------------

  CREATE TABLE "MAIN"."COUNTRY_API_ERROR" 
   (	"SQLCODE" VARCHAR2(20 BYTE) COLLATE "USING_NLS_COMP", 
	"SQLERRMS" VARCHAR2(4000 BYTE) COLLATE "USING_NLS_COMP", 
	"LOCATION" VARCHAR2(400 BYTE) COLLATE "USING_NLS_COMP", 
	"OCCURE_DATE" TIMESTAMP (6) DEFAULT CURRENT_TIMESTAMP
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Table DESTINATION
--------------------------------------------------------

  CREATE TABLE "MAIN"."DESTINATION" 
   (	"DESTINATION_ID" NUMBER(8,0), 
	"COUNTRY_ISO_ID" CHAR(2 BYTE) COLLATE "USING_NLS_COMP", 
	"NAME" VARCHAR2(255 BYTE) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Table OFFER
--------------------------------------------------------

  CREATE TABLE "MAIN"."OFFER" 
   (	"OFFER_ID" NUMBER, 
	"TYPE_ID" NUMBER, 
	"NAME" VARCHAR2(255 BYTE) COLLATE "USING_NLS_COMP", 
	"PRICE" NUMBER(7,2), 
	"MINIMAL_PRICE" NUMBER(7,2), 
	"DEPARTURE_DATE" DATE, 
	"COMEBACK_DATE" DATE, 
	"DESTINATION_ID" NUMBER, 
	"DURATION" NUMBER GENERATED ALWAYS AS ("COMEBACK_DATE"-"DEPARTURE_DATE") VIRTUAL , 
	"START_OFFER_DATE" DATE DEFAULT SYSDATE, 
	"END_OFFER_DATE" DATE, 
	"SPOTS_LEFT" NUMBER(4,0), 
	"HAS_FREE_SPOTS" NUMBER GENERATED ALWAYS AS (CASE  WHEN "SPOTS_LEFT">0 THEN 1 ELSE 0 END) VIRTUAL 
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Table OFFER_PRICE_ARCHIVE
--------------------------------------------------------

  CREATE TABLE "MAIN"."OFFER_PRICE_ARCHIVE" 
   (	"OFFER_ID" NUMBER, 
	"PRICE_DIFF" NUMBER(7,2)
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Table OFFER_TYPE
--------------------------------------------------------

  CREATE TABLE "MAIN"."OFFER_TYPE" 
   (	"TYPE_ID" NUMBER, 
	"NAME" VARCHAR2(255 BYTE) COLLATE "USING_NLS_COMP"
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Table RESERVATION
--------------------------------------------------------

  CREATE TABLE "MAIN"."RESERVATION" 
   (	"CLIENT_ID" NUMBER, 
	"OFFER_ID" NUMBER, 
	"CREATION_DATETIME" TIMESTAMP (6) DEFAULT CURRENT_TIMESTAMP, 
	"PARTICIPANTS_NUM" NUMBER(2,0), 
	"PRICE" NUMBER(8,2)
   )  DEFAULT COLLATION "USING_NLS_COMP" SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 10 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "DATA" ;
  GRANT DELETE ON "MAIN"."RESERVATION" TO "WEB";
  GRANT SELECT ON "MAIN"."RESERVATION" TO "WEB";
  GRANT INSERT ("PARTICIPANTS_NUM") ON "MAIN"."RESERVATION" TO "WEB";
  GRANT INSERT ("OFFER_ID") ON "MAIN"."RESERVATION" TO "WEB";
  GRANT INSERT ("CLIENT_ID") ON "MAIN"."RESERVATION" TO "WEB";
  GRANT UPDATE ("PARTICIPANTS_NUM") ON "MAIN"."RESERVATION" TO "WEB";
--------------------------------------------------------
--  DDL for View AVAILABLE_OFFERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAIN"."AVAILABLE_OFFERS" ("OFFER_ID", "TYPE_ID", "TYPE_NAME", "NAME", "PRICE", "DEPARTURE_DATE", "COMEBACK_DATE", "DURATION", "DESTINATION_ID", "COUNTRY_NAME", "COUNTRY_REGION", "DESTINATION", "SPOTS_LEFT") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT 
    o.offer_id,
	t.type_id,
    t.name AS type_name,
	o.name,
	o.price,
	o.departure_date,
	o.comeback_date,
    o.duration,
	d.destination_id,
    country_pkg.find_country_name(d.country_iso_id) AS country_name,
    country_pkg.find_country_region(d.country_iso_id) AS country_region,
    d.name AS destination,
	o.spots_left
    FROM main.offer o
    JOIN destination d ON o.destination_id = d.destination_id
    JOIN offer_type t ON o.type_id = t.type_id
    WHERE (o.has_free_spots = 1 AND o.start_offer_date <= SYSDATE AND o.end_offer_date > SYSDATE)
;
  GRANT SELECT ON "MAIN"."AVAILABLE_OFFERS" TO "WEB";
REM INSERTING into MAIN.CLIENT
SET DEFINE OFF;
Insert into MAIN.CLIENT (CLIENT_ID,EMAIL) values ('7','user@test.com');
Insert into MAIN.CLIENT (CLIENT_ID,EMAIL) values ('1','admin@test.com');
REM INSERTING into MAIN.COUNTRY_API_ERROR
SET DEFINE OFF;
REM INSERTING into MAIN.DESTINATION
SET DEFINE OFF;
Insert into MAIN.DESTINATION (DESTINATION_ID,COUNTRY_ISO_ID,NAME) values ('1','PL','Warszawa');
Insert into MAIN.DESTINATION (DESTINATION_ID,COUNTRY_ISO_ID,NAME) values ('2','MX','Cancun');
Insert into MAIN.DESTINATION (DESTINATION_ID,COUNTRY_ISO_ID,NAME) values ('3','US','Newport');
Insert into MAIN.DESTINATION (DESTINATION_ID,COUNTRY_ISO_ID,NAME) values ('4','BS','Nassau');
Insert into MAIN.DESTINATION (DESTINATION_ID,COUNTRY_ISO_ID,NAME) values ('5','GB','Birmingham');
Insert into MAIN.DESTINATION (DESTINATION_ID,COUNTRY_ISO_ID,NAME) values ('6','UG','Kampala');
REM INSERTING into MAIN.OFFER
SET DEFINE OFF;
Insert into MAIN.OFFER (OFFER_ID,TYPE_ID,NAME,PRICE,MINIMAL_PRICE,DEPARTURE_DATE,COMEBACK_DATE,DESTINATION_ID,DURATION,START_OFFER_DATE,END_OFFER_DATE,SPOTS_LEFT,HAS_FREE_SPOTS) values ('1','1','Safari','7500','4800',to_date('22/09/10','RR/MM/DD'),to_date('22/09/22','RR/MM/DD'),'6','12',to_date('22/05/24','RR/MM/DD'),to_date('22/08/01','RR/MM/DD'),'40','1');
Insert into MAIN.OFFER (OFFER_ID,TYPE_ID,NAME,PRICE,MINIMAL_PRICE,DEPARTURE_DATE,COMEBACK_DATE,DESTINATION_ID,DURATION,START_OFFER_DATE,END_OFFER_DATE,SPOTS_LEFT,HAS_FREE_SPOTS) values ('2','2','Visit Birmingham','2500','900',to_date('22/07/12','RR/MM/DD'),to_date('22/07/22','RR/MM/DD'),'5','10',to_date('22/05/24','RR/MM/DD'),to_date('22/07/10','RR/MM/DD'),'55','1');
Insert into MAIN.OFFER (OFFER_ID,TYPE_ID,NAME,PRICE,MINIMAL_PRICE,DEPARTURE_DATE,COMEBACK_DATE,DESTINATION_ID,DURATION,START_OFFER_DATE,END_OFFER_DATE,SPOTS_LEFT,HAS_FREE_SPOTS) values ('3','3','Bahamas','5250','4800',to_date('23/01/25','RR/MM/DD'),to_date('23/02/14','RR/MM/DD'),'4','20',to_date('22/05/24','RR/MM/DD'),to_date('22/11/01','RR/MM/DD'),'85','1');
Insert into MAIN.OFFER (OFFER_ID,TYPE_ID,NAME,PRICE,MINIMAL_PRICE,DEPARTURE_DATE,COMEBACK_DATE,DESTINATION_ID,DURATION,START_OFFER_DATE,END_OFFER_DATE,SPOTS_LEFT,HAS_FREE_SPOTS) values ('4','3','Yucatan','5100','2600',to_date('22/10/15','RR/MM/DD'),to_date('22/10/30','RR/MM/DD'),'2','15',to_date('22/05/24','RR/MM/DD'),to_date('22/10/01','RR/MM/DD'),'130','1');
Insert into MAIN.OFFER (OFFER_ID,TYPE_ID,NAME,PRICE,MINIMAL_PRICE,DEPARTURE_DATE,COMEBACK_DATE,DESTINATION_ID,DURATION,START_OFFER_DATE,END_OFFER_DATE,SPOTS_LEFT,HAS_FREE_SPOTS) values ('5','4','Vermont','4780','2400',to_date('22/12/22','RR/MM/DD'),to_date('23/01/03','RR/MM/DD'),'3','12',to_date('22/05/24','RR/MM/DD'),to_date('22/12/01','RR/MM/DD'),'40','1');
Insert into MAIN.OFFER (OFFER_ID,TYPE_ID,NAME,PRICE,MINIMAL_PRICE,DEPARTURE_DATE,COMEBACK_DATE,DESTINATION_ID,DURATION,START_OFFER_DATE,END_OFFER_DATE,SPOTS_LEFT,HAS_FREE_SPOTS) values ('6','2','Warszawa','800','300',to_date('22/08/11','RR/MM/DD'),to_date('22/08/16','RR/MM/DD'),'1','5',to_date('22/05/24','RR/MM/DD'),to_date('22/08/01','RR/MM/DD'),'3','1');
REM INSERTING into MAIN.OFFER_PRICE_ARCHIVE
SET DEFINE OFF;
REM INSERTING into MAIN.OFFER_TYPE
SET DEFINE OFF;
Insert into MAIN.OFFER_TYPE (TYPE_ID,NAME) values ('1','Safari');
Insert into MAIN.OFFER_TYPE (TYPE_ID,NAME) values ('2','City Breaks');
Insert into MAIN.OFFER_TYPE (TYPE_ID,NAME) values ('3','Beach Holidays');
Insert into MAIN.OFFER_TYPE (TYPE_ID,NAME) values ('4','Ski Holidays');
REM INSERTING into MAIN.RESERVATION
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index PK_CLIENT
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."PK_CLIENT" ON "MAIN"."CLIENT" ("CLIENT_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index PK_OFFER_PRICE_ARCHIVE
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."PK_OFFER_PRICE_ARCHIVE" ON "MAIN"."OFFER_PRICE_ARCHIVE" ("OFFER_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index OFFER_AVAILABLE_IDX
--------------------------------------------------------

  CREATE INDEX "MAIN"."OFFER_AVAILABLE_IDX" ON "MAIN"."OFFER" ("HAS_FREE_SPOTS") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index PK_OFFER
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."PK_OFFER" ON "MAIN"."OFFER" ("OFFER_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index DEST_NAME_UNQ
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."DEST_NAME_UNQ" ON "MAIN"."DESTINATION" ("COUNTRY_ISO_ID", "NAME") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index PK_OFFER_TYPE
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."PK_OFFER_TYPE" ON "MAIN"."OFFER_TYPE" ("TYPE_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index EMAIL_UNQ
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."EMAIL_UNQ" ON "MAIN"."CLIENT" ("EMAIL") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index PK_RESERVATION
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."PK_RESERVATION" ON "MAIN"."RESERVATION" ("CLIENT_ID", "OFFER_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index TYPE_NAME_UNQ
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."TYPE_NAME_UNQ" ON "MAIN"."OFFER_TYPE" ("NAME") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Index PK_DESTINATION
--------------------------------------------------------

  CREATE UNIQUE INDEX "MAIN"."PK_DESTINATION" ON "MAIN"."DESTINATION" ("DESTINATION_ID") 
  PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA" ;
--------------------------------------------------------
--  DDL for Trigger CLIENT_PK_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."CLIENT_PK_INSERT" 
BEFORE INSERT ON main.client 
FOR EACH ROW 
BEGIN
  :new.client_id := main.client_seq.nextval;
END;
/
ALTER TRIGGER "MAIN"."CLIENT_PK_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger COUNT_RESERVATION_PRICE_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."COUNT_RESERVATION_PRICE_TG" 
    BEFORE INSERT OR UPDATE OF participants_num ON main.reservation
    FOR EACH ROW
    FOLLOWS main.reduce_avail_spots_tg
    BEGIN
        SELECT :new.participants_num*o.price INTO :new.price FROM offer o WHERE o.offer_id = :new.offer_id;
    END;
/
ALTER TRIGGER "MAIN"."COUNT_RESERVATION_PRICE_TG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEST_PK_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."DEST_PK_INSERT" 
BEFORE INSERT ON main.destination
FOR EACH ROW 
BEGIN
    country_pkg.validate_country_code(:new.country_iso_id);
    :new.destination_id := main.destination_seq.nextval;
END;
/
ALTER TRIGGER "MAIN"."DEST_PK_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEST_VALIDATE_COUNTRY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."DEST_VALIDATE_COUNTRY" 
BEFORE UPDATE OF country_iso_id ON main.destination
FOR EACH ROW
BEGIN
    country_pkg.validate_country_code(:new.country_iso_id);
END;
/
ALTER TRIGGER "MAIN"."DEST_VALIDATE_COUNTRY" ENABLE;
--------------------------------------------------------
--  DDL for Trigger OFFER_PK_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."OFFER_PK_INSERT" 
BEFORE INSERT ON main.offer
FOR EACH ROW 
BEGIN
  :new.offer_id := main.offer_seq.nextval;
END;
/
ALTER TRIGGER "MAIN"."OFFER_PK_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger OFFER_TYPE_PK_INSERT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."OFFER_TYPE_PK_INSERT" 
BEFORE INSERT ON main.offer_type
FOR EACH ROW 
BEGIN
  :new.type_id := main.offer_type_seq.nextval;
END;
/
ALTER TRIGGER "MAIN"."OFFER_TYPE_PK_INSERT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger REDUCE_AVAIL_SPOTS_TG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "MAIN"."REDUCE_AVAIL_SPOTS_TG" 
    BEFORE DELETE OR INSERT OR UPDATE OF participants_num ON main.reservation
    FOR EACH ROW
    BEGIN
        main.reduce_avail_spots(:new.participants_num, :old.participants_num, :new.offer_id);
    END;
/
ALTER TRIGGER "MAIN"."REDUCE_AVAIL_SPOTS_TG" ENABLE;
--------------------------------------------------------
--  DDL for Procedure REDUCE_AVAIL_SPOTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "MAIN"."REDUCE_AVAIL_SPOTS" (in_new_part_num IN NUMBER, in_old_part_num IN NUMBER, in_offer_id IN NUMBER)
  AUTHID DEFINER
AS
  check_violation EXCEPTION;
  PRAGMA exception_init(check_violation, -2290);
BEGIN
    UPDATE main.offer SET spots_left = (CASE 
        WHEN (in_old_part_num IS NOT NULL AND in_new_part_num IS NOT NULL) THEN 
            spots_left + in_old_part_num- in_new_part_num
        WHEN (in_old_part_num IS NOT NULL) THEN
            spots_left + in_old_part_num
        ELSE spots_left - in_new_part_num
            END)
        WHERE offer_id = in_offer_id;
EXCEPTION
    WHEN check_violation THEN
        RAISE;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'DB internal error');
END;

/

  GRANT EXECUTE ON "MAIN"."REDUCE_AVAIL_SPOTS" TO "WEB";
--------------------------------------------------------
--  DDL for Package COUNTRY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "MAIN"."COUNTRY_PKG" AS 

  PROCEDURE validate_country_code(iv_code IN VARCHAR2);
  FUNCTION find_country_name (iv_code IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION find_country_region (iv_code IN VARCHAR2) RETURN VARCHAR2;
  country_not_found_error EXCEPTION;
  api_error EXCEPTION;

END COUNTRY_PKG;

/
--------------------------------------------------------
--  DDL for Package PROMO_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "MAIN"."PROMO_PKG" AS 
    TYPE price_diff_rec_type IS RECORD (r_offer_id NUMBER, r_price_diff NUMBER(7,2));
    TYPE price_diff_arr_type IS TABLE OF price_diff_rec_type;
    TYPE offers_arr_type IS TABLE OF NUMBER;
    PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_days_left IN NUMBER DEFAULT 7);
    PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_offers_arr offers_arr_type);
END PROMO_PKG;

/
--------------------------------------------------------
--  DDL for Package Body COUNTRY_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "MAIN"."COUNTRY_PKG" AS

PROCEDURE save_api_error(iv_sqlcode VARCHAR2, iv_sqlerrms VARCHAR2, iv_location VARCHAR2)
AS
PRAGMA autonomous_transaction;
BEGIN
    INSERT INTO main.country_api_error(sqlcode, sqlerrms, location) VALUES (iv_sqlcode, iv_sqlerrms, iv_location);
    commit;
END save_api_error;

PROCEDURE validate_country_code(iv_code IN VARCHAR2) AS
  lv_id  VARCHAR2(200);
BEGIN
    BEGIN
        UTL_HTTP.SET_WALLET('');
        SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].id') INTO lv_id FROM dual;
    EXCEPTION WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.validate_country_code');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        RAISE api_error;
    END;
    IF lv_id IS NULL THEN
        dbms_output.put_line('Country with given code can''t be found');
        RAISE country_not_found_error;
    END IF;
END validate_country_code;
  
FUNCTION find_country_name(iv_code IN VARCHAR2) RETURN VARCHAR2 
AS
    lv_name  VARCHAR2(200);
BEGIN
    BEGIN
        UTL_HTTP.SET_WALLET('');
        SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].name') INTO lv_name FROM dual;
    EXCEPTION WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_name');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        RAISE api_error;
    END;
    IF lv_name IS NULL THEN
        dbms_output.put_line('Country with given code can''t be found');
        RAISE country_not_found_error;
    END IF;
    RETURN lv_name;
END find_country_name;
    
FUNCTION find_country_region(iv_code IN VARCHAR2) RETURN VARCHAR2
AS
    lv_region  VARCHAR2(200);
BEGIN
    BEGIN
        UTL_HTTP.SET_WALLET('');
        SELECT JSON_VALUE(utl_http.request('https://api.worldbank.org/v2/country/'|| iv_code ||'?format=json'), '$[1][0].region.value') INTO lv_region FROM dual;
    EXCEPTION WHEN OTHERS THEN
        country_pkg.save_api_error(sqlcode,sqlerrm,'main.country_pkg.find_country_region');
        dbms_output.put_line('Error occured. Check  main.country_api_error table');
        RAISE api_error;
    END;
    IF lv_region IS NULL THEN
        dbms_output.put_line('Country with given code can''t be found');
        RAISE country_not_found_error;
    END IF;
    RETURN lv_region;
END find_country_region;
  
END COUNTRY_PKG;

/
--------------------------------------------------------
--  DDL for Package Body PROMO_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "MAIN"."PROMO_PKG" AS
    
    PROCEDURE save_price_diff(diff_arr IN price_diff_arr_type)
    AS
    BEGIN
            FORALL rc_num IN diff_arr.first..diff_arr.last
                MERGE INTO main.offer_price_archive p
                     USING (SELECT null FROM DUAL)
                    ON (p.offer_id = diff_arr(rc_num).r_offer_id)
                WHEN MATCHED THEN UPDATE
                    SET p.price_diff = p.price_diff + diff_arr(rc_num).r_price_diff
                WHEN NOT MATCHED THEN 
                INSERT (offer_id, price_diff)
                    VALUES (diff_arr(rc_num).r_offer_id, diff_arr(rc_num).r_price_diff);
        commit;
    END;
    
    PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_days_left IN NUMBER DEFAULT 7)
    AS 
    CURSOR lc_discouned_offers IS SELECT offer_id, price, minimal_price FROM main.offer 
        WHERE (SYSDATE + in_days_left >= end_offer_date AND end_offer_date >= SYSDATE) FOR UPDATE OF price;
    ln_new_price NUMBER;
    price_diff_rec price_diff_rec_type;
    price_diff_arr price_diff_arr_type := price_diff_arr_type();
    BEGIN
        FOR off IN lc_discouned_offers LOOP
            price_diff_arr.EXTEND;
            IF off.price*(1-in_discount_pct/100) >= off.minimal_price THEN 
                ln_new_price := off.price*(1-in_discount_pct/100);
            ELSE
                ln_new_price := off.minimal_price;
            END IF;
            UPDATE main.offer SET price = ln_new_price
                    WHERE CURRENT OF lc_discouned_offers;               
            price_diff_rec.r_offer_id := off.offer_id;
            price_diff_rec.r_price_diff := off.price - ln_new_price;
            price_diff_arr(price_diff_arr.LAST) := price_diff_rec;
        END LOOP;
        promo_pkg.save_price_diff(price_diff_arr);
    END seasonal_promo;

  PROCEDURE seasonal_promo(in_discount_pct IN NUMBER, in_offers_arr IN offers_arr_type) AS
  ln_old_price NUMBER;
  price_diff_arr price_diff_arr_type := price_diff_arr_type();
  BEGIN
    FORALL off IN in_offers_arr.first..in_offers_arr.last
            UPDATE (SELECT offer_id, price, minimal_price, (SELECT offer.price FROM dual) old_price FROM offer)
                SET price = (CASE WHEN (price*(1-in_discount_pct/100)) >= minimal_price 
                THEN price*(1-in_discount_pct/100)
                ELSE minimal_price END)
                    WHERE offer_id = in_offers_arr(off)
                RETURNING offer_id, old_price - price BULK COLLECT INTO price_diff_arr;
    promo_pkg.save_price_diff(price_diff_arr);
  END seasonal_promo;

END PROMO_PKG;

/
--------------------------------------------------------
--  DDL for Function AVAILABLE_OFFERS_PAGINATED
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MAIN"."AVAILABLE_OFFERS_PAGINATED" (start_row_num IN NUMBER DEFAULT 1, per_page IN NUMBER DEFAULT 30)
RETURN SYS_REFCURSOR
AS
    lc_av_off SYS_REFCURSOR;
BEGIN
    OPEN lc_av_off FOR SELECT * FROM (SELECT ao.*, rownum rn FROM (SELECT * FROM main.available_offers ORDER BY offer_id) ao WHERE rownum < start_row_num+per_page) WHERE rn >= start_row_num;
    RETURN lc_av_off;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        null;
    WHEN OTHERS THEN
        RAISE;
END;

/

  GRANT EXECUTE ON "MAIN"."AVAILABLE_OFFERS_PAGINATED" TO "WEB";
--------------------------------------------------------
--  DDL for Function NUMBER_OF_PAGES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "MAIN"."NUMBER_OF_PAGES" (per_page IN NUMBER DEFAULT 30) RETURN NUMBER
AS 
ln_pages NUMBER;
BEGIN
    SELECT FLOOR(COUNT(offer_id)/per_page) INTO ln_pages FROM available_offers;
    RETURN ln_pages;
END;

/

  GRANT EXECUTE ON "MAIN"."NUMBER_OF_PAGES" TO "WEB";
--------------------------------------------------------
--  Constraints for Table DESTINATION
--------------------------------------------------------

  ALTER TABLE "MAIN"."DESTINATION" MODIFY ("DESTINATION_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."DESTINATION" MODIFY ("COUNTRY_ISO_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."DESTINATION" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."DESTINATION" ADD CONSTRAINT "PK_DESTINATION" PRIMARY KEY ("DESTINATION_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
  ALTER TABLE "MAIN"."DESTINATION" ADD CONSTRAINT "DEST_NAME_UNQ" UNIQUE ("COUNTRY_ISO_ID", "NAME")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
--------------------------------------------------------
--  Constraints for Table OFFER
--------------------------------------------------------

  ALTER TABLE "MAIN"."OFFER" MODIFY ("OFFER_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("MINIMAL_PRICE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("DEPARTURE_DATE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("COMEBACK_DATE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("DESTINATION_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("START_OFFER_DATE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("END_OFFER_DATE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" MODIFY ("SPOTS_LEFT" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "SPOTS_LEFT_CHK" CHECK (spots_left >= 0) ENABLE;
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "PRICE_CHK" CHECK (price >= minimal_price) ENABLE;
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "MINIMAL_PRICE_CHK" CHECK (minimal_price > 0) ENABLE;
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "COMBACK_DATE_CHK" CHECK (comeback_date > departure_date) ENABLE;
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "END_OFFER_CHK" CHECK (end_offer_date > start_offer_date) ENABLE;
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "PK_OFFER" PRIMARY KEY ("OFFER_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
--------------------------------------------------------
--  Constraints for Table CLIENT
--------------------------------------------------------

  ALTER TABLE "MAIN"."CLIENT" MODIFY ("CLIENT_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."CLIENT" MODIFY ("EMAIL" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."CLIENT" ADD CONSTRAINT "PK_CLIENT" PRIMARY KEY ("CLIENT_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
  ALTER TABLE "MAIN"."CLIENT" ADD CONSTRAINT "EMAIL_UNQ" UNIQUE ("EMAIL")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
--------------------------------------------------------
--  Constraints for Table OFFER_TYPE
--------------------------------------------------------

  ALTER TABLE "MAIN"."OFFER_TYPE" MODIFY ("TYPE_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER_TYPE" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER_TYPE" ADD CONSTRAINT "PK_OFFER_TYPE" PRIMARY KEY ("TYPE_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
  ALTER TABLE "MAIN"."OFFER_TYPE" ADD CONSTRAINT "TYPE_NAME_UNQ" UNIQUE ("NAME")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DATA"  ENABLE;
--------------------------------------------------------
--  Constraints for Table RESERVATION
--------------------------------------------------------

  ALTER TABLE "MAIN"."RESERVATION" MODIFY ("CLIENT_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."RESERVATION" MODIFY ("OFFER_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."RESERVATION" MODIFY ("CREATION_DATETIME" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."RESERVATION" MODIFY ("PARTICIPANTS_NUM" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."RESERVATION" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."RESERVATION" ADD CONSTRAINT "PARTICIPANTS_NUM_CHK" CHECK (participants_num >= 1) ENABLE;
  ALTER TABLE "MAIN"."RESERVATION" ADD CONSTRAINT "PK_RESERVATION" PRIMARY KEY ("CLIENT_ID", "OFFER_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  TABLESPACE "DATA"  ENABLE;
--------------------------------------------------------
--  Constraints for Table COUNTRY_API_ERROR
--------------------------------------------------------

  ALTER TABLE "MAIN"."COUNTRY_API_ERROR" MODIFY ("OCCURE_DATE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table OFFER_PRICE_ARCHIVE
--------------------------------------------------------

  ALTER TABLE "MAIN"."OFFER_PRICE_ARCHIVE" MODIFY ("OFFER_ID" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER_PRICE_ARCHIVE" MODIFY ("PRICE_DIFF" NOT NULL ENABLE);
  ALTER TABLE "MAIN"."OFFER_PRICE_ARCHIVE" ADD CONSTRAINT "PK_OFFER_PRICE_ARCHIVE" PRIMARY KEY ("OFFER_ID")
  USING INDEX PCTFREE 10 INITRANS 20 MAXTRANS 255 
  TABLESPACE "DATA"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OFFER
--------------------------------------------------------

  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "FK_OFFER_DESTINATION" FOREIGN KEY ("DESTINATION_ID")
	  REFERENCES "MAIN"."DESTINATION" ("DESTINATION_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MAIN"."OFFER" ADD CONSTRAINT "FK_OFFER_OFFER_TYPE" FOREIGN KEY ("TYPE_ID")
	  REFERENCES "MAIN"."OFFER_TYPE" ("TYPE_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table OFFER_PRICE_ARCHIVE
--------------------------------------------------------

  ALTER TABLE "MAIN"."OFFER_PRICE_ARCHIVE" ADD CONSTRAINT "FK_OFFER_PRICE_ARCHIVE" FOREIGN KEY ("OFFER_ID")
	  REFERENCES "MAIN"."OFFER" ("OFFER_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESERVATION
--------------------------------------------------------

  ALTER TABLE "MAIN"."RESERVATION" ADD CONSTRAINT "FK_RESERVATION_CLIENT" FOREIGN KEY ("CLIENT_ID")
	  REFERENCES "MAIN"."CLIENT" ("CLIENT_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MAIN"."RESERVATION" ADD CONSTRAINT "FK_RESERVATION_OFFER" FOREIGN KEY ("OFFER_ID")
	  REFERENCES "MAIN"."OFFER" ("OFFER_ID") ON DELETE CASCADE ENABLE;
