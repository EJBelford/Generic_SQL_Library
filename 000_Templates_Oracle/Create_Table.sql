-- SOURCE: %YourObjectName%_seq.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%_seq
--      PURPOSE: REC_ID sequence for %YourObjectName%
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
-- Automatically available Auto Replace Keywords:
--    Object Name:     %YourObjectName%
--   Company Name:     %YourOrganization%
--    Sysdate:         %SYSDATE% (YYYY-MM-DD)
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        %USERNAME% (set in TOAD Options, Procedure Editor)
--    Table Space:     %TabSpace%  
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

-- DROP SEQUENCE %YourObjectName%_seq;

CREATE SEQUENCE %YourObjectName%_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 


-- SOURCE: %YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: %Descripton%
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
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

-- DROP TABLE %YourObjectName%;
	
CREATE TABLE %YourObjectName% 
(
    rec_id                           NUMBER              NOT NULL ,
    rec_uuid                         VARCHAR2(40)        NOT NULL ,
--
-- Do a replace of the xx to create base table 
    xx_code                          NUMBER              DEFAULT 0 ,
    xx_desc                          VARCHAR2(20)        DEFAULT 'unk' ,
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
    delete_flag                      CHAR(1)             DEFAULT 'N' ,
    delete_date                      DATE                DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    hidden_by                        VARCHAR2(50)        NULL ,
    hidden_flag                      CHAR(1)             DEFAULT 'N' ,
    hidden_date                      DATE                DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') 
)
PCTUSED 0  PCTFREE 10  INITRANS 1  MAXTRANS 255 
TABLESPACE %TabSpace%
STORAGE ( INITIAL 64K  NEXT 32K  MINEXTENTS 1  MAXEXTENTS  UNLIMITED
            PCTINCREASE 0  BUFFER_POOL  DEFAULT )
LOGGING  NOCOMPRESS  NOCACHE  NOPARALLEL  MONITORING;

/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE %YourObjectName% 
IS '%YourObjectName% - %Descripton%'; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN %YourObjectName%.rec_id 
IS 'REC_ID - Primary, blind key of the %YourObjectName% table.'; 
COMMENT ON COLUMN %YourObjectName%.rec_uuid 
IS 'REC_UUID - Blind uuid key of the %YourObjectName% table.'; 

COMMENT ON COLUMN %YourObjectName%.xx_code 
IS 'xx_CODE - '; 
COMMENT ON COLUMN %YourObjectName%.xx_desc 
IS 'xx_DESC - '; 

COMMENT ON COLUMN %YourObjectName%.status 
IS 'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';
COMMENT ON COLUMN %YourObjectName%.updt_by 
IS 'UPDT_BY - The date/timestamp of when the record was created/updated.';
COMMENT ON COLUMN %YourObjectName%.lst_updt 
IS 'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.';
COMMENT ON COLUMN %YourObjectName%.active_flag 
IS 'ACTIVE_FLAG - Flag indicating if the record is active or not.';
COMMENT ON COLUMN %YourObjectName%.active_date 
IS 'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.';
COMMENT ON COLUMN %YourObjectName%.inactive_date 
IS 'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.';       
COMMENT ON COLUMN %YourObjectName%.insert_by 
IS 'INSERT_BY - Reports who initially created the record.';
COMMENT ON COLUMN %YourObjectName%.insert_date 
IS 'INSERT_DATE - Reports when the record was initially created.';
COMMENT ON COLUMN %YourObjectName%.update_by 
IS 'UPDATE_BY - Reports who last updated the record.';
COMMENT ON COLUMN %YourObjectName%.update_date 
IS 'UPDATE_DATE - Reports when the record was last updated.';
COMMENT ON COLUMN %YourObjectName%.delete_by 
IS 'DELETE_BY - Reports who last deleted the record.';       
COMMENT ON COLUMN %YourObjectName%.delete_flag 
IS 'DELETE_FLAG - Flag indicating if the record can be deleted.';
COMMENT ON COLUMN %YourObjectName%.delete_date 
IS 'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';
COMMENT ON COLUMN %YourObjectName%.hidden_by 
IS 'HIDDEN_BY - Reports who last hide the record.';       
COMMENT ON COLUMN %YourObjectName%.hidden_flag 
IS 'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';
COMMENT ON COLUMN %YourObjectName%.hidden_date 
IS 'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('%YourObjectName%'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('%YourObjectName%') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('%YourObjectName%') 
ORDER BY b.column_id; 
*/


-- SOURCE: pk_%YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Primary key for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE %YourObjectName%  
    ADD CONSTRAINT pk_%YourObjectName% 
    PRIMARY KEY 
    (
    rec_id
    );
    
   
-- SOURCE: ixu_%YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Unique index for ixu_%YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

-- DROP INDEX ixu_%YourObjectName%;

CREATE UNIQUE INDEX ixu_%YourObjectName% 
    ON %YourObjectName%
        (
        xx_code
        );


-- SOURCE: fk_%YourObjectName%_xx_id.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Foreign key for fk_%YourObjectName%_xx_id
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE %YourObjectName%  DROP CONSTRAINT fk_%YourObjectName%_xx_id;        

ALTER TABLE %YourObjectName%  
    ADD CONSTRAINT fk_%YourObjectName%_code_xx_id 
    FOREIGN KEY 
        (
        xx_code
        ) 
    REFERENCES xx_%YourObjectName%_yyyyy_dim
        (
        xx_code
        );


-- SOURCE: ck_%YourObjectName%_act_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Create the active_flag constraint for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE %YourObjectName%  DROP CONSTRAINT ck_%YourObjectName%_act_fl; 

--                          1         2         3
--                 123456789012345678901234567890    

ALTER TABLE %YourObjectName%  
    ADD CONSTRAINT ck_%YourObjectName%_act_fl 
    CHECK (active_flag='I' OR active_flag='N' OR active_flag='Y');


-- SOURCE: ck_%YourObjectName%_del_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Create the delete_flag constraint for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE %YourObjectName%  DROP CONSTRAINT ck_%YourObjectName%_del_fl;    

--                          1         2         3
--                 123456789012345678901234567890    

ALTER TABLE %YourObjectName%  
    ADD CONSTRAINT ck_%YourObjectName%_del_fl 
    CHECK (delete_flag='N' OR delete_flag='Y');


-- SOURCE: ck_%YourObjectName%_hid_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Create the hidden_flag constraint for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE %YourObjectName%  DROP CONSTRAINT ck_%YourObjectName%_hid_fl;  

--                          1         2         3
--                 123456789012345678901234567890    

ALTER TABLE %YourObjectName%  
    ADD CONSTRAINT ck_%YourObjectName%_hid_fl 
    CHECK (hidden_flag='N' OR hidden_flag='Y');


-- SOURCE: ck_%YourObjectName%_stat_fl.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%
--      PURPOSE: Create the status constraint for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE %YourObjectName%  
--     DROP CONSTRAINT ck_%YourObjectName%_stat_fl;        

--                          1         2         3
--                 123456789012345678901234567890    

ALTER TABLE %YourObjectName%  
    ADD CONSTRAINT ck_%YourObjectName%_stat_fl 
    CHECK (status='C' OR status='D' OR status='E' OR status='H' 
        OR status='L' OR status='P' OR status='Q' OR status='R'
        OR status='T' OR status='Z' OR status='N'
        );


-- SOURCE: tr_i_%YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: tr_i_%YourObjectName%
--      PURPOSE: Insert trigger for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER tr_i_%YourObjectName%_seq
BEFORE INSERT
ON %YourObjectName%
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id NUMBER;

BEGIN
    v_rec_id := 0;

    SELECT %YourObjectName%_seq.nextval 
    INTO   v_rec_id 
    FROM   dual;
   
    :new.rec_id   := v_rec_id;
    :new.rec_uuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := sysdate;
    :new.updt_by  := user;

    EXCEPTION
        WHEN others THEN
        -- consider logging the error and then re-raise
        RAISE;
       
END tr_i_%YourObjectName%;
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL'; 

 
-- SOURCE: grant_%YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: grant_%YourObjectName%
--      PURPOSE: Create grants for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290_Grants-----*/

GRANT SELECT, INSERT, UPDATE         ON %YourObjectName% TO eps_admin;
GRANT SELECT                         ON %YourObjectName% TO eps_user;


-- SOURCE: synonym_%YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: synonym_%YourObjectName%
--      PURPOSE: Create synonyn for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320_Synonyms -----*/   

--CREATE PUBLIC SYNONYM %YourObjectName% FOR %schema%.%YourObjectName%; 


-- SOURCE: x_merge_%YourObjectName%.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _merge_%YourObjectName%
--      PURPOSE: Inital load script for %YourObjectName%
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
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Populate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

DECLARE

BEGIN 

    MERGE INTO  %YourObjectName% tar 
    USING (
        SELECT
            1                   AS xx_code , 
            'Test code desc. '  AS xx_desc ,
            0                   AS source_rec_id ,
            0                   AS lst_update_rec_id
            FROM dual
        ) src
    ON (tar.xx_code = src.xx_code)
    WHEN NOT MATCHED THEN 
        INSERT (     xx_code,     xx_desc,     source_rec_id,     lst_update_rec_id )
        VALUES ( src.xx_code, src.xx_desc, src.source_rec_id, src.lst_update_rec_id )
    WHEN MATCHED THEN
        UPDATE SET 
            tar.xx_desc = src.xx_desc;

    COMMIT;    

END;  
/ 
    
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Validate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*

SELECT * FROM %YourObjectName%; 
/  


SET SERVEROUTPUT ON

DECLARE

BEGIN 

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.NEW_LINE;
    
    FOR table_load 
    IN  (
        SELECT rec_id, 
            xx_code,
            xx_desc
        FROM %YourObjectName% 
        ORDER BY rec_id
        )
    LOOP
        DBMS_OUTPUT.PUT_LINE
            (          table_load.rec_id 
            || ', ' || table_load.xx_code 
            || ', ' || table_load.xx_desc
            );
    END LOOP;    -- table_load 
    
END;  
/ 

*/


-- SOURCE: %YourObjectName%_audit.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: %YourObjectName%_audit                                    
--      PURPOSE: Creates an audit table for %YourObjectName% that tracks   
--               changes to the parent table as they are made.  
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
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/

DROP TABLE %YourObjectName%_audit CASCADE CONSTRAINTS;  

CREATE TABLE %YourObjectName%_audit 
(
    rec_id                            INTEGER      NOT NULL,
--
    rec_uuid                          VARCHAR2(50)  NOT NULL, 
--
    cmd                               CHAR(1)      NOT NULL,
    update_date                       TIMESTAMP    NOT NULL,
    update_by                         VARCHAR2(50),
--
    n_xx_code                         NUMBER,
    o_xx_code                         NUMBER,
    n_xx_desc                         VARCHAR2(20),
    o_xx_desc                         VARCHAR2(20), 
--
    PRIMARY KEY (rec_id, cmd, update_date) 
)
PCTFREE 10 PCTUSED 0 TABLESPACE AuthDataSrc_Dev_TabSpace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );


COMMENT ON TABLE %YourObjectName%_audit 
    IS '%YourObjectName%_audit - Creates an audit table for %YourObjectName% that tracks changes to the parent table as they are made.';


-- SOURCE: tr_%YourObjectName%_audit.sql
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018
                        Unpublished, All Rights Reserved
================================================================================
----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
--                                                                            
--        NAME: %YourObjectName%                                            
--     PURPOSE:                                                               
--
--  CREATED BY: %USERNAME%                                                  
-- CREATED DATE: %SYSDATE%                                                   
--                                                                            
--  ASSUMPTIONS:
--
--  LIMITATIONS:
--
--        NOTES:
--
--
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created 
--
/*--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

-- DROP TRIGGER IF EXISTS tr_%YourObjectName%_audit ON %YourObjectName%;

CREATE OR REPLACE TRIGGER tr_%YourObjectName%_audit 
    AFTER INSERT OR UPDATE OR DELETE 
    ON %YourObjectName% 
    FOR EACH ROW 

BEGIN

    IF INSERTING THEN 
        
        INSERT INTO %YourObjectName%_audit 
            (
            rec_id, rec_uuid, cmd, 
            update_date, update_by, 
            n_xx_code, 
            n_xx_desc
            )  
        VALUES ( :NEW.rec_id, :NEW.rec_uuid, 'I', 
            SYSDATE, USER, 
            :NEW.xx_code, 
            :NEW.xx_desc   
            );
    
    ELSIF UPDATING THEN 
        
        INSERT INTO %YourObjectName%_audit 
            (
            rec_id, rec_uuid, cmd, 
            update_date, update_by, 
            n_xx_code,                  o_xx_code,
            n_xx_desc,                  o_xx_desc
            )  
        VALUES ( :NEW.rec_id, :NEW.rec_uuid, 'U', 
            SYSDATE, USER, 
            :NEW.xx_code,                   :OLD.xx_code,
            :NEW.xx_desc,                   :OLD.xx_desc 
            );
    
    ELSIF DELETING THEN 
        
        INSERT INTO %YourObjectName%_audit 
            (
            rec_id, rec_uuid, cmd, 
            update_date, update_by, 
            o_xx_code, 
            o_xx_desc            
            )  
        VALUES ( :OLD.rec_id, :OLD.rec_uuid, 'D', 
            SYSDATE, USER, 
            :OLD.xx_code, 
            :OLD.xx_desc          
            );
    
    END IF;

END;
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';    

