CREATE OR REPLACE FUNCTION raw_to_guid( raw_guid IN RAW ) 
    RETURN VARCHAR2
    
AS

/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*---*/
/*==============================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
==============================================================================*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
-- Function Name: %YourObjectname%
--          Desc:
--
--    Created By: %USERNAME%
--  Created Date: %SYSDATE%
--
--        Source: %YourObjectname%.sql
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Parameters:
--      Input:
--
--     Output:
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Used in the following:
--
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available in Toad's Auto Replace Keywords:
-- Otherwise replace manually using find and replace.
--    Object Name:     %YourObjectName%
--    Sysdate:         %SYSDATE%
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        %USERNAME% (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog)
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--     Change History:
-- DDMMMYY - Who         - RDP / ECP # - Details
-- ddmmmyy - %USERNAME%  - RDPTSK00xxx - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*--- Unit Test Scripts ---*/
/*

SELECT SYS_GUID() FROM dual; 

SELECT raw_to_guid(null) FROM dual; 

SELECT raw_to_guid(SYS_GUID()) FROM dual;

-- Failures

SELECT raw_to_guid() FROM dual;

SELECT raw_to_guid('a') FROM dual;

SELECT raw_to_guid('aC002AFA3D40C42259D4B3CE547B9489C') FROM dual;

*/

hex     VARCHAR2(32);

BEGIN

    IF raw_guid IS NULL THEN
        hex := RAWTOHEX(SYS_GUID());
    ELSE 
        hex := RAWTOHEX(raw_guid);
    END IF;
    
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

