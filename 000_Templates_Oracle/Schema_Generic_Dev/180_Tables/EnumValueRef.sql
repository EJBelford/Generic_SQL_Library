DROP TABLE generic_dev."EnumValueRef" CASCADE CONSTRAINTS; 

CREATE TABLE generic_dev."EnumValueRef" (
    rec_Id                NUMBER NOT NULL,
    rec_Uuid              VARCHAR2(40 BYTE) NOT NULL,
    enum_Type             VARCHAR2(75 BYTE) NOT NULL,
    enum_Value            VARCHAR2(25 BYTE) NOT NULL,
    order_By              NUMBER(*,0) DEFAULT 0,
    enum_Display_Name     VARCHAR2(125 BYTE) NOT NULL,
    description           VARCHAR2(2000 BYTE),
    constant_Flag         CHAR(1 BYTE) DEFAULT 'N',
    enum_Type_Rec_Id      NUMBER NOT NULL,
    enum_Type_Rec_Uuid    VARCHAR2(40 BYTE) NOT NULL,
    status                VARCHAR2(1 BYTE) DEFAULT 'N',
    updt_By               VARCHAR2(50 BYTE) DEFAULT substr(user,1,50),
    lst_Updt              DATE DEFAULT SYSDATE,
    active_Flag           VARCHAR2(1 BYTE) DEFAULT 'Y',
    active_Date           DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    inactive_Date         DATE DEFAULT TO_DATE('31-DEC-2099','DD-MON-YYYY'),
    insert_By             VARCHAR2(50 BYTE) DEFAULT substr(user,1,50),
    insert_Date           DATE DEFAULT SYSDATE,
    update_By             VARCHAR2(50 BYTE),
    update_Date           DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    delete_By             VARCHAR2(50 BYTE),
    delete_Flag           VARCHAR2(1 BYTE) DEFAULT 'N',
    delete_Date           DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    hidden_By             VARCHAR2(50 BYTE),
    hidden_Flag           VARCHAR2(1 BYTE) DEFAULT 'N',
    hidden_Date           DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY')
)
PCTFREE 10 PCTUSED 0 TABLESPACE generic_dev_tabspace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE generic_dev."EnumValueRef"
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

ALTER TABLE generic_dev."EnumValueRef"
    ADD CONSTRAINT ck_enum_value_ref_act_fl CHECK (
        active_flag = 'I'
        OR active_flag = 'N'
        OR active_flag = 'Y'
    );

ALTER TABLE generic_dev."EnumValueRef"
    ADD CONSTRAINT ck_enum_value_ref_del_fl CHECK (
        delete_flag = 'N'
        OR delete_flag = 'Y'
    );

ALTER TABLE generic_dev."EnumValueRef"
    ADD CONSTRAINT ck_enumvalueref_hid_fl CHECK (
        hidden_flag = 'N'
        OR hidden_flag = 'Y'
    );

COMMENT ON TABLE generic_dev."EnumValueRef" IS
    'enum_values - Individual enumeration values that belong under a particular enumeration type.'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".rec_id IS
    'recid - Primary, blind key of the enum_values table.';

COMMENT ON COLUMN generic_dev."EnumValueRef".rec_uuid IS
    'recuuid - Blind uuid key of the enum_values table.';

COMMENT ON COLUMN generic_dev."EnumValueRef".enum_type IS
    'enum_type - Name/identifier of the overarching enumeration type that this value belongs to.  '
;

COMMENT ON COLUMN generic_dev."EnumValueRef".enum_value IS
    'enum_value - The actual specific enumeration value.  ';

COMMENT ON COLUMN generic_dev."EnumValueRef".order_by IS
    'order_by - Integer value used to create a custom sort order not possible programmatically.  '
;

COMMENT ON COLUMN generic_dev."EnumValueRef".enum_display_name IS
    'enum_display_name - ';

COMMENT ON COLUMN generic_dev."EnumValueRef".description IS
    'description - Brief description of the enumeration value.  ';

COMMENT ON COLUMN generic_dev."EnumValueRef".constant_flag IS
    'constant - Whether or not enumeration value is unchangeable or dynamic.  ';

COMMENT ON COLUMN generic_dev."EnumValueRef".enum_type_rec_id IS
    'enum_type_recid -  ';

COMMENT ON COLUMN generic_dev."EnumValueRef".enum_type_rec_uuid IS
    'enum_type_recuuid -  ';

COMMENT ON COLUMN generic_dev."EnumValueRef".status IS
    'STATUS - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".updt_by IS
    'UPDT_BY - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN generic_dev."EnumValueRef".lst_updt IS
    'LST_UPDT - Indicates either the program name or user ID of the person who updated the record.'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".active_flag IS
    'ACTIVE_FLAG - Flag indicating if the record is active or not.';

COMMENT ON COLUMN generic_dev."EnumValueRef".active_date IS
    'ACTIVE_DATE - Additional control for active_Fl indicating when the record became active.'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".inactive_date IS
    'INACTIVE_DATE - Additional control for active_Fl indicating when the record went inactive.'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".insert_by IS
    'INSERT_BY - Reports who initially created the record.';

COMMENT ON COLUMN generic_dev."EnumValueRef".insert_date IS
    'INSERT_DATE - Reports when the record was initially created.';

COMMENT ON COLUMN generic_dev."EnumValueRef".update_by IS
    'UPDATE_BY - Reports who last updated the record.';

COMMENT ON COLUMN generic_dev."EnumValueRef".update_date IS
    'UPDATE_DATE - Reports when the record was last updated.';

COMMENT ON COLUMN generic_dev."EnumValueRef".delete_by IS
    'DELETE_BY - Reports who last deleted the record.';

COMMENT ON COLUMN generic_dev."EnumValueRef".delete_flag IS
    'DELETE_FLAG - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN generic_dev."EnumValueRef".delete_date IS
    'DELETE_DATE - Additional control for DELETE_FLAG indicating when the record was marked for deletion.'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".hidden_by IS
    'HIDDEN_BY - Reports who last hide the record.';

COMMENT ON COLUMN generic_dev."EnumValueRef".hidden_flag IS
    'HIDDEN_FLAG - Flag indicating if the record should be hidden from the general user in things like drop-down lists.'
;

COMMENT ON COLUMN generic_dev."EnumValueRef".hidden_date IS
    'HIDDEN_DATE - Addition control for HIDDEN_FLAG indicating when the record was hidden.'
;

CREATE UNIQUE INDEX generic_dev.pk_enumvalueref ON
    generic_dev."EnumValueRef" (
        rec_id
    ASC )
        TABLESPACE generic_dev_tabspace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

CREATE UNIQUE INDEX generic_dev.ixu_enumvalueref ON
    generic_dev."EnumValueRef" (
        enum_type
    ASC,
        enum_value
    ASC )
        TABLESPACE generic_dev_tabspace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE generic_dev."EnumValueRef"
    ADD CONSTRAINT pk_enumvalueref PRIMARY KEY ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE generic_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;