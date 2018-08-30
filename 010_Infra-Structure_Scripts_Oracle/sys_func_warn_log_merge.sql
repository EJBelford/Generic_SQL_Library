CREATE OR REPLACE PROCEDURE sys_func_warn_log_merge
(
p_rec_id                        IN        NUMBER, 
calling_proc                    IN        VARCHAR2, -- The name of the calling 
    -- process, used for writing to the various system logs                                         -- heirachy
p_warning_type                  IN        VARCHAR2,
p_warning_from                  IN        VARCHAR2,
p_warning_msg                   IN        VARCHAR2,
p_warning_action                IN        VARCHAR2,
proc_result                     IN OUT    VARCHAR2 -- This lets the calling 
    -- process know the results of the processing and if a  error occured, 
    -- what the error was
)

AS

/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
--
--            Name: sys_func_warn_log_merge
--            Desc:
--
--      Created By: Gene Belford
--    Created Date: 20180724
--
--          Source: sys_func_warn_log_merge.sql
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
-- YYYYMMDD - Who          - RDP / ECP # - Details
-- 20180724 - Gene Belford -             - Created
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
proc_result                     VARCHAR2(20)                    := NULL;
v_rec_id                        NUMBER;

BEGIN

-- Insert a new functional warning message 

    sys_func_warn_log_merge ( NULL, -- rec_id
        calling_proc,               --  
        'Error Unit Test',          -- warning_type
        'Unit Test',                -- warning_from
        'Test: Insert new warning', -- warning_msg
        NULL,                       -- warning_action
        proc_result );
        
-- Update a existing functional warning message
        
    SELECT MAX(rec_id) - 4 
    INTO v_rec_id 
    FROM sys_func_warn_log;    

    sys_func_warn_log_merge ( v_rec_id, 
        calling_proc, 
        'Error Unit Test',
        'Unit Test',
        'Test: Update existing warning',
        ' Updated '  || SYSDATE,
        proc_result );
        
-- Cause the procedure to log an error to SYS_DEBUG_TBL

    sys_func_warn_log_merge ( NULL, 
        calling_proc, 
        'Error Unit Test1234567890123456789012345678901234567890',
        'Unit Test',
        'Test: Insert new warning',
        NULL,
        proc_result );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('proc_result: ' || proc_result);

END;

SELECT rec_id, warning_timestamp, warning_type, warning_from, 
    warning_status, warning_msg, warning_action
FROM sys_func_warn_log 
ORDER BY rec_id DESC;

SELECT * FROM sys_proc_log ORDER BY rec_id DESC;

SELECT * FROM sys_debug_tbl ORDER BY rec_id DESC;

*/

-- Exception handling variables (p_)

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

v_rec_id                        NUMBER := NULL;

BEGIN

    MERGE 
    INTO  sys_func_warn_log tar
    USING ( SELECT p_rec_id      AS rec_id, 
                p_warning_type   AS warning_type,
                p_warning_from   AS warning_from,
                p_warning_msg    AS warning_msg,
                p_warning_action AS warning_action
            FROM dual  
          ) src 
    ON (tar.rec_id = src.rec_id 
--         AND tar.warning_status = 'C'
        )
    WHEN MATCHED THEN 
        UPDATE 
        SET tar.warning_status    = 'H', 
            tar.warning_timestamp = SYSDATE,
            tar.warning_action    = warning_action
    WHEN NOT MATCHED THEN
        INSERT ( 
            warning_type,
            warning_from,
            warning_msg,
            warning_status,
            warning_timestamp,
            warning_action
            ) 
        VALUES ( 
            src.warning_type,
            src.warning_from,
            src.warning_msg,
            'C',
            SYSDATE,
            src.warning_action
            );
            
    SELECT MAX(rec_id) 
    INTO proc_result 
    FROM sys_func_warn_log;
    
EXCEPTION
    WHEN OTHERS THEN
        proc_result := SUBSTR('OTHERS', 1, 20);

        p_oerr      := SQLCODE;
        p_debug_msg := SUBSTR(SQLERRM,  1, 200);
        p_cd_ptr    := SUBSTR(p_cd_ptr, 1, 200);
 
        DBMS_OUTPUT.PUT_LINE('Error: ' 
            || ' - ' || calling_proc 
            || ' - ' || proc_result);
    
        sys_debug_tbl_ins ( this_proc_name,  
            p_oerr,            p_cd_ptr,  
            calling_proc,      p_proc_data,     
            p_debug_msg,       SYSDATE,   
            proc_result );

        COMMIT;
END;    
/