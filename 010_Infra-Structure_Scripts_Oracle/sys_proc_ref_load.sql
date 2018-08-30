
/*--*----1----*----2----*----3----*----4----*----5----*----6----*----7----*----8
================================================================================
                          Classification: UNCLASSIFIED
================================================================================
                      Copyright, %YourOrganization%, 2018 
                        Unpublished, All Rights Reserved
================================================================================
----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--         Name: sys_proc_ref_load
--         Desc: Loads a set of generic system process references that are 
--               included in the generic pattern. 
--
--   Created By: Gene Belford
-- Created Date: 20180718
--
--       Source: sys_proc_ref_load.sql
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Parameters:
--      Input:   None
--
--      Output:  None
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Used in the following:
--
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--     Change History:
-- YYYYMMDD - Who          - RDP / ECP # - Details
-- 20180718 - Gene Belford -             - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Test script -----*/
/*

DECLARE 

tstname                      sys_proc_ref.process_name%TYPE; 

BEGIN 

DELETE FROM sys_proc_ref;
COMMIT;

SELECT * FROM sys_proc_ref ORDER BY process_Id;
            
END; 

*/ 

/* This line can be used to generated a UUID when adding new load commands.   */
-- SELECT raw_to_guid(null) FROM dual;

ALTER TRIGGER "GENERIC_DEV"."TR_I_SYS_PROC_REF_SEQ" DISABLE;
 
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  7,   '9C0617C9-7291-F143-94A5-B017A3F6CCAD',  
     -1,   'not_Applicable', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  6,   '547B413F-360C-8D44-9D25-1932970A2531',  
      0,   'not_Defined', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  8,   '521D3FA5-5122-E945-AFBF-0B4ADE88BC34',   
      1,   'sys_Proc_Log_InsrtUpdt', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  9,  'A399155B-9611-B34F-BBCF-D199C069C84F',  
      2,  'sys_Proc_Log_Cleanup', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  10,  '4C437D82-0A18-CF47-A6B7-081AB11ABBE1',  
     11,  'sys_Debug_Tbl_InsrtUpdt', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  11,  'F65E6E27-F1D9-AF44-A01D-AF0985D48C6F',  
     12,  'sys_Debug_Tbl_Cleanup', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  12,  '1DC88370-E56E-734F-BE64-684F8EDCCF3C',  
     13, 'sys_Debug_Tbl_Del', 'C');
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  13, 'B955D7B6-F45B-514A-98E0-677293047611', 
    100, 'maintain_Generic_Warehouse', 'C'); 
    
INSERT INTO sys_proc_ref (rec_id, rec_uuid, process_Id, process_Name, status) 
VALUES (  14, 'BEEB3302-BE0E-864E-B76A-6714E6D519C7', 
    101, 'item_Part_Load', 'C'); 
    
COMMIT;

ALTER TRIGGER "GENERIC_DEV"."TR_I_SYS_PROC_REF_SEQ" ENABLE; 
