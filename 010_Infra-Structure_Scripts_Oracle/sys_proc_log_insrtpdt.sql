CREATE OR REPLACE PROCEDURE sys_proc_log_InsrtUpdt 
(
ps_Rec_Id			    IN OUT          INT , 
ps_ProcessKey		    IN              INT ,
ps_ProcessStartDt		IN              TIMESTAMP ,
ps_ProcessEndDt		    IN              TIMESTAMP ,
ps_ProcessStatusCd		IN              INT ,
ps_SqlErrorCode		    IN              INT ,
ps_RecReadInt		    IN              INT ,
ps_RecValidInt		    IN              INT ,
ps_RecLoadInt		    IN              INT ,
ps_RecInsertedInt		IN              INT ,
ps_RecMergedInt         IN              INT ,
ps_RecSelectedInt		IN              INT ,
ps_RecUpdatedInt		IN              INT ,
ps_RecDeletedInt		IN              INT ,
ps_UserLoginId		    IN              VARCHAR ,
ps_Message		        IN              VARCHAR 
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
--         SP Name: sys_proc_log_InsrtUpdt 
--         SP Desc: Captures SQL processing information for debugging 
--                  and monitoring  
--  
--   SP Created By: Gene Belford 
-- SP Created Date: 29 Nov 2006  
-- 
--       SP Source: 
-- 
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*      SP Parameters:                                                        */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
/*     Change History:                                                        */
/* DDMMMYY - Who - Ticket # - CR # - Details                                  */
/* 29Nov06 - GB  - 00000000 - 0000 - Created                                  */
/*                                                                            */
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/

/*----- Test script -----*/
/*

set serveroutput on

DECLARE

    ps_Rec_Id			    INT  := null; 
    ps_ProcessKey		    INT  := 1;
    ps_ProcessStartDt		TIMESTAMP := null;
    ps_ProcessEndDt		    TIMESTAMP := null;
    ps_ProcessStatusCd		INT  := 3;
    ps_SqlErrorCode		    INT  := 4;
    ps_RecReadInt		    INT  := 5;
    ps_RecValidInt		    INT  := 6;
    ps_RecLoadInt		    INT  := 7;
    ps_RecInsertedInt		INT  := 8;
    ps_RecMergedInt         INT  := 13;
    ps_RecSelectedInt		INT  := 9;
    ps_RecUpdatedInt		INT  := 10;
    ps_RecDeletedInt		INT  := 11;
    ps_UserLoginId		    VARCHAR(40) := 'ps_UserLoginId';
    ps_Message		        VARCHAR(40) := 'ps_Message'; 

BEGIN

    DBMS_OUTPUT.ENABLE(1000000);
    DBMS_OUTPUT.PUT_LINE('Start Unit Test: "sys_proc_log_InsrtUpdt" ');
    
    ps_ProcessStartDt := CURRENT_TIMESTAMP;
    
    sys_proc_log_InsrtUpdt (  ps_Rec_Id, 
        ps_ProcessKey,        ps_ProcessStartDt,    ps_ProcessEndDt,
        ps_ProcessStatusCd,   ps_SqlErrorCode,      ps_RecReadInt,
        ps_RecValidInt,       ps_RecLoadInt,        ps_RecInsertedInt,
        ps_RecMergedInt,      ps_RecSelectedInt,    ps_RecUpdatedInt,
        ps_RecDeletedInt,     ps_UserLoginId ,      ps_Message );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('ps_Rec_Id: ' || ps_Rec_Id);
    
    ps_ProcessEndDt := CURRENT_TIMESTAMP;
    
    sys_proc_log_InsrtUpdt (  ps_Rec_Id, 
        ps_ProcessKey,        ps_ProcessStartDt,    ps_ProcessEndDt,
        ps_ProcessStatusCd,   ps_SqlErrorCode,      ps_RecReadInt,
        ps_RecValidInt,       ps_RecLoadInt,        ps_RecInsertedInt,
        ps_RecMergedInt,      ps_RecSelectedInt,    ps_RecUpdatedInt,
        ps_RecDeletedInt,     ps_UserLoginId ,      ps_Message );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Completed Unit Test: "sys_proc_log_InsrtUpdt" ');
    
END;

SELECT * FROM sys_proc_log;

*/
/*--*----|----*----|----*----|----*----|----*----|----*----|----*----|----*---*/
debug           INT       := 0; 

BEGIN 
    IF ps_Rec_Id IS NULL THEN

        INSERT INTO sys_proc_log  
            (
            process_key,
            process_start_date,
            user_login_id,
            message 
            )
        VALUES (
            ps_ProcessKey, 
            ps_ProcessStartDt,
            ps_UserLoginId,
            ps_Message
        );
    
        SELECT	MAX(rec_id) 
        INTO    ps_Rec_Id
        FROM	sys_proc_log;

    ELSE
        BEGIN 

        	UPDATE	sys_proc_log  
        	SET	process_end_date    = ps_ProcessEndDt,
                process_status_code = ps_ProcessStatusCd,
                sql_error_code      = ps_SqlErrorCode,
                rec_read_int        = ps_RecReadInt,
                rec_valid_int       = ps_RecValidInt,
                rec_load_int        = ps_RecLoadInt,
                rec_inserted_int    = ps_RecInsertedInt,
                rec_merged_int      = ps_RecMergedInt,
                rec_selected_int    = ps_RecSelectedInt,
                rec_updated_int     = ps_RecUpdatedInt,
                rec_deleted_int     = ps_RecDeletedInt,
                user_login_id       = ps_UserLoginId, 
        		message             = ps_Message 
        	WHERE	rec_id = ps_rec_id;
            
        END;
        
    END IF;

END;
