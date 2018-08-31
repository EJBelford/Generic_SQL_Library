-- SOURCE: gnrc_sys_glos_ref_seq.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref_seq
--      PURPOSE: REC_ID sequence for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

DROP SEQUENCE gnrc_sys_glos_ref_seq;

CREATE SEQUENCE gnrc_sys_glos_ref_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 
    

-- SOURCE: gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: <Descripton>
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--  ASSUMPTIONS:
--
--  LIMITATIONS:
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

DROP TABLE gnrc_sys_glos_ref CASCADE CONSTRAINTS;
	
CREATE TABLE gnrc_sys_glos_ref   
(
    rec_id                           NUMBER              NOT NULL ,
    rec_uuid                         VARCHAR2(40)        NOT NULL ,
--
--    gnrc_sys_glos_fk   UUID       REFERENCES gnrc_sys_glos (rec_uuid), -- NOT NULL,
--
    term                             VARCHAR2(50)        NOT NULL,
    term_status                      CHAR(1)             DEFAULT 'A', 
    term_def                         VARCHAR2(250),
    term_def_ext                     VARCHAR2(500),
    term_synonyms                    CHAR(1)             DEFAULT 'N', 
    term_related                     CHAR(1)             DEFAULT 'N', 
    term_source_from                 VARCHAR2(200),
    term_source_adapted              CHAR(1)             DEFAULT 'N',
    term_sort_ordr                   INTEGER             DEFAULT 0, 
    term_date                        VARCHAR2(15),
--
    status                           CHAR(1)             DEFAULT 'N' ,
    updt_by                          VARCHAR2(50)        DEFAULT SUBSTR(USER, 1, 50) ,
    lst_updt                         DATE                DEFAULT SYSDATE ,
--
    active_flag                      CHAR(1)             DEFAULT 'Y' , 
    active_date                      DATE                DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') , 
    inactive_date                    DATE                DEFAULT TO_DATE('31-DEC-2099', 'DD-MON-YYYY') ,
--
    insert_by                        VARCHAR2(50)        DEFAULT SUBSTR(USER, 1, 50) , 
    insert_date                      DATE                DEFAULT SYSDATE , 
    update_by                        VARCHAR2(50)        NULL ,
    update_date                      DATE                DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    delete_by                        VARCHAR2(50)        NULL ,
    delete_flag                      VARCHAR2(1)         DEFAULT 'N' ,
    delete_date                      DATE                DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    hidden_by                        VARCHAR2(50)        NULL ,
    hidden_flag                      VARCHAR2(1)         DEFAULT 'N' ,
    hidden_date                      DATE                DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') 
)
PCTFREE 10 PCTUSED 0 TABLESPACE AuthDataSrc_Dev_TabSpace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE gnrc_sys_glos_ref 
IS 'gnrc_sys_glos_ref - <Descripton>'; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN gnrc_sys_glos_ref.rec_id 
IS 'REC_ID - Primary, blind key of the gnrc_sys_glos_ref table.'; 

COMMENT ON COLUMN gnrc_sys_glos_ref.rec_uuid 
IS 'REC_UUID - Blind uuid key of the gnrc_sys_glos_ref table.'; 


COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term_status 
IS 'term_status - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_cat_1 - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_acro_1 - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_sort_ordr - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_def - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_source - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_example_1 - ';
COMMENT ON COLUMN gnrc_sys_glos_ref.term 
IS 'term_note_1 - ';


COMMENT ON COLUMN gnrc_sys_glos_ref.status 
IS 'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';

COMMENT ON COLUMN gnrc_sys_glos_ref.updt_by 
IS 'UPDT_BY - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN gnrc_sys_glos_ref.lst_updt 
IS 'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.';

COMMENT ON COLUMN gnrc_sys_glos_ref.active_flag 
IS 'ACTIVE_FLAG - Flag indicating if the record is active or not.';

COMMENT ON COLUMN gnrc_sys_glos_ref.active_date 
IS 'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.';

COMMENT ON COLUMN gnrc_sys_glos_ref.inactive_date 
IS 'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.';

COMMENT ON COLUMN gnrc_sys_glos_ref.insert_by 
IS 'INSERT_BY - Reports who initially created the record.';

COMMENT ON COLUMN gnrc_sys_glos_ref.insert_date 
IS 'INSERT_DATE - Reports when the record was initially created.';

COMMENT ON COLUMN gnrc_sys_glos_ref.update_by 
IS 'UPDATE_BY - Reports who last updated the record.';

COMMENT ON COLUMN gnrc_sys_glos_ref.update_date 
IS 'UPDATE_DATE - Reports when the record was last updated.';

COMMENT ON COLUMN gnrc_sys_glos_ref.delete_by 
IS 'DELETE_BY - Reports who last deleted the record.';       

COMMENT ON COLUMN gnrc_sys_glos_ref.delete_flag 
IS 'DELETE_FLAG - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN gnrc_sys_glos_ref.delete_date 
IS 'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';

COMMENT ON COLUMN gnrc_sys_glos_ref.hidden_by 
IS 'HIDDEN_BY - Reports who last hide the record.';       

COMMENT ON COLUMN gnrc_sys_glos_ref.hidden_flag 
IS 'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';

COMMENT ON COLUMN gnrc_sys_glos_ref.hidden_date 
IS 'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('gnrc_sys_glos_ref'); 
*/
/*----- Check to see if the table column comments are present -----*/
/*
SELECT  b.column_id, 
        a.table_name, 
        a.column_name, 
        b.data_type, 
        b.data_length, 
        b.nullable, 
        b.data_default,  
        a.comments 
--        , '|', b.*  
FROM    user_col_comments a
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('gnrc_sys_glos_ref') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('gnrc_sys_glos_ref') 
ORDER BY b.column_id; 
*/
/*----- Look-up field description from master LIDB table -----*/
/*
SELECT a.* 
FROM   lidb_cmnt@pfsawh.lidbdev a
WHERE  a.col_name LIKE UPPER('%supply%')
ORDER BY a.col_name; 
/ 
*/
/*   
SELECT a.* 
FROM   user_col_comments a
WHERE  a.column_name LIKE UPPER('%rec_id%'); 
/ 
*/

-- SOURCE: pk_gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Primary key for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Primary Key -----*/

ALTER TABLE gnrc_sys_glos_ref  
    ADD CONSTRAINT pk_gnrc_sys_glos_ref 
    PRIMARY KEY 
    (
    rec_id
    );
    
   
-- SOURCE: ixu_gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Unique index for ixu_gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Indexs -----*/

-- DROP INDEX ixu_gnrc_sys_glos_ref;

CREATE UNIQUE INDEX ixu_gnrc_sys_glos_ref 
    ON gnrc_sys_glos_ref
        (
        term
        );


-- SOURCE: fk_gnrc_sys_glos_ref_xx_id.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Foreign key for fk_gnrc_sys_glos_ref_xx_id..
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE gnrc_sys_glos_ref  DROP CONSTRAINT fk_gnrc_sys_glos_ref_xx_id;        

--ALTER TABLE gnrc_sys_glos_ref  
--    ADD CONSTRAINT fk_pfsa_code_xx_id 
--    FOREIGN KEY 
--        (
--        xx_code
--        ) 
--    REFERENCES xx_pfsa_yyyyy_dim
--        (
--        xx_code
--        );


-- SOURCE: ck_gnrc_sys_glos_ref_act_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Create the active_flag constraint for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE gnrc_sys_glos_ref  DROP CONSTRAINT ck_gnrc_sys_glos_ref_act_fl; 

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE gnrc_sys_glos_ref  
    ADD CONSTRAINT ck_gnrc_sys_glos_ref_act_fl 
    CHECK (active_flag='I' OR active_flag='N' OR active_flag='Y');


-- SOURCE: ck_gnrc_sys_glos_ref_del_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Create the delete_flag constraint for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE gnrc_sys_glos_ref  DROP CONSTRAINT ck_gnrc_sys_glos_ref_del_fl;    

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE gnrc_sys_glos_ref  
    ADD CONSTRAINT ck_gnrc_sys_glos_ref_del_fl 
    CHECK (delete_flag='N' OR delete_flag='Y');


-- SOURCE: ck_gnrc_sys_glos_ref_hid_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Create the hidden_flag constraint for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE gnrc_sys_glos_ref  DROP CONSTRAINT ck_gnrc_sys_glos_ref_hid_fl;  

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE gnrc_sys_glos_ref  
    ADD CONSTRAINT ck_gnrc_sys_glos_ref_hid_fl 
    CHECK (hidden_flag='N' OR hidden_flag='Y');


-- SOURCE: ck_gnrc_sys_glos_ref_stat_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: gnrc_sys_glos_ref
--      PURPOSE: Create the status constraint for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE gnrc_sys_glos_ref  
--     DROP CONSTRAINT ck_gnrc_sys_glos_ref_stat_fl;        

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE gnrc_sys_glos_ref  
    ADD CONSTRAINT ck_gnrc_sys_glos_ref_stat_fl 
    CHECK (status='C' OR status='D' OR status='E' OR status='H' 
        OR status='L' OR status='P' OR status='Q' OR status='R'
        OR status='T' OR status='Z' OR status='N'
        );


-- SOURCE: tr_i_gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: tr_i_gnrc_sys_glos_ref
--      PURPOSE: Insert trigger for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER tr_i_gnrc_sys_glos_ref_seq
BEFORE INSERT
ON gnrc_sys_glos_ref
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id NUMBER;

BEGIN
    v_rec_id := 0;

    SELECT gnrc_sys_glos_ref_seq.nextval 
    INTO   v_rec_id 
    FROM   dual;
   
    :new.rec_id   := v_rec_id;
    :new.rec_uuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := sysdate;
    :new.updt_by  := user;

    EXCEPTION
        WHEN others THEN
        -- consider logging the error and then re-raise..
        RAISE;
       
END tr_i_gnrc_sys_glos_ref;
/
 
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';


-- SOURCE: grant_gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_grant_gnrc_sys_glos_ref
--      PURPOSE: Create grants for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Grants-----*/

GRANT SELECT, INSERT, UPDATE         ON gnrc_sys_glos_ref TO eps_admin;
GRANT SELECT                         ON gnrc_sys_glos_ref TO eps_user;


-- SOURCE: synonym_gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_synonym_gnrc_sys_glos_ref
--      PURPOSE: Create synonyn for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     gnrc_sys_glos_ref
--    Sysdate:         %SYSDATE%
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        %USERNAME% (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Synonyms -----*/   

--CREATE PUBLIC SYNONYM gnrc_sys_glos_ref FOR pfsawh.gnrc_sys_glos_ref; 


-- SOURCE: merge_gnrc_sys_glos_ref.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: merge_gnrc_sys_glos_ref
--      PURPOSE: Inital load script for gnrc_sys_glos_ref
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Populate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

--DECLARE
--
--BEGIN 
--
--    MERGE INTO  gnrc_sys_glos_ref tar 
--    USING (
--        SELECT
--            1                   AS xx_code , 
--            'Test code desc. '  AS xx_desc ,
--            0                   AS source_rec_id ,
--            0                   AS lst_update_rec_id
--            FROM dual
--        ) src
--    ON (tar.xx_code = src.xx_code)
--    WHEN NOT MATCHED THEN 
--        INSERT (     xx_code,     xx_desc,     source_rec_id,     lst_update_rec_id )
--        VALUES ( src.xx_code, src.xx_desc, src.source_rec_id, src.lst_update_rec_id )
--    WHEN MATCHED THEN
--        UPDATE SET 
--            tar.xx_desc = src.xx_desc;
--
--    COMMIT;    
--
--END;  
--/ 
    
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Validate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*

SELECT * FROM gnrc_sys_glos_ref; 
/  


DECLARE

BEGIN 

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.NEW_LINE;
    
    FOR table_load 
    IN  (
        SELECT rec_id, 
            xx_code,
            xx_desc
        FROM gnrc_sys_glos_ref 
        ORDER BY rec_id
        )
    LOOP
        DBMS_OUTPUT.PUT_LINE
            (          table_load.rec_id 
            || ', ' || table_load.xx_code 
            || ', ' || table_load.xx_desc
            );
    END LOOP;    -- table_load.. 
    
END;  
/ 
*/


/* SOURCE: gnrc_sys_glos_ref_audit.sql                                  */
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
/*                                                                            */
/* Module Name: gnrc_sys_glos_ref_audit                                      */
/*      Author: Gene Belford                                                  */
/* Description: Creates an audit table for gnrc_sys_glos_ref that tracks     */
/*              changes to the parent table as they are made.                 */
/*        Date: 2013-12-18                                                    */
/*                                                                            */
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
/*                                                                            */
/* Change History                                                             */
/* ==============                                                             */
/* Date:       Chng_Ctrl  Name                  Description                   */
/* ==========  =========  ====================  ============================= */
/* 2013-12-18             Gene Belford          Created                       */
/*                                                                            */
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/

DROP TABLE gnrc_sys_glos_ref_audit CASCADE CONSTRAINTS;  

CREATE TABLE gnrc_sys_glos_ref_audit 
(
rec_id                              INTEGER      NOT NULL,
--
rec_uuid                            VARCHAR2(50)  NOT NULL, 
--
cmd                                 CHAR(1)      NOT NULL,
update_date                         TIMESTAMP    NOT NULL,
update_by                           VARCHAR2(50),
--
n_term                              VARCHAR2(50),
o_term                              VARCHAR2(50),
n_term_status                       CHAR(1),
o_term_status                       CHAR(1),
n_term_def                          VARCHAR2(250),
o_term_def                          VARCHAR2(250),
n_term_def_ext                      VARCHAR2(500),
o_term_def_ext                      VARCHAR2(500),
n_term_synonyms                     CHAR(1), 
o_term_synonyms                     CHAR(1), 
n_term_related                      CHAR(1), 
o_term_related                      CHAR(1), 
n_term_source_from                  VARCHAR2(200),
o_term_source_from                  VARCHAR2(200),
n_term_source_adapted               CHAR(1),
o_term_source_adapted               CHAR(1),
n_term_sort_ordr                    INTEGER, 
o_term_sort_ordr                    INTEGER, 
n_term_date                         VARCHAR2(15),
o_term_date                         VARCHAR2(15),
--
PRIMARY KEY (rec_id, cmd, update_date) 
)
PCTFREE 10 PCTUSED 0 TABLESPACE AuthDataSrc_Dev_TabSpace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );


COMMENT ON TABLE gnrc_sys_glos_ref_audit 
    IS 'gnrc_sys_glos_ref_audit - Creates an audit table for gnrc_sys_glos_ref that tracks changes to the parent table as they are made.';


/* SOURCE: tr_gnrc_sys_glos_ref_audit                                                               */
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
/*                                                                            */
/* Module Name: gnrc_sys_glos_ref                                            */
/*      Author: Gene Belford                                                  */
/* Description:                                                               */
/*        Date: 2013-12-18                                                    */
/*                                                                            */
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
/*                                                                            */
/* Change History                                                             */
/* ==============                                                             */
/* Date:       Chng_Ctrl  Name                  Description                   */
/* ==========  =========  ====================  ============================= */
/* 2013-12-18             Gene Belford          Created                       */
/*                                                                            */
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

-- DROP TRIGGER IF EXISTS tr_gnrc_sys_glos_ref_audit ON gnrc_sys_glos_ref;

CREATE OR REPLACE TRIGGER tr_gnrc_sys_glos_ref_audit 
    AFTER INSERT OR UPDATE OR DELETE 
    ON gnrc_sys_glos_ref 
    FOR EACH ROW 

BEGIN

    IF INSERTING THEN 
        
        INSERT INTO gnrc_sys_glos_ref_audit 
            (
            rec_id, rec_uuid, cmd, 
            update_date, update_by, 
            n_term, 
            n_term_status,
            n_term_def,    
            n_term_def_ext,  
            n_term_synonyms, 
            n_term_related,   
            n_term_source_from, 
            n_term_source_adapted,
            n_term_sort_ordr, 
            n_term_date
            )  
        VALUES ( :NEW.rec_id, :NEW.rec_uuid, 'I', 
            SYSDATE, USER, 
            :NEW.term, 
            :NEW.term_status,
            :NEW.term_def, 
            :NEW.term_def_ext, 
            :NEW.term_synonyms,
            :NEW.term_related, 
            :NEW.term_source_from,
            :NEW.term_source_adapted,
            :NEW.term_sort_ordr, 
            :NEW.term_date   
            );
    
    ELSIF UPDATING THEN 
        
        INSERT INTO gnrc_sys_glos_ref_audit 
            (
            rec_id, rec_uuid, cmd, 
            update_date, update_by, 
            n_term,                     o_term,
            n_term_status,              o_term_status,
            n_term_def,                 o_term_def,
            n_term_def_ext,             o_term_def_ext,
            n_term_synonyms,            o_term_synonyms, 
            n_term_related,             o_term_related, 
            n_term_source_from,         o_term_source_from,
            n_term_source_adapted,      o_term_source_adapted,
            n_term_sort_ordr,           o_term_sort_ordr, 
            n_term_date,                o_term_date
            )  
        VALUES ( :NEW.rec_id, :NEW.rec_uuid, 'U', 
            SYSDATE, USER, 
            :NEW.term,                      :OLD.term,
            :NEW.term_status,               :OLD.term_status,
            :NEW.term_def,                  :OLD.term_def,
            :NEW.term_def_ext,              :OLD.term_def_ext,
            :NEW.term_synonyms,             :OLD.term_synonyms, 
            :NEW.term_related,              :OLD.term_related, 
            :NEW.term_source_from,          :OLD.term_source_from,
            :NEW.term_source_adapted,       :OLD.term_source_adapted,
            :NEW.term_sort_ordr,            :OLD.term_sort_ordr, 
            :NEW.term_date,                 :OLD.term_date 
            );
    
    ELSIF DELETING THEN 
        
        INSERT INTO gnrc_sys_glos_ref_audit 
            (
            rec_id, rec_uuid, cmd, 
            update_date, update_by, 
            o_term, 
            o_term_status,
            o_term_def,    
            o_term_def_ext,  
            o_term_synonyms, 
            o_term_related,   
            o_term_source_from, 
            o_term_source_adapted,
            o_term_sort_ordr, 
            o_term_date            
            )  
        VALUES ( :OLD.rec_id, :OLD.rec_uuid, 'D', 
            SYSDATE, USER, 
            :OLD.term, 
            :OLD.term_status,
            :OLD.term_def, 
            :OLD.term_def_ext, 
            :OLD.term_synonyms,
            :OLD.term_related, 
            :OLD.term_source_from,
            :OLD.term_source_adapted,
            :OLD.term_sort_ordr, 
            :OLD.term_date               
            );
    
    END IF;

END;
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';    


/*

INSERT INTO "AUTHDATASOURCE_DEV"."GNRC_SYS_GLOS_REF" (TERM, TERM_DEF, TERM_SOURCE_FROM) VALUES ('access', 'The ability and means to communicate with or otherwise interact with a system, to use system resources to handle information, to gain knowledge of the information the system contains, or to control system components and functions.', 'CNSSI 4009');
INSERT INTO "AUTHDATASOURCE_DEV"."GNRC_SYS_GLOS_REF" (TERM, TERM_SYNONYMS) VALUES ('access and identity management', 'Y');
INSERT INTO "AUTHDATASOURCE_DEV"."GNRC_SYS_GLOS_REF" (TERM, TERM_DEF, TERM_RELATED, TERM_SOURCE_FROM) VALUES ('access control', 'The process of granting or denying specific requests for or attempts to: 1) obtain and use information and related information processing services; and 2) enter specific physical facilities.', 'Y', 'CNSSI 4009');
INSERT INTO "AUTHDATASOURCE_DEV"."GNRC_SYS_GLOS_REF" (TERM, TERM_DEF, TERM_SOURCE_FROM) VALUES ('access control mechanism', 'Security measures designed to detect and deny unauthorized access and permit authorized access to an information system or a physical facility.', 'CNSSI 4009');
INSERT INTO "AUTHDATASOURCE_DEV"."GNRC_SYS_GLOS_REF" (TERM, TERM_DEF, TERM_RELATED, TERM_SOURCE_ADAPTED, TERM_SORT_ORDR) VALUES ('active attack', 'An actual assault perpetrated by an intentional threat source that attempts to alter a system, its resources, its data, or its operations.', 'Y', 'Y', '0');


COMMIT;

*/
