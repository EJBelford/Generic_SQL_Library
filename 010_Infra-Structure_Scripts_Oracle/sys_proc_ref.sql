
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: sys_proc_ref_seq
--      PURPOSE: REC_ID sequence for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: sys_proc_ref_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

-- DROP SEQUENCE sys_proc_ref_seq;

CREATE SEQUENCE sys_proc_ref_seq
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
--         NAME: sys_proc_ref
--      PURPOSE: <Descripton>
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: sys_proc_ref.sql
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
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

-- DROP TABLE sys_proc_ref CASCADE CONSTRAINTS;
	
CREATE TABLE sys_proc_ref 
(
    rec_id                           NUMBER           NOT NULL ,
    rec_uuid                         VARCHAR2(40)     NOT NULL ,
--
    process_id                       NUMBER           UNIQUE,
    process_name                     VARCHAR2(50)     UNIQUE, 
    process_run_ctrl                 NUMBER,
    process_run_ctrl_override        CHAR(1)          DEFAULT 'N',
    debug_on_flag                    NUMBER           DEFAULT 0,
--
    status                           CHAR(1)          DEFAULT 'N' ,
    updt_by                          VARCHAR2(50)     DEFAULT SUBSTR(USER, 1, 50) ,
    lst_updt                         TIMESTAMP(0)     DEFAULT SYSDATE ,
--
    active_flag                      CHAR(1)          DEFAULT 'Y' , 
    active_date                      TIMESTAMP(0)     DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') , 
    inactive_date                    TIMESTAMP(0)     DEFAULT TO_DATE('31-DEC-2099', 'DD-MON-YYYY') ,
--
    insert_by                        VARCHAR2(50)     DEFAULT SUBSTR(USER, 1, 50) , 
    insert_date                      TIMESTAMP(0)     DEFAULT SYSDATE , 
    update_by                        VARCHAR2(50)     NULL ,
    update_date                      TIMESTAMP(0)     DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    delete_by                        VARCHAR2(50)     NULL ,
    delete_flag                      CHAR(1)          DEFAULT 'N' ,
    delete_date                      TIMESTAMP(0)     DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') ,
    hidden_by                        VARCHAR2(50)     NULL ,
    hidden_flag                      CHAR(1)          DEFAULT 'N' ,
    hidden_date                      TIMESTAMP(0)     DEFAULT TO_DATE('01-JAN-1900', 'DD-MON-YYYY') 
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

COMMENT ON TABLE sys_proc_ref 
IS 'sys_proc_ref - <Descripton>'; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN sys_proc_ref.rec_id 
IS 'REC_ID - Primary, blind key of the sys_proc_ref table.'; 
COMMENT ON COLUMN sys_proc_ref.rec_uuid 
IS 'REC_UUID - Blind uuid key of the sys_proc_ref table.'; 

COMMENT ON COLUMN sys_proc_ref.process_id 
IS 'PROCESS_ID - A unique integer identifier used to identify a given process. ';
COMMENT ON COLUMN sys_proc_ref.process_name 
IS 'PROCESS_NAME - The name of the process/description';
COMMENT ON COLUMN sys_proc_ref.process_run_ctrl 
IS 'PROCESS_RUN_CTRL - ';
COMMENT ON COLUMN sys_proc_ref.process_run_ctrl_override 
IS 'PROCESS_RUN_CTRL_OVERRIDE - Controls whether to manually override the process control.';

COMMENT ON COLUMN sys_proc_ref.status 
IS 'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';
COMMENT ON COLUMN sys_proc_ref.updt_by 
IS 'UPDT_BY - The date/timestamp of when the record was created/updated.';
COMMENT ON COLUMN sys_proc_ref.lst_updt 
IS 'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.';
COMMENT ON COLUMN sys_proc_ref.active_flag 
IS 'ACTIVE_FLAG - Flag indicating if the record is active or not.';
COMMENT ON COLUMN sys_proc_ref.active_date 
IS 'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.';
COMMENT ON COLUMN sys_proc_ref.inactive_date 
IS 'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.';
COMMENT ON COLUMN sys_proc_ref.insert_by 
IS 'INSERT_BY - Reports who initially created the record.';
COMMENT ON COLUMN sys_proc_ref.insert_date 
IS 'INSERT_DATE - Reports when the record was initially created.';
COMMENT ON COLUMN sys_proc_ref.update_by 
IS 'UPDATE_BY - Reports who last updated the record.';
COMMENT ON COLUMN sys_proc_ref.update_date 
IS 'UPDATE_DATE - Reports when the record was last updated.';
COMMENT ON COLUMN sys_proc_ref.delete_by 
IS 'DELETE_BY - Reports who last deleted the record.';       
COMMENT ON COLUMN sys_proc_ref.delete_flag 
IS 'DELETE_FLAG - Flag indicating if the record can be deleted.';
COMMENT ON COLUMN sys_proc_ref.delete_date 
IS 'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';
COMMENT ON COLUMN sys_proc_ref.hidden_by 
IS 'HIDDEN_BY - Reports who last hide the record.';       
COMMENT ON COLUMN sys_proc_ref.hidden_flag 
IS 'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';
COMMENT ON COLUMN sys_proc_ref.hidden_date 
IS 'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('sys_proc_ref'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('sys_proc_ref') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('sys_proc_ref') 
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
--         NAME: sys_proc_ref
--      PURPOSE: Primary key for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: pk_sys_proc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE sys_proc_ref  
    ADD CONSTRAINT pk_sys_proc_ref 
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
--         NAME: sys_proc_ref
--      PURPOSE: Unique index for ixu_sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ixu_sys_proc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

-- DROP INDEX ixu_sys_proc_ref;

--CREATE UNIQUE INDEX ixu_sys_proc_ref 
--    ON sys_proc_ref
--        (
--        process_id
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
--         NAME: sys_proc_ref
--      PURPOSE: Foreign key for fk_sys_proc_ref_xx_id..
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: fk_sys_proc_ref_xx_id.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE sys_proc_ref  DROP CONSTRAINT fk_sys_proc_ref_xx_id;        

--ALTER TABLE sys_proc_ref  
--    ADD CONSTRAINT fk_sys_proc_ref_code_xx_id 
--    FOREIGN KEY 
--        (
--        xx_code
--        ) 
--    REFERENCES xx_sys_proc_ref_yyyyy_dim
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
--         NAME: sys_proc_ref
--      PURPOSE: Create the active_flag constraint for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_sys_proc_ref_act_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE sys_proc_ref  DROP CONSTRAINT ck_sys_proc_ref_act_fl; 

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE sys_proc_ref  
    ADD CONSTRAINT ck_sys_proc_ref_act_fl 
    CHECK (active_flag='I' OR active_flag='N' OR active_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: sys_proc_ref
--      PURPOSE: Create the delete_flag constraint for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_sys_proc_ref_del_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE sys_proc_ref  DROP CONSTRAINT ck_sys_proc_ref_del_fl;    

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE sys_proc_ref  
    ADD CONSTRAINT ck_sys_proc_ref_del_fl 
    CHECK (delete_flag='N' OR delete_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: sys_proc_ref
--      PURPOSE: Create the hidden_flag constraint for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_sys_proc_ref_hid_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE sys_proc_ref  DROP CONSTRAINT ck_sys_proc_ref_hid_fl;  

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE sys_proc_ref  
    ADD CONSTRAINT ck_sys_proc_ref_hid_fl 
    CHECK (hidden_flag='N' OR hidden_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: sys_proc_ref
--      PURPOSE: Create the status constraint for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_sys_proc_ref_stat_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE sys_proc_ref  
--     DROP CONSTRAINT ck_sys_proc_ref_statfl;        

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE sys_proc_ref  
    ADD CONSTRAINT ck_sys_proc_ref_statfl 
    CHECK (status='C' OR status='D' OR status='E' OR status='H' 
        OR status='L' OR status='P' OR status='Q' OR status='R'
        OR status='T' OR status='Z' OR status='N'
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
--         NAME: tr_i_sys_proc_ref
--      PURPOSE: Insert trigger for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: tr_i_sys_proc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

CREATE OR REPLACE TRIGGER tr_i_sys_proc_ref_seq
BEFORE INSERT
ON sys_proc_ref
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id NUMBER;

BEGIN
    v_rec_id := 0;

    SELECT sys_proc_ref_seq.nextval 
    INTO   v_rec_id 
    FROM   dual;
   
    :new.rec_id   := v_rec_id;
    :new.rec_uuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := SYSDATE;
    :new.updt_by  := USER;

    EXCEPTION
        WHEN others THEN
        -- consider logging the error and then re-raise..
        RAISE;
       
END tr_i_sys_proc_ref;
/
 
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _grant_sys_proc_ref
--      PURPOSE: Create grants for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE:            _grant_sys_proc_ref.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290_Grants-----*/

--GRANT SELECT, INSERT, UPDATE         ON sys_proc_ref TO c_%schema%_db_in;
--GRANT SELECT                         ON sys_proc_ref TO liw_basic;
--GRANT SELECT                         ON sys_proc_ref TO liw_restricted;
--GRANT SELECT                         ON sys_proc_ref TO s_%schema%;

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _synonym_sys_proc_ref
--      PURPOSE: Create synonyn for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE:            _synonym_sys_proc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320_Synonyms -----*/   

--CREATE PUBLIC SYNONYM sys_proc_ref FOR %schema%.sys_proc_ref; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _merge_sys_proc_ref
--      PURPOSE: Inital load script for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE:            x_merge_sys_proc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Populate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*
DECLARE

BEGIN 

    MERGE INTO  sys_proc_ref tar 
    USING (
        SELECT
            -3                                     AS process_id ,
            'Test proc name'                       AS process_name 
            FROM dual
        ) src
    ON (tar.process_id = src.process_id)
    WHEN NOT MATCHED THEN 
        INSERT (     process_id,     process_name )
        VALUES ( src.process_id, src.process_name )
    WHEN MATCHED THEN
        UPDATE SET 
            tar.process_name = src.process_name;

    COMMIT;    

END;  
*/
    
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Validate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*

SELECT * FROM sys_proc_ref; 
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
        FROM sys_proc_ref 
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
