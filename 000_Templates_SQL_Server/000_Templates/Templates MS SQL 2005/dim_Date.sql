USE [test]
GO
/****** Object:  Table [dbo].[dim_Date]    Script Date: 01/16/2007 12:09:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dim_Date](
	[timestamp] [timestamp] NULL,
	[Date_Key] [int] IDENTITY(1,1) NOT NULL,
	[Date] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FullDateDesc] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DayOfWeek] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DayNumInEpoch] [int] NOT NULL,
	[WeekNumInEpoch] [int] NOT NULL,
	[MonthNumInEpoch] [int] NOT NULL,
	[DayNumInCalendarMonth] [int] NOT NULL,
	[DayNumInCalendarYear] [int] NOT NULL,
	[DayNumInFiscalMonth] [int] NOT NULL,
	[DayNumInFiscalYear] [int] NOT NULL,
	[LastDayInWeekIndicator] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastDayInMonthIndicator] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarWeekEndingDate] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarWeekNumberInYear] [int] NOT NULL,
	[CalendarMonthName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarMonthNumberInYear] [int] NOT NULL,
	[CalendarYearMonth_YYYYMM] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarQuarter] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarYearQuarter_YYYYQQ] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarHalfYear] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CalendarYear] [int] NOT NULL,
	[FiscalWeek] [int] NOT NULL,
	[FiscalWeekNumberInYear] [int] NOT NULL,
	[FiscalMonth] [int] NOT NULL,
	[FiscalMonthInYear] [int] NOT NULL,
	[FiscalYearMonth_YYYYMM] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FiscalQuarter] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FiscalYearQuarter_YYYYQQ] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FiscalHalfYear] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FiscalYear] [char](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[HolidayIndicator] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[WeekdayIndicator] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SellingSeason] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MajorEvent] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[insert_by] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_dim_Date_insert_by]  DEFAULT (user_name()),
	[insert_dt] [datetime] NOT NULL CONSTRAINT [DF_dim_Date_insert_dt]  DEFAULT (getdate()),
	[update_by] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[update_dt] [datetime] NULL,
	[delete_fl] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[delete_dt] [datetime] NULL,
 CONSTRAINT [PK_dim_Date] PRIMARY KEY CLUSTERED 
(
	[Date_Key] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[dim_Date]  WITH CHECK ADD  CONSTRAINT [CK_dim_Date_CalendarMonthName] CHECK  (([CalendarMonthName]='December' OR [CalendarMonthName]='November' OR [CalendarMonthName]='October' OR [CalendarMonthName]='September' OR [CalendarMonthName]='August' OR [CalendarMonthName]='July' OR [CalendarMonthName]='June' OR [CalendarMonthName]='May' OR [CalendarMonthName]='April' OR [CalendarMonthName]='March' OR [CalendarMonthName]='February' OR [CalendarMonthName]='January' OR [CalendarMonthName]='Not Applicable'))
GO
ALTER TABLE [dbo].[dim_Date] CHECK CONSTRAINT [CK_dim_Date_CalendarMonthName]
GO
ALTER TABLE [dbo].[dim_Date]  WITH CHECK ADD  CONSTRAINT [CK_dim_Date_DayOfWeek] CHECK  (([DayOfWeek]='Saturday' OR [DayOfWeek]='Friday' OR [DayOfWeek]='Thursday' OR [DayOfWeek]='Wednesday' OR [DayOfWeek]='Tuesday' OR [DayOfWeek]='Monday' OR [DayOfWeek]='Sunday' OR [DayOfWeek]='Not Applicable'))
GO
ALTER TABLE [dbo].[dim_Date] CHECK CONSTRAINT [CK_dim_Date_DayOfWeek]
GO
ALTER TABLE [dbo].[dim_Date]  WITH CHECK ADD  CONSTRAINT [CK_dim_Date_HolidayIndicator] CHECK  (([HolidayIndicator]='Non-Holiday' OR [HolidayIndicator]='Holiday' OR [HolidayIndicator]='Not Applicable'))
GO
ALTER TABLE [dbo].[dim_Date] CHECK CONSTRAINT [CK_dim_Date_HolidayIndicator]
GO
ALTER TABLE [dbo].[dim_Date]  WITH CHECK ADD  CONSTRAINT [CK_dim_Date_Weekday] CHECK  (([WeekdayIndicator]='Weekend Day' OR [WeekdayIndicator]='Weekday' OR [WeekdayIndicator]='Not Applicable'))
GO
ALTER TABLE [dbo].[dim_Date] CHECK CONSTRAINT [CK_dim_Date_Weekday]
GO
ALTER TABLE [dbo].[dim_Date]  WITH CHECK ADD  CONSTRAINT [CK_dim_Date_SellingSeason] CHECK  (([SellingSeason]='Spring' OR [SellingSeason]='Summer' OR [SellingSeason]='Fall' OR [SellingSeason]='Winter' OR [SellingSeason]='Not Applicable'))
GO
ALTER TABLE [dbo].[dim_Date] CHECK CONSTRAINT [CK_dim_Date_SellingSeason]
GO
ALTER TABLE [dbo].[dim_Date]  WITH CHECK ADD  CONSTRAINT [CK_dim_Date_MajorEvent] CHECK  (([MajorEvent]='Non-Event' OR [MajorEvent]='Not Applicable'))
GO
ALTER TABLE [dbo].[dim_Date] CHECK CONSTRAINT [CK_dim_Date_MajorEvent]
GO
