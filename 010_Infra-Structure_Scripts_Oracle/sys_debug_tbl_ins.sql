CREATE OR REPLACE PROCEDURE sys_debug_tbl_ins
(
p_proc_name                     IN        VARCHAR2,-- The name of the calling 
    -- process, used for writing to the various system logs
p_oerr                          IN        VARCHAR2,    
p_location                      IN        VARCHAR2, 
p_calling_proc                  IN        VARCHAR2,
p_id_key                        IN        VARCHAR2,        
p_debug_msg                     IN        VARCHAR2,    
p_msg_dt                        IN        DATE,

proc_result                     IN OUT    VARCHAR2 -- This lets the calling 
    -- process know the results of the processing and if a  error occured, 
    -- what the error was
)

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
--            Name: sys_debug_tbl_ins
--            Desc:
--
--      Created By: Gene Belford
--    Created Date: 20180723
--
--          Source: sys_debug_tbl_ins.sql
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--      Parameters:
--           Input:
--
--          Output:
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- Used in the following:
--
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--     Change History:
-- YYYYMMDD - Who           - RDP / ECP # - Details
-- 20180723 - Gene Belford  -             - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Test script -----*/
/*

SET SERVEROUTPUT on;
ALTER SESSION SET NLS_DATE_FORMAT          = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT     = 'YYYY-MM-DD HH24:MI:SS.FF3';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT  = 'YYYY-MM-DD HH24:MI:SS.FF3 TZH:TZM';

DECLARE

v_sys_debug_tbl                 sys_debug_tbl%ROWTYPE;
proc_result                     VARCHAR2(20)                 := NULL;

BEGIN

    v_sys_debug_tbl.msg_dt       := SYSDATE;
    v_sys_debug_tbl.proc_name    := 'sys_debug_tbl_ins';
    v_sys_debug_tbl.oerr         := '000000';
    v_sys_debug_tbl.cd_ptr       := 'Test_00';
    v_sys_debug_tbl.calling_proc := 'Unit Test';
    v_sys_debug_tbl.proc_data    := 'Test_00';
    v_sys_debug_tbl.debug_msg    := 'Start of unit test.';

    sys_debug_tbl_ins (  v_sys_debug_tbl.proc_name,  
         v_sys_debug_tbl.oerr,          v_sys_debug_tbl.cd_ptr,  
         v_sys_debug_tbl.calling_proc,  v_sys_debug_tbl.proc_data,     
         v_sys_debug_tbl.debug_msg,     v_sys_debug_tbl.msg_dt,   
         proc_result );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('proc_result: ' || proc_result);

END;

SELECT warning_timestamp, warning_type, warning_from, 
    warning_status, warning_msg, warning_action
FROM sys_func_warn_log 
ORDER BY rec_id DESC;

SELECT * FROM sys_proc_log ORDER BY rec_id DESC;

SELECT * FROM sys_debug_tbl ORDER BY rec_id DESC;

*/

-- Exception handling variables (p_)

--p_oerr                          sys_debug_tbl.oerr%TYPE
--    := NULL;                 /*  */
p_cd_ptr                        sys_debug_tbl.cd_ptr%TYPE
    := 'Begin';              /*  */
p_proc_data                     sys_debug_tbl.proc_data%TYPE
    := NULL;                 /*  */
--p_debug_msg                     sys_debug_tbl.debug_msg%TYPE
--    := NULL;                 /*  */
	
-- coder responsible for identying key for debug

p_last_process                  sys_proc_ref%ROWTYPE;
p_this_process                  sys_proc_ref%ROWTYPE;
l_p_start                       DATE          := SYSDATE;
l_now_is                         DATE          := SYSDATE;
l_now_is_id                      NUMBER        := NULL;

-- module variables (v_)

--v_debug                    NUMBER
--     := 0;   -- Controls debug options (0 -Off)
v_debug_on_flag                  INTEGER := 0;

----------------------------------- START --------------------------------------

BEGIN

    DBMS_OUTPUT.ENABLE(1000000);
-- Set the outer shell logging variables

    p_cd_ptr        := SUBSTR('00-Start', 1, 10);

    DBMS_OUTPUT.PUT_LINE(p_proc_name || ': ' || p_cd_ptr);
    
/*----------------------------------------------------------------------------*/
/*----- End of actual work in the outer shell                            -----*/
/*----------------------------------------------------------------------------*/

-- complete the housekeeping for the process

--    p_this_process.last_run_status      := 'COMPLETE';
--    p_this_process.last_run_status_time := SYSDATE;
--    p_this_process.last_run_compl       := SYSDATE;
--
--    updt_sys_proc_ref ( p_proc_name, p_proc_name,
--                          p_this_process.last_run, p_this_process.who_ran,
--                          p_this_process.last_run_status,
--                          p_this_process.last_run_status_time,
--                          p_this_process.last_run_compl );

    INSERT 
    INTO sys_debug_tbl 
        (
        proc_name,    oerr,         cd_ptr,      calling_proc, 
        proc_data,    debug_msg,    msg_dt
        )
    VALUES 
        (
        p_proc_name,  p_oerr,       p_location,  p_calling_proc, 
        p_id_key,     p_debug_msg,  SYSDATE
        );

    COMMIT;

    p_cd_ptr               := SUBSTR('9999-End', 1, 10);

    proc_result := SUBSTR('CMPL', 1, 20);

END sys_debug_tbl_ins;
/
