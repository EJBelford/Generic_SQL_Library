CREATE OR REPLACE FUNCTION sys_proc_ctrl_get 
    (
    ps_proc_ctrl_name IN sys_proc_ctrl_ref.proc_ctrl_name%TYPE 
    )
RETURN NUMBER 

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
--         Name: sys_proc_ctrl_get
--         Desc:
--
--   Created By: Gene Belford
-- Created Date: 20180724
--
--       Source: sys_proc_ctrl_get.sql
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
--     Change History:
-- YYYYMMDD - Who         - RDP / ECP # - Details
-- 20180724 - Gene Belford  -             - Created
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

    v_process_run_ctrl  := sys_proc_ctrl_get (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 01: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 02: Failure - Should return a error code and write to debug table... 
    
    tstname :=  'schema_owner x'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := sys_proc_ctrl_get (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 02: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 03: Additional - The value to return is a number... 
    
    tstname :=  'v_keep_n_days_of_log'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := sys_proc_ctrl_get (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 03: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 04: Additional - The string is to long... 
    
    tstname :=  'string is to long'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := sys_proc_ctrl_get (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 04: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_process_run_ctrl 
       ); 
            
-- Test 05: Additional - The is less than max length... 
    
    tstname :=  'short'; 
    v_process_run_ctrl  :=  NULL; 

    v_process_run_ctrl  := sys_proc_ctrl_get (tstname); 

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
v_proc_ctrl_value                NUMBER;
proc_result                      NUMBER; 

-- Exception handling variables (p_)...

this_proc_name                  sys_debug_tbl.proc_name%TYPE  
    := 'sys_proc_ctrl_get';     /*  */
p_oerr                          sys_debug_tbl.oerr%TYPE
    := NULL;                 /*  */
p_cd_ptr                        sys_debug_tbl.cd_ptr%TYPE
    := 'Begin';              /*  */
p_proc_data                     sys_debug_tbl.proc_data%TYPE
    := NULL;                 /*  */
p_debug_msg                     sys_debug_tbl.debug_msg%TYPE
    := NULL;                 /*  */

-- coder responsible for identying key for debug

ps_last_process                  sys_proc_log%rowtype;
ps_this_process                  sys_proc_log%rowtype;

BEGIN

    p_cd_ptr              := ps_proc_ctrl_name;
    v_process_run_ctrl    := NULL;

    SELECT proc_ctrl_value 
    INTO   v_proc_ctrl_value
    FROM   sys_proc_ctrl_ref 
    WHERE  proc_ctrl_name = ps_proc_ctrl_name 
        AND status = 'C' 
        AND active_flag = 'Y' 
        AND sysdate BETWEEN active_date AND inactive_date; 

    RETURN NVL(v_proc_ctrl_value, -9999);

    EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_oerr       := SQLCODE;
            p_debug_msg  := SUBSTR('Insert "' || ps_proc_ctrl_name 
                                || '" intosys_proc_ref - ' 
                                || SQLERRM, 
                                1, 200);
            p_cd_ptr     := SUBSTR(p_cd_ptr, 1, 200);

            sys_debug_tbl_ins (  this_proc_name,  
                p_oerr,            p_cd_ptr,  
                NULL,              p_proc_data,     
                p_debug_msg,       SYSDATE,   
                proc_result );

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
            p_oerr      := SQLCODE;
            p_debug_msg := SUBSTR(SQLERRM,  1, 200);
            p_cd_ptr    := SUBSTR(p_cd_ptr, 1, 200);

            sys_debug_tbl_ins ( this_proc_name,  
                p_oerr,            p_cd_ptr,  
                NULL,              p_proc_data,     
                p_debug_msg,       SYSDATE,   
                proc_result );

            COMMIT; 
                
            RETURN -9998;

END sys_proc_ctrl_get;
/