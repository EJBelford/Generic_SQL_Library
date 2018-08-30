CREATE OR REPLACE PROCEDURE YourObjectname
(
calling_procedure     IN        VARCHAR2,-- Calling procedure name, used in
                                         -- debugging, calling procedure
                                         -- responsible for maintaining
                                         -- heirachy
unexpected_error      IN OUT    VARCHAR2 -- This would let the calling process
                                         -- know that there was an error during
                                         -- processing
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
--         SP Name: YourObjectname
--         SP Desc:
--
--   SP Created By: %USERNAME%
-- SP Created Date: %SYSDATE%
--
--       SP Source: YourObjectname.sql
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
-- SP Parameters:
--         Input:
--
--        Output:
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
-- DDMMMYY - Who         - RDP / ECP # - Details
-- ddmmmyy - %USERNAME%  - RDPTSK00xxx - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Test script -----*/
/*

set serveroutput on

DECLARE

calling_procedure            sys_debug_tbl.called_by%TYPE := 'GBelford';
l_call_error                 VARCHAR2(20)                        := NULL;

BEGIN

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Start Unit Test: "YourObjectname" ');
    
    YourObjectname (calling_procedure, l_call_error);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Completed Unit Test: "YourObjectname" ');
    
    DBMS_OUTPUT.PUT_LINE('l_call_error: ' || l_call_error);

END;

SELECT * FROM sys_proc_log ORDER BY rec_id DESC;

*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

-- Exception handling variables (ps_)

ps_procedure_name                sys_debug_tbl.ps_procedure%TYPE
    := 'YourObjectname';    /*  */
ps_location                      sys_debug_tbl.ps_location%TYPE
    := 'Begin';              /*  */
ps_oerr                          sys_debug_tbl.ps_oerr%TYPE
    := NULL;                 /*  */
ps_msg                           sys_debug_tbl.ps_msg%TYPE
    := NULL;                 /*  */
ps_id_key                        sys_debug_tbl.ps_id_key%TYPE
    := NULL;                 /*  */
-- coder responsible for identying key for debug

--ps_last_process                  sys_processes%ROWTYPE;
--ps_this_process                  sys_processes%ROWTYPE;
l_ps_start                       DATE          := SYSDATE;
l_now_is                         DATE          := SYSDATE;
l_now_is_id                      NUMBER        := NULL;


-- Process status variables (s0_)

proc0_recId                      sys_proc_log.rec_id%TYPE
    := NULL;                 /* NUMBER */
proc1_recId                      sys_proc_log.rec_id%TYPE
    := NULL;                 /* NUMBER */

proc0                            sys_proc_log%ROWTYPE;
proc1                            sys_proc_log%ROWTYPE;

-- module variables (v_)

--v_debug                    NUMBER
--     := 0;   -- Controls debug options (0 -Off)
v_debug_on_flag                  sys_proc_ref.debug_on_flag%TYPE;

/*---------------------- Cursors ---------------------------------------------*/

CURSOR process_cur IS
    SELECT   a.process_key, a.message
    FROM     sys_proc_log a
    ORDER BY a.process_key DESC;

process_rec    process_cur%ROWTYPE;

/*-------------- Start of Output Module --------------------------------------*/
/* This section wraps the Oracle DBMS_OUT and shortens the call down to "PL". */
/* This could be converted to package.  See Oracle PL?SQL Best Practices by   */ 
/* Steve Feuerstein for additioanl informatiopn.                              */
/*----------------------------------------------------------------------------*/

/*--------------- Toggle Output Module ---------------------------------------*/

show_output_flag BOOLEAN;

/*--------------- Output Private Modules -------------------------------------*/

PROCEDURE display_line (line_in IN VARCHAR2) IS
BEGIN
    IF    show_output_flag
    THEN
       DBMS_OUTPUT.put_line (line_in);
    END IF;
END;

FUNCTION boolean_string (
  boolean_in IN BOOLEAN, name_in IN VARCHAR2 := NULL)
  RETURN VARCHAR2
IS
BEGIN
    IF boolean_in
    THEN
        RETURN    name_in || ': ' || 'TRUE ';
    ELSE
        RETURN    name_in || ': ' || 'FALSE';
    END IF;
END;

/*----------------Output pl Procedures ---------------------------------------*/

PROCEDURE pl (
    date_in   IN   DATE,
    mask_in   IN   VARCHAR2 := 'YYYY-MM-DD - HH24:MI:SS',
    name_in   IN   VARCHAR2 := 'No desc'
)
IS
BEGIN
    display_line (name_in || ': ' || TO_CHAR (date_in, mask_in));
END;

PROCEDURE pl (char_in IN VARCHAR2,   name_in IN VARCHAR2 := 'No desc') IS
BEGIN
    display_line (name_in || ': '|| char_in);
END;

PROCEDURE pl (number_in IN NUMBER,   name_in IN VARCHAR2 := 'No desc') IS
BEGIN
    display_line (name_in || ': '|| number_in);
END;

PROCEDURE pl (boolean_in IN BOOLEAN, name_in IN VARCHAR2) IS
BEGIN
    display_line (boolean_string (boolean_in, NVL(name_in, 'Boolean')));
END;

/*--------------- End of Output Module ---------------------------------------*/

/*--------------- START ------------------------------------------------------*/

BEGIN

-- Cell if debugging is on for the module

    BEGIN
        SELECT debug_on_flag
        INTO   v_debug_on_flag
        FROM   sys_proc_ref
        WHERE  UPPER(process_name) = UPPER(ps_procedure_name);

        IF v_debug_on_flag > 0 THEN
            show_output_flag := TRUE;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            show_output_flag := FALSE;
    END;

    IF show_output_flag OR v_debug_on_flag > 0 THEN
        DBMS_OUTPUT.ENABLE(1000000);
        DBMS_OUTPUT.PUT_LINE('Starting ' || ps_procedure_name);
    END IF;
    

-- Set the outer shell logging variables

    ps_location := SUBSTR('00-Start', 1, 10);

    proc0.rec_id             := NULL;  -- -2;
    proc0.process_Key        := NULL;
    proc0.module_Num         := 0;
    proc0.process_Start_Date := SYSDATE;
    proc0.user_Login_Id      := USER;
    proc0.message            := NULL;

    ps_id_key                := proc0.message;

/*    generic_dev_insupd_processlog
        (
        proc0.rec_id, proc0.process_Key,
        proc0.module_Num, proc0.step_Num,
        proc0.process_Start_Date, NULL,
        NULL, NULL,
        NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL,
        proc0.user_Login_Id, NULL, proc0_recId
        ); */

    Sys_Proc_Log_InsrtUpdt (  proc0.rec_id, 
        proc0.process_Key,    proc0.process_Start_Date, NULL,
        NULL, NULL, NULL,
        NULL, NULL, NULL,
        NULL, NULL, NULL,
        NULL,                 proc0.user_Login_Id,      proc0.message );

-- When need, this sets the batch id for the groups processing together
-- for easier process monitoring and tuning.

--    proc0.process_batch_id := get_sys_proc_batch_id;
    proc1.process_batch_id := proc0.process_batch_id;

    UPDATE sys_proc_log
    SET    process_batch_id = proc0.process_batch_id
    WHERE  process_key = proc0_recId;

    pl('calling_procedure: ' || calling_procedure ||
        ', ' || proc0.rec_id ||
        ', ' || proc0.process_Key
        );

-- get the run criteria from the pfsa_processes table for the last run of this main process

/*    get_generic_dev_process_info ( ps_procedure_name, ps_procedure_name,
                            ps_last_process.last_run, ps_last_process.who_ran,
                            ps_last_process.last_run_status,
                            ps_last_process.last_run_status_time,
                            ps_last_process.last_run_compl ); */

-- update the pfsa_process table to indicate main process began

/*    updt_generic_dev_processes ( ps_procedure_name, ps_procedure_name,
                          ps_this_process.last_run, ps_this_process.who_ran,
                          ps_this_process.last_run_status,
                          ps_this_process.last_run_status_time,
                          ps_last_process.last_run_compl ); */
    COMMIT;

/*----------------------------------------------------------------------------*/
/*----- Start of actual work in the outer shell                          -----*/
/*----------------------------------------------------------------------------*/

-- If the v_rec_Id is NULL then we assume that a new log record is required.

    IF proc0.rec_id IS NULL THEN

        ps_location := SUBSTR('05-Insert', 1, 10);

        pl('Insert');

        proc0.rec_inserted_int := NVL(proc0.rec_inserted_int, 0) + SQL%ROWCOUNT;
--        proc1.rec_inserted_int := NVL(proc1.rec_inserted_int, 0) + SQL%ROWCOUNT;
    ELSE

        ps_location := SUBSTR('10-Update', 1, 10);

        pl('Update rec_id: ' || proc0.rec_id);

        proc0.rec_updated_int := NVL(proc0.rec_updated_int, 0) + SQL%ROWCOUNT;
--        proc1.rec_updated_int := NVL(proc1.rec_updated_int, 0) + SQL%ROWCOUNT;
    END IF;

/*----------------------------------------------------------------------------*/
/*----- Start of sub-section 10                                          -----*/
/*----------------------------------------------------------------------------*/

    ps_location := SUBSTR('10-Sub', 1, 10);

-- Set the sub-section logging variables

    proc1_recId              := NULL;

    proc1.rec_id             := proc0.rec_id;
    proc1.process_Key        := NULL;
    proc1.module_Num         := 10;
    proc1.process_Start_Date := SYSDATE;
    proc1.user_Login_Id      := USER;
    proc1.message            := NULL;

    proc1.rec_read_int       := NULL;
    proc1.rec_valid_int      := NULL;
    proc1.rec_load_int       := NULL;
    proc1.rec_inserted_int   := NULL;
    proc1.rec_selected_int   := NULL;
    proc1.rec_updated_int    := NULL;
    proc1.rec_deleted_int    := NULL;
    proc1.rec_merged_int     := NULL;

/*    generic_dev_insupd_processlog
        (
        proc1.process_RecId, proc1.process_Key,
        proc1.module_Num, proc1.step_Num,
        proc1.process_Start_Date, NULL,
        NULL, NULL,
        NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL,
        proc1.user_Login_Id, NULL, proc1_recId
        ); */

    COMMIT;

/*-------------------------------------*/
/*----- Start of sub-section work -----*/

    FOR std_debug
    IN  (
        SELECT msg_dt, ps_procedure, ps_location, called_by,
            ps_id_key, ps_oerr, ps_msg
        FROM   sys_debug_tbl
        ORDER BY msg_dt DESC
        )
    LOOP
        pl  (
            ps_procedure_name
            || ': '|| TO_CHAR(std_debug.msg_dt, 'DD-MON-YYYY HH:MM:SS')
            || ' - ' || std_debug.ps_msg, 'log'
            );

        proc0.rec_read_int := NVL(proc0.rec_read_int, 0) + 1;
        proc1.rec_read_int := NVL(proc1.rec_read_int, 0) + 1;

    END LOOP; -- std_debug

/*-----  End of sub-section work  -----*/
/*-------------------------------------*/

-- Capture any processing for the sub-section

    proc1.process_end_date    := SYSDATE;
    proc1.sql_error_code      := SQLCODE;
    proc1.process_status_code := NVL(proc0.sql_error_code, SQLCODE);
    proc1.message             := SUBSTR( proc0.message
        || ' - ' || SQLCODE
        || ' - ' || SQLERRM, 1, 200);

/*    generic_dev_insupd_processlog
        (
        proc1.process_recid, proc1.process_key,
        proc1.module_num, proc1.step_num,
        proc1.process_start_date, proc1.process_end_date,
        proc1.process_status_code, proc1.sql_error_code,
        proc1.rec_read_int, proc1.rec_valid_int, proc1.rec_load_int,
        proc1.rec_inserted_int, proc1.rec_merged_int, proc1.rec_selected_int,
        proc1.rec_updated_int, proc1.rec_deleted_int,
        proc1.user_login_id, proc1.message, proc1_recid
        ); */

    COMMIT;

/*----------------------------------------------------------------------------*/
/*----- Start of subsection 20                                           -----*/
/*----------------------------------------------------------------------------*/

    ps_location := SUBSTR('20-Sub', 1, 10);

    proc1_recId              := NULL;

-- Set the sub-section logging variables

    proc1.rec_id             := proc0.rec_id;
    proc1.process_Key        := NULL;
    proc1.module_Num         := 20;
    proc1.process_Start_Date := SYSDATE;
    proc1.user_Login_Id      := USER;
    proc1.message            := NULL;

    proc1.rec_read_int       := NULL;
    proc1.rec_valid_int      := NULL;
    proc1.rec_load_int       := NULL;
    proc1.rec_inserted_int   := NULL;
    proc1.rec_selected_int   := NULL;
    proc1.rec_updated_int    := NULL;
    proc1.rec_deleted_int    := NULL;
    proc1.rec_merged_int     := NULL;

/*    generic_dev_insupd_processlog
        (
        proc1.process_RecId, proc1.process_Key,
        proc1.module_Num, proc1.step_Num,
        proc1.process_Start_Date, NULL,
        NULL, NULL,
        NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL,
        proc1.user_Login_Id, NULL, proc1_recId
        ); */

    COMMIT;

/*-------------------------------------*/
/*----- Start of sub-section work -----*/

    IF show_output_flag THEN

        pl('-----');

        OPEN process_cur;

        LOOP
            FETCH process_cur
            INTO  process_rec;

            EXIT WHEN process_cur%NOTFOUND
                OR (process_cur%ROWCOUNT > 11)  -- Need for unit testing
                ;

            pl  (
                ps_procedure_name
                || ': '|| process_rec.process_key
                || ', '|| process_rec.message, 'Process message'
                );

            proc0.rec_read_int := NVL(proc0.rec_read_int, 0) + 1;
            proc1.rec_read_int := NVL(proc1.rec_read_int, 0) + 1;

        END LOOP;

        CLOSE process_cur;

    END IF;

/*-----  End of sub-section work  -----*/
/*-------------------------------------*/

-- Capture any processing for the sub-section

    proc1.process_end_date    := SYSDATE;
    proc1.sql_error_code      := SQLCODE;
    proc1.process_status_code := NVL(proc0.sql_error_code, SQLCODE);
    proc1.message             := SUBSTR( proc0.message
        || ' - ' || SQLCODE
        || ' - ' || SQLERRM, 1, 200);

/*    generic_dev_insupd_processlog
        (
        proc1.rec_id, proc1.process_key,
        proc1.module_num, proc1.step_num,
        proc1.process_start_date, proc1.process_end_date,
        proc1.process_status_code, proc1.sql_error_code,
        proc1.rec_read_int, proc1.rec_valid_int, proc1.rec_load_int,
        proc1.rec_inserted_int, proc1.rec_merged_int, proc1.rec_selected_int,
        proc1.rec_updated_int, proc1.rec_deleted_int,
        proc1.user_login_id, proc1.message, proc1_recid
        ); */

    COMMIT;

/*----------------------------------------------------------------------------*/
/*----- End of actual work in the outer shell                            -----*/
/*----------------------------------------------------------------------------*/

-- Capture any processing for the outer shell

    ps_location := SUBSTR('sys 999', 1, 10);

    proc0.process_end_date    := SYSDATE;
    proc0.sql_error_code      := SQLCODE;
    proc0.process_status_code := NVL(proc0.sql_error_code, SQLCODE);
    proc0.message             := SUBSTR( proc0.message
        || ' - ' || SQLCODE
        || ' - ' || SQLERRM, 1, 200);

/*    generic_dev_insupd_processlog
        (
        proc0.rec_id, proc0.process_key,
        proc0.module_num, proc0.step_num,
        proc0.process_start_date, proc0.process_end_date,
        proc0.process_status_code, proc0.sql_error_code,
        proc0.rec_read_int, proc0.rec_valid_int, proc0.rec_load_int,
        proc0.rec_inserted_int, proc0.rec_merged_int, proc0.rec_selected_int,
        proc0.rec_updated_int, proc0.rec_deleted_int,
        proc0.user_login_id, proc0.message, proc0_recid
        ); */

    Sys_Proc_Log_InsrtUpdt (  proc0.rec_id, 
        proc0.process_Key,         proc0.process_Start_Date, proc0.process_end_date,
        proc0.process_status_code, proc0.sql_error_code,     NULL,
        NULL, NULL, NULL,
        NULL, NULL, NULL,
        NULL,                      proc0.user_Login_Id,      proc0.message );

-- complete the housekeeping for the process

--    ps_this_process.last_run_status      := 'COMPLETE';
--    ps_this_process.last_run_status_time := SYSDATE;
--    ps_this_process.last_run_compl       := SYSDATE;

/*    updt_generic_dev_processes ( ps_procedure_name, ps_procedure_name,
                          ps_this_process.last_run, ps_this_process.who_ran,
                          ps_this_process.last_run_status,
                          ps_this_process.last_run_status_time,
                          ps_this_process.last_run_compl ); */

    COMMIT;

    unexpected_error := SUBSTR('CMPL', 1, 20);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        unexpected_error := SUBSTR('CMPL_ERR: DUP_VAL_ON_INDEX', 1, 20);
    WHEN NO_DATA_FOUND THEN
        unexpected_error := SUBSTR('CMPL_ERR: NO_DATA_FOUND', 1, 20);
    WHEN TOO_MANY_ROWS THEN
        unexpected_error := SUBSTR('CMPL_ERR: TOO_MANY_ROWS', 1, 20);
    WHEN ZERO_DIVIDE THEN
        unexpected_error := SUBSTR('CMPL_ERR: ZERO_DIVIDE', 1, 20);
    WHEN INVALID_NUMBER THEN
        unexpected_error := SUBSTR('CMPL_ERR: DUP_VAL_ON_INDEX', 1, 20);
    WHEN PROGRAM_ERROR THEN
        unexpected_error := SUBSTR('CMPL_ERR: PROGRAM_ERROR', 1, 20);
    WHEN OTHERS THEN
        unexpected_error := SUBSTR('CMPL_ERR: OTHERS', 1, 20);

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
            ps_procedure_name, ps_oerr, ps_location, calling_procedure,
            ps_id_key, ps_msg, SYSDATE
            );

        COMMIT;

--       RAISE;

--       ROLLBACK;

END YourObjectname;
/
