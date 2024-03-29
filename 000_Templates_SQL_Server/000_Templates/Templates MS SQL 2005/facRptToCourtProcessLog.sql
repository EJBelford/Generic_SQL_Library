USE [CMISLog]
GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[facRptToCourtProcessLog]') 
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[facRptToCourtProcessLog]
GO

/****** Object:  Table [dbo].[facRptToCourtProcessLog]    Script Date: 05/25/2007 12:55:33 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

--<summary> Process log tracking stored procedure performance in the the CMIS database </summary>

--<remarks><code>
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--
--         Table Name: facRptToCourtProcessLog
--         Table Desc: Process log tracking stored procedure performance in the the CMIS database.  
--                     Data is inserted by stored procedure dbo.spr_InsUpd_RptToCourt_ProcessLog.
-- 
--   Table Created By: Gene Belford
-- Table Created Date: 25 May 2007
--
--       Table Source: facRptToCourtProcessLog.sql 
--
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--     Change History:
-- DDMMMYY - Who - Ticket # - CR # - Details
-- 25May07 - GB  - 00000000 - 0000 - Created 
-- 06Jun07 - GB  - 00000000 - 0000 -  Added PK and FK
-- 29Jun07 - GB  - 00000000 - 0000 -  Changed FK for fac_RptToCourt
-- 11Jul07 - GB  -          -      - Created under CMIS 
-- 
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--</code></remarks>

CREATE TABLE [dbo].[facRptToCourtProcessLog]
(
	[timestamp]						[TIMESTAMP]		NULL,
	[ProcessLog_RecId]				[INT]			IDENTITY(100000,1) NOT NULL,
	[process_key]					[INT]			NOT NULL,
	[process_start_dt]				[DATETIME]		NULL,
	[process_end_dt]				[DATETIME]		NULL,
	[process_status_cd]				[INT]			NULL,

	[RptToCourt_RecId]				[INT]			NOT NULL,
	
	[sql_error_code]				[INT]			NULL,
	[rec_read_int]					[INT]			NULL,
	[rec_valid_int]					[INT]			NULL,
	[rec_load_int]					[INT]			NULL,
	[rec_inserted_int]				[INT]			NULL,
	[rec_selected_int]				[INT]			NULL,
	[rec_updated_int]				[INT]			NULL,
	[rec_deleted_int]				[INT]			NULL, 

	[user_login_id]					[VARCHAR](30)	NULL,
	[message]						[VARCHAR](255)	NULL
) 
ON [PRIMARY]	-- [CMIS_CoreData] 
GO

ALTER TABLE dbo.facRptToCourtProcessLog ADD CONSTRAINT
	PK_dim_facRptToCourtProcessLog PRIMARY KEY CLUSTERED 
	(
	[RptToCourt_RecId] ,
	[ProcessLog_RecId]
	) ON [PRIMARY]	-- [CMIS_CoreData]
GO
/*
ALTER TABLE [dbo].[facRptToCourtProcessLog]  
	WITH CHECK ADD  
	CONSTRAINT [FK_facRptToCourtProcessLog_fac_RptToCourt] 
	FOREIGN KEY([RptToCourt_RecId])
	REFERENCES [dbo].[fac_RptToCourt] ([RptToCourt_RecId])
GO
*/
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*
EXEC sp_dropextendedproperty 
	@name = 'CMIS_Description',  
	@level0type = 'SCHEMA',
	@level0name = 'dbo', 
	@level1type = 'TABLE', 
	@level1name = 'facRptToCourtProcessLog'
GO
*/
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Process log tracking stored procedure performance in the the CMIS database.  Data is inserted by stored procedure dbo.spr_InsUpd_RptToCourt_ProcessLog.' , 
	@level0type=N'SCHEMA',
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'facRptToCourtProcessLog'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Identity and Primary key for facRptToCourtProcessLog records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'facRptToCourtProcessLog', 
	@level2type=N'COLUMN', 
	@level2name=N'ProcessLog_RecId'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Primary key for facRptToCourtProcessLog records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'facRptToCourtProcessLog', 
	@level2type=N'COLUMN', 
	@level2name=N'RptToCourt_RecId'
GO

/*
---------------------------------------
------- dimCMISProcesses        ------- 
---------------------------------------

PRINT	'*** dimCMISProcesses ***'
PRINT	'* Insert test *' 

INSERT 
INTO	dimCMISProcesses (process_Key, process_Desc) 
VALUES	(-100, 'Unit test case 1')

--- Default Review ---

PRINT	'* Default Review *' 

SELECT	process_Key, process_Desc, active_Fl, active_Dt, inactive_Dt, insert_By, insert_Dt, 
		update_By, update_Dt, delete_Fl, delete_Dt 
FROM	dimCMISProcesses 
WHERE	process_Key < -1

----- PRIMARY KEY constraint -----

PRINT	'* PRIMARY KEY constraint *' 

INSERT 
INTO	dimCMISProcesses (process_Key, process_Desc) 
VALUES	(-100, 'Unit test case 1')

----- FOREIGN KEY constraint -----

--PRINT	'* FOREIGN KEY constraint *' 

--INSERT 
--INTO	dimCMISProcesses (process_Key, process_Desc) 
--VALUES	(-100, 'Unit test case 4')

--- Trigger Review ---

PRINT	'* Trigger Review *' 

UPDATE	dimCMISProcesses 
SET		process_Desc = 'Unit test case 3' 
WHERE	process_Key = -100  

SELECT	process_Key, process_Desc, active_Fl, active_Dt, inactive_Dt, insert_By, insert_Dt, 
		update_By, update_Dt, delete_Fl, delete_Dt 
FROM	dimCMISProcesses 
WHERE	process_Key = -100 

----- NOT NULL constraint -----

PRINT	'* NOT NULL constraint *' 

INSERT 
INTO	dimCMISProcesses (process_Key) 
VALUES	(NULL)

INSERT 
INTO	dimCMISProcesses (process_Desc) 
VALUES	(NULL)

-----Cleanup -----

PRINT	'* Cleanup *' 

DELETE	dimCMISProcesses WHERE process_Key < -1
--DELETE	dimCMISProcesses_yyy WHERE CatCd < 0

*/
