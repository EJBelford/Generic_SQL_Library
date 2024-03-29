USE [CMIS]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[trig_update_dimCmisCodes]') 
	AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
	DROP TRIGGER [dbo].[trig_update_dimCmisCodes]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[dimCMISCodes]') 
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[dimCMISCodes]
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

--<summary> Contains the code values and descriptions used in CMIS </summary>

--<remarks><code>
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
-- 
--         Table Name: dimCmisCodes 
--         Table Desc: Contains the code values and descriptions used in CMIS
-- 
--   Table Created By: Gene Belford
-- Table Created Date: 6 June 2007
-- 
--       Table Source: dimCmisCodes.sql
-- 
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--     Change History: 
-- DDMMMYY - Who - Ticket # - CR # - Details 
-- 06Jun07 - GB  - 00000000 - 0000 - Created
-- 11Jul07 - GB  -          -      - Created under CMIS 
-- 11Jul07 - GB  -          -      - Broad update to meet JIS best practices standards 
-- 01Oct07 - GB  -          -      - Added sort order key 
-- 
/*----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*----|----*--*/
--</code></remarks>

CREATE TABLE [dbo].[dimCmisCodes] 
(
	[timestamp]		[TIMESTAMP]			NULL ,
	[Code_RecId]	[INT]				IDENTITY (1000, 1) NOT NULL ,
	
	[catCd]			[SMALLINT]			NOT NULL ,
	[itmCd]			[VARCHAR](50)		NOT NULL ,
	[itmTxt]		[VARCHAR](150)		NULL ,

	[codeSource]	[VARCHAR](20)		NULL ,  
	[codeSourceId]	[VARCHAR](20)		NULL , 
	[codeSourceCd]	[VARCHAR](50)		NULL , 
	[codeSourceTxt]	[VARCHAR](150)		NULL , 
	[codeSortOrder] [SMALLINT]			NULL ,			-- 01Oct07 - GB - Added sort order key 
	
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
) ON [PRIMARY]		-- [CMIS_CoreData]
GO

ALTER TABLE dbo.dimCmisCodes ADD CONSTRAINT
	PK_dimCmisCodes_catCd_itmCd PRIMARY KEY CLUSTERED 
	(
	[catCd] ,
	[itmCd]
	) ON [PRIMARY]		-- [CMIS_CoreData]
GO

ALTER TABLE [dbo].[dimCmisCodes]  WITH CHECK ADD  
CONSTRAINT [FK_dimCmisCodes_catCd$dimCmisCodeDefinition_catCd] FOREIGN KEY([catCd])
REFERENCES [dbo].[dimCmisCodeDefinition] ([catCd])
GO

ALTER TABLE [dbo].[dimCmisCodes] CHECK CONSTRAINT [FK_dimCmisCodes_catCd$dimCmisCodeDefinition_catCD]
ALTER TABLE [dbo].[dimCmisCodes] WITH NOCHECK ADD 
	CONSTRAINT [DF_dimCmisCodes_active_Fl] DEFAULT (0) FOR [active_Fl] ,
	CONSTRAINT [DF_dimCmisCodes_active_Dt] DEFAULT ('1/1/1900') FOR [active_Dt] ,
	CONSTRAINT [DF_dimCmisCodes_inactive_Dt] DEFAULT ('1/1/1900') FOR [inactive_Dt] ,
	CONSTRAINT [DF_dimCmisCodes_insert_By] DEFAULT (user_name()) FOR [insert_By] ,
	CONSTRAINT [DF_dimCmisCodes_insert_Dt] DEFAULT (getdate()) FOR [insert_Dt] ,
	CONSTRAINT [DF_dimCmisCodes_update_Dt] DEFAULT ('1/1/1900') FOR [update_Dt] ,
	CONSTRAINT [DF_dimCmisCodes_delete_Fl] DEFAULT (0) FOR [delete_Fl] , 
	CONSTRAINT [DF_dimCmisCodes_delete_Dt] DEFAULT ('1/1/1900') FOR [delete_Dt] ,
	CONSTRAINT [DF_dimCmisCodes_hidden_Fl] DEFAULT (0) FOR [hidden_Fl] , 
	CONSTRAINT [DF_dimCmisCodes_hidden_Dt] DEFAULT ('1/1/1900') FOR [hidden_Dt] 
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[dimCmisCodes]  TO [public]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER [trig_upd_dimCmisCodes] ON dbo.dimCmisCodes 
FOR UPDATE 
AS

DECLARE	@RecId	INT

SELECT	@RecId = Code_RecId 
FROM	inserted

UPDATE	dimCmisCodes 
SET	update_by = USER_NAME(),
	update_dt = GETDATE()
WHERE	Code_RecId = @RecId
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
	@level1name = 'dimCmisCodes'
GO
*/
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the code values and descriptions used in CMIS', 
	@level0type=N'SCHEMA',
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Identity for dimCmisCodes records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'Code_RecId'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Primary key for dimCmisCodes records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'catCd'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Primary key for dimCmisCodes records.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'itmCd'
GO

EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Flag indicating if the record is active or not.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'active_Fl'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Addition control for active_Fl indicating when the record became active.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'active_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Addition control for active_Fl indicating when the record went inactive.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'inactive_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the USERNAME() captured when the record was inserted.  Populated using "DF_dimCmisCodes_insert_By."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'insert_By'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the GETDATE() captured when the record was inserted.  Populated using "DF_dimCmisCodes_insert_Dt."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'insert_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the USERNAME() captured when the record was last updated.  Populated by the trigger "trig_upd_dimCmisCodes."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'update_By'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Contains the GETDATE() captured when the record was last updated.  Populated by the trigger "trig_upd_dimCmisCodes."' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'update_Dt'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Flag indicating if the record can be deleted.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'delete_Fl'
GO
EXEC sys.sp_addextendedproperty 
	@name=N'CMIS_Description', 
	@value=N'Addition control for delete_Fl indicating when the record was marked for deletion.' , 
	@level0type=N'SCHEMA', 
	@level0name=N'dbo', 
	@level1type=N'TABLE', 
	@level1name=N'dimCmisCodes', 
	@level2type=N'COLUMN', 
	@level2name=N'delete_Dt'
GO

/*
---------------------------------------
------- dimCmisCodes             ------- 
---------------------------------------

PRINT	'*** dimCmisCodes ***'
PRINT	'* Insert test *' 

INSERT 
INTO	dimCmisCodesDefinition (CatCd, CodeNm) VALUES (-100, 'Unit test')

INSERT 
INTO	dimCmisCodes (catCd, itmCd, itmTxt) 
VALUES	(-100, 1, 'Unit test case 1')

--- Default Review ---

PRINT	'* Default Review *' 

SELECT	catCd, itmCd, itmTxt, active_Fl, active_Dt, inactive_Dt, insert_By, insert_Dt, 
		update_By, update_Dt, delete_Fl, delete_Dt 
FROM	dimCmisCodes 
WHERE	catCd < -1

----- PRIMARY KEY constraint -----

PRINT	'* PRIMARY KEY constraint *' 

INSERT 
INTO	dimCmisCodes (catCd, itmCd, itmTxt) 
VALUES	(-100, 1, 'Unit test case 1')

----- FOREIGN KEY constraint -----

PRINT	'* FOREIGN KEY constraint *' 

INSERT 
INTO	dimCmisCodes (catCd, itmCd, itmTxt) 
VALUES	(-200, 1, 'Unit test case 4')

--- Trigger Review ---

PRINT	'* Trigger Review *' 

UPDATE	dimCmisCodes 
SET		itmTxt = 'Unit test case 3' 
WHERE	catCd = -100  

SELECT	catCd, itmCd, itmTxt, active_Fl, active_Dt, inactive_Dt, insert_By, insert_Dt, 
		update_By, update_Dt, delete_Fl, delete_Dt 
FROM	dimCmisCodes 
WHERE	catCd = -100 

----- NOT NULL constraint -----

PRINT	'* NOT NULL constraint *' 

INSERT 
INTO	dimCmisCodes (catCd) 
VALUES	(NULL)

INSERT 
INTO	dimCmisCodes (itmCd) 
VALUES	(NULL)

-----Cleanup -----

PRINT	'* Cleanup *' 

DELETE	dimCmisCodes WHERE catCd < -1
DELETE	dimCmisCodesDefinition WHERE CatCd < 0

*/

/*----- Load Code table -----*/ 

DELETE dimCmisCodes WHERE CatCd = 8193
DELETE dimCmisCodeDefinition WHERE CatCd = 8193

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (8193, 'PSI Report Types', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8193, '1', 'PSI', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8193, '2', 'AIP', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8193, '3', 'PSI/AIP', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8193, '4', 'Short Form PSI', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9001
DELETE dimCmisCodeDefinition WHERE CatCd = 9001

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9001, 'PSI Report Recommendation Types', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '-1', 'Select one', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '1', 'Probation: Yes', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '2', 'Probation: No', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '3', 'Other (Please Specify)', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '5', 'Probation Only', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '6', 'Incarceration Followed By Probation', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9001, '7', 'Incarceration', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9002
DELETE dimCmisCodeDefinition WHERE CatCd = 9002

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9002, 'PSI Attachment Types', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9002, '1', 'Addendum', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9002, '2', 'Appendix', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9002, '3', 'Juvenile Record - Free Flow', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9002, '4', 'Juvenile Record - Tabulated', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9003
DELETE dimCmisCodeDefinition WHERE CatCd = 9003

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9003, 'PSI Form Types', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9003, '1', 'Long Form', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9003, '2', 'Short Form', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9004
DELETE dimCmisCodeDefinition WHERE CatCd = 9004

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9004, 'Subject Relationships', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, '-1', 'Unknown' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'A1', 'Adoptive Mother' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'A2', 'Adoptive Father' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'A3', 'Adopted Son' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'A4', 'Adopted Daughter' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'B1', 'Mother' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'B2', 'Father' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'B3', 'Son' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'B4', 'Daughter' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'B5', 'Sister' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'B6', 'Brother' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'C3', 'Custodian Son' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'C4', 'Custodian Daughter' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'F1', 'Aunt' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'F2', 'Uncle' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'F3', 'Cousin' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'G1', 'Grandmother' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'G2', 'Grandfather' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'G3', 'Grandson' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'G4', 'Granddaughter' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'S1', 'Stepmother' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'S2', 'Stepfather' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'S3', 'Stepson' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'S4', 'Stepdaughter' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'Z1', 'Spouse' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'ZA', 'Husband' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'ZB', 'Wife' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'ZC', 'Fiance' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'Z2', 'Parents' , GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9004, 'Z3', 'Child' , GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9005
DELETE dimCmisCodeDefinition WHERE CatCd = 9005

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9005, 'Locked Flag', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9005, '0', 'Unlocked', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9005, '1', 'Locked', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9006
DELETE dimCmisCodeDefinition WHERE CatCd = 9006

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9006, 'Continuance Request Type', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9006, '0', 'CSSD', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9006, '1', 'Plaintiff', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9006, '2', 'Defendant', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9006, '21', 'Test', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9007
DELETE dimCmisCodeDefinition WHERE CatCd = 9007

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9007, 'Checked Box Flag', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9007, '0', 'Unchecked', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9007, '1', 'Checked', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 5334
DELETE dimCmisCodeDefinition WHERE CatCd = 5334

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (5334, 'ncic: EYE Code', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'BLK', 'BLK | Black', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'BLU', 'BLU | Blue', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'BRO', 'BRO | Brown', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'GRN', 'GRN | Green', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'GRY', 'GRY | Gray', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'HAZ', 'HAZ | Hazel', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'MAR', 'MAR | Maroon', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'MUL', 'MUL | Multicolored', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'PNK', 'PNK | Pink', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5334, 'XXX', 'XXX | Unknown', GETDATE()) 

DELETE dimCmisCodes WHERE CatCd = 5333
DELETE dimCmisCodeDefinition WHERE CatCd = 5333

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (5333, 'ncic: HAIR Code', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'BLK', 'BLK | Black', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'BLN', 'BLN | Blond or Strawberry', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'BLU', 'BLU | Blue', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'BRO', 'BRO | Brown', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'GRN', 'GRN | Green', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'GRY', 'GRY | Gray or Partially Gray', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'ONG', 'ONG | Orange', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'PLE', 'PLE | Puple', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'PNK', 'PNK | Pink', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'RED', 'RED | Red or Auburn', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'SDY', 'SDY | Sandy', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'WHI', 'WHI | White', GETDATE()) 
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5333, 'XXX', 'XXX | Unknown', GETDATE()) 

DELETE dimCmisCodes WHERE CatCd = 5700
DELETE dimCmisCodeDefinition WHERE CatCd = 5700

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (5700, 'ncic: SKIN Code', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'XXX', 'XXX | Unknown', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'ALB', 'ALB | Albino', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'BLK', 'BLK | Black', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'DRK', 'DRK | Dark', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'DBR', 'DBR | Dark Brown', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'FAR', 'FAR | Fair', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'LGT', 'LGT | Light', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'LBR', 'LBR | Light Brown', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'MED', 'MED | Medium', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'MBR', 'MBR | Medium Brown', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'OLV', 'OLV | Olive', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'RUD', 'RUD | Ruddy', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'SAL', 'SAL | Sallow', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (5700, 'YEL', 'YEL | Yellow', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 8141
DELETE dimCmisCodeDefinition WHERE CatCd = 8141

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (8141, 'Ethnicity/Race Codes', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '-1', '', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '6', 'African-American / Caucasian', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '7', 'African-American / Latin', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '9', 'American Indian / Alaskan Native', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '4', 'Asian / Pacific Islander', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '2', 'Black', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '11', 'Black / Hispanic', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '10', 'Black / White', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '3', 'Hispanic', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '8', 'Oriental / Caucasian', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '12', 'Oriental / White', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '5', 'Unknown', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (8141, '1', 'White', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9008
DELETE dimCmisCodeDefinition WHERE CatCd = 9008

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9008, 'Subject Build', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, '-1', 'Select One', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'ath', 'Athletic', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'avg', 'Average', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'hvy', 'Heavy', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'hky', 'Husky', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'lge', 'Large', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'med', 'Medium', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'mus', 'Muscular', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'owh', 'Overweight', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'pet', 'Petite', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'sle', 'Slender', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'slt', 'Slight', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'sli', 'Slim', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'sml', 'Small', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'stk', 'Stocky', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'thn', 'Thin', GETDATE())
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, active_dt) VALUES (9008, 'vhy', 'Very Heavy', GETDATE())

DELETE dimCmisCodes WHERE CatCd = 9009
DELETE dimCmisCodeDefinition WHERE CatCd = 9009

INSERT INTO dimCmisCodeDefinition (CatCd, CodeNm, active_dt) VALUES (9009, 'Spoken Language - ISO 639-3', GETDATE())

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, '-1', 'Select One', '', 0, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'eng', 'English', 'ISO 639-3', 10, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'spa', 'Spanish', 'ISO 639-3', 20, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'fra', 'French', 'ISO 639-3', 30, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'cmn', 'Chinese, Mandarin', 'ISO 639-3', 40, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'deu', 'German', 'ISO 639-3', 50, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'tgl', 'Tagalog', 'ISO 639-3', 60, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'vie', 'Vietnamese', 'ISO 639-3', 70, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'ita', 'Italian', 'ISO 639-3', 80, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'kor', 'Korean', 'ISO 639-3', 90, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'rus', 'Russian', 'ISO 639-3', 100, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'pol', 'Polish', 'ISO 639-3', 110, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'ara', 'Arabic', 'ISO 639-3', 120, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'por', 'Portuguese', 'ISO 639-3', 130, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'jpn', 'Japanese', 'ISO 639-3', 140, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'lou', 'French Creole, Louisiana', 'ISO 639-3', 150, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'ell', 'Greek', 'ISO 639-3', 160, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'hin', 'Hindi', 'ISO 639-3', 170, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'fas', 'Persain', 'ISO 639-3', 180, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'urd', 'Urdu', 'ISO 639-3', 190, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'yue', 'Chinese, Cantonese', 'ISO 639-3', 200, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'ase', 'Sign Language, American', 'ISO 639-3', 210, 'true', '10/1/07', 'false', '1/1/1900')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'zzz', 'Other', '', 220, 'true', '10/1/07', 'false', '1/1/1900')

INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'khm', 'Cambodian', 'ISO 639-3', NULL, 'true', '10/1/07', 'true', '10/1/07')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'pan', 'Panjabi, Eastern', 'ISO 639-3', NULL, 'true', '10/1/07', 'true', '10/1/07')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'hat', 'Haitian Creole', 'ISO 639-3', NULL, 'true', '10/1/07', 'true', '10/1/07')
INSERT INTO dimCmisCodes (CatCd, ItmCd, ItmTxt, codeSource, codeSortOrder, active_Fl, active_dt, hidden_Fl, hidden_dt) 
	VALUES (9009, 'loa', 'Lao', 'ISO 639-3', NULL, 'true', '10/1/07', 'true', '10/1/07')

/* 
SELECT	-- c.timestamp, 
--	c.rec_id, 
	cd.CodeNm, 
	c.CatCd, 
	LEFT(c.ItmCd, 5) AS ItmCd,  
	LEFT(c.ItmTxt, 30) AS ItmTxt, 

	c.CodeSource,  
--	c.CodeSourceId, 
--	c.CodeSourceCd, 
--	c.CodeSourceTxt, 
	c.codeSortOrder, 
	c.hidden_fl, 
	c.hidden_dt, 
	
	c.active_fl, 
	c.active_dt --, 
--	c.inactive_dt, 

--	c.insert_by, 
--	c.insert_dt, 
--	c.update_by, 
--	c.update_dt, 
--	c.delete_fl, 
--	c.delete_dt
FROM	dimCmisCodes c 
LEFT OUTER JOIN dimCmisCodeDefinition cd
	ON c.CatCd = cd.CatCd 
ORDER BY c.CatCd DESC, c.codeSortOrder, c.ItmCd 
*/

/*
DELETE	dimCmisCode

INSERT 
INTO	dimCmisCodes 
	(
--	timestamp ,
--	rec_id ,
--	dim_key ,
--	dim_desc ,
	
	CatCd ,
	ItmCd ,
	ItmTxt ,

--	active_fl ,
--	active_dt ,
--	inactive_dt ,
	insert_by ,
	insert_dt ,
	update_by ,
	update_dt ,
	delete_fl --,
--	delete_dt 
	)
SELECT	CatCd, 
		LEFT(ItmCd, 50), 
--		LngCd, 
--		GrpTypCd, 
		LEFT(ItmTxt, 150), 

		ISNULL(LstMdUsrID, -1),  
		ISNULL(CrtSetTs, GETDATE()), 
		LstMdUsrID, 
--		LstMdSvrID, 
		LstMdTs,  
--		RplStsCd, 
		DelFlg --, 
--		RplSetTs 
FROM	CTDoJProd..Code 
WHERE	LngCd = 0
*/ 

