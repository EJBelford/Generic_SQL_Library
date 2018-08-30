/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef_seq
--      PURPOSE: REC_ID sequence for EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: EnumTypeRef_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

DROP SEQUENCE authDataSource_dev.EnumTypeRef_seq;

CREATE SEQUENCE authDataSource_dev.EnumTypeRef_seq
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
--         NAME: EnumTypeRef
--      PURPOSE: <Descripton>
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: EnumTypeRef.sql
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
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

DROP TABLE authDataSource_dev.EnumTypeRef CASCADE CONSTRAINTS;

CREATE TABLE authDataSource_dev.EnumTypeRef (
    ads_id           NUMBER                             NOT NULL,
    ads_uuid         VARCHAR2(40 BYTE)                  NOT NULL,
    enum_type        VARCHAR2(75 BYTE)                  NOT NULL,
    enum_type_desc   VARCHAR2(3000 BYTE)                NOT NULL,
    classification   VARCHAR2(100 BYTE)                 DEFAULT '(U)',
    constant_flag    CHAR(1 BYTE)                       DEFAULT 'N',
    ads_src_name     VARCHAR2(25 BYTE),
    ads_src_version  VARCHAR2(10 BYTE)                  DEFAULT 'v000',
    status           VARCHAR2(1 BYTE)                   DEFAULT 'N',
    updt_by          VARCHAR2(50 BYTE)                  DEFAULT substr(user,1,50),
    lst_updt         DATE                               DEFAULT SYSDATE,
    active_flag      CHAR(1 BYTE)                       DEFAULT 'Y',
    active_date      DATE                               DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    inactive_date    DATE                               DEFAULT TO_DATE('31-DEC-2099','DD-MON-YYYY'),
    insert_by        VARCHAR2(50 BYTE)                  DEFAULT substr(user,1,50),
    insert_date      DATE                               DEFAULT SYSDATE,
    update_by        VARCHAR2(50 BYTE),
    update_date      DATE                               DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    delete_by        VARCHAR2(50 BYTE),
    delete_flag      CHAR(1 BYTE)                       DEFAULT 'N',
    delete_date      DATE                               DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    hidden_by        VARCHAR2(50 BYTE),
    hidden_flag      CHAR(1 BYTE)                       DEFAULT 'N',
    hidden_date      DATE                               DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY')
)
PCTFREE 10 PCTUSED 0 TABLESPACE AuthDataSrc_Dev_TabSpace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );


/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE authDataSource_dev.EnumTypeRef IS
    'enumTypeRef - The overarching data object that represents whole enumerations in the database by their names.';


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.ads_id IS
    'ads_id - Primary, blind key of the enumTypeRef table.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.ads_uuid IS
    'ads_uuid - Blind uuid key of the enumTypeRef table.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.enum_type IS
    'ENUM_TYPE - Identifying name of the enumeration in the database.  ';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.enum_type_desc IS
    'ENUM_TYPE_DESC - Brief description of the enumeration.  ';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.classification IS
    'CLASSIFICATION - This simple type is used by the classification attribute to identify the highest level of classification of the information being encoded.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.constant_flag IS
    'CONSTANT_FLAG - Whether or not the enumeration is constant (unchangeable, probably used in the system), or dynamic (changeable, probably just used for visualization purposes).';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.ads_src_name IS
    'ADS_SRC_NAME - The source of the enumeration type. ';
    
COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.ads_src_version IS
    'ADS_SRC_VERSION - Unquie identifier used to designate a specific version od enum type. ';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.status IS
    'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.updt_by IS
    'UPDT_BY - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.lst_updt IS
    'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.active_flag IS
    'ACTIVE_FLAG - Flag indicating if the record is active or not.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.active_date IS
    'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.inactive_date IS
    'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.insert_by IS
    'INSERT_BY - Reports who initially created the record.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.insert_date IS
    'INSERT_DATE - Reports when the record was initially created.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.update_by IS
    'UPDATE_BY - Reports who last updated the record.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.update_date IS
    'UPDATE_DATE - Reports when the record was last updated.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.delete_by IS
    'DELETE_BY - Reports who last deleted the record.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.delete_flag IS
    'DELETE_FLAG - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.delete_date IS
    'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.hidden_by IS
    'HIDDEN_BY - Reports who last hide the record.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.hidden_flag IS
    'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';

COMMENT ON COLUMN authDataSource_dev.EnumTypeRef.hidden_date IS
    'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.';


/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('EnumTypeRef'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('EnumTypeRef') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('EnumTypeRef') 
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
--
--         NAME: EnumTypeRef
--      PURPOSE: Primary key for EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: pk_EnumTypeRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT pk_enumTypeRef PRIMARY KEY ( enum_type )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE AuthDataSrc_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef
--      PURPOSE: Unique index for ixu_EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ixu_EnumTypeRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

-- DROP INDEX pk_enumTypeRef;

CREATE UNIQUE INDEX authDataSource_dev.pk_enumTypeRef ON
    authDataSource_dev.EnumTypeRef (
        enum_type
    ASC )
        TABLESPACE AuthDataSrc_Dev_TabSpace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef
--      PURPOSE: Foreign key for fk_EnumTypeRef_xx_id
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: fk_EnumTypeRef_xx_id.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ixu_enumtyperef_recid;        

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT ixu_enumtyperef_recid UNIQUE ( ads_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE AuthDataSrc_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ixu_enumtyperef_recuuid;        

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT ixu_enumtyperef_recuuid UNIQUE ( ads_uuid )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE AuthDataSrc_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef
--      PURPOSE: Create the status_flag constraint for EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_EnumTypeRef_stat_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ck_EnumTypeRef_stat_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT ck_enumTypeRef_stat_fl CHECK (
        status = 'C'
        OR status = 'D'
        OR status = 'E'
        OR status = 'H'
        OR status = 'L'
        OR status = 'P'
        OR status = 'Q'
        OR status = 'R'
        OR status = 'T'
        OR status = 'Z'
        OR status = 'N'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef
--      PURPOSE: Create the active_flag constraint for EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_EnumTypeRef_act_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ck_EnumTypeRef_act_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT ck_enumTypeRef_act_fl CHECK (
        active_flag = 'I'
        OR active_flag = 'N'
        OR active_flag = 'Y'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef
--      PURPOSE: Create the delete_flag constraint for EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_EnumTypeRef_del_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ck_EnumTypeRef_del_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT ck_enumTypeRef_del_fl CHECK (
        delete_flag = 'N'
        OR delete_flag = 'Y'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumTypeRef
--      PURPOSE: Create the hidden_flag constraint for EnumTypeRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: ck_EnumTypeRef_hid_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-13 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ck_EnumTypeRef_hid_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumTypeRef
    ADD CONSTRAINT ck_enumTypeRef_hid_fl CHECK (
        hidden_flag = 'N'
        OR hidden_flag = 'Y'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: tr_i_EnumTypeRef
--      PURPOSE: Insert trigger for EnumTypeRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: tr_i_EnumTypeRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  -             - Created.. 
--
/*DECLARE
--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER authDataSource_dev.TR_I_ENUMTYPEREF_SEQ 
    BEFORE INSERT ON authDataSource_dev.EnumTypeRef REFERENCING 
    NEW AS New 
    OLD AS Old 
    FOR EACH ROW 
    
DECLARE

    v_recid NUMBER;

BEGIN
    v_recid := 0;

    SELECT enumtyperef_seq.nextval 
    INTO   v_recid 
    FROM   dual;

    :new.ads_id   := v_recid;
    :new.ads_uuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := sysdate;
    :new.updt_by  := user;

    EXCEPTION
        WHEN others THEN
        -- consider logging the issue and then re-raise
        RAISE;

END tr_i_enumTypeRef_seq;
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL'; 


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _grant_EnumTypeRef
--      PURPOSE: Create grants for EnumTypeRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE:            _grant_enumTypeRef.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-13 - Gene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290 - Grants-----*/

GRANT SELECT, INSERT, UPDATE         ON EnumTypeRef TO eps_admin;
GRANT SELECT                         ON EnumTypeRef TO eps_user;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _synonym_enumTypeRef
--      PURPOSE: Create synonyn for EnumTypeRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE:            _synonym_enumTypeRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details
-- 2017-12-13 - Gene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320 - Synonyms -----*/   

--CREATE PUBLIC SYNONYM EnumTypeRef FOR authDataSource_dev.EnumTypeRef; 

