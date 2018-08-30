/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_value_assoc_seq
--      PURPOSE: REC_ID sequence for enum_value_assoc
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: enum_value_assoc_seq.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who           - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 170_Sequence  -----*/

DROP SEQUENCE enum_value_assoc_ref_seq;

CREATE SEQUENCE enum_value_assoc_ref_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_value_assoc_ref
--      PURPOSE: Individual enumeration values that belong under a particular 
--               enumeration type.
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: enum_value_assoc_ref.sql
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
-- 2018-05-15 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 180_Create Table  -----*/

DROP TABLE enum_value_assoc_ref;
	
CREATE TABLE enum_value_assoc_ref 
(
    rec_id                           NUMBER              NOT NULL ,
    rec_uuid                         VARCHAR2(40)        NOT NULL ,
--
    enum_type                        VARCHAR2(25)        NOT NULL ,
    enum_value                       VARCHAR2(25)        NOT NULL ,
    enum_assoc_type                  VARCHAR2(25)        NOT NULL ,
    enum_assoc_code                  VARCHAR2(25)        NOT NULL ,
    enum_assoc_name                  VARCHAR2(50)        NOT NULL ,
    enum_assoc_desc                  VARCHAR2(2000) ,	
    enum_value_rec_id                NUMBER              NOT NULL ,
    enum_value_rec_uuid              VARCHAR2(40)        NOT NULL ,
--
    status                           VARCHAR2(1)         DEFAULT 'N' ,
    updt_by                          VARCHAR2(50)        DEFAULT SUBSTR(USER, 1, 50) ,
    lst_updt                         DATE                DEFAULT SYSDATE ,
--
    active_flag                      VARCHAR2(1)         DEFAULT 'Y' , 
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
) SEGMENT CREATION IMMEDIATE 
    PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
STORAGE ( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT 
    )
TABLESPACE "PDS_TABSPACE";

/*----- Table Meta-Data -----*/ 

COMMENT ON TABLE enum_value_assoc_ref 
IS 'enum_value_assoc_ref - Allowsthe user to associate custom values with particuler enumeration value.  For example if a user wished to redefine an exisitng value to a new value a "map" would be defined betwwen the two values. '; 


/*----- Column Meta-Data -----*/ 

COMMENT ON COLUMN enum_value_assoc_ref.rec_id 
IS 'REC_ID - Primary, blind key of the enum_value_assocs table.'; 
COMMENT ON COLUMN enum_value_assoc_ref.rec_uuid 
IS 'REC_UUID - Blind uuid key of the enum_value_assocs table.'; 

COMMENT ON COLUMN enum_value_assoc_ref.enum_type 
IS 'enum_type - Name/identifier of the overarching enumeration type that this value belongs to.  ';
COMMENT ON COLUMN enum_value_assoc_ref.enum_assoc_type 
IS 'enum_assoc_type -  ';
COMMENT ON COLUMN enum_value_assoc_ref.enum_assoc_name 
IS 'enum_assoc_name -  ';
COMMENT ON COLUMN enum_value_assoc_ref.enum_assoc_desc 
IS 'enum_assoc_desc - Brief description of the enumeration association value.  ';	
COMMENT ON COLUMN enum_value_assoc_ref.enum_value_rec_id 
IS 'enum_value_rec_id -  ';
COMMENT ON COLUMN enum_value_assoc_ref.enum_value_rec_uuid 
IS 'enum_value_rec_uuid -  ';

COMMENT ON COLUMN enum_value_assoc_ref.status 
IS 'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';
COMMENT ON COLUMN enum_value_assoc_ref.updt_by 
IS 'UPDT_BY - The date/timestamp of when the record was created/updated.';
COMMENT ON COLUMN enum_value_assoc_ref.lst_updt 
IS 'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.';
COMMENT ON COLUMN enum_value_assoc_ref.active_flag 
IS 'ACTIVE_FLAG - Flag indicating if the record is active or not.';
COMMENT ON COLUMN enum_value_assoc_ref.active_date 
IS 'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.';
COMMENT ON COLUMN enum_value_assoc_ref.inactive_date 
IS 'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.';
COMMENT ON COLUMN enum_value_assoc_ref.insert_by 
IS 'INSERT_BY - Reports who initially created the record.';
COMMENT ON COLUMN enum_value_assoc_ref.insert_date 
IS 'INSERT_DATE - Reports when the record was initially created.';
COMMENT ON COLUMN enum_value_assoc_ref.update_by 
IS 'UPDATE_BY - Reports who last updated the record.';
COMMENT ON COLUMN enum_value_assoc_ref.update_date 
IS 'UPDATE_DATE - Reports when the record was last updated.';
COMMENT ON COLUMN enum_value_assoc_ref.delete_by 
IS 'DELETE_BY - Reports who last deleted the record.';       
COMMENT ON COLUMN enum_value_assoc_ref.delete_flag 
IS 'DELETE_FLAG - Flag indicating if the record can be deleted.';
COMMENT ON COLUMN enum_value_assoc_ref.delete_date 
IS 'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';
COMMENT ON COLUMN enum_value_assoc_ref.hidden_by 
IS 'HIDDEN_BY - Reports who last hide the record.';       
COMMENT ON COLUMN enum_value_assoc_ref.hidden_flag 
IS 'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';
COMMENT ON COLUMN enum_value_assoc_ref.hidden_date 
IS 'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

/*----- Check to see if the table comment is present -----*/
/*
SELECT table_name, comments 
FROM   user_tab_comments 
WHERE  table_name = UPPER('enum_value_assoc_ref'); 
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
LEFT OUTER JOIN user_tab_columns b ON b.table_name = UPPER('enum_value_assoc_ref') 
    AND  a.column_name = b.column_name
WHERE    a.table_name = UPPER('enum_value_assoc_ref') 
ORDER BY b.column_id; 
*/

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_value_assoc_ref
--      PURPOSE: Primary key for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: pk_enum_value_assoc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 213_Primary Key -----*/

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT pk_enum_value_assoc_ref 
    PRIMARY KEY 
    (
    rec_id
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
--         NAME: enum_value_assoc_ref
--      PURPOSE: Unique index for ixu_enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: ixu_enum_value_assoc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 220_Indexs -----*/

-- DROP INDEX ixu_enum_value_assoc_ref;

CREATE UNIQUE INDEX ixu_enum_value_assoc_ref 
    ON enum_value_assoc_ref
        (
        enum_type, 
		enum_value, 
		enum_assoc_type,
        enum_assoc_code
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
--         NAME: enum_value_assoc_ref
--      PURPOSE: Foreign key for fk_enum_value_assocs_xx_id..
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: fk_enum_value_assoc_ref_xx_id.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 215_Foreign Key -----*/

ALTER TABLE enum_value_assoc_ref  DROP CONSTRAINT fk_enumvalueassoc_enumtype;        

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT fk_enumvalueassoc_enumtype 
    FOREIGN KEY 
        (
        enum_type
        ) 
    REFERENCES enum_type_ref
        (
        enum_type
        ); 

/*----- 215_Foreign Key -----*/

ALTER TABLE enum_value_assoc_ref  DROP CONSTRAINT fk_enumassocref_enumvaluerecid;        

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT fk_enumassocref_enumvaluerecid 
    FOREIGN KEY 
        (
        enum_value_rec_id
        ) 
    REFERENCES enum_value_ref
        (
        rec_id
        ); 

/*----- 215_Foreign Key -----*/

ALTER TABLE enum_value_assoc_ref  DROP CONSTRAINT fk_enumassocref_enumvalueuuid;        

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT fk_enumassocref_enumvalueuuid 
    FOREIGN KEY 
        (
        enum_value_rec_uuid
        ) 
    REFERENCES enum_type_ref
        (
        rec_uuid
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
--         NAME: enum_value_assoc_ref
--      PURPOSE: Create the active_flag constraint for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: ck_enum_value_assocs_act_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE enum_value_assocs  DROP CONSTRAINT ck_enum_value_assocs_act_fl; 

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT ck_enum_value_assoc_ref_act_fl 
    CHECK (active_flag='I' OR active_flag='N' OR active_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_value_assoc_ref
--      PURPOSE: Create the delete_flag constraint for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: ck_enum_value_assoc_ref_del_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE enum_value_assocs  DROP CONSTRAINT ck_enum_value_assocs_del_fl;    

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT ck_enum_value_assoc_ref_del_fl 
    CHECK (delete_flag='N' OR delete_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_value_assoc_ref
--      PURPOSE: Create the hidden_flag constraint for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: ck_enum_value_assoc_ref_hid_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE enum_value_assocs  DROP CONSTRAINT ck_enum_value_assoc_ref_hid_fl;  

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT ck_enum_value_assoc_ref_hid_fl 
    CHECK (hidden_flag='N' OR hidden_flag='Y');

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: enum_value_assoc_ref
--      PURPOSE: Create the status constraint for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: ck_enum_value_assoc_ref_stat_fl.sql
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 217_Constraints -----*/

-- ALTER TABLE enum_value_assoc_ref  
--     DROP CONSTRAINT ck_enum_valu_assoc_ref_stat_fl;        

--                          1         2         3..
--                 123456789012345678901234567890..    

ALTER TABLE enum_value_assoc_ref  
    ADD CONSTRAINT ck_enum_valu_assoc_ref_stat_fl 
    CHECK (status='C' OR status='D' OR status='E' OR status='H' 
        OR status='L' OR status='P' OR status='Q' OR status='R'
        OR status='T' OR status='Z' OR status='N'
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
--         NAME: tr_i_enum_value_assoc_ref
--      PURPOSE: Insert trigger for enum_value_assoc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: tr_i_enum_value_assoc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 270_Trigger -----*/

CREATE OR REPLACE TRIGGER tr_i_enum_value_assoc_ref_seq
BEFORE INSERT
ON "EnumValueAssocRef"
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

DECLARE

    v_rec_id NUMBER;

	FUNCTION raw_to_guid( raw_guid IN RAW ) RETURN VARCHAR2
	IS
	hex VARCHAR2(32);
  
	BEGIN

		hex := RAWTOHEX(raw_guid);

		RETURN SUBSTR(hex, 7, 2) 
			|| SUBSTR(hex, 5, 2) 
			|| SUBSTR(hex, 3, 2) 
			|| SUBSTR(hex, 1, 2) 
			|| '-'
			|| SUBSTR(hex, 11, 2) 
			|| SUBSTR(hex, 9, 2) 
			|| '-'
			|| SUBSTR(hex, 15, 2) 
			|| SUBSTR(hex, 13, 2) 
			|| '-'
			|| SUBSTR(hex, 17, 4) 
			|| '-'
			|| SUBSTR(hex, 21, 12);

	END;

BEGIN
    v_rec_id := 0;

    SELECT "EnumValueAssocRef_SEQ".nextval 
    INTO   v_rec_id 
    FROM   dual;
   
    :new.recid   := v_rec_id;
    :new.recuuid := raw_to_guid(SYS_GUID());
    :new.status   := 'C';
    :new.lst_updt := sysdate;
    :new.updt_by  := user;

    EXCEPTION
        WHEN others THEN
        -- consider logging the error and then re-raise..
        RAISE;
       
END tr_i_enum_value_assocs;
 
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_grant_enum_value_assoc_ref
--      PURPOSE: Create grants for enum_value_assoc_ref
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: xxxTSK00xxx_grant_enum_value_assoc_ref.sql
--
--        NOTES:
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - RDPTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 290_Grants-----*/

--GRANT SELECT, INSERT, UPDATE         ON enum_value_assoc_ref TO c_%schema%_db_in;
--GRANT SELECT                         ON enum_value_assoc_ref TO liw_basic;
--GRANT SELECT                         ON enum_value_assoc_ref TO liw_restricted;
--GRANT SELECT                         ON enum_value_assoc_ref TO s_%schema%;

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_synonym_enum_value_assoc_ref
--      PURPOSE: Create synonyn for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: xxxTSK00xxx_synonym_enum_value_assoc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     enum_value_assocs
--    Sysdate:         2018-05-15
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        Gene Belford (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- 320_Synonyms -----*/   

--CREATE PUBLIC SYNONYM enum_value_assoc_ref 
--FOR "PDS".enum_value_assoc_ref; 

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, Booz Allen Hamilton, 2018
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: xxxTSK00xxx_merge_enum_value_assocs
--      PURPOSE: Inital load script for enum_value_assocs
--
--   CREATED BY: Gene Belford
-- CREATED DATE: 2018-05-15
--
--       SOURCE: xxxTSK00xxxx_merge_enum_value_assoc_ref.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     enum_value_assocs
--    Sysdate:         2018-05-15
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        Gene Belford (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- 2018-05-15 - Gene Belford  - xxxTSK00xxx - Created.. 
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
--    MERGE INTO  enum_value_assoc_ref tar 
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
/ 
    
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*                                                                            */
/*                                 Validate                                   */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*

SELECT * FROM enum_value_assoc_ref; 
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
        FROM enum_value_assoc_ref 
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
