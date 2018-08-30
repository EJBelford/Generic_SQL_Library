
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: sys_debug_tbl_seq
--      PURPOSE: REC_ID sequence for sys_debug_tbl
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-07-18
--
--       SOURCE: sys_debug_tbl_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details.
-- 2018-07-18 - Gene Belford  -             - Created. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

-- DROP SEQUENCE sys_debug_tbl_seq;

CREATE SEQUENCE sys_debug_tbl_seq
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
--
--         NAME: sys_debug_tbl
--      PURPOSE: Used in %YourObjectname% processing to capture unexpected  
--               errors in processing as well as general program debugging  
--               during development.  Production systems should expect no  
--               records to be created.  Creation of a record is considerred 
--               a problem.
--               The design was taken from U.S. Army Logistic Support Agency 
--               (LOGSA) Post Fielding Support Analysis (PFSA). 
--
--   CREATED BY: G. Belford
-- CREATED DATE: 18-Nov-2009
--
--       SOURCE: sys_debug_tbl.sql
--
--  ASSUMPTIONS:
--
--  LIMITATIONS:
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--     Change History:
-- DD-MMM-YYYY - Who         - RDP / ECP # - Details
-- 18-Nov-2009 - G. Belford  - RDPTSK00xxx - Created 
-- 16-Jul-2018 - G. Belford  -             - Validated
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Create Table  -----*/

-- DROP TABLE SYS_DEBUG_TBL CASCADE CONSTRAINTS;
	
CREATE TABLE sys_debug_tbl 
(
    rec_id                           NUMBER              NOT NULL ,
--
    msg_dt                           DATE, 
    proc_name                        VARCHAR2(128),
    oerr                             VARCHAR2(6),
    cd_ptr                           VARCHAR2(10),
    calling_proc                     VARCHAR2(100),
    proc_data                        VARCHAR2(200),
    debug_msg                        VARCHAR2(200) 
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

COMMENT ON TABLE sys_debug_tbl 
IS 'sys_debug_tbl - Used in processing to capture unexpected errors in processing as well as general program debugging during development.  Production systems should expect no records to be created.  Creation of a record is considerred a problem.'; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN sys_debug_tbl.rec_id 
IS 'REC_ID - Primary, blind key of the sys_debug_tbl table.'; 

COMMENT ON COLUMN sys_debug_tbl.proc_name 
IS 'PROC_NAME - The actual procedure/function/process in which the error occurred.';

COMMENT ON COLUMN sys_debug_tbl.ps_oerr 
IS 'PS_OERR - The actual oracle error number returned when the error is encountered.  Should be null for coder generated debug statements used in development';

COMMENT ON COLUMN sys_debug_tbl.cd_ptr 
IS 'CD_PTR - A coder generated location in the procedure/function/process.  Standard for all code is ''Begin'' as a default';

COMMENT ON COLUMN sys_debug_tbl.calling_proc 
IS 'CALLING_PROC - Calling procedure name, used in debugging, calling procedure responsible for maintaining heirachy.';

COMMENT ON COLUMN sys_debug_tbl.proc_data 
IS 'PROC_DATA - A coder generated text identification to identify what data was being processed when the error occurred.  Note the limit in size';

COMMENT ON COLUMN sys_debug_tbl.debug_msg 
IS 'DEBUG_MSG - A coder generated descriptive message';

COMMENT ON COLUMN sys_debug_tbl.msg_dt 
IS 'MSG_DT - The date/timestamp of when the debug record was created';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('sys_debug_tbl'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('sys_debug_tbl') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('sys_debug_tbl') 
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


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2018>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: sys_proc_ref
--      PURPOSE: Primary key for sys_proc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-07-18
--
--       SOURCE: pk_sys_proc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details.
-- 2018-07-18 - Gene Belford  -             - Created. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE sys_debug_tbl  
    ADD CONSTRAINT pk_sys_debug_tbl 
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
--         NAME: tr_i_sys_debug_tbl
--      PURPOSE: Insert trigger for sys_debug_tbl
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-07-18
--
--       SOURCE: tr_i_sys_debug_tbl.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details.
-- 2018-07-18 - Gene Belford  -             - Created. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER tr_i_sys_debug_tbl_seq
BEFORE INSERT
ON sys_debug_tbl
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id NUMBER;

BEGIN
    v_rec_id := 0;

    SELECT sys_debug_tbl_seq.nextval 
    INTO   v_rec_id 
    FROM   dual;
   
    :new.rec_id   := v_rec_id;

    EXCEPTION
        WHEN others THEN
        -- consider logging the error and then re-raise.
        RAISE;
       
END tr_i_sys_debug_tbl;
/
 
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL'; 
