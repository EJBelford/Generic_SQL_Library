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
-- Function Name: raw_to_guid
--          Desc:
--
--    Created By: Gene Belford
--  Created Date: 20180701
--
--        Source: raw_to_guid.sql
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
-- Used every table that has a uuid in a readable format.
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--     Change History:
-- YYYYMMDD - Who           - RDP / ECP # - Details
-- 20180701 - Gene Belford  -             - Created
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

