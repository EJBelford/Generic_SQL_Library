CREATE OR REPLACE PROCEDURE sys_proc_log_merge
(
calling_proc                    IN          VARCHAR2, -- The name of the calling 
    -- process, used for writing to the various system logs
ps_rec_id                       IN OUT      NUMBER, 
ps_rec_uuid                     IN          VARCHAR2, 
ps_process_batch_id             IN          NUMBER, 
ps_process_key                  IN          NUMBER, 
ps_process_id                   IN          NUMBER, 
ps_module_num                   IN          NUMBER, 
ps_step_num                     IN          NUMBER, 
ps_process_start_date           IN          TIMESTAMP, 
ps_process_end_date             IN          TIMESTAMP, 
ps_process_status_code          IN          CHAR, 
ps_sql_error_code               IN          NUMBER, 
ps_rec_read_int                 IN          NUMBER, 
ps_rec_valid_int                IN          NUMBER, 
ps_rec_load_int                 IN          NUMBER, 
ps_rec_inserted_int             IN          NUMBER, 
ps_rec_merged_int               IN          NUMBER, 
ps_rec_selected_int             IN          NUMBER, 
ps_rec_updated_int              IN          NUMBER, 
ps_rec_deleted_int              IN          NUMBER, 
ps_user_login_id                IN          VARCHAR2, 
ps_message                      IN          VARCHAR2, 
proc_result                     IN OUT      VARCHAR2 -- This would let the calling 
    -- process know that there was an error during processing
)

AS

/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--            Name: sys_proc_log_merge
--            Desc:
--
--      Created By: Gene Belford
--    Created Date: 20180725
--
--          Source: sys_proc_log_merge.sql
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
-- 20180725 - Gene Belford  -             - Created
--
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Test script -----*/
/*

SET SERVEROUTPUT on;
ALTER SESSION SET NLS_DATE_FORMAT          = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT     = 'YYYY-MM-DD HH24:MI:SS.FF3';
ALTER SESSION SET NLS_TIMESTAMP_TZ_FORMAT  = 'YYYY-MM-DD HH24:MI:SS.FF3 TZH:TZM';

DECLARE

calling_proc                    sys_debug_tbl.calling_proc%TYPE := 'Unit Test';
proc0                           sys_proc_log%ROWTYPE;
proc_result                     VARCHAR2(20)                    := NULL;

BEGIN

    proc0.rec_Id                := NULL;
    proc0.rec_uuid              := NULL;
    proc0.process_batch_id      := NULL;
    proc0.process_key           := NULL;
    proc0.process_id            := 0;
    proc0.module_num            := 0;
    proc0.step_num              := 0;
    proc0.process_start_date    := SYSDATE;
    proc0.process_end_date      := NULL;
    proc0.process_status_code   := NULL; 
    proc0.sql_error_code        := NULL; 
    proc0.rec_read_int          := 0;        
    proc0.rec_valid_int         := 0;    
    proc0.rec_load_int          := 0; 
    proc0.rec_inserted_int      := 0;    
    proc0.rec_merged_int        := 0;  
    proc0.rec_selected_int      := 0;
    proc0.rec_updated_int       := 0;     
    proc0.rec_deleted_int       := 0; 
    proc0.user_login_id         := USER;
    proc0.message               := NULL;
    
    DBMS_OUTPUT.PUT_LINE('pds_load_test: proc0.rec_id: ' || proc0.rec_id);
    
    sys_proc_log_merge ( calling_proc, 
        proc0.rec_id,              proc0.rec_uuid, 
        proc0.process_batch_id,    proc0.process_key,      proc0.process_id, 
        proc0.module_num,          proc0.step_num, 
        proc0.process_start_date,  proc0.process_end_date, 
        proc0.process_status_code, proc0.sql_error_code, 
        proc0.rec_read_int,        proc0.rec_valid_int,    proc0.rec_load_int, 
        proc0.rec_inserted_int,    proc0.rec_merged_int,   proc0.rec_selected_int,
        proc0.rec_updated_int,     proc0.rec_deleted_int, 
        proc0.user_login_id,       proc0.message,     
        proc_result );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('pds_load_test: proc0.rec_id: ' || proc0.rec_id);

END;

SELECT warning_timestamp, warning_type, warning_from, 
    warning_status, warning_msg, warning_action
FROM sys_func_warn_log 
ORDER BY rec_id DESC;

SELECT * FROM sys_proc_log ORDER BY rec_id DESC;

SELECT * FROM sys_debug_tbl ORDER BY rec_id DESC;

*/

-- Exception handling variables (ps_)

this_proc_name                  sys_debug_tbl.proc_name%TYPE 
    := 'sys_proc_log_merge';
p_oerr                          sys_debug_tbl.oerr%TYPE
    := NULL;                 /*  */
p_cd_ptr                        sys_debug_tbl.cd_ptr%TYPE
    := 'Begin';              /*  */
p_proc_data                     sys_debug_tbl.proc_data%TYPE
    := NULL;                 /*  */
p_debug_msg                     sys_debug_tbl.debug_msg%TYPE
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
    DBMS_OUTPUT.PUT_LINE('sys_proc_log_merge: starting');
    
-- Set the outer shell logging variables

    p_cd_ptr := SUBSTR('00-Start', 1, 10);

--    proc0.rec_Id             := -2;
--    proc0.process_Key        := NULL;
--    proc0.module_Num         := 0;
--    proc0.process_Start_Date := SYSDATE;
--    proc0.user_Login_Id      := USER;
    proc0.message            := NULL;

    p_debug_msg              := proc0.message;

/*-------------------------------------*/
/*----- Start of sub-section work -----*/

    DBMS_OUTPUT.PUT_LINE('sys_proc_log_merge: ps_rec_id: ' || ps_rec_id);
    
    MERGE 
    INTO sys_proc_log tar 
    USING ( SELECT ps_rec_id               AS rec_id,
                ps_rec_uuid                AS rec_uuid, 
                ps_process_batch_id        AS process_batch_id, 
                ps_process_key             AS process_key, 
                ps_process_id              AS process_id, 
                ps_module_num              AS module_num, 
                ps_step_num                AS step_num, 
                ps_process_start_date      AS process_start_date, 
                ps_process_end_date        AS process_end_date, 
                ps_process_status_code     AS process_status_code, 
                ps_sql_error_code          AS sql_error_code, 
                ps_rec_read_int            AS rec_read_int, 
                ps_rec_valid_int           AS rec_valid_int, 
                ps_rec_load_int            AS rec_load_int, 
                ps_rec_inserted_int        AS rec_inserted_in, 
                ps_rec_merged_int          AS rec_merges_int, 
                ps_rec_selected_int        AS rec_selected_int, 
                ps_rec_updated_int         AS rec_updated_int, 
                ps_rec_deleted_int         AS rec_deleted_int, 
                ps_user_login_id           AS user_login_id, 
                ps_message                 AS message 
            FROM dual 
        ) src
    ON ( tar.rec_id = src.rec_id ) 
    WHEN MATCHED THEN
        UPDATE 
        SET tar.process_end_date    = SYSDATE,
            tar.process_status_code = src.process_status_code,
            tar.sql_error_code      = src.sql_error_code,
            tar.rec_read_int        = src.rec_read_int, 
            tar.rec_valid_int       = src.rec_valid_int, 
            tar.rec_load_int        = src.rec_load_int, 
            tar.rec_inserted_int    = src.rec_inserted_in, 
            tar.rec_merged_int      = src.rec_merges_int, 
            tar.rec_selected_int    = src.rec_selected_int, 
            tar.rec_updated_int     = src.rec_updated_int, 
            tar.rec_deleted_int     = src.rec_deleted_int, 
            tar.message             = src.message 
    WHEN NOT MATCHED THEN
        INSERT ( 
            tar.process_batch_id, 
            tar.process_key, 
            tar.process_id, 
            tar.module_num,
            tar.step_num,
            tar.process_start_date,
            tar.process_status_code, 
            tar.user_login_id
            ) 
        VALUES (
            0,
            0,
            0,
            0,
            0,
            NVL(src.process_start_date, SYSDATE),
            src.process_status_code,
            USER
            );
            
         IF NVL(ps_rec_id, 0) < 1 THEN
            SELECT rec_id 
            INTO ps_rec_id 
            FROM sys_proc_log  
            WHERE ps_process_start_date = process_start_date; 
         END IF;
    
    DBMS_OUTPUT.PUT_LINE('sys_proc_log_merge: ps_rec_id: ' || ps_rec_id);
    DBMS_OUTPUT.PUT_LINE('sys_proc_log_merge: ending successfully');
    
/*-----  End of sub-section work  -----*/
/*-------------------------------------*/

    proc_result := SUBSTR('CMPL', 1, 20);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        proc_result := SUBSTR('CMPL_ERR: DUP_VAL_ON_INDEX', 1, 20);
    WHEN NO_DATA_FOUND THEN
        proc_result := SUBSTR('CMPL_ERR: NO_DATA_FOUND', 1, 20);
    WHEN TOO_MANY_ROWS THEN
        proc_result := SUBSTR('CMPL_ERR: TOO_MANY_ROWS', 1, 20);
    WHEN ZERO_DIVIDE THEN
        proc_result := SUBSTR('CMPL_ERR: ZERO_DIVIDE', 1, 20);
    WHEN INVALID_NUMBER THEN
        proc_result := SUBSTR('CMPL_ERR: DUP_VAL_ON_INDEX', 1, 20);
    WHEN PROGRAM_ERROR THEN
        proc_result := SUBSTR('CMPL_ERR: PROGRAM_ERROR', 1, 20);
    WHEN OTHERS THEN
        proc_result := SUBSTR('CMPL_ERR: OTHERS', 1, 20);

        DBMS_OUTPUT.PUT_LINE('sys_proc_log_merge: ending with errors');
    
        p_oerr      := SQLCODE;
        p_debug_msg := SUBSTR(SQLERRM,  1, 200);
        p_cd_ptr    := SUBSTR(p_cd_ptr, 1, 200);

        sys_debug_tbl_ins ( 'sys_proc_log_merge',  
             p_oerr,           p_cd_ptr,  
             calling_proc,     p_proc_data,     
             p_debug_msg,      SYSDATE,   
             proc_result );

        COMMIT;

END sys_proc_log_merge;
/
