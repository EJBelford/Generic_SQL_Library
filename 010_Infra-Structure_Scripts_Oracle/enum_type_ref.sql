/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_type_ref_seq
--      PURPOSE: REC_ID sequence for enum_type_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: enum_type_ref_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2017-12-13 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

-- DROP SEQUENCE enum_type_ref_seq;

CREATE SEQUENCE enum_type_ref_seq
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
--         NAME: enum_type_ref
--      PURPOSE: <Descripton>
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: enum_type_ref.sql
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

-- DROP TABLE enum_type_ref CASCADE CONSTRAINTS;

CREATE TABLE enum_type_ref (
    rec_Id            NUMBER                NOT NULL,
    rec_Uuid          VARCHAR2(40 BYTE)     NOT NULL,
    enum_Type         VARCHAR2(75 BYTE)     NOT NULL,
    enum_Type_Desc    VARCHAR2(3000 BYTE)   NOT NULL,
    classification    VARCHAR2(100 BYTE)    DEFAULT '(U)',
    constant_Flag     CHAR(1 BYTE)          DEFAULT 'N',
    source_Name       VARCHAR2(25 BYTE),
    source_version    VARCHAR2(10 BYTE)                  DEFAULT 'v000',
    status            VARCHAR2(1 BYTE)      DEFAULT 'N',
    updt_By           VARCHAR2(50 BYTE)     DEFAULT substr(user,1,50),
    lst_Updt          TIMESTAMP DEFAULT     SYSDATE,
    active_Flag       CHAR(1 BYTE)          DEFAULT 'Y',
    active_Date       TIMESTAMP             DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    inactive_Date     TIMESTAMP             DEFAULT TO_DATE('31-DEC-2099','DD-MON-YYYY'),
    insert_By         VARCHAR2(50 BYTE)     DEFAULT substr(user,1,50),
    insert_Date       TIMESTAMP             DEFAULT SYSDATE,
    update_By         VARCHAR2(50 BYTE),
    update_Date       TIMESTAMP             DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    delete_By         VARCHAR2(50 BYTE),
    delete_Flag       CHAR(1 BYTE)          DEFAULT 'N',
    delete_Date       TIMESTAMP             DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    hidden_By         VARCHAR2(50 BYTE),
    hidden_Flag       CHAR(1 BYTE)          DEFAULT 'N',
    hidden_Date       TIMESTAMP             DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY')
)
PCTFREE 10 PCTUSED 0 TABLESPACE Generic_Dev_TabSpace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );


/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE enum_type_ref IS
    'EnumTypeRef - The overarching data object that represents whole enumerations in the database by their names.';


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN enum_type_ref.rec_Id IS
    'rec_Id - Primary, blind key of the enum_type_ref table.';

COMMENT ON COLUMN enum_type_ref.rec_Uuid IS
    'rec_Uuid - Blind uuid key of the enum_type_ref table.';

COMMENT ON COLUMN enum_type_ref.enum_Type IS
    'enum_Type - Identifying name of the enumeration in the database.  ';

COMMENT ON COLUMN enum_type_ref.enum_Type_Desc IS
    'enum_Type_Desc - Brief description of the enumeration.  ';

COMMENT ON COLUMN enum_type_ref.classification IS
    'classification - This simple type is used by the classification attribute to identify the highest level of classification of the information being encoded.';

COMMENT ON COLUMN enum_type_ref.constant_Flag IS
    'constant_Flag - Whether or not the enumeration is constant (unchangeable, probably used in the system), or dynamic (changeable, probably just used for visualization purposes).';

COMMENT ON COLUMN enum_type_ref.source_name IS 
    'enum_Source_Name - The source of the enumeration type. ';

COMMENT ON COLUMN enum_type_ref.source_version IS
    'source_version - Unquie identifier used to designate a specific version od enum type. ';
    
COMMENT ON COLUMN enum_type_ref.status IS
    'status - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';

COMMENT ON COLUMN enum_type_ref.updt_By IS
    'updt_By - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN enum_type_ref.lst_Updt IS
    'lst_Updt - Indicates either the program name or user ID of the person who updated the record.';

COMMENT ON COLUMN enum_type_ref.active_Flag IS
    'active_Flag - Flag indicating if the record is active or not.';

COMMENT ON COLUMN enum_type_ref.active_Date IS
    'active_Date - Additional control for active_Fl indicating when the record became active.';

COMMENT ON COLUMN enum_type_ref.inactive_Date IS
    'inactive_Date - Additional control for active_Fl indicating when the record went inactive.';

COMMENT ON COLUMN enum_type_ref.insert_By IS
    'insert_By - Reports who initially created the record.';

COMMENT ON COLUMN enum_type_ref.insert_Date IS
    'insert_Date - Reports when the record was initially created.';

COMMENT ON COLUMN enum_type_ref.update_By IS
    'update_By - Reports who last updated the record.';

COMMENT ON COLUMN enum_type_ref.update_Date IS
    'update_Date - Reports when the record was last updated.';

COMMENT ON COLUMN enum_type_ref.delete_By IS
    'delete_By - Reports who last deleted the record.';

COMMENT ON COLUMN enum_type_ref.delete_Flag IS
    'delete_Flag - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN enum_type_ref.delete_Date IS
    'delete_Date - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';

COMMENT ON COLUMN enum_type_ref.hidden_By IS
    'hidden_By - Reports who last hide the record.';

COMMENT ON COLUMN enum_type_ref.hidden_Flag IS
    'hidden_Flag - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';

COMMENT ON COLUMN enum_type_ref.hidden_Date IS
    'hidden_Date - Addition control for HIDDEN_FLAG indicating when the record was hidden.';


/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('enum_type_ref'); 
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
WHERE    a.table_name = UPPER('enum_type_ref') 
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

ALTER TABLE enum_type_ref
    ADD CONSTRAINT pk_enum_type_ref PRIMARY KEY ( enum_type )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE Generic_Dev_TabSpace
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

-- DROP INDEX pk_enum_type_ref;

CREATE UNIQUE INDEX pk_enum_type_ref ON
    enum_type_ref (
        enum_type
    ASC )
        TABLESPACE Generic_Dev_TabSpace PCTFREE 10
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

ALTER TABLE enum_type_ref
    ADD CONSTRAINT ixu_enumtyperef_recuuid UNIQUE ( rec_uuid )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE Generic_Dev_TabSpace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;


-- ALTER TABLE EnumTypeRef  DROP CONSTRAINT ixu_enumtyperef_recuuid;        

ALTER TABLE enum_type_ref
    ADD CONSTRAINT ixu_enumtyperef_recid UNIQUE ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE Generic_Dev_TabSpace
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

--                   1         2         3
--          123456789012345678901234567890    

ALTER TABLE enum_type_ref
    ADD CONSTRAINT ck_enum_type_ref_stat_fl CHECK (
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

--                   1         2         3
--          123456789012345678901234567890    

ALTER TABLE enum_type_ref
    ADD CONSTRAINT ck_enum_type_ref_act_fl CHECK (
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

--                   1         2         3
--          123456789012345678901234567890    

ALTER TABLE enum_type_ref
    ADD CONSTRAINT ck_enum_type_ref_del_fl CHECK (
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

--                   1         2         3
--          123456789012345678901234567890    

ALTER TABLE enum_type_ref
    ADD CONSTRAINT ck_enum_type_ref_hid_fl CHECK (
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
--         NAME: tr_i_enum_type_ref
--      PURPOSE: Insert trigger for enum_type_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-13
--
--       SOURCE: tr_i_enum_type_ref.sql
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

CREATE OR REPLACE TRIGGER tr_i_enum_type_ref_seq
    BEFORE INSERT ON enum_type_ref REFERENCING 
    NEW AS New 
    OLD AS Old
    FOR EACH ROW

DECLARE

    v_recid    NUMBER;

BEGIN
    v_recid   := 0;

    SELECT enum_type_ref_seq.nextval 
    INTO   v_recid 
    FROM   dual;
    
    :new.rec_id   := v_recid;
    :new.rec_uuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := sysdate;
    :new.updt_by  := user;

EXCEPTION
    WHEN others THEN
    -- consider logging the error and then re-raise..
    RAISE;

END tr_i_enum_type_ref; 
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
--         NAME: xxxTSK00xxx_grant_EnumTypeRef
--      PURPOSE: Create grants for EnumTypeRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: xxxTSK00xxx_grant_EnumTypeRef.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290 - Grants-----*/

--GRANT SELECT, INSERT, UPDATE         ON EnumTypeRef TO eps_admin;
--GRANT SELECT                         ON EnumTypeRef TO eps_user;


/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_synonym_EnumTypeRef
--      PURPOSE: Create synonyn for EnumTypeRef
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2017-12-12
--
--       SOURCE: xxxTSK00xxx_synonym_EnumTypeRef.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2017-12-12 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320 - Synonyms -----*/   

--CREATE PUBLIC SYNONYM EnumTypeRef FOR pds.EnumTypeRef; 

