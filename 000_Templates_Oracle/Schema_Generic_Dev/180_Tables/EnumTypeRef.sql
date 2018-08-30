DROP TABLE generic_dev."EnumTypeRef" CASCADE CONSTRAINTS;

CREATE TABLE generic_dev."EnumTypeRef" (
    rec_Id            NUMBER NOT NULL,
    rec_Uuid          VARCHAR2(40 BYTE) NOT NULL,
    enum_Type         VARCHAR2(75 BYTE) NOT NULL,
    enum_Type_Desc    VARCHAR2(3000 BYTE) NOT NULL,
    classification    VARCHAR2(100 BYTE) DEFAULT '(U)',
    constant_Flag     CHAR(1 BYTE) DEFAULT 'N',
    enum_Source_Name  VARCHAR2(25 BYTE),
    status            VARCHAR2(1 BYTE) DEFAULT 'N',
    updt_By           VARCHAR2(50 BYTE) DEFAULT substr(user,1,50),
    lst_Updt          DATE DEFAULT SYSDATE,
    active_Flag       CHAR(1 BYTE) DEFAULT 'Y',
    active_Date       DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    inactive_Date     DATE DEFAULT TO_DATE('31-DEC-2099','DD-MON-YYYY'),
    insert_By         VARCHAR2(50 BYTE) DEFAULT substr(user,1,50),
    insert_Date       DATE DEFAULT SYSDATE,
    update_By         VARCHAR2(50 BYTE),
    update_Date       DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    delete_By         VARCHAR2(50 BYTE),
    delete_Flag       CHAR(1 BYTE) DEFAULT 'N',
    delete_Date       DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY'),
    hidden_By         VARCHAR2(50 BYTE),
    hidden_Flag       CHAR(1 BYTE) DEFAULT 'N',
    hidden_Date       DATE DEFAULT TO_DATE('01-JAN-1900','DD-MON-YYYY')
)
PCTFREE 10 PCTUSED 0 TABLESPACE generic_dev_tabspace LOGGING
    STORAGE ( INITIAL 65536 NEXT 32768 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE generic_dev."EnumTypeRef"
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

ALTER TABLE generic_dev."EnumTypeRef"
    ADD CONSTRAINT ck_enum_type_ref_act_fl CHECK (
        active_flag = 'I'
        OR active_flag = 'N'
        OR active_flag = 'Y'
    );

ALTER TABLE generic_dev."EnumTypeRef"
    ADD CONSTRAINT ck_enum_type_ref_del_fl CHECK (
        delete_flag = 'N'
        OR delete_flag = 'Y'
    );

ALTER TABLE generic_dev."EnumTypeRef"
    ADD CONSTRAINT ck_enum_type_ref_hid_fl CHECK (
        hidden_flag = 'N'
        OR hidden_flag = 'Y'
    );

COMMENT ON TABLE generic_dev."EnumTypeRef" IS
    'EnumTypeRef - The overarching data object that represents whole enumerations in the database by their names.'
;

COMMENT ON COLUMN generic_dev."EnumTypeRef".rec_Id IS
    'rec_Id - Primary, blind key of the enum_type_ref table.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".rec_Uuid IS
    'rec_Uuid - Blind uuid key of the enum_type_ref table.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".enum_Type IS
    'enum_Type - Identifying name of the enumeration in the database.  ';

COMMENT ON COLUMN generic_dev."EnumTypeRef".enum_Type_Desc IS
    'enum_Type_Desc - Brief description of the enumeration.  ';

COMMENT ON COLUMN generic_dev."EnumTypeRef".classification IS
    'classification - This simple type is used by the classification attribute to identify the highest level of classification of the information being encoded.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".constant_Flag IS
    'constant_Flag - Whether or not the enumeration is constant (unchangeable, probably used in the system), or dynamic (changeable, probably just used for visualization purposes).';

COMMENT ON COLUMN generic_dev."EnumTypeRef".enum_Source_Name IS 
    'enum_Source_Name - The source of the enumeration type. ';

COMMENT ON COLUMN generic_dev."EnumTypeRef".status IS
    'status - The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]';

COMMENT ON COLUMN generic_dev."EnumTypeRef".updt_By IS
    'updt_By - The date/timestamp of when the record was created/updated.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".lst_Updt IS
    'lst_Updt - Indicates either the program name or user ID of the person who updated the record.'
;

COMMENT ON COLUMN generic_dev."EnumTypeRef".active_Flag IS
    'active_Flag - Flag indicating if the record is active or not.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".active_Date IS
    'active_Date - Additional control for active_Fl indicating when the record became active.'
;

COMMENT ON COLUMN generic_dev."EnumTypeRef".inactive_Date IS
    'inactive_Date - Additional control for active_Fl indicating when the record went inactive.'
;

COMMENT ON COLUMN generic_dev."EnumTypeRef".insert_By IS
    'insert_By - Reports who initially created the record.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".insert_Date IS
    'insert_Date - Reports when the record was initially created.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".update_By IS
    'update_By - Reports who last updated the record.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".update_Date IS
    'update_Date - Reports when the record was last updated.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".delete_By IS
    'delete_By - Reports who last deleted the record.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".delete_Flag IS
    'delete_Flag - Flag indicating if the record can be deleted.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".delete_Date IS
    'delete_Date - Additional control for DELETE_FLAG indicating when the record was marked for deletion.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".hidden_By IS
    'hidden_By - Reports who last hide the record.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".hidden_Flag IS
    'hidden_Flag - Flag indicating if the record should be hidden from the general user in things like drop-down lists.';

COMMENT ON COLUMN generic_dev."EnumTypeRef".hidden_Date IS
    'hidden_Date - Addition control for HIDDEN_FLAG indicating when the record was hidden.';

CREATE UNIQUE INDEX generic_dev.pk_enum_type_ref ON
    generic_dev."EnumTypeRef" (
        enum_type
    ASC )
        TABLESPACE generic_dev_tabspace PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE generic_dev."EnumTypeRef"
    ADD CONSTRAINT pk_enum_type_ref PRIMARY KEY ( enum_type )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE generic_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE generic_dev."EnumTypeRef"
    ADD CONSTRAINT ixu_enumtyperef_recuuid UNIQUE ( rec_uuid )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE generic_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;

ALTER TABLE generic_dev."EnumTypeRef"
    ADD CONSTRAINT ixu_enumtyperef_recid UNIQUE ( rec_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE generic_dev_tabspace
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS
1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        COMPUTE STATISTICS;
