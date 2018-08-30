/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef_seq
--      PURPOSE: REC_ID sequence for EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: EnumValueRef_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - DetailsEnumValueRe
-- 2017-12-12 - euGene Belford  -             - CreatedEnumValueRe 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

DROP SEQUENCE authDataSource_dev.EnumValueRef_seq;

CREATE SEQUENCE authDataSource_dev.EnumValueRef_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: <Descripton>
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: EnumValueRef.sql
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
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

DROP TABLE authDataSource_dev.EnumValueRef CASCADE CONSTRAINTS; 

CREATE TABLE authDataSource_dev.EnumValueRef (
    rec_Id                NUMBER                NOT NULL,
    rec_Uuid              VARCHAR2(40 BYTE)     NOT NULL,
    enum_Type             VARCHAR2(75 BYTE)     NOT NULL,
    enum_Value            VARCHAR2(25 BYTE)     NOT NULL,
    order_By              NUMBER(*,0)           DEFAULT 0,
    enum_Display_Name     VARCHAR2(125 BYTE)    NOT NULL,
    description           VARCHAR2(2000 BYTE),
    constant_Flag         CHAR(1 BYTE)          DEFAULT 'N',
    enum_Type_Rec_Id      NUMBER                NOT NULL,
    enum_Type_Rec_Uuid    VARCHAR2(40 BYTE)     NOT NULL,
    status                VARCHAR2(1 BYTE)      DEFAULT 'N',
    updt_By               VARCHAR2(50 BYTE)     DEFAULT SUBSTR(USER,1,50),
    lst_Updt              DATE                  DEFAULT SYSTIMESTAMP,
    active_Flag           VARCHAR2(1 BYTE)      DEFAULT 'Y',
    active_Date           DATE                  DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    inactive_Date         DATE                  DEFAULT TO_DATE('31-DEC-2099','DD-MON-YYYY'),
    insert_By             VARCHAR2(50 BYTE)     DEFAULT SUBSTR(USER,1,50),
    insert_Date           DATE                  DEFAULT SYSTIMESTAMP,
    update_By             VARCHAR2(50 BYTE),
    update_Date           DATE                  DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    delete_By             VARCHAR2(50 BYTE),
    delete_Flag           VARCHAR2(1 BYTE)      DEFAULT 'N',
    delete_Date           DATE                  DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    hidden_By             VARCHAR2(50 BYTE),
    hidden_Flag           VARCHAR2(1 BYTE)      DEFAULT 'N',
    hidden_Date           DATE                  DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY')
)
PCTFREE 10 PCTUSED 0 TABLESPACE AuthDataSrc_Dev_TabSpace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE authDataSource_dev.EnumValueRef IS
    'EnumValueRef - Individual enumeration values that belong under a particular enumeration type. ';


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.rec_Id IS
    'rec_Id - Primary, blind key of the enum_values table.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.rec_Uuid IS
    'rec_Uuid - Blind uuid key of the enum_values table.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.enum_Type IS
    'enum_Type - Name/identifier of the overarching enumeration type that this value belongs to. ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.enum_Value IS
    'enum_Value - The actual specific enumeration value.  ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.order_By IS
    'order_By - Integer value used to create a custom sort order not possible programmatically. ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.enum_Display_Name IS
    'enum_Display_Name - What the user would see in a drop down or in a report. ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.description IS
    'description - Brief description of the enumeration value.  ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.constant_Flag IS
    'constant_Flag - Whether or not enumeration value is unchangeable or dynamic.  ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.enum_Type_Rec_Id IS
    'enum_Type_Rec_Id -  Id pointer to the parent enum type. ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.enum_Type_Rec_Uuid IS
    'enum_Type_Rec_Uuid -  Uuid pointer to the parent enum type. ';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.status IS
    'status - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.updt_By IS
    'updt_By - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.lst_Updt IS
    'lst_Updt - Indicates either the program name or user ID of the person who updated the record.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.active_Flag IS
    'active_Flag - Flag indicating if the record is active or not.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.active_Date IS
    'active_Date - Additional control for active_Fl indicating when the record became active.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.inactive_Date IS
    'inactive_Date - Additional control for active_Fl indicating when the record went inactive.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.insert_By IS
    'insert_By - Reports who initially created the record.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.insert_Date IS
    'insert_Date - Reports when the record was initially created.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.update_By IS
    'update_By - Reports who last updated the record.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.update_Date IS
    'update_Date - Reports when the record was last updated.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.delete_By IS
    'delete_By - Reports who last deleted the record.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.delete_Flag IS
    'delete_Flag - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.delete_Date IS
    'delete_Date - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.hidden_By IS
    'hidden_By - Reports who last hide the record.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.hidden_Flag IS
    'hidden_Flag - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';

COMMENT ON COLUMN authDataSource_dev.EnumValueRef.hidden_Date IS
    'hidden_Date - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('EnumValueRef'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('EnumValueRef') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('EnumValueRef') 
ORDER BY b.column_id; 
*/

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Primary key for EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: pk_EnumValueRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT pk_enumValueRef PRIMARY KEY ( enum_type, enum_value )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE AuthDataSrc_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Unique index for ixu_EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ixu_EnumValueRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

--CREATE UNIQUE INDEX authDataSource_dev.ixu_enumvalueref ON
--    authDataSource_dev.EnumValueRef (
--        enum_type     ASC,
--        enum_value    ASC  )
--        TABLESPACE AuthDataSrc_Dev_TabSpace PCTFREE 10
--            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
--1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
--        COMPUTE STATISTICS;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Foreign key for fk_EnumValueRef_xx_id
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: fk_EnumValueRef_xx_id.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

-- ALTER TABLE EnumValueRef  DROP CONSTRAINT ixu_enumvalueref_recid;        

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT ixu_enumvalueref_recid UNIQUE ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE AuthDataSrc_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


-- ALTER TABLE EnumValueRef  DROP CONSTRAINT ixu_enumvalueref_recuuid;        

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT ixu_enumvalueref_recuuid UNIQUE ( rec_uuid )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE AuthDataSrc_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Create the status_flag constraint for EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_EnumValueRef_stat_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who             - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumValueRef  DROP CONSTRAINT ck_EnumValueRef_stat_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT ckEnumValueRef_stat_fl CHECK (
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
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Create the active_flag constraint for EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_EnumValueRef_act_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumValueRef  DROP CONSTRAINT ck_EnumValueRef_act_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT ckEnumValueRef_act_fl CHECK (
        active_flag = 'I'
        OR active_flag = 'N'
        OR active_flag = 'Y'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Create the delete_flag constraint for EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_EnumValueRef_del_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumValueRef  DROP CONSTRAINT ck_EnumValueRef_del_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT ckEnumValueRef_del_fl CHECK (
        delete_flag = 'N'
        OR delete_flag = 'Y'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: EnumValueRef
--      PURPOSE: Create the hidden_flag constraint for EnumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: ck_EnumValueRef_hid_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-12 - euGene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE EnumValueRef  DROP CONSTRAINT ck_EnumValueRef_hid_fl; 

--                                      1         2         3
--                             123456789012345678901234567890    

ALTER TABLE authDataSource_dev.EnumValueRef
    ADD CONSTRAINT ck_enumvalueref_hid_fl CHECK (
        hidden_flag = 'N'
        OR hidden_flag = 'Y'
    );


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: tr_i_enumValueRef
--      PURPOSE: Insert trigger for enumValueRef
--
--   CREATED BY: euGene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: tr_i_enumValueRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-12 - euGene Belford  -             - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER authDataSource_dev.TR_I_ENUMVALUEREF_SEQ 
    BEFORE INSERT ON authDataSource_dev.EnumValueRef REFERENCING 
    NEW AS New 
    OLD AS Old 
    FOR EACH ROW 
DECLARE

    v_recid NUMBER;

BEGIN
    v_recid := 0;

    SELECT enumValueRef_seq.nextval 
    INTO   v_recid 
    FROM   dual;

    :new.rec_id   := v_recid;
    :new.rec_uuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := sysdate;
    :new.updt_by  := user;

    EXCEPTION
        WHEN others THEN
        -- consider logging the issue and then re-raiseEnumValueRe
        RAISE;

END tr_i_enumValueRef_seq;
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _grant_EnumValueRef
--      PURPOSE: Create grants for EnumValueRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE:            _grant_EnumValueRef.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-12 - Gene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290 - Grants-----*/

GRANT SELECT, INSERT, UPDATE         ON EnumValueRef TO eps_admin;
GRANT SELECT                         ON EnumValueRef TO eps_user;

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                   Copyright, Belford DB Consulting LLC, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME:            _synonym_EnumValueRef
--      PURPOSE: Create synonyn for EnumValueRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE:            _synonym_EnumValueRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details
-- 2017-12-12 - Gene Belford  -             - Created 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320 - Synonyms -----*/   

--CREATE PUBLIC SYNONYM EnumValueRef FOR authDataSource_dev.EnumValueRef; 

        