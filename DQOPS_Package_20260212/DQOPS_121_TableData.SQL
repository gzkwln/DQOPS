USE [WRKDQOPS]
GO
SET IDENTITY_INSERT [dbo].[ttDataAccess] ON 
GO
INSERT [dbo].[ttDataAccess] ([ID], [DataAccess]) VALUES (1, N'Precalculation')
GO
INSERT [dbo].[ttDataAccess] ([ID], [DataAccess]) VALUES (2, N'Direct')
GO
SET IDENTITY_INSERT [dbo].[ttDataAccess] OFF
GO
SET IDENTITY_INSERT [dbo].[ztCriticality] ON 
GO
INSERT [dbo].[ztCriticality] ([ID], [Criticality], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (1, N'High', NULL, N'ABelloti', CAST(N'2023-11-07T10:16:00' AS SmallDateTime), N'UserInterface', N'ABelloti', CAST(N'2023-11-07T10:16:00' AS SmallDateTime), N'UserInterface', 0)
GO
INSERT [dbo].[ztCriticality] ([ID], [Criticality], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (2, N'Medium', NULL, N'ABelloti', CAST(N'2023-11-07T10:16:00' AS SmallDateTime), N'UserInterface', N'ABelloti', CAST(N'2023-11-07T10:16:00' AS SmallDateTime), N'UserInterface', 0)
GO
INSERT [dbo].[ztCriticality] ([ID], [Criticality], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (3, N'Low', NULL, N'ABelloti', CAST(N'2023-11-07T10:16:00' AS SmallDateTime), N'UserInterface', N'ABelloti', CAST(N'2023-11-07T10:16:00' AS SmallDateTime), N'UserInterface', 0)
GO
SET IDENTITY_INSERT [dbo].[ztCriticality] OFF
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Accuracy')
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Completeness')
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Conformity')
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Consistency')
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Integrity')
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Timeliness')
GO
INSERT [dbo].[ztDQDimension] ([DQDimensions]) VALUES (N'Validity')
GO
INSERT [dbo].[ztNumberRange] ([RuleOrigin], [FromNo], [ToNumber], [LastNumberUsed]) VALUES (N'Bespoke', 1001, 9999, 1000)
GO
INSERT [dbo].[ztNumberRange] ([RuleOrigin], [FromNo], [ToNumber], [LastNumberUsed]) VALUES (N'Catalog', 1, 1000, 0)
GO
INSERT [dbo].[ztParam] ([One], [Usage], [EmailFrom], [CustomField01], [CustomField02], [CustomField03], [CustomField04], [CustomField05]) VALUES (1, N'DQ', N'ActionTracker@syniti.com', NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[ztRuleOrigin] ([RuleOrigin]) VALUES (N'Bespoke')
GO
INSERT [dbo].[ztRuleOrigin] ([RuleOrigin]) VALUES (N'Catalog')
GO
SET IDENTITY_INSERT [dbo].[ztSeverity] ON 
GO
INSERT [dbo].[ztSeverity] ([ID], [Severity], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (1, N'Critical', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[ztSeverity] ([ID], [Severity], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (2, N'High', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[ztSeverity] ([ID], [Severity], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (3, N'Medium', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[ztSeverity] ([ID], [Severity], [Value], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus]) VALUES (4, N'Low', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ztSeverity] OFF
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (10, N'Not started', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-05T11:27:00' AS SmallDateTime), N'UserInterface', N'CPOPP', CAST(N'2024-03-11T19:14:00' AS SmallDateTime), N'UserInterface', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (20, N'Awaiting specification', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-05T11:28:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-04-08T16:46:00' AS SmallDateTime), N'UserInterface', 0, N'Not started', N'Specify – Functional User is required to provide the technical report specification', N'Provide Definition of Report (a high level requirements document)')
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (30, N'Build In progress', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-05T11:28:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-04-09T11:11:00' AS SmallDateTime), N'UserInterface', 0, N'Awaiting specification', N'Build – Developer User has all required information to proceed with build, or otherwise comment to revert to Functional User', N'Provide DQ Rule Specification (a DQ Rule Design document based on a template – refer to Lead for more information)')
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (40, N'Pending validation', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-05T11:28:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-04-08T16:47:00' AS SmallDateTime), N'UserInterface', 0, N'Build In progress', N'Validate  - Functional User is required to perform the initial validation of the report and provide an improvement required', N'Proceed with Rule Build')
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (50, N'Validate/Improve Iteration', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-05T11:28:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-04-09T11:16:00' AS SmallDateTime), N'UserInterface', 0, N'Pending validation & improvement', N'Publish – Governance User provides final approval for this report to be published', N'Complete Validation and Confirm report to be Published')
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (70, N'Published', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-05T11:28:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-04-09T11:17:00' AS SmallDateTime), N'UserInterface', 0, N'Validation Complete awaiting Publication', N'Publish (system) – developer/admin performs technical activity required (Move reports between groups, DQ Score Roll Up, Report/Dashboard scheduling/sharing)', N'Complete publication of DQ Report')
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (100, N'Closed', N'DQ Report Tracker', N'CPOPP', CAST(N'2024-03-07T10:14:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-04-08T17:08:00' AS SmallDateTime), N'UserInterface', 0, NULL, N'No action pending', NULL)
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (299, N'Not started', N'Action Tracker', N'CPOPP', CAST(N'2024-03-11T19:15:00' AS SmallDateTime), N'UserInterface', N'CPOPP', CAST(N'2024-03-11T19:15:00' AS SmallDateTime), N'UserInterface', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (300, N'Open', N'Action Tracker', N'CPOPP', CAST(N'2024-03-11T19:14:00' AS SmallDateTime), N'UserInterface', N'CPOPP', CAST(N'2024-03-11T19:14:00' AS SmallDateTime), N'UserInterface', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (310, N'Pending', N'Action Tracker', N'CPOPP', CAST(N'2024-03-11T19:14:00' AS SmallDateTime), N'UserInterface', N'CPOPP', CAST(N'2024-03-11T19:14:00' AS SmallDateTime), N'UserInterface', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[ztStatus] ([Priority], [Status], [Type], [AddedBy], [AddedOn], [AddedVia], [ChangedBy], [ChangedOn], [ChangedVia], [boaStatus], [Status_Unchecked], [Next_Event], [Preceding_Action]) VALUES (320, N'Closed', N'Action Tracker', N'CPOPP', CAST(N'2024-03-11T19:14:00' AS SmallDateTime), N'UserInterface', N'kshd195', CAST(N'2024-03-12T16:17:00' AS SmallDateTime), N'UserInterface', 0, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ztEmail] ON 
GO
INSERT [dbo].[ztEmail] ([ID], [From], [To], [CC], [BCC], [Subject], [Body], [Email_Attachment], [Group]) VALUES (1, N'ActionTracker@syniti.com', NULL, NULL, NULL, N'Action Tracker ID #ID# - Status: #ReportStatus#', N'Dear #Name#<div><br></div><div>You have been assigned to the Action Tracker ID: #ID#.</div><div>Title: #Title#</div><div><br></div><div>Please follow the link to access the Action Tracker Details.</div><div><br></div><div>Best regards,</div><div>Action Tracker</div>', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ztEmail] OFF