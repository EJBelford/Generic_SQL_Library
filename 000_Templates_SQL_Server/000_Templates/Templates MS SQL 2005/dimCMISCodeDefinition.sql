USE [CMIS]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[trig_update_dimCmisCode]') 
	AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
	DROP TRIGGER [dbo].[trig_update_dimCmisCode]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[dimCMISCode]') 
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[dimCMISCode]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'[dbo].[trig_upd_dim_CMIS_CodeDefinition]') 
	AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
	DROP TRIGGER [dbo].[trig_update_dim_CMIS_CodeDefinition]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'[dbo].[dimCmisCodeDefinition]') 
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[dimCmisCodeDefinition]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

--<summary> Contains the description of the code type value </summary>

--<remarks><code>
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
-- 
--         Table Name: dimCmisCodeDefinition 
--         Table Desc: Contains the description of the code type value 
-- 
--   Table Created By: Gene Belford
-- Table Created Date: 6 June 2007
-- 
--       Table Source: dimCmisCodeDefinition.sql
-- 
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--     Change History: 
-- DDMMMYY - Who - Ticket # - CR # - Details 
-- 06Jun07 - GB  - 00000000 - 0000 - Created
-- 11Jul07 - GB  -          -      - Created under CMIS 
-- 11Jul07 - GB  -          -      - Broad update to meet JIS best practices standards 
-- 26Jul07 - GB  -          -      - Add Hidden flag and date 
-- 
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--</code></remarks>

CREATE TABLE [dbo].[dimCmisCodeDefinition] 
(
	[timestamp]		[TIMESTAMP]			NULL ,
	[rec_Id]		[INT]				IDENTITY (1000, 1) NOT NULL ,
	
	[catCd]			[SMALLINT]			NOT NULL ,
	[codeNm]		[VARCHAR](60)		NOT NULL ,

	[codeSource]	[VARCHAR](20)		NULL ,  
	[codeSourceId]	[VARCHAR](20)		NULL , 

	[active_Fl]		[BIT]				NULL ,
	[active_Dt]		[SMALLDATETIME]		NOT NULL ,
	[inactive_Dt]	[SMALLDATETIME]		NOT NULL ,
	[insert_By]		[VARCHAR](20)		NOT NULL ,
	[insert_Dt]		[SMALLDATETIME]		NOT NULL ,
	[update_By]		[VARCHAR](20)		NULL ,
	[update_Dt]		[SMALLDATETIME]		NOT NULL ,
	[delete_Fl]		[BIT]				NULL ,
	[delete_Dt]		[SMALLDATETIME]		NOT NULL ,
	[hidden_Fl]		[BIT]				NULL ,
	[hidden_Dt]		[SMALLDATETIME]		NOT NULL 
) ON [CMIS_CoreData]
GO

ALTER TABLE dbo.dimCmisCodeDefinition ADD CONSTRAINT
	PK_dimCmisCodeDefinition_catCd PRIMARY KEY CLUSTERED 
	(
	[catCd] 
	) ON [CMIS_CoreData]
GO

ALTER TABLE [dbo].[dimCmisCodeDefinition] WITH NOCHECK ADD 
	CONSTRAINT [DF_dimCmisCodeDefinition_active_Fl] DEFAULT (0) FOR [active_Fl] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_active_Dt] DEFAULT ('1/1/1900') FOR [active_Dt] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_inactive_Dt] DEFAULT ('1/1/1900') FOR [inactive_Dt] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_insert_By] DEFAULT (user_name()) FOR [insert_By] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_insert_Dt] DEFAULT (getdate()) FOR [insert_Dt] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_update_Dt] DEFAULT ('1/1/1900') FOR [update_Dt] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_delete_Fl] DEFAULT (0) FOR [delete_Fl] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_delete_Dt] DEFAULT ('1/1/1900') FOR [delete_Dt] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_hidden_Fl] DEFAULT (0) FOR [hidden_Fl] ,
	CONSTRAINT [DF_dimCmisCodeDefinition_hidden_Dt] DEFAULT ('1/1/1900') FOR [hidden_Dt] 
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[dimCmisCodeDefinition]  TO [public]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER [trig_upd_dimCmisCodeDefinition] ON dbo.dimCmisCodeDefinition 
FOR UPDATE 
AS

DECLARE	@RecId	INT

SELECT	@RecId = Rec_Id 
FROM	inserted

UPDATE	dimCmisCodeDefinition 
SET	update_By = USER_NAME(),
	update_Dt = GETDATE()
WHERE	Rec_Id = @RecId
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/*
EXEC sp_dropextendedproperty 
	@name = 'CMIS_Description',  
	@level0type = 'SCHEMA',
	@level0name = 'dbo', 
	@level1type = 'TABLE', 
	@level1name = 'dimCmisCodeDefinition'
GO
*/
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the description of the code type value', 
	@level0type=N'SCHEMA',
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Identity for dimCmisCodeDefinition records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'rec_Id'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Primary key for dimCmisCodeDefinition records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'catCd'
GO

EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Flag indicating if the record is active or not.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'active_Fl'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Addition control for active_Fl indicating when the record became active.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'active_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Addition control for active_Fl indicating when the record went inactive.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'inactive_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the USERNAME() captured when the record was inserted.  Populated using "DF_dimCmisCodeDefinition_insert_By."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'insert_By'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the GETDATE() captured when the record was inserted.  Populated using "DF_dimCmisCodeDefinition_insert_Dt."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'insert_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the USERNAME() captured when the record was last updated.  Populated by the trigger "trig_upd_dimCmisCodeDefinition."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'update_By'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the GETDATE() captured when the record was last updated.  Populated by the trigger "trig_upd_dimCmisCodeDefinition."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'update_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Flag indicating if the record can be deleted.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'delete_Fl'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Addition control for delete_Fl indicating when the record was marked for deletion.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodeDefinition', 
	@level2type=N'COLUMN', 
	@level2name=N'delete_Dt'
GO

/*
---------------------------------------
------- dimCMISCodeDefinition   ------- 
---------------------------------------

PRINT	'*** dimCMISCode ***'
PRINT	'* Insert test *' 

INSERT 
INTO	dimCmisCodeDefinition (CatCd, CodeNm) 
VALUES (-100, 'Unit test')

--- Default Review ---

PRINT	'* Default Review *' 

SELECT	catCd, CodeNm, active_Fl, active_Dt, inactive_Dt, insert_By, insert_Dt, 
		update_By, update_Dt, delete_Fl, delete_Dt 
FROM	dimCMISCodeDefinition 
WHERE	catCd < -1

----- PRIMARY KEY constraint -----

PRINT	'* PRIMARY KEY constraint *' 

INSERT 
INTO	dimCmisCodeDefinition (CatCd, CodeNm) 
VALUES (-100, 'Unit test')

----- FOREIGN KEY constraint -----

--PRINT	'* FOREIGN KEY constraint *' 

--INSERT 
--INTO	dimCmisCodeDefinition (CatCd, CodeNm) 
--VALUES (-200, 'Unit test 1')

--- Trigger Review ---

PRINT	'* Trigger Review *' 

UPDATE	dimCMISCodeDefinition 
SET		codeNm = 'Unit test case 3' 
WHERE	catCd = -100  

SELECT	catCd, CodeNm, active_Fl, active_Dt, inactive_Dt, insert_By, insert_Dt, 
		update_By, update_Dt, delete_Fl, delete_Dt 
FROM	dimCMISCodeDefinition 
WHERE	catCd = -100 

----- NOT NULL constraint -----

PRINT	'* NOT NULL constraint *' 

INSERT 
INTO	dimCMISCodeDefinition (catCd) 
VALUES	(NULL)

INSERT 
INTO	dimCMISCodeDefinition (CodeNm) 
VALUES	(NULL)

-----Cleanup -----

PRINT	'* Cleanup *' 

--DELETE	dimCMISCode WHERE catCd < -1
DELETE	dimCMISCodeDefinition WHERE CatCd < 0

*/
