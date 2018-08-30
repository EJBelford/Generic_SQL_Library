/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log_seq
--      PURPOSE: REC_ID sequence for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: generic_sys_proc_log_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     generic_sys_proc_log
--    Sysdate:         2017-12-13
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        Gene Belford (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

-- DROP SEQUENCE generic_sys_proc_log_seq;

CREATE SEQUENCE generic_sys_proc_log_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: <Descripton>
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: generic_sys_proc_log.sql
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
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

-- DROP TABLE generic_sys_proc_log CASCADE CONSTRAINTS;
	
CREATE TABLE generic_sys_proc_log 
(
    rec_id                          NUMBER              NOT NULL ,
    rec_uuid                        VARCHAR2(40)        NOT NULL ,
--
    process_batch_id                NUMBER, 
    process_key                     NUMBER              NOT NULL,
--
    process_id                      NUMBER              NOT NULL,
    module_num                      NUMBER              DEFAULT    0,
    step_num                        NUMBER              DEFAULT    0,
    process_start_date              TIMESTAMP WITH TIME ZONE,
    process_end_date                TIMESTAMP WITH TIME ZONE,
    process_status_code             INT,
--
    sql_error_code                  NUMBER,
    rec_read_int                    NUMBER,
    rec_valid_int                   NUMBER,
    rec_load_int                    NUMBER,
    rec_inserted_int                NUMBER,
    rec_merged_int                  NUMBER,
    rec_selected_int                NUMBER,
    rec_updated_int                 NUMBER,
    rec_deleted_int                 NUMBER, 
--
    user_login_id                   VARCHAR2(30),
    message                         VARCHAR2(255)    
)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             32K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE generic_sys_proc_log 
IS 'generic_sys_proc_log - Process log tracking stored procedure performance in the the CMIS database.  Data is inserted by stored procedure dbo.spr_InsUpd_RptToCourt_ProcessLog.'; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN generic_sys_proc_log.process_key 
IS 'PROCESS_KEY - Identity and Primary key for facRptToCourtProcessLog records.'; 

COMMENT ON COLUMN generic_sys_proc_log.module_num 
IS 'MODULE_NUM - Identities module within a give mutli-step process.'; 

COMMENT ON COLUMN generic_sys_proc_log.step_num 
IS 'STEP_NUM - Identities steps within a give mutli-step process.'; 

COMMENT ON COLUMN generic_sys_proc_log.process_start_date 
IS 'PROCESS_START_DATE - When the process started.';

COMMENT ON COLUMN generic_sys_proc_log.process_end_date 
IS 'PROCESS_END_DATE - When the process ended.';

COMMENT ON COLUMN generic_sys_proc_log.process_status_code  
IS 'PROCESS_STATUS_CODE - Processing status of the process. ';

COMMENT ON COLUMN generic_sys_proc_log.process_id 
IS 'PROCESS_ID - Primary key for facRptToCourtProcessLog records.';

COMMENT ON COLUMN generic_sys_proc_log.sql_error_code 
IS 'SQL_ERROR_CODE - Return status of the select statement executed.';

COMMENT ON COLUMN generic_sys_proc_log.rec_read_int 
IS 'REC_READ_INT - Number of records read by the process.';

COMMENT ON COLUMN generic_sys_proc_log.rec_valid_int 
IS 'REC_VALID_INT - Number of records found to be valid by the process.';

COMMENT ON COLUMN generic_sys_proc_log.rec_load_int 
IS 'REC_LOAD_INT - Number of records loaded by the process.';

COMMENT ON COLUMN generic_sys_proc_log.rec_inserted_int 
IS 'REC_INSERTED_INT - Number of records inserted by the process';

COMMENT ON COLUMN generic_sys_proc_log.rec_merged_int 
IS 'REC_MERGED_INT - Number of records merged by the process';

COMMENT ON COLUMN generic_sys_proc_log.rec_selected_int 
IS 'REC_SELECTED_INT - Number of records selected by the process';

COMMENT ON COLUMN generic_sys_proc_log.rec_updated_int 
IS 'REC_UPDATED_INT - Number of records updateded by the process';

COMMENT ON COLUMN generic_sys_proc_log.rec_deleted_int 
IS 'REC_DELETED_INT - Number of records deleteed by the process';

COMMENT ON COLUMN generic_sys_proc_log.user_login_id 
IS 'USER_LOGIN_ID - The user id the this process was run under.';

COMMENT ON COLUMN generic_sys_proc_log.message 
IS 'MESSAGE - Captures any informated needed for process review.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('generic_sys_proc_log'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('generic_sys_proc_log') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('generic_sys_proc_log') 
ORDER BY b.column_id; 
*/

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Primary key for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: pk_generic_sys_proc_log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE generic_sys_proc_log  
    ADD CONSTRAINT pk_generic_sys_proc_log 
    PRIMARY KEY 
    (
    rec_id
    );
    
   
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Unique index for ixu_generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ixu_generic_sys_proc_log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

-- DROP INDEX ixu_generic_sys_proc_log;

CREATE UNIQUE INDEX ixu_generic_sys_proc_log 
    ON generic_sys_proc_log
        (
        rec_uuid
        );

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Foreign key for fk_generic_sys_proc_log_xx_id..
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: fk_generic_sys_proc_log_xx_id.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE generic_sys_proc_log  DROP CONSTRAINT fk_generic_sys_proc_log_xx_id;        

--ALTER TABLE generic_sys_proc_log  
--    ADD CONSTRAINT fk_generic_sys_proc_log_code_xx_id 
--    FOREIGN KEY 
--        (
--        xx_code
--        ) 
--    REFERENCES xx_generic_sys_proc_log_yyyyy_dim
--        (
--        xx_code
--        );

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Create the active_flag constraint for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_generic_sys_proc_log_act_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE generic_sys_proc_log  DROP CONSTRAINT ck_generic_sys_proc_log_act_fl; 

--                          1         2         3..
--                 123456789012345678901234567890..    

--ALTER TABLE generic_sys_proc_log  
--    ADD CONSTRAINT ck_generic_sys_proc_log_act_fl 
--    CHECK (active_flag='I' OR active_flag='N' OR active_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Create the delete_flag constraint for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_generic_sys_proc_log_del_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE generic_sys_proc_log  DROP CONSTRAINT ck_generic_sys_proc_log_del_fl;    

--                          1         2         3..
--                 123456789012345678901234567890..    

--ALTER TABLE generic_sys_proc_log  
--    ADD CONSTRAINT ck_generic_sys_proc_log_del_fl 
--    CHECK (delete_flag='N' OR delete_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Create the hidden_flag constraint for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_generic_sys_proc_log_hid_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE generic_sys_proc_log  DROP CONSTRAINT ck_generic_sys_proc_log_hid_fl;  

--                          1         2         3..
--                 123456789012345678901234567890..    

--ALTER TABLE generic_sys_proc_log  
--    ADD CONSTRAINT ck_generic_sys_proc_log_hid_fl 
--    CHECK (hidden_flag='N' OR hidden_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_proc_log
--      PURPOSE: Create the status constraint for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_generic_sys_proc_log_stat_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE generic_sys_proc_log  
--     DROP CONSTRAINT ck_generic_sys_proc_log_stat_fl;        

--                          1         2         3..
--                 123456789012345678901234567890..    

--ALTER TABLE generic_sys_proc_log  
--    ADD CONSTRAINT ck_generic_sys_proc_log_stat_fl 
--    CHECK (status='C' OR status='D' OR status='E' OR status='H' 
--        OR status='L' OR status='P' OR status='Q' OR status='R'
--        OR status='T' OR status='Z' OR status='N'
--        );

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: tr_i_generic_sys_proc_log
--      PURPOSE: Insert trigger for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: tr_i_generic_sys_proc_log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*DECLARE
--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER tr_i_generic_sys_proc_log_seq
BEFORE INSERT
ON generic_sys_proc_log
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id    NUMBER;
    v_rec_uuid  VARCHAR(40);

BEGIN
    v_rec_id   := 0;

    SELECT generic_sys_proc_log_seq.nextval 
    INTO   v_rec_id 
    FROM   dual;
    
    SELECT raw_to_guid(SYS_GUID()) 
    INTO   v_rec_uuid 
    FROM   dual;

    :new.rec_id      := v_rec_id;
    :new.rec_uuid    := v_rec_uuid;
    :new.process_key := 0;
    :new.process_id  := 0;

EXCEPTION
    WHEN others THEN
    -- consider logging the error and then re-raise..
    RAISE;

END tr_i_generic_sys_proc_log; 
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL'; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_grant_generic_sys_proc_log
--      PURPOSE: Create grants for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: xxxTSK00xxx_grant_generic_sys_proc_log.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290_Grants-----*/

--GRANT SELECT, INSERT, UPDATE         ON generic_sys_proc_log TO c_%schema%_db_in;
--GRANT SELECT                         ON generic_sys_proc_log TO liw_basic;
--GRANT SELECT                         ON generic_sys_proc_log TO liw_restricted;
--GRANT SELECT                         ON generic_sys_proc_log TO s_%schema%;

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_synonym_generic_sys_proc_log
--      PURPOSE: Create synonyn for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: xxxTSK00xxx_synonym_generic_sys_proc_log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     generic_sys_proc_log
--    Sysdate:         2017-12-13
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        Gene Belford (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320_Synonyms -----*/   

--CREATE PUBLIC SYNONYM generic_sys_proc_log FOR %schema%.generic_sys_proc_log; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_merge_generic_sys_proc_log
--      PURPOSE: Inital load script for generic_sys_proc_log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: xxxTSK00xxxx_merge_generic_sys_proc_log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     generic_sys_proc_log
--    Sysdate:         2017-12-13
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        Gene Belford (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Populate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*
DECLARE

BEGIN 

    MERGE INTO  generic_sys_proc_log tar 
    USING (
        SELECT
            1                   AS process_key , 
            2                   AS process_id ,
            0                   AS source_rec_id ,
            0                   AS lst_update_rec_id
            FROM dual
        ) src
    ON (tar.process_key = src.process_key)
    WHEN NOT MATCHED THEN 
        INSERT (     process_key,     process_id )
        VALUES ( src.process_key, src.process_id )
    WHEN MATCHED THEN
        UPDATE SET 
            tar.process_id = src.process_id;

    COMMIT;    

END;  
*/ 
    
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Validate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*

SELECT * FROM generic_sys_proc_log; 
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
        FROM generic_sys_proc_log 
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
