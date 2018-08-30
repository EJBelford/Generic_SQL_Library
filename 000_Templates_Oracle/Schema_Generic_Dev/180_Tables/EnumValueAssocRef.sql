DROP TABLE generic_dev."EnumValueAssocRef" CASCADE CONSTRAINTS;

CREATE TABLE generic_dev."EnumValueAssocRef" (
    rec_Id                 NUMBER NOT NULL,
    rec_Uuid               VARCHAR2(40 BYTE) NOT NULL,
    enum_Type              VARCHAR2(25 BYTE) NOT NULL,
    enum_Value             VARCHAR2(25 BYTE) NOT NULL,
    enum_Assoc_Type        VARCHAR2(25 BYTE) NOT NULL,
    enum_Assoc_Code        VARCHAR2(25 BYTE) NOT NULL,
    enum_Assoc_Name        VARCHAR2(50 BYTE) NOT NULL,
    enum_Assoc_Desc        VARCHAR2(2000 BYTE),
    enum_Value_Rec_Id      NUMBER NOT NULL,
    enum_Value_Rec_Uuid    VARCHAR2(40 BYTE) NOT NULL,
    status                 VARCHAR2(1 BYTE) DEFAULT 'N',
    updt_By                VARCHAR2(50 BYTE) DEFAULT substr(user,1,50),
    lst_Updt               DATE DEFAULT SYSDATE,
    active_Flag            VARCHAR2(1 BYTE) DEFAULT 'Y',
    active_Date            DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    inactive_Date          DATE DEFAULT TO_DATE('31-DEC-2099','DD-MON-YYYY'),
    insert_By              VARCHAR2(50 BYTE) DEFAULT substr(user,1,50),
    insert_Date            DATE DEFAULT SYSDATE,
    update_By              VARCHAR2(50 BYTE),
    update_Date            DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    delete_By              VARCHAR2(50 BYTE),
    delete_Flag            VARCHAR2(1 BYTE) DEFAULT 'N',
    delete_Date            DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    hidden_By              VARCHAR2(50 BYTE),
    hidden_Flag            VARCHAR2(1 BYTE) DEFAULT 'N',
    hidden_Date            DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY')
)
PCTFREE 10 PCTUSED 40 TABLESPACE generic_dev_tabspace LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE generic_dev."EnumValueAssocRef"
    ADD CONSTRAINT ck_enum_valu_assoc_ref_stat_fl CHECK (
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

ALTER TABLE generic_dev."EnumValueAssocRef"
    ADD CONSTRAINT ck_EnumValueAssocRef_act_fl CHECK (
        active_flag = 'I'
        OR active_flag = 'N'
        OR active_flag = 'Y'
    );

ALTER TABLE generic_dev."EnumValueAssocRef"
    ADD CONSTRAINT ck_EnumValueAssocRef_del_fl CHECK (
        delete_flag = 'N'
        OR delete_flag = 'Y'
    );

ALTER TABLE generic_dev."EnumValueAssocRef"
    ADD CONSTRAINT ck_EnumValueAssocRef_hid_fl CHECK (
        hidden_flag = 'N'
        OR hidden_flag = 'Y'
    );

COMMENT ON TABLE generic_dev."EnumValueAssocRef" IS
    '"EnumValueAssocRef" - Allowsthe user to associate custom values with particuler enumeration value.  For example if a user wished to redefine an exisitng value to a new value a "map" would be defined betwwen the two values. '
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".rec_id IS
    'rec_id - Primary, blind key of the enum_value_assocs table.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".rec_uuid IS
    'rec_uuid - Blind uuid key of the enum_value_assocs table.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".enum_type IS
    'enum_type - Name/identifier of the overarching enumeration type that this value belongs to.  '
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".enum_assoc_type IS
    'enum_assoc_type -  ';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".enum_assoc_name IS
    'enum_assoc_name -  ';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".enum_assoc_desc IS
    'enum_assoc_desc - Brief description of the enumeration association value.  ';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".enum_value_rec_id IS
    'enum_value_rec_id -  ';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".enum_value_rec_uuid IS
    'enum_value_rec_uuid -  ';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".status IS
    'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]'
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".updt_by IS
    'UPDT_BY - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".lst_updt IS
    'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.'
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".active_flag IS
    'ACTIVE_FLAG - Flag indicating if the record is active or not.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".active_date IS
    'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.'
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".inactive_date IS
    'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.'
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".insert_by IS
    'INSERT_BY - Reports who initially created the record.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".insert_date IS
    'INSERT_DATE - Reports when the record was initially created.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".update_by IS
    'UPDATE_BY - Reports who last updated the record.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".update_date IS
    'UPDATE_DATE - Reports when the record was last updated.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".delete_by IS
    'DELETE_BY - Reports who last deleted the record.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".delete_flag IS
    'DELETE_FLAG - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".delete_date IS
    'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.'
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".hidden_by IS
    'HIDDEN_BY - Reports who last hide the record.';

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".hidden_flag IS
    'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.'
;

COMMENT ON COLUMN generic_dev."EnumValueAssocRef".hidden_date IS
    'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.'
;

CREATE UNIQUE INDEX generic_dev.pk_EnumValueAssocRef ON
    generic_dev."EnumValueAssocRef" (
        rec_id
    ASC )
        TABLESPACE generic_dev_tabspace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

CREATE UNIQUE INDEX generic_dev.ixu_EnumValueAssocRef ON
    generic_dev."EnumValueAssocRef" (
        enum_type
    ASC,
        enum_value
    ASC,
        enum_assoc_type
    ASC,
        enum_assoc_code
    ASC )
        TABLESPACE generic_dev_tabspace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE generic_dev."EnumValueAssocRef"
    ADD CONSTRAINT pk_EnumValueAssocRef PRIMARY KEY ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE generic_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;
