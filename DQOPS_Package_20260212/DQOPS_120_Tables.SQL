USE [WRKDQOPS]
GO
/****** Object:  Table [dbo].[GETAPIRESULTS]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GETAPIRESULTS](
	[ExtractID] [nvarchar](50) NOT NULL,
	[URL] [nvarchar](100) NOT NULL,
	[URLEXTENSION] [nvarchar](200) NOT NULL,
	[TENANTID] [nvarchar](100) NOT NULL,
	[LastUpdate] [datetime] NULL,
	[TABLENAME] [nvarchar](100) NULL,
	[GETRESULTS] [nvarchar](max) NULL,
	[APIUsername] [varchar](255) NULL,
	[APIPassword] [nvarchar](2559) NULL,
	[APIPassword_BAK] [varbinary](max) NULL,
	[TableOrder] [int] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_GETAPIRESULTS] PRIMARY KEY CLUSTERED 
(
	[ExtractID] ASC,
	[URL] ASC,
	[URLEXTENSION] ASC,
	[TENANTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JSON_USERS]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JSON_USERS](
	[ExtractID] [nvarchar](50) NOT NULL,
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
	[email] [nvarchar](255) NULL,
	[email_notification] [nvarchar](50) NULL,
	[locale] [nvarchar](50) NULL,
	[opt_in] [nvarchar](50) NULL,
	[active] [nvarchar](50) NULL,
	[version_state] [nvarchar](50) NULL,
	[version] [nvarchar](50) NULL,
 CONSTRAINT [PK_JSON_USERS] PRIMARY KEY CLUSTERED 
(
	[ExtractID] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rtActionTracker]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rtActionTracker](
	[ID] [int] NOT NULL,
	[DQReportTrackerID] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[Title] [nvarchar](max) NULL,
	[AssignedTo] [nvarchar](50) NULL,
	[Priority] [nvarchar](50) NULL,
	[ClosedDate] [datetime] NULL,
	[ClosedBy] [nvarchar](50) NULL,
	[AssignToBusiness] [nvarchar](50) NULL,
	[AssignToSyniti] [nvarchar](50) NULL,
	[NewPriority] [nvarchar](50) NULL,
	[NewStatus] [nvarchar](50) NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[WaveID] [uniqueidentifier] NULL,
	[ProcessAreaID] [uniqueidentifier] NULL,
	[ObjectID] [uniqueidentifier] NULL,
	[CategoryID] [uniqueidentifier] NULL,
	[ScenarioID] [uniqueidentifier] NULL,
	[RequestID] [int] NULL,
	[GroupID] [nvarchar](50) NULL,
	[DQReport] [nvarchar](100) NULL,
	[ReportStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_rtActionTracker] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rtActionTrackerAttachment]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rtActionTrackerAttachment](
	[ID] [int] NOT NULL,
	[ParentID] [int] NOT NULL,
	[FilePath] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_rtActionTrackerAttachment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rtActionTrackerDetail]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rtActionTrackerDetail](
	[ParentID] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[AssignTo] [nvarchar](50) NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_rtActionTrackerDetail] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rtActionTrackerDQReport]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rtActionTrackerDQReport](
	[ParentID] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[GroupID] [nvarchar](50) NULL,
	[Report] [nvarchar](max) NULL,
	[ReportLink] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
 CONSTRAINT [PK_rtActionTrackerDQReport] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rtActionTrackerReport]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rtActionTrackerReport](
	[ParentID] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[Wave] [uniqueidentifier] NULL,
	[ProcessArea] [uniqueidentifier] NULL,
	[Object] [uniqueidentifier] NULL,
	[Report] [nvarchar](max) NULL,
	[ReportLink] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
 CONSTRAINT [PK_rtActionTrackerReport] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SKP_User]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SKP_User](
	[id] [nvarchar](200) NOT NULL,
	[name] [nvarchar](200) NULL,
	[email] [nvarchar](200) NULL,
	[locale] [nvarchar](100) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_SKP_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActions]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Action] [nvarchar](50) NULL,
	[DueBy] [datetime] NULL,
	[AssignedTo] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Comment] [nvarchar](100) NULL,
	[MeetingName] [nvarchar](100) NULL,
	[DMOwner] [nvarchar](50) NULL,
	[BusinessOwner] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttActions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActionTracker]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActionTracker](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[Title] [nvarchar](max) NULL,
	[AssignedTo] [nvarchar](50) NULL,
	[Priority] [nvarchar](50) NULL,
	[ClosedDate] [datetime] NULL,
	[ClosedBy] [nvarchar](50) NULL,
	[AssignToGovernance] [nvarchar](50) NULL,
	[AssignToDevelopment] [nvarchar](50) NULL,
	[NewPriority] [nvarchar](50) NULL,
	[NewStatus] [nvarchar](50) NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [datetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[WaveID] [uniqueidentifier] NULL,
	[ProcessAreaID] [uniqueidentifier] NULL,
	[ObjectID] [uniqueidentifier] NULL,
	[CategoryID] [uniqueidentifier] NULL,
	[ScenarioID] [uniqueidentifier] NULL,
	[RequestID] [int] NULL,
	[GroupID] [nvarchar](50) NULL,
	[DQReport] [nvarchar](256) NULL,
	[ReportStatus] [nvarchar](50) NULL,
	[DQReportTrackerID] [int] NULL,
 CONSTRAINT [PK_ttActionTracker] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActionTrackerAttachment]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActionTrackerAttachment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NOT NULL,
	[FilePath] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_ttActionTrackerAttachment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActionTrackerDetail]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActionTrackerDetail](
	[ParentID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[AssignTo] [nvarchar](50) NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[IsComment] [bit] NULL,
 CONSTRAINT [PK_ttActionTrackerDetail] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActionTrackerDetailBackUp]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActionTrackerDetailBackUp](
	[ParentID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AddedOn] [datetime] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[AssignTo] [nvarchar](50) NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[IsComment] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActionTrackerDQReport]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActionTrackerDQReport](
	[ParentID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [nvarchar](50) NULL,
	[Report] [nvarchar](max) NULL,
	[ReportLink] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [datetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
 CONSTRAINT [PK_ttActionTrackerDQReport] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttActionTrackerReport]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttActionTrackerReport](
	[ParentID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Wave] [uniqueidentifier] NULL,
	[ProcessArea] [uniqueidentifier] NULL,
	[Object] [uniqueidentifier] NULL,
	[Report] [nvarchar](max) NULL,
	[ReportLink] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
 CONSTRAINT [PK_ttActionTrackerReport] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttBusinessUser]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttBusinessUser](
	[UserName] [nvarchar](50) NOT NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttBusinessUser] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttCriticalilty_Compliance]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttCriticalilty_Compliance](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RuleID] [int] NOT NULL,
	[CriticalDataElement] [bit] NULL,
	[Potential_GxP] [bit] NULL,
	[Potential_SoX] [bit] NULL,
	[Potential_PII] [bit] NULL,
	[Potential_GDPR] [bit] NULL,
 CONSTRAINT [PK__ttCritic__3214EC2781C0BAEB] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttDataAccess]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttDataAccess](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DataAccess] [nvarchar](50) NULL,
 CONSTRAINT [PK__ttDataAc__3214EC273E8B30CA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttDecisions]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttDecisions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Decision] [nvarchar](50) NULL,
	[Owner] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Priority] [nvarchar](50) NULL,
	[DueBy] [datetime] NULL,
	[ActualDate] [datetime] NULL,
	[Comments] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttDecisions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttDQReportAttachment]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttDQReportAttachment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NOT NULL,
	[FilePath] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
	[SpecificationLink] [nvarchar](100) NULL,
 CONSTRAINT [PK_ttDQReportAttachment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttDQReportTracker]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttDQReportTracker](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DQOPSID] [nvarchar](50) NULL,
	[ReportID] [nvarchar](130) NULL,
	[Define] [bit] NULL,
	[Specify] [bit] NULL,
	[Build] [bit] NULL,
	[ValidateImprove] [bit] NULL,
	[Publish] [bit] NULL,
	[Health] [nvarchar](50) NULL,
	[CatalogReportName] [nvarchar](max) NULL,
	[ReportName] [nvarchar](max) NULL,
	[ReportType] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Priority] [nvarchar](50) NULL,
	[Startdate] [datetime] NULL,
	[Iteration] [nvarchar](50) NULL,
	[EndDate] [datetime] NULL,
	[PctComplete] [nvarchar](50) NULL,
	[Duration] [nvarchar](50) NULL,
	[Predecessors] [nvarchar](50) NULL,
	[AssignedTo] [nvarchar](50) NULL,
	[Requestor] [nvarchar](50) NULL,
	[BusinessProcess] [nvarchar](50) NULL,
	[FunctionalArea] [nvarchar](50) NULL,
	[RuleCriticality] [nvarchar](50) NULL,
	[RuleStatement] [nvarchar](500) NULL,
	[Comment] [nvarchar](max) NULL,
	[Implication] [nvarchar](max) NULL,
	[Source] [nvarchar](50) NULL,
	[ReportLogicalStatement] [nvarchar](max) NULL,
	[Reportfields] [nvarchar](max) NULL,
	[ReportFilter] [nvarchar](max) NULL,
	[ReportRepository] [nvarchar](500) NULL,
	[OpportunityCriteria] [nvarchar](max) NULL,
	[OpportunityViewName] [nvarchar](500) NULL,
	[RulestatementPositive] [nvarchar](max) NULL,
	[Remediation] [nvarchar](max) NULL,
	[Object] [nvarchar](50) NULL,
	[Group] [nvarchar](50) NULL,
	[QualityDimension] [nvarchar](50) NULL,
	[Thresholds] [nvarchar](50) NULL,
	[CostPerFailure] [nvarchar](50) NULL,
	[Disable] [bit] NULL,
	[ClientRef] [nvarchar](50) NULL,
	[Sprint] [nvarchar](50) NULL,
	[Dimensions] [nvarchar](50) NULL,
	[FunctionalDesignSummary] [nvarchar](max) NULL,
	[CustomField01] [nvarchar](50) NULL,
	[CustomField02] [nvarchar](50) NULL,
	[CustomField03] [nvarchar](50) NULL,
	[CustomField04] [nvarchar](50) NULL,
	[CustomField05] [nvarchar](50) NULL,
	[RuleOrigin] [nvarchar](50) NULL,
 CONSTRAINT [PK_ttDQReportTracker] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttDQReportTracker_Comment]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttDQReportTracker_Comment](
	[ParentID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Comment] [nvarchar](max) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [datetime] NULL,
 CONSTRAINT [PK_ttDQReportTracker_Comment] PRIMARY KEY CLUSTERED 
(
	[ParentID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttFunctionalUser]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttFunctionalUser](
	[UserName] [nvarchar](50) NOT NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttFunctionalUser] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttIssues]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttIssues](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[RaisedBy] [nvarchar](50) NULL,
	[Severity] [nvarchar](50) NULL,
	[Issue] [nvarchar](50) NULL,
	[Impact] [nvarchar](50) NULL,
	[ImpactType] [nvarchar](50) NULL,
	[Action] [nvarchar](50) NULL,
	[IssueResolution] [nvarchar](50) NULL,
	[Feedback] [nvarchar](50) NULL,
	[Owner] [nvarchar](50) NULL,
	[DueBy] [datetime] NULL,
	[Status] [nvarchar](50) NULL,
	[IssueType] [nvarchar](50) NULL,
	[ReqEscalation] [bit] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttIssues] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttReportProperties]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttReportProperties](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RuleID] [int] NOT NULL,
	[StrategyDimension] [nvarchar](50) NULL,
	[DataAccess] [nvarchar](50) NULL,
	[MainTable] [nvarchar](50) NULL,
	[MainField] [nvarchar](50) NULL,
	[DataModel] [nvarchar](50) NULL,
	[ResolutionValue] [nvarchar](50) NULL,
	[ResolutionEffort] [nvarchar](50) NULL,
	[CleanseDimension] [nvarchar](50) NULL,
 CONSTRAINT [PK__ttReport__3214EC27FB660894] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttRisks]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttRisks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[IdentifiedBy] [nvarchar](50) NULL,
	[ProjectStage] [nvarchar](50) NULL,
	[Specification] [nvarchar](100) NULL,
	[Status] [nvarchar](50) NULL,
	[Owner] [nvarchar](50) NULL,
	[Severity] [nvarchar](50) NULL,
	[Probability] [float] NULL,
	[Impact] [nvarchar](50) NULL,
	[RiskMitigation] [nvarchar](50) NULL,
	[RiskMitDueDate] [datetime] NULL,
	[ReqEscalation] [bit] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttRisks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttStrategyDimension]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttStrategyDimension](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StrategyDimension] [nvarchar](50) NULL,
 CONSTRAINT [PK__ttStrate__3214EC272932B930] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttSynitiUser]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttSynitiUser](
	[UserName] [nvarchar](50) NOT NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ttSynitiUser] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztCriticality]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztCriticality](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Criticality] [nvarchar](50) NULL,
	[Value] [int] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ztCriticality_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztCustomField01]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztCustomField01](
	[Priority] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ztCustomField01] PRIMARY KEY CLUSTERED 
(
	[Priority] ASC,
	[CustomFieldValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztCustomField02]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztCustomField02](
	[Priority] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ztCustomField02] PRIMARY KEY CLUSTERED 
(
	[Priority] ASC,
	[CustomFieldValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztCustomField03]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztCustomField03](
	[Priority] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ztCustomField03] PRIMARY KEY CLUSTERED 
(
	[Priority] ASC,
	[CustomFieldValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztCustomField04]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztCustomField04](
	[Priority] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ztCustomField04] PRIMARY KEY CLUSTERED 
(
	[Priority] ASC,
	[CustomFieldValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztCustomField05]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztCustomField05](
	[Priority] [int] NOT NULL,
	[CustomFieldValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ztCustomField05] PRIMARY KEY CLUSTERED 
(
	[Priority] ASC,
	[CustomFieldValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztDQDimension]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztDQDimension](
	[DQDimensions] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DQDimensions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztDQGRoup]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztDQGRoup](
	[GROUPID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztDQTrackerObject]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztDQTrackerObject](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Object] [nvarchar](50) NULL,
 CONSTRAINT [PK_ztDQTrackerObject] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztEmail]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztEmail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[From] [nvarchar](100) NULL,
	[To] [nvarchar](100) NULL,
	[CC] [nvarchar](100) NULL,
	[BCC] [nvarchar](100) NULL,
	[Subject] [nvarchar](500) NULL,
	[Body] [nvarchar](max) NULL,
	[Email_Attachment] [nvarchar](1000) NULL,
	[Group] [nvarchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztNumberRange]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztNumberRange](
	[RuleOrigin] [varchar](255) NOT NULL,
	[FromNo] [int] NULL,
	[ToNumber] [int] NULL,
	[LastNumberUsed] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RuleOrigin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztParam]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztParam](
	[One] [int] NULL,
	[Usage] [nvarchar](50) NULL,
	[EmailFrom] [nvarchar](100) NULL,
	[CustomField01] [nvarchar](50) NULL,
	[CustomField02] [nvarchar](50) NULL,
	[CustomField03] [nvarchar](50) NULL,
	[CustomField04] [nvarchar](50) NULL,
	[CustomField05] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztRuleOrigin]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztRuleOrigin](
	[RuleOrigin] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RuleOrigin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztSeverity]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztSeverity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Severity] [nvarchar](50) NULL,
	[Value] [int] NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
 CONSTRAINT [PK_ztSeverity_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztSprint]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztSprint](
	[SprintID] [nvarchar](50) NOT NULL,
	[SprintName] [nvarchar](50) NULL,
	[CalendarWeek] [nvarchar](50) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
 CONSTRAINT [PK_ztSprint] PRIMARY KEY CLUSTERED 
(
	[SprintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztStatus]    Script Date: 2/12/2026 3:25:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztStatus](
	[Priority] [int] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[AddedBy] [nvarchar](50) NULL,
	[AddedOn] [smalldatetime] NULL,
	[AddedVia] [nvarchar](50) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [smalldatetime] NULL,
	[ChangedVia] [nvarchar](50) NULL,
	[boaStatus] [int] NULL,
	[Status_Unchecked] [nvarchar](50) NULL,
	[Next_Event] [nvarchar](500) NULL,
	[Preceding_Action] [nvarchar](500) NULL,
 CONSTRAINT [PK_ztStatus_1] PRIMARY KEY CLUSTERED 
(
	[Priority] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GETAPIRESULTS] ADD  CONSTRAINT [DF_GETAPIRESULTS_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[GETAPIRESULTS] ADD  CONSTRAINT [DF_GETAPIRESULTS_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance] ADD  CONSTRAINT [DF__ttCritica__Criti__14E61A24]  DEFAULT ((0)) FOR [CriticalDataElement]
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance] ADD  CONSTRAINT [DF__ttCritica__Poten__15DA3E5D]  DEFAULT ((0)) FOR [Potential_GxP]
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance] ADD  CONSTRAINT [DF__ttCritica__Poten__16CE6296]  DEFAULT ((0)) FOR [Potential_SoX]
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance] ADD  CONSTRAINT [DF__ttCritica__Poten__17C286CF]  DEFAULT ((0)) FOR [Potential_PII]
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance] ADD  CONSTRAINT [DF__ttCritica__Poten__18B6AB08]  DEFAULT ((0)) FOR [Potential_GDPR]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Definition]  DEFAULT ((0)) FOR [Define]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Specification]  DEFAULT ((0)) FOR [Specify]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Build]  DEFAULT ((0)) FOR [Build]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Validate]  DEFAULT ((0)) FOR [ValidateImprove]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Publish]  DEFAULT ((0)) FOR [Publish]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Health]  DEFAULT ('CranSoft.Status.DSPLateTask') FOR [Health]
GO
ALTER TABLE [dbo].[ttDQReportTracker] ADD  CONSTRAINT [DF_ttDQReportTracker_Disable]  DEFAULT ((0)) FOR [Disable]
GO
ALTER TABLE [dbo].[ttActionTrackerAttachment]  WITH CHECK ADD  CONSTRAINT [FK_ttActionTrackerAttachment_ttActionTracker] FOREIGN KEY([ParentID])
REFERENCES [dbo].[ttActionTracker] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttActionTrackerAttachment] CHECK CONSTRAINT [FK_ttActionTrackerAttachment_ttActionTracker]
GO
ALTER TABLE [dbo].[ttActionTrackerDetail]  WITH CHECK ADD  CONSTRAINT [FK_ttActionTrackerDetail_ttActionTracker] FOREIGN KEY([ParentID])
REFERENCES [dbo].[ttActionTracker] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttActionTrackerDetail] CHECK CONSTRAINT [FK_ttActionTrackerDetail_ttActionTracker]
GO
ALTER TABLE [dbo].[ttActionTrackerDQReport]  WITH CHECK ADD  CONSTRAINT [FK_ttActionTrackerDQReport_ttActionTracker] FOREIGN KEY([ParentID])
REFERENCES [dbo].[ttActionTracker] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttActionTrackerDQReport] CHECK CONSTRAINT [FK_ttActionTrackerDQReport_ttActionTracker]
GO
ALTER TABLE [dbo].[ttActionTrackerReport]  WITH CHECK ADD  CONSTRAINT [FK_ttActionTrackerReport_ttActionTracker] FOREIGN KEY([ParentID])
REFERENCES [dbo].[ttActionTracker] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttActionTrackerReport] CHECK CONSTRAINT [FK_ttActionTrackerReport_ttActionTracker]
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance]  WITH CHECK ADD  CONSTRAINT [FK__ttCritica__RuleI__19AACF41] FOREIGN KEY([RuleID])
REFERENCES [dbo].[ttDQReportTracker] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttCriticalilty_Compliance] CHECK CONSTRAINT [FK__ttCritica__RuleI__19AACF41]
GO
ALTER TABLE [dbo].[ttDQReportTracker_Comment]  WITH CHECK ADD  CONSTRAINT [FK_ttDQReportTracker_Comment_ttDQReportTracker] FOREIGN KEY([ParentID])
REFERENCES [dbo].[ttDQReportTracker] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttDQReportTracker_Comment] CHECK CONSTRAINT [FK_ttDQReportTracker_Comment_ttDQReportTracker]
GO
ALTER TABLE [dbo].[ttReportProperties]  WITH CHECK ADD  CONSTRAINT [FK__ttReportP__RuleI__251C81ED] FOREIGN KEY([RuleID])
REFERENCES [dbo].[ttDQReportTracker] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ttReportProperties] CHECK CONSTRAINT [FK__ttReportP__RuleI__251C81ED]
GO
