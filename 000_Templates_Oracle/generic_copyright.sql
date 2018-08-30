CREATE OR REPLACE FUNCTION get_sys_proc_batch_id 
    (
    p_process_name IN sys_proc_ref.process_name%TYPE 
    )
RETURN VARCHAR2 

AS

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
--         Name: get_sys_proc_batch_id
--         Desc:
--
--   Created By: Gene Belford
-- Created Date: 20180718
--
--       Source: get_sys_proc_batch_id.sql
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Parameters:
--      Input:
--
--      Output:
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Used in the following:
--
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Automatically available in Toad's Auto Replace Keywords:
-- Otherwise replace manually using find and replace.
--    Object Name:     %YourObjectname%
--    Sysdate:         %SYSDATE%
--    Date and Time:   %DATE%, %TIME%, and %DATETIME%
--    Username:        %USERNAME% (set in TOAD Options, Procedure Editor)
--    Table Name:      %TableName% (set in the "New PL/SQL Object" dialog)
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

tstname                      sys_proc_ref.process_control_name%TYPE; 

BEGIN 

    DBMS_OUTPUT.ENABLE(1000000);

-- Test 01: Success - Should return a control value... 
    
    tstname :=  'schema_owner'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := get_sys_proc_batch_id (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 01: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
    COMMIT;
            
END; 

*/ 

 
    INSERT INTO GB_generic_Processes (process_Key, process_Description, status) 
        VALUES ( -1,   'NOT APPLICABLE', 'C');
    INSERT INTO GB_generic_Processes (process_Key, process_Description, status) 
        VALUES (  1,   'pr_generic_insUpd_processLog', 'C');
    INSERT INTO GB_generic_Processes (process_Key, process_Description, status) 
        VALUES (  10,  'pr_generic_processlog_Cleanup', 'C');
    INSERT INTO GB_generic_Processes (process_Key, process_Description, status) 
        VALUES (  11,  'pr_generic_stdDebugTbl_Del', 'C');
    INSERT INTO GB_generic_Processes (process_Key, process_Description, status) 
        VALUES (  100, 'maintain_generic_warehouse', 'C'); 
    INSERT INTO GB_generic_Processes (process_Key, process_Description, status) 
        VALUES (  101, 'pr_generic_item_part_load', 'C'); 
