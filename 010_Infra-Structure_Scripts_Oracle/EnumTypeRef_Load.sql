
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                  <Copyright, Belford DB Consulting LLC, 2017>
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         NAME: generic_sys_enum_type_ref_load
--      PURPOSE: Load data into the generic_sys_enum_type_ref_load table.
--
--   CREATED BY: %USERNAME%
-- CREATED DATE: %SYSDATE%
--
--       SOURCE: generic_sys_enum_type_ref_load.sql
--
--        NOTES:
--
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available Auto Replace Keywords:
--    Object Name:     %YourObjectName%
--    Sysdate:         %SYSDATE%
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        %USERNAME% (set in TOAD Options, Procedure Editor)
--    Table Name:      generic_sys_enum_type (set in the "New PL/SQL Object" dialog) 
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- CHANGE HISTORY
-- YYYY-MM-DD - Who         - RDP / ECP # - Details..
-- %SYSDATE% - %USERNAME%  - RDPTSK00xxx - Created.. 
--
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/

/*----- 310_Schema_Post_Deploy  -----*/

-- DELETE FROM enum_type_ref;

-- Default record --

/* INSERT INTO enum_type_ref ( 
enum_type,
classification,
constant_flag,
enum_type_desc
) 
VALUES ( 'CONSTANT_FLAG', 'UNCLASSIFED', 'N', 'Whether or not the enumeration is constant (unchangeable, probably used in the system), or dynamic (changeable, probably just used for visualization purposes).' );  */

-- Load records --

/* INSERT INTO enum_type_ref ( 
enum_type,
classification,
constant_flag,
enum_type_desc
)  
          SELECT 'STATUS', 'UNCLASSIFED', 'N', 'The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]' FROM DUAL 
UNION ALL SELECT 'ACTIVE_FLAG', 'UNCLASSIFED', 'N', 'Flag indicating if the record is active or not.' FROM DUAL 
UNION ALL SELECT 'DELETE_FLAG', 'UNCLASSIFED', 'N', 'Flag indicating if the record can be deleted.' FROM DUAL 
UNION ALL SELECT 'HIDDEN_FLAG', 'UNCLASSIFED', 'N', 'Flag indicating if the record should be hidden from the general user in things like drop-down lists.' FROM DUAL ; */

-- Test SELECT --
/*----- 

SELECT enum_type,
    classification,
    constant_flag,
    enum_type_desc   
FROM enum_type_ref 
ORDER BY enum_type;

-----*/

-- Merge records --

MERGE INTO enum_type_ref tar
USING  (
    SELECT 'CONSTANT_FLAG' AS enum_type, 'U' AS classification, 
        'N' AS constant_flag,  
        'Whether or not the enumeration is constant (unchangeable, probably used in the system), or dynamic (changeable, probably just used for visualization purposes).' AS enum_type_desc FROM DUAL 
    UNION ALL SELECT 'STATUS' AS enum_type, 'U' AS classification,  
        'N' AS constant_flag,  
        'The Extract-Transform-Load (ETL) status of the record in question.  [C - Current, D - Duplicate, E - Error, H - Historical, L - Logical, P - Processed, Q - Questionable, R - Ready to Process, T- ?????, Z - Future]' AS enum_type_desc FROM DUAL
    UNION ALL SELECT 'ACTIVE_FLAG' AS enum_type, 'U' AS classification,  
        'N' AS constant_flag,  
        'Flag indicating if the record is active or not.' AS enum_type_desc FROM DUAL
    UNION ALL SELECT 'DELETE_FLAG' AS enum_type, 'U' AS classification,  
        'N' AS constant_flag,  
        'Flag indicating if the record can be deleted.' AS enum_type_desc FROM DUAL
    UNION ALL SELECT 'HIDDEN_FLAG' AS enum_type, 'U' AS classification,  
        'N' AS constant_flag,  
        'Flag indicating if the record should be hidden from the general user in things like drop-down lists.' AS enum_type_desc FROM DUAL
    UNION ALL SELECT 'CLASSIFICATION' AS enum_type, 'U' AS classification,  
        'N' AS constant_flag,  
        'A classification level must be assigned to information when that information is determined to be classified. A classification level indicates the relative importance of classified information to national security and thereby determines the specific security requirements applicable to that information. Clearly defined classification levels are essential to an effective classification system.' AS enum_type_desc FROM DUAL
    ) src
ON    ( tar.enum_type  = src.enum_type  )
WHEN MATCHED THEN
    UPDATE 
    SET tar.classification = src.classification,
        tar.constant_flag = src.constant_flag,
        tar.enum_type_desc = src.enum_type_desc,
	    tar.update_date = SYSDATE,
        tar.update_by = SUBSTR(USER, 1, 50)
WHEN NOT MATCHED THEN
    INSERT ( 
	    tar.enum_type,
        tar.classification,
        tar.constant_flag,
        tar.enum_type_desc
	    )
    VALUES (
	    src.enum_type,
        src.classification,
        src.constant_flag,
        src.enum_type_desc
		)
;
