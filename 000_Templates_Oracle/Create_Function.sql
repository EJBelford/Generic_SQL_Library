CREATE OR REPLACE FUNCTION %YourObjectName% 
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
--         Name: %YourObjectName%
--         Desc:
--
--   Created By: %USERNAME%
-- Created Date: %SYSDATE%
--
--       Source: %YourObjectName%.sql
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
-- YYYYMMDD - Who         - RDP / ECP # - Details
-- %SYSDATE% - %USERNAME%  -             - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Unit Test Scripts -----*/
/*

SET SERVEROUTPUT on;
ALTER SESSION SET NLS_DATE_FORMAT          = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT     = 'YYYY-MM-DD HH24:MI:SS.FF3';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT  = 'YYYY-MM-DD HH24:MI:SS.FF3 TZH:TZM';

DECLARE 

tstname                      sys_proc_ref.process_name%TYPE; 
v_process_run_ctrl           sys_proc_ref.process_run_ctrl%TYPE; 

BEGIN 

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Start Unit Test');

-- Test 01: Success - Should return a control value... 
    
    tstname :=  'schema_owner'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := %YourObjectName% (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 01: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 02: Failure - Should return a error code and write to debug table... 
    
    tstname :=  'schema_owner x'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := %YourObjectName% (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 02: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 03: Additional - The value to return is a number... 
    
    tstname :=  'v_keep_n_days_of_log'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := %YourObjectName% (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 03: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 04: Additional - The string is to long... 
    
    tstname :=  'string is to long'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := %YourObjectName% (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 04: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 05: Additional - The is less than max length... 
    
    tstname :=  'short'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := %YourObjectName% (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 05: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 

    COMMIT;
            
    DBMS_OUTPUT.PUT_LINE('Completed Unit Test');

END; 

SELECT warning_timestamp, warning_type, warning_from, 
    warning_status, warning_msg, warning_action
FROM sys_func_warn_log 
ORDER BY rec_id DESC;

SELECT * FROM sys_proc_log ORDER BY rec_id DESC;

SELECT * FROM sys_debug_tbl ORDER BY rec_id DESC;

*/ 
/*----- End of Unit Test Scripts -----*/

v_process_run_ctrl               sys_proc_ref.process_run_ctrl%TYPE;

-- Exception handling variables (ps_)...

ps_procedure_name                sys_debug_tbl.ps_procedure%TYPE  
    := '%YourObjectName%';     /*  */
ps_location                      sys_debug_tbl.ps_location%TYPE  
    := 'Begin';              /*  */
ps_oerr                          sys_debug_tbl.ps_oerr%TYPE   
    := null;                 /*  */
ps_msg                           sys_debug_tbl.ps_msg%TYPE 
    := null;                 /*  */
ps_id_key                        sys_debug_tbl.ps_id_key%TYPE 
    := null;                 /*  */
-- coder responsible for identying key for debug

ps_last_process                  sys_proc_log%rowtype;
ps_this_process                  sys_proc_log%rowtype;

BEGIN

    ps_id_key := v_process_control_name;
    v_process_run_ctrl    := NULL;

    SELECT v_process_control_name -- Replace with value to pass back...
    INTO   v_process_run_ctrl
    FROM dual
--    FROM   %TableName%
--    WHERE  UPPER(process_control_name) = UPPER(v_process_control_name) 
--        AND status = 'C'
--        AND active_flag = 'Y'
--        AND sysdate BETWEEN active_date AND inactive_date
    ;

    RETURN NVL(v_process_run_ctrl, -9999);

    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            RETURN -9992;
        WHEN NO_DATA_FOUND THEN
            ps_oerr   := SQLCODE;
            ps_msg    := SUBSTR('Insert "' || v_process_control_name 
                                || '" intosys_proc_ref - ' 
                                || SQLERRM, 
                                1, 200);
            ps_id_key := SUBSTR(ps_id_key, 1, 200);

            INSERT 
            INTO sys_debug_tbl 
                (
                ps_procedure,      ps_oerr, ps_location, called_by, 
                ps_id_key, ps_msg, msg_dt
                )
            VALUES 
                (
                ps_procedure_name, ps_oerr, ps_location, NULL, 
                ps_id_key, ps_msg, SYSDATE
                );

            COMMIT; 
                
            RETURN -9993;
        WHEN TOO_MANY_ROWS THEN
            RETURN -9994;
        WHEN ZERO_DIVIDE THEN
            RETURN -9995;
        WHEN INVALID_NUMBER THEN
            RETURN -9996;
        WHEN PROGRAM_ERROR THEN
            RETURN -9997;
        WHEN OTHERS THEN
            ps_oerr   := SQLCODE;
            ps_msg    := SUBSTR(SQLERRM,   1, 200);
            ps_id_key := SUBSTR(ps_id_key, 1, 200);

            INSERT 
            INTO sys_debug_tbl 
                (
                ps_procedure,      ps_oerr, ps_location, called_by, 
                ps_id_key, ps_msg, msg_dt
                )
            VALUES 
                (
                ps_procedure_name, ps_oerr, ps_location, NULL, 
                ps_id_key, ps_msg, SYSDATE
                );

            COMMIT; 
                
            RETURN -9998;

END %YourObjectName%;
/