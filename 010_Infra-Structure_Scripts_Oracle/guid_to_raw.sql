CREATE OR REPLACE FUNCTION guid_to_raw 
    (
    chr_guid IN VARCHAR2 
    )
RETURN RAW 

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
--         Name: guid_to_raw
--         Desc:
--
--   Created By: Gene Belford
-- Created Date: 20180719
--
--       Source: guid_to_raw.sql
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
-- YYYYMMDD - Who          - RDP / ECP # - Details
-- 20180719 - Gene Belford -             - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Unit Test Scripts -----*/
/*

SET SEVEROUTPUT on;
ALTER SESSION SET NLS_DATE_FORMAT          = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT     = 'YYYY-MM-DD HH24:MI:SS.FF3';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT  = 'YYYY-MM-DD HH24:MI:SS.FF3 TZH:TZM';

DECLARE 

tstname                      sys_proc_ref.process_name%TYPE; 
v_process_run_ctrl           sys_proc_ref.process_run_ctrl%TYPE; 

v_value                      VARCHAR2(50);

BEGIN 

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Start Unit Test');

-- Test Preparation: 
    
    v_value := raw_to_guid(null); 
    
    DBMS_OUTPUT.PUT_LINE('Test value: ' || v_value);  
    
-- Test 01: Success - Should return a control value... 
    
    v_value := guid_to_raw(v_value);
    
    DBMS_OUTPUT.PUT_LINE('Test 01 Results: ' || v_value);  
    
    
-- Test 02: Failure - Should return a error code and write to debug table... 
    
    v_value := guid_to_raw(NULL);
    
    DBMS_OUTPUT.PUT_LINE('Test 02 Results: ' || v_value);  
    
    
-- Test 03: Additional - The string is to long... 
    
    tstname :=  'string is to long 1234567890123456789012345'; 
    v_value :=  tstname; 

    v_value :=  guid_to_raw (tstname); 

    DBMS_OUTPUT.PUT_LINE 
       (
          'Test 03: ' 
       || 'process_control_name: '    || tstname 
       || ', process_control_value: ' || v_value 
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
    := 'guid_to_raw';     /*  */
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

hex     RAW(16);

BEGIN

    ps_id_key := v_process_run_ctrl;
    v_process_run_ctrl    := NULL;

    RETURN HEXTORAW(REPLACE(chr_guid, '-' , ''));

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ps_oerr   := SQLCODE;
            ps_msg    := SUBSTR('Insert "' || v_process_run_ctrl 
                                || '" into sys_proc_ref - ' 
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
                
            RETURN NULL;
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
                
            RETURN NULL;

END guid_to_raw;
/