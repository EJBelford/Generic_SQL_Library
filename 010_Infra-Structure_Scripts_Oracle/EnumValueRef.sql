DROP SEQUENCE prds_dev.EnumValueRef_seq;

CREATE SEQUENCE prds_dev.EnumValueRef_seq
--    START WITH 1000000 
    MINVALUE   1
    NOCYCLE
    NOCACHE
    NOORDER; 

/*----------------*/

DROP TABLE prds_dev.EnumValueRef CASCADE CONSTRAINTS; 

CREATE TABLE prds_dev.EnumValueRef (
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
PCTFREE 10 PCTUSED 0 TABLESPACE prds_dev_tabspace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT ck_enum_value_ref_stat_fl CHECK (
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

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT ck_enum_value_ref_act_fl CHECK (
        active_flag = 'I'
        OR active_flag = 'N'
        OR active_flag = 'Y'
    );

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT ck_enum_value_ref_del_fl CHECK (
        delete_flag = 'N'
        OR delete_flag = 'Y'
    );

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT ck_enumvalueref_hid_fl CHECK (
        hidden_flag = 'N'
        OR hidden_flag = 'Y'
    );

COMMENT ON TABLE prds_dev.EnumValueRef IS
    'EnumValueRef - Individual enumeration values that belong under a particular enumeration type. ';

COMMENT ON COLUMN prds_dev.EnumValueRef.rec_Id IS
    'rec_Id - Primary, blind key of the enum_values table.';

COMMENT ON COLUMN prds_dev.EnumValueRef.rec_Uuid IS
    'rec_Uuid - Blind uuid key of the enum_values table.';

COMMENT ON COLUMN prds_dev.EnumValueRef.enum_Type IS
    'enum_Type - Name/identifier of the overarching enumeration type that this value belongs to. ';

COMMENT ON COLUMN prds_dev.EnumValueRef.enum_Value IS
    'enum_Value - The actual specific enumeration value.  ';

COMMENT ON COLUMN prds_dev.EnumValueRef.order_By IS
    'order_By - Integer value used to create a custom sort order not possible programmatically. ';

COMMENT ON COLUMN prds_dev.EnumValueRef.enum_Display_Name IS
    'enum_Display_Name - What the user would see in a drop down or in a report. ';

COMMENT ON COLUMN prds_dev.EnumValueRef.description IS
    'description - Brief description of the enumeration value.  ';

COMMENT ON COLUMN prds_dev.EnumValueRef.constant_Flag IS
    'constant_Flag - Whether or not enumeration value is unchangeable or dynamic.  ';

COMMENT ON COLUMN prds_dev.EnumValueRef.enum_Type_Rec_Id IS
    'enum_Type_Rec_Id -  Id pointer to the parent enum type. ';

COMMENT ON COLUMN prds_dev.EnumValueRef.enum_Type_Rec_Uuid IS
    'enum_Type_Rec_Uuid -  Uuid pointer to the parent enum type. ';

COMMENT ON COLUMN prds_dev.EnumValueRef.status IS
    'status - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';

COMMENT ON COLUMN prds_dev.EnumValueRef.updt_By IS
    'updt_By - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN prds_dev.EnumValueRef.lst_Updt IS
    'lst_Updt - Indicates either the program name or user ID of the person who updated the record.';

COMMENT ON COLUMN prds_dev.EnumValueRef.active_Flag IS
    'active_Flag - Flag indicating if the record is active or not.';

COMMENT ON COLUMN prds_dev.EnumValueRef.active_Date IS
    'active_Date - Additional control for active_Fl indicating when the record became active.'
;

COMMENT ON COLUMN prds_dev.EnumValueRef.inactive_Date IS
    'inactive_Date - Additional control for active_Fl indicating when the record went inactive.'
;

COMMENT ON COLUMN prds_dev.EnumValueRef.insert_By IS
    'insert_By - Reports who initially created the record.';

COMMENT ON COLUMN prds_dev.EnumValueRef.insert_Date IS
    'insert_Date - Reports when the record was initially created.';

COMMENT ON COLUMN prds_dev.EnumValueRef.update_By IS
    'update_By - Reports who last updated the record.';

COMMENT ON COLUMN prds_dev.EnumValueRef.update_Date IS
    'update_Date - Reports when the record was last updated.';

COMMENT ON COLUMN prds_dev.EnumValueRef.delete_By IS
    'delete_By - Reports who last deleted the record.';

COMMENT ON COLUMN prds_dev.EnumValueRef.delete_Flag IS
    'delete_Flag - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN prds_dev.EnumValueRef.delete_Date IS
    'delete_Date - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';

COMMENT ON COLUMN prds_dev.EnumValueRef.hidden_By IS
    'hidden_By - Reports who last hide the record.';

COMMENT ON COLUMN prds_dev.EnumValueRef.hidden_Flag IS
    'hidden_Flag - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';

COMMENT ON COLUMN prds_dev.EnumValueRef.hidden_Date IS
    'hidden_Date - Addition control for HIDDEN_FLAG indicating when the record was hidden.'
;

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT ixu_enumvalueref_recid UNIQUE ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE prds_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT ixu_enumvalueref_recuuid UNIQUE ( rec_uuid )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE prds_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

CREATE UNIQUE INDEX prds_dev.ixu_enumvalueref ON
    prds_dev.EnumValueRef (
        enum_type
    ASC,
        enum_value
    ASC )
        TABLESPACE prds_dev_tabspace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE prds_dev.EnumValueRef
    ADD CONSTRAINT pk_enumvalueref PRIMARY KEY ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE prds_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

/*--:----1----:----2----:----3----:----4----:----5----:----6----:----7----:---*/   
/* CREATE OR REPLACE TRIGGER                                                  */
/*--:----1----:----2----:----3----:----4----:----5----:----6----:----7----:---*/   

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

CREATE OR REPLACE TRIGGER prds_dev.TR_I_ENUMVALUEREF_SEQ 
    BEFORE INSERT ON prds_dev.EnumValueRef REFERENCING 
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
        -- consider logging the issue and then re-raise..
        RAISE;

END tr_i_enumValueRef_seq;
/

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:ALL';

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
        