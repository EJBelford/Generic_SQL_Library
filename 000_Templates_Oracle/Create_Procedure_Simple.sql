CREATE OR REPLACE PROCEDURE %YourObjectname%
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

/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--            Name: %YourObjectname%
--            Desc:
--
--      Created By: %USERNAME%
--    Created Date: %SYSDATE%
--
--          Source: %YourObjectname%.sql
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
-- Automatically available Auto Replace Keywords:
--    Object Name:     %YourObjectName%
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

/*----- Test script -----*/
/*

SET SERVEROUTPUT on;
ALTER SESSION SET NLS_DATE_FORMAT          = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT     = 'YYYY-MM-DD HH24:MI:SS.FF3';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT  = 'YYYY-MM-DD HH24:MI:SS.FF3 TZH:TZM';

DECLARE

calling_procedure            sys_debug_tbl.called_by%TYPE := 'Unit Test';
l_call_error                 VARCHAR2(20)                        := NULL;

BEGIN

    %YourObjectname% (calling_procedure, l_call_error);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('l_call_error: ' || l_call_error);

END;

SELECT warning_timestamp, warning_type, warning_from, 
    warning_status, warning_msg, warning_action
FROM sys_func_warn_log 
ORDER BY rec_id DESC;

SELECT * FROM sys_proc_log ORDER BY rec_id DESC;

SELECT * FROM sys_debug_tbl ORDER BY rec_id DESC;

*/

-- Exception handling variables (ps_)

ps_procedure                     VARCHAR2(30) 
    := '%YourObjectname%';
ps_location                      sys_debug_tbl.ps_location%TYPE
    := 'Begin';              /*  */
ps_oerr                          sys_debug_tbl.ps_oerr%TYPE
    := NULL;                 /*  */
ps_msg                           sys_debug_tbl.ps_msg%TYPE
    := NULL;                 /*  */
ps_id_key                        sys_debug_tbl.ps_id_key%TYPE
    := NULL;                 /*  */
	
-- coder responsible for identying key for debug

-- ps_last_process                  sys_proc_ref%ROWTYPE;
-- ps_this_process                  sys_proc_ref%ROWTYPE;
l_ps_start                       DATE          := SYSDATE;
l_now_is                         DATE          := SYSDATE;
l_now_is_id                      NUMBER        := NULL;


-- Process status variables (s0_)

-- proc0_recId                      sys_proc_log.Rec_Id%TYPE
    -- := NULL;                 /* NUMBER */
-- proc1_recId                      sys_proc_log.process_RecId%TYPE
    -- := NULL;                 /* NUMBER */

proc0                            sys_proc_log%ROWTYPE;
proc1                            sys_proc_log%ROWTYPE;

-- module variables (v_)

--v_debug                    NUMBER
--     := 0;   -- Controls debug options (0 -Off)
v_debug_on_flag                  INTEGER := 0;

/*---------------------- Cursors ----------------------*/

CURSOR process_cur IS
    SELECT   a.process_key, a.message
    FROM     sys_proc_log a
    ORDER BY a.process_key DESC;

process_rec    process_cur%ROWTYPE;

/*-------------- Start of Output Module ---------------*/
/* This section wraps the Oracle DBMS_OUT and shortens */
/* the call down to "PL".  This could be converted to  */
/* package.  See Oracle PL?SQL Best Practices          */
/* by Steve Feuerstein for additioanl informatiopn.    */
/*-----------------------------------------------------*/

/*--------------- Toggle Output Module ----------------*/

show_output_flag BOOLEAN;

/*--------------- Output Private Modules --------------*/

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

/*----------------Output pl Procedures ----------------*/

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

/*--------------- End of Output Module ----------------*/

----------------------------------- START --------------------------------------

BEGIN

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Starting ' || '%YourObjectname%');
    
-- Set the outer shell logging variables

    ps_location := SUBSTR('00-Start', 1, 10);

    proc0.process_rec_Id     := -2;
    proc0.process_Key        := NULL;
    proc0.module_Num         := 0;
    proc0.process_Start_Date := SYSDATE;
    proc0.user_Login_Id      := USER;
    proc0.message            := NULL;

    ps_id_key                := proc0.message;

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
            ps_procedure
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
                ps_procedure
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

/*----------------------------------------------------------------------------*/
/*----- End of actual work in the outer shell                            -----*/
/*----------------------------------------------------------------------------*/

-- complete the housekeeping for the process

--    ps_this_process.last_run_status      := 'COMPLETE';
--    ps_this_process.last_run_status_time := SYSDATE;
--    ps_this_process.last_run_compl       := SYSDATE;
--
--    updt_sys_proc_ref ( ps_procedure, ps_procedure,
--                          ps_this_process.last_run, ps_this_process.who_ran,
--                          ps_this_process.last_run_status,
--                          ps_this_process.last_run_status_time,
--                          ps_this_process.last_run_compl );

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
            ps_procedure, ps_oerr, ps_location, calling_procedure,
            ps_id_key, ps_msg, SYSDATE
            );

        sys_debug_tbl_ins (  ps_procedure,  
             ps_oerr,           ps_location,  
             calling_procedure, ps_id_key,     
             ps_msg,            SYSDATE,   
             unexpected_error );

        COMMIT;
--       RAISE;
--       ROLLBACK;

END %YourObjectname%;
/
