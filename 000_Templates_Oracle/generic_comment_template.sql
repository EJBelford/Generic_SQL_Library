
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
