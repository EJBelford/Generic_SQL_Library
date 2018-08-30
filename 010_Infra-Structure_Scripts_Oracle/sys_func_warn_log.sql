/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log_seq
--      PURPOSE: REC_ID sequence for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: Sys_Func_Warn_Log_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

-- DROP SEQUENCE Sys_Func_Warn_Log_seq;

CREATE SEQUENCE Sys_Func_Warn_Log_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: <Descripton>
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: Sys_Func_Warn_Log.sql
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
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

-- DROP TABLE Sys_Func_Warn_Log CASCADE CONSTRAINTS;
	
CREATE TABLE Sys_Func_Warn_Log 
(
    rec_id                           NUMBER                     NOT NULL ,
    rec_uuid                         VARCHAR2(40)               NOT NULL ,
--
    warning_type                     VARCHAR(50) ,
    warning_from                     VARCHAR(100) , 
    warning_msg                      VARCHAR(2000) , 
    warning_status                   CHAR(1)                    DEFAULT 'C' , 
    warning_timestamp                TIMESTAMP WITH TIME ZONE   DEFAULT SYSDATE , 
    warning_action                   VARCHAR(2000) , 
--
    status                           CHAR(1)                    DEFAULT 'N' ,
    updt_by                          VARCHAR2(50)               DEFAULT SUBSTR(USER, 1, 50) ,
    lst_updt                         DATE                       DEFAULT SYSDATE ,
--
    active_flag                      CHAR(1)                    DEFAULT 'Y' , 
    active_date                      DATE                       DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') , 
    inactive_date                    DATE                       DEFAULT TO_DATE('31-DEC-2099', 'DD-MON-YYYY') ,
--
    insert_by                        VARCHAR2(50)               DEFAULT SUBSTR(USER, 1, 50) , 
    insert_date                      DATE                       DEFAULT SYSDATE , 
    update_by                        VARCHAR2(50)               NULL ,
    update_date                      DATE                       DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    delete_by                        VARCHAR2(50)               NULL ,
    delete_flag                      CHAR(1)                    DEFAULT 'N' ,
    delete_date                      DATE                       DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    hidden_by                        VARCHAR2(50)               NULL ,
    hidden_flag                      CHAR(1)                    DEFAULT 'N' ,
    hidden_date                      DATE                       DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') 
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

COMMENT ON TABLE Sys_Func_Warn_Log 
IS 'Sys_Func_Warn_Log - <Descripton>'; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN Sys_Func_Warn_Log.rec_id 
IS 'REC_ID - Primary, blind key of the Sys_Func_Warn_Log table.'; 
COMMENT ON COLUMN Sys_Func_Warn_Log.rec_uuid 
IS 'REC_UUID - Blind uuid key of the Sys_Func_Warn_Log table.'; 

COMMENT ON COLUMN Sys_Func_Warn_Log.warning_type 
IS 'warning_type - PROCESSING/DATA INTEGRITY/REVIEW REQUIRED/tdb as idicated by raising module.';
COMMENT ON COLUMN Sys_Func_Warn_Log.warning_from 
IS 'warning_from - Should contain the name of the raising module with the entire calling string.';
COMMENT ON COLUMN Sys_Func_Warn_Log.warning_msg 
IS 'warning_msg - Information with the rasing module that helps resolve, and/or research the issue.';
COMMENT ON COLUMN Sys_Func_Warn_Log.warning_status 
IS 'warning_status - A 1 character code for the statsu of the record, (Current, Error, Historical, New, Processing, Waiting)'; 
COMMENT ON COLUMN Sys_Func_Warn_Log.warning_timestamp  
IS 'warning_timestamp - The timestamp of when warning was recorded.';
COMMENT ON COLUMN Sys_Func_Warn_Log.warning_action 
IS 'warning_action - The action taken to coreect the warning.';
 

COMMENT ON COLUMN Sys_Func_Warn_Log.status 
IS 'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';
COMMENT ON COLUMN Sys_Func_Warn_Log.updt_by 
IS 'UPDT_BY - The date/timestamp of when the record was created/updated.';
COMMENT ON COLUMN Sys_Func_Warn_Log.lst_updt 
IS 'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.';
COMMENT ON COLUMN Sys_Func_Warn_Log.active_flag 
IS 'ACTIVE_FLAG - Flag indicating if the record is active or not.';
COMMENT ON COLUMN Sys_Func_Warn_Log.active_date 
IS 'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.';
COMMENT ON COLUMN Sys_Func_Warn_Log.inactive_date 
IS 'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.';
COMMENT ON COLUMN Sys_Func_Warn_Log.insert_by 
IS 'INSERT_BY - Reports who initially created the record.';
COMMENT ON COLUMN Sys_Func_Warn_Log.insert_date 
IS 'INSERT_DATE - Reports when the record was initially created.';
COMMENT ON COLUMN Sys_Func_Warn_Log.update_by 
IS 'UPDATE_BY - Reports who last updated the record.';
COMMENT ON COLUMN Sys_Func_Warn_Log.update_date 
IS 'UPDATE_DATE - Reports when the record was last updated.';
COMMENT ON COLUMN Sys_Func_Warn_Log.delete_by 
IS 'DELETE_BY - Reports who last deleted the record.';       
COMMENT ON COLUMN Sys_Func_Warn_Log.delete_flag 
IS 'DELETE_FLAG - Flag indicating if the record can be deleted.';
COMMENT ON COLUMN Sys_Func_Warn_Log.delete_date 
IS 'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';
COMMENT ON COLUMN Sys_Func_Warn_Log.hidden_by 
IS 'HIDDEN_BY - Reports who last hide the record.';       
COMMENT ON COLUMN Sys_Func_Warn_Log.hidden_flag 
IS 'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';
COMMENT ON COLUMN Sys_Func_Warn_Log.hidden_date 
IS 'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('Sys_Func_Warn_Log'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('Sys_Func_Warn_Log') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('Sys_Func_Warn_Log') 
ORDER BY b.column_id; 
*/

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Primary key for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: pk_Sys_Func_Warn_Log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE Sys_Func_Warn_Log  
    ADD CONSTRAINT pk_Sys_Func_Warn_Log 
    PRIMARY KEY 
    (
    rec_id
    );
    
   
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Unique index for ixu_Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: ixu_Sys_Func_Warn_Log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

-- DROP INDEX ixu_Sys_Func_Warn_Log;

--CREATE UNIQUE INDEX ixu_Sys_Func_Warn_Log 
--    ON Sys_Func_Warn_Log
--        (
--        xx_code
--        );

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Foreign key for fk_Sys_Func_Warn_Log_xx_id..
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: fk_Sys_Func_Warn_Log_xx_id.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE Sys_Func_Warn_Log  DROP CONSTRAINT fk_Sys_Func_Warn_Log_xx_id;        

--ALTER TABLE Sys_Func_Warn_Log  
--    ADD CONSTRAINT fk_Sys_Func_Warn_Log_code_xx_id 
--    FOREIGN KEY 
--        (
--        xx_code
--        ) 
--    REFERENCES xx_Sys_Func_Warn_Log_yyyyy_dim
--        (
--        xx_code
--        );

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Create the active_flag constraint for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: ck_Sys_Func_Warn_Log_act_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE Sys_Func_Warn_Log  DROP CONSTRAINT ck_Sys_Func_Warn_Log_act_fl; 

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE Sys_Func_Warn_Log  
    ADD CONSTRAINT ck_Sys_Func_Warn_Log_act_fl 
    CHECK (active_flag='I' OR active_flag='N' OR active_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Create the delete_flag constraint for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: ck_Sys_Func_Warn_Log_del_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE Sys_Func_Warn_Log  DROP CONSTRAINT ck_Sys_Func_Warn_Log_del_fl;    

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE Sys_Func_Warn_Log  
    ADD CONSTRAINT ck_Sys_Func_Warn_Log_del_fl 
    CHECK (delete_flag='N' OR delete_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Create the hidden_flag constraint for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: ck_Sys_Func_Warn_Log_hid_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE Sys_Func_Warn_Log  DROP CONSTRAINT ck_Sys_Func_Warn_Log_hid_fl;  

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE Sys_Func_Warn_Log  
    ADD CONSTRAINT ck_Sys_Func_Warn_Log_hid_fl 
    CHECK (hidden_flag='N' OR hidden_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: Sys_Func_Warn_Log
--      PURPOSE: Create the status constraint for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: ck_Sys_Func_Warn_Log_stat_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE Sys_Func_Warn_Log  
--     DROP CONSTRAINT ck_Sys_Func_Warn_Log_stat_fl;        

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE Sys_Func_Warn_Log  
    ADD CONSTRAINT ck_Sys_Func_Warn_Log_stat_fl 
    CHECK (status='C' OR status='D' OR status='E' OR status='H' 
        OR status='L' OR status='P' OR status='Q' OR status='R'
        OR status='T' OR status='Z' OR status='N'
        );

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: tr_i_Sys_Func_Warn_Log
--      PURPOSE: Insert trigger for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: tr_i_Sys_Func_Warn_Log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

CREATE OR REPLACE TRIGGER tr_i_Sys_Func_Warn_Log_seq
BEFORE INSERT
ON Sys_Func_Warn_Log
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id NUMBER;

BEGIN
    v_rec_id := 0;

    SELECT Sys_Func_Warn_Log_seq.nextval 
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
       
END tr_i_Sys_Func_Warn_Log;
 
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_grant_Sys_Func_Warn_Log
--      PURPOSE: Create grants for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: xxxTSK00xxx_grant_Sys_Func_Warn_Log.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290_Grants-----*/

--GRANT SELECT, INSERT, UPDATE         ON Sys_Func_Warn_Log TO c_%schema%_db_in;
--GRANT SELECT                         ON Sys_Func_Warn_Log TO liw_basic;
--GRANT SELECT                         ON Sys_Func_Warn_Log TO liw_restricted;
--GRANT SELECT                         ON Sys_Func_Warn_Log TO s_%schema%;

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_synonym_Sys_Func_Warn_Log
--      PURPOSE: Create synonyn for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: xxxTSK00xxx_synonym_Sys_Func_Warn_Log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320_Synonyms -----*/   

--CREATE PUBLIC SYNONYM Sys_Func_Warn_Log FOR %schema%.Sys_Func_Warn_Log; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_merge_Sys_Func_Warn_Log
--      PURPOSE: Inital load script for Sys_Func_Warn_Log
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2013-12-17
--
--       SOURCE: xxxTSK00xxxx_merge_Sys_Func_Warn_Log.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- 2013-12-17 - Gene Belford  -             - Created 
-- 2018-07-17 - Gene Belford  -             - 11g Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Populate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*
DECLARE

BEGIN 

    MERGE INTO  Sys_Func_Warn_Log tar 
    USING (
        SELECT
            'warning_type'    AS warning_type,
            'warning_from'    AS warning_from, 
            'warning_msg'     AS warning_msg, 
            'warning_action'  AS warning_action 
        FROM dual 
        ) src
    ON (tar.warning_type = src.warning_type)
    WHEN NOT MATCHED THEN 
        INSERT (     warning_type,     warning_from,     warning_msg,      warning_action )
        VALUES ( src.warning_type, src.warning_from, src.warning_msg, src. warning_action )
    WHEN MATCHED THEN
        UPDATE SET 
            tar.warning_msg = 'Matched';

    COMMIT;    

END; */  
/ 
    
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Validate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*

SELECT * FROM Sys_Func_Warn_Log; 
/  


SET SERVEROUTPUT ON

DECLARE

BEGIN 

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.NEW_LINE;
    
    FOR table_load 
    IN  (
        SELECT rec_id, 
            rec_uuid, 
            warning_type,
            warning_from, 
            warning_msg, 
            warning_action 
        FROM Sys_Func_Warn_Log 
        ORDER BY rec_id
        )
    LOOP
        DBMS_OUTPUT.PUT_LINE
            (          table_load.rec_id 
            || ', ' || table_load.rec_uuid 
            || ', ' || table_load.warning_type 
            || ', ' || table_load.warning_from
            || ', ' || table_load.warning_msg
            || ', ' || table_load.warning_action
            );
    END LOOP;    -- table_load.. 
    
END;  
/ 

*/
