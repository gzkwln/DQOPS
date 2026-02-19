USE [WRKDQOPS]
GO
/****** Object:  View [dbo].[webActionTracker_LastComment_000_Sel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_LastComment_000_Sel]
AS
SELECT        ParentID
FROM            dbo.ttActionTrackerDetail
WHERE        (IsComment = 1)
GROUP BY ParentID

GO
/****** Object:  View [dbo].[webActionTracker_LastComment_010_Sel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_LastComment_010_Sel]
AS
SELECT        dbo.ttActionTrackerDetail.ParentID, MAX(dbo.ttActionTrackerDetail.ID) AS ID
FROM            dbo.ttActionTrackerDetail INNER JOIN
                         dbo.webActionTracker_LastComment_000_Sel ON dbo.ttActionTrackerDetail.ParentID = dbo.webActionTracker_LastComment_000_Sel.ParentID
WHERE        (dbo.ttActionTrackerDetail.IsComment = 1)
GROUP BY dbo.ttActionTrackerDetail.ParentID

GO
/****** Object:  View [dbo].[webActionTracker_LastComment_020_Sel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_LastComment_020_Sel]
AS
SELECT        dbo.ttActionTrackerDetail.ParentID AS ID, dbo.ttActionTrackerDetail.Description
FROM            dbo.webActionTracker_LastComment_010_Sel INNER JOIN
                         dbo.ttActionTrackerDetail ON dbo.webActionTracker_LastComment_010_Sel.ParentID = dbo.ttActionTrackerDetail.ParentID AND dbo.webActionTracker_LastComment_010_Sel.ID = dbo.ttActionTrackerDetail.ID

GO
/****** Object:  View [dbo].[webActionTrackerDetail_Comment_CountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDetail_Comment_CountSel]
AS
SELECT        ParentID AS ID, COUNT(1) AS Count
FROM            dbo.ttActionTrackerDetail
WHERE        (IsComment = 1)
GROUP BY ParentID

GO
/****** Object:  View [dbo].[webActionTrackerDQReport_CountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDQReport_CountSel]
AS
SELECT        ParentID, COUNT(1) AS Count
FROM            dbo.ttActionTrackerDQReport
GROUP BY ParentID

GO
/****** Object:  View [dbo].[webActionTrackerAttachment_CountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerAttachment_CountSel]
AS
SELECT        ParentID, COUNT(1) AS Count
FROM            dbo.ttActionTrackerAttachment
GROUP BY ParentID

GO
/****** Object:  View [dbo].[webActionTracker_DQHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE   VIEW [dbo].[webActionTracker_DQHor]
AS
  SELECT dbo.ttActionTracker.boaStatus,
         dbo.ttActionTracker.ID,
		 dbo.ttActionTracker.DQReportTrackerID,
         dbo.ttActionTracker.GroupID,
		 ttActionTracker.WaveID,
		 ttActionTracker.ProcessAreaID,
		 ttActionTracker.ObjectID,
		 ttActionTracker.CategoryID,
		 ttActionTracker.ScenarioID,
		 ttActionTracker.DQReport AS DQReport,
         --dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTracker.DQReport) AS DQReport,
         dbo.ttActionTracker.Priority,
         dbo.ttActionTracker.Status,
		 dbo.ttActionTracker.ReportStatus,
		 dbo.ttDQReportTracker.Sprint,
         dbo.ttActionTracker.Title,
         dbo.webActionTracker_LastComment_020_Sel.Description             AS LastComment,
         dbo.ttActionTracker.AssignedTo,
		 NULL AS NotifyUser,
         dbo.ttActionTracker.AddedOn,
         dbo.ttActionTracker.AddedBy,
         dbo.ttActionTracker.ClosedDate,
         dbo.ttActionTracker.ClosedBy,
         dbo.webActionTrackerDetail_Comment_CountSel.Count                AS ActionTrackerDetail,
         dbo.webActionTrackerDQReport_CountSel.Count                      AS DQReports,
         dbo.webActionTrackerAttachment_CountSel.Count                    AS Attachment,
         CASE
           WHEN ttsynitiuser.username IS NOT NULL THEN 'Development'
           WHEN ttbusinessuser.username IS NOT NULL THEN 'Governance'
         END                                                       AS Owner,
         NULL                                                      AS ArchiveClosedActions,
         dbo.ztParam.Usage
  FROM   dbo.ttActionTracker
         LEFT OUTER JOIN dbo.webActionTrackerDetail_Comment_CountSel
                      ON dbo.ttActionTracker.ID = dbo.webActionTrackerDetail_Comment_CountSel.ID
         LEFT OUTER JOIN dbo.webActionTracker_LastComment_020_Sel
                      ON dbo.ttActionTracker.ID = dbo.webActionTracker_LastComment_020_Sel.ID
         LEFT OUTER JOIN dbo.webActionTrackerAttachment_CountSel
                      ON dbo.ttActionTracker.ID = dbo.webActionTrackerAttachment_CountSel.ParentID
         LEFT OUTER JOIN dbo.webActionTrackerDQReport_CountSel
                      ON dbo.ttActionTracker.ID = dbo.webActionTrackerDQReport_CountSel.ParentID
         LEFT OUTER JOIN dbo.ttBusinessUser
                      ON dbo.ttActionTracker.AssignedTo = dbo.ttBusinessUser.UserName
         LEFT OUTER JOIN dbo.ttSynitiUser
                      ON dbo.ttActionTracker.AssignedTo = dbo.ttSynitiUser.UserName
         CROSS JOIN dbo.ztParam 
		 INNER JOIN ttDQReportTracker 
					  ON ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
GO
/****** Object:  View [dbo].[webActionTrackerDQReportSummary_ReportCountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webActionTrackerDQReportSummary_ReportCountSel]
AS
SELECT        DQReportTrackerID,  COUNT(1) AS Count
FROM            dbo.ttActionTrackerDQReport INNER JOIN ttActionTracker ON ttActionTrackerDQReport.ParentID = ttActionTracker.ID
GROUP BY DQReportTrackerID

GO
/****** Object:  View [dbo].[webActionTrackerDQReportSummaryHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webActionTrackerDQReportSummaryHor]
AS
  SELECT dbo.ttActionTracker.DQReportTrackerID,
                              dbo.ttActionTrackerDQReport.GroupID,
         dbo.ttActionTrackerDQReport.Report,
         dbo.webActionTrackerDQReportSummary_ReportCountSel.Count AS ActionTracker
  FROM   dbo.ttActionTrackerDQReport
                              INNER JOIN ttActionTracker ON ttActionTrackerDQReport.ParentID = ttActionTracker.ID
         LEFT OUTER JOIN dbo.webActionTrackerDQReportSummary_ReportCountSel
                      ON dbo.ttActionTracker.DQReportTrackerID = dbo.webActionTrackerDQReportSummary_ReportCountSel.DQReportTrackerID
  GROUP  BY dbo.ttActionTracker.DQReportTrackerID,
                                            dbo.ttActionTrackerDQReport.GroupID,
            dbo.ttActionTrackerDQReport.Report,
            dbo.webActionTrackerDQReportSummary_ReportCountSel.Count 

                                            
GO
/****** Object:  View [dbo].[boaUsersEmailList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[boaUsersEmailList]
AS
SELECT id, name, email, locale, active
FROM     [dbo].[JSON_USERS]
WHERE  (email IS NOT NULL)

GO
/****** Object:  View [dbo].[webztEmailHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webztEmailHor]
AS
SELECT dbo.ztEmail.ID, dbo.ztEmail.[From], dbo.boaUsersEmailList.Name, dbo.ztEmail.[To], dbo.ztEmail.CC, dbo.ztEmail.BCC, dbo.ztEmail.Subject, dbo.ztEmail.Body, 
                  dbo.ztEmail.Email_Attachment, dbo.ztEmail.[Group]
FROM     dbo.ztEmail LEFT OUTER JOIN
                  dbo.boaUsersEmailList ON dbo.ztEmail.[To] = dbo.boaUsersEmailList.email


GO
/****** Object:  View [dbo].[webActionTracker_NotifyUserEmailWORKFLOW]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webActionTracker_NotifyUserEmailWORKFLOW]
AS
  SELECT ztParam.[EmailFrom] AS [From],
         boaUsersEmailList.Name,
         email AS [To],
         CC,
         BCC,
         Subject,
         Body,
         Email_Attachment,
         [Group],
         webztEmailHor.ID AS EmailID,
		 ttActionTracker.ID,
		 ttActionTracker.ReportStatus,
		 ttActionTracker.Title
  FROM   dbo.webztEmailHor
 CROSS JOIN dbo.ttActionTracker
 INNER JOIN boaUsersEmailList ON dbo.ttActionTracker.AssignedTo = boaUsersEmailList.email
 CROSS JOIN dbo.ztParam
GO
/****** Object:  View [dbo].[webActionTracker_AssignEmailFlow]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
 
CREATE   VIEW [dbo].[webActionTracker_AssignEmailFlow]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.AssignedTo, boaUsersEmailList.Email AS [To], 'You have been assigned to action: ' + CONVERT(nvarchar, dbo.ttActionTracker.ID) AS Subject, 
                         'Please follow the link to access the action details' AS Body, dbo.ztParam.EmailFrom AS [From]
FROM            dbo.ttActionTracker INNER JOIN
                         boaUsersEmailList ON dbo.ttActionTracker.AssignedTo = boaUsersEmailList.email CROSS JOIN
                         dbo.ztParam
GO
/****** Object:  View [dbo].[webSelectionPageVer]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE   VIEW [dbo].[webSelectionPageVer]
AS
SELECT 
(SELECT COUNT(*) FROM ttDQReportTracker) AS DQReportTracker
,(SELECT COUNT(*) FROM ttDQReportTracker WHERE AssignedTo = email) AS MyDQReportAssignments
,(SELECT COUNT(*) FROM ttActionTracker) AS ActionTracker
,(SELECT COUNT(*) FROM ttActionTracker WHERE AssignedTo = email) AS MyActionTrackerAssignments
,(SELECT COUNT(*) FROM rtActionTracker) AS ActionTrackerClosed
,NULL AS CountOfLifeCyclePhases
,(SELECT COUNT(*) FROM ttDQReportTracker WHERE [Define]    = 1 AND Specify = 0) AS [Define]  
,(SELECT COUNT(*) FROM ttDQReportTracker WHERE [Specify]   = 1 AND Build = 0) AS [Specify] 
,(SELECT COUNT(*) FROM ttDQReportTracker WHERE [Build]     = 1 AND ValidateImprove = 0) AS [Build]   
,(SELECT COUNT(*) FROM ttDQReportTracker WHERE [ValidateImprove]  = 1 AND Publish = 0) AS [ValidateImprove]
,(SELECT COUNT(*) FROM ttDQReportTracker WHERE [Publish]   = 1) AS [Publish] 
,email AS boaUserEmail
FROM boaUsersEmailList
GO
/****** Object:  View [dbo].[ztSAPTableList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[ztSAPTableList]  
 AS SELECT T.name AS Table_Name ,  
       C.name AS Column_Name ,  
       P.name AS Data_Type ,  
       C.max_length AS Size ,  
       CAST(P.precision AS VARCHAR) + '/' + CAST(P.scale AS VARCHAR) AS Precision_Scale  
FROM   [SRCSAPECCDEMO].sys.objects AS T  
       JOIN [SRCSAPECCDEMO].sys.columns AS C ON T.object_id = C.object_id  
       JOIN [SRCSAPECCDEMO].sys.types AS P ON C.system_type_id = P.system_type_id  
    where T.type = 'U'
GO
/****** Object:  View [dbo].[webSAPFieldList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webSAPFieldList] AS 
Select Distinct Table_Name,Column_Name From ztSAPTableList
GO
/****** Object:  View [dbo].[webCustomField01List]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCustomField01List]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField01
GO
/****** Object:  View [dbo].[webttDQReportTracker_CustomField01_NotInListVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webttDQReportTracker_CustomField01_NotInListVal] AS SELECT [ttDQReportTracker].[ID], [ttDQReportTracker].[CustomField01] FROM [dbo].[ttDQReportTracker] LEFT OUTER JOIN [dbo].[webCustomField01List] ON ([ttDQReportTracker].[CustomField01]=[webCustomField01List].[CustomFieldValue]) WHERE ([webCustomField01List].[CustomFieldValue] IS NULL AND [ttDQReportTracker].[CustomField01] IS NOT NULL AND [ttDQReportTracker].[CustomField01] != ' ')
GO
/****** Object:  View [dbo].[webActionTrackerDQReportSummary_ActionTracker_010_CountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webActionTrackerDQReportSummary_ActionTracker_010_CountSel]
AS
SELECT        /*REPLACE(dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTrackerDQReport.Report), 'tv', '') ttActionTrackerDQReport.Report AS DQReport,*/ dbo.ttActionTracker.ID, ttActionTracker.DQReportTrackerID
FROM            dbo.ttActionTrackerDQReport INNER JOIN
                        dbo.ttActionTracker ON dbo.ttActionTrackerDQReport.ParentID = dbo.ttActionTracker.ID
GROUP BY /*REPLACE(dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTrackerDQReport.Report), 'tv', '')ttActionTrackerDQReport.Report,*/ dbo.ttActionTracker.ID, ttActionTracker.DQReportTrackerID

 

GO
/****** Object:  View [dbo].[webActionTrackerDQReportSummary_TrackerActionCountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webActionTrackerDQReportSummary_TrackerActionCountSel]
AS
SELECT        DQReportTrackerID, COUNT(1) AS Count
FROM            dbo.webActionTrackerDQReportSummary_ActionTracker_010_CountSel
GROUP BY DQReportTrackerID

GO
/****** Object:  View [dbo].[webCustomField02List]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCustomField02List]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField02
GO
/****** Object:  View [dbo].[webttDQReportTracker_CustomField02_NotInListVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webttDQReportTracker_CustomField02_NotInListVal] AS SELECT [ttDQReportTracker].[ID], [ttDQReportTracker].[CustomField02] FROM [dbo].[ttDQReportTracker] LEFT OUTER JOIN [dbo].[webCustomField02List] ON ([ttDQReportTracker].[CustomField02]=[webCustomField02List].[CustomFieldValue]) WHERE ([webCustomField02List].[CustomFieldValue] IS NULL AND [ttDQReportTracker].[CustomField02] IS NOT NULL AND [ttDQReportTracker].[CustomField02] != ' ')
GO
/****** Object:  View [dbo].[webCustomField03List]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCustomField03List]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField03
GO
/****** Object:  View [dbo].[webttDQReportTracker_CustomField03_NotInListVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webttDQReportTracker_CustomField03_NotInListVal] AS SELECT [ttDQReportTracker].[ID], [ttDQReportTracker].[CustomField03] FROM [dbo].[ttDQReportTracker] LEFT OUTER JOIN [dbo].[webCustomField03List] ON ([ttDQReportTracker].[CustomField03]=[webCustomField03List].[CustomFieldValue]) WHERE ([webCustomField03List].[CustomFieldValue] IS NULL AND [ttDQReportTracker].[CustomField03] IS NOT NULL AND [ttDQReportTracker].[CustomField03] != ' ')
GO
/****** Object:  View [dbo].[webDQReportAttachment_CountSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webDQReportAttachment_CountSel]
AS
SELECT        ParentID, COUNT(1) AS Count
FROM            dbo.ttDQReportAttachment
GROUP BY ParentID

GO
/****** Object:  View [dbo].[webDQReportTracker_CommentHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webDQReportTracker_CommentHor]
AS
SELECT        ParentID, ID, Comment, AddedBy, AddedOn
FROM            dbo.ttDQReportTracker_Comment

GO
/****** Object:  View [dbo].[webDQReportTrackerHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE   VIEW [dbo].[webDQReportTrackerHor]
AS
SELECT dbo.ttDQReportTracker.ID,
	RIGHT('0000' + CAST(DQOPSID AS VARCHAR), 4) AS DQOPSID,
		RuleOrigin,
         dbo.ttDQReportTracker.FunctionalArea,
         dbo.ttDQReportTracker.[Group],
         dbo.ttDQReportTracker.ReportID ,
         NULL                                                     AS ShowDQReport,
         dbo.ttDQReportTracker.Define,
         dbo.ttDQReportTracker.Specify,
         dbo.ttDQReportTracker.Build,
         dbo.ttDQReportTracker.ValidateImprove,
         dbo.ttDQReportTracker.Publish,
         dbo.ttDQReportTracker.Dimensions,
         dbo.ttDQReportTracker.Health,
         dbo.ttDQReportTracker.CatalogReportName,
         dbo.ttDQReportTracker.ReportName,
         dbo.ttDQReportTracker.Sprint,
         dbo.ttDQReportTracker.ReportType,
         dbo.ttDQReportTracker.State,
         dbo.ttDQReportTracker.ClientRef,
         dbo.ttDQReportTracker.Priority,
		 dbo.ttDQReportTracker.FunctionalDesignSummary,
         dbo.ttDQReportTracker.CustomField01,
         dbo.ttDQReportTracker.CustomField02,
         dbo.ttDQReportTracker.CustomField03,
         dbo.ttDQReportTracker.CustomField04,
         dbo.ttDQReportTracker.CustomField05,
         dbo.ttDQReportTracker.AssignedTo,
         NULL                                                     AS Comment,
         webDQReportTracker_CommentHor.LatestComment,
         dbo.webActionTrackerDQReportSummary_TrackerActionCountSel.Count AS ActionTracker,
         NULL                                                     AS ActionTrackerClosed,
         dbo.webActionTrackerDQReportSummary_TrackerActionCountSel.Count AS ActionTrackerCount,
         dbo.webDQReportAttachment_CountSel.Count                 AS Attachment,
		 NULL AS [Reset],
		 NULL AS ReportProperties,
		 NULL AS CriticalyAndCompliance
		 
  FROM   dbo.ttDQReportTracker
         LEFT OUTER JOIN dbo.webActionTrackerDQReportSummary_TrackerActionCountSel
                      ON dbo.ttDQReportTracker.ID = dbo.webActionTrackerDQReportSummary_TrackerActionCountSel.DQReportTrackerID
         LEFT OUTER JOIN dbo.webDQReportAttachment_CountSel
                      ON dbo.ttDQReportTracker.ID = dbo.webDQReportAttachment_CountSel.ParentID
              LEFT OUTER JOIN (SELECT webDQReportTracker_CommentHor.ParentID,
									-- Max(ID)                                                                        AS ID,
									 Substring(Comment, 1, 50) + CASE WHEN Len(Comment) > 50 THEN '...' ELSE '' END AS LatestComment
							  FROM   dbo.webDQReportTracker_CommentHor
							  INNER JOIN ( SELECT ParentID, MAX(ID) AS MaxID FROM dbo.webDQReportTracker_CommentHor GROUP BY ParentID) AS MaxIDs 
											ON  webDQReportTracker_CommentHor.ParentID = MaxIDs.ParentID AND 
												webDQReportTracker_CommentHor.ID = MaxIDs.MaxID
							   GROUP  BY webDQReportTracker_CommentHor.ParentID,
										Comment) AS webDQReportTracker_CommentHor
                      ON dbo.ttDQReportTracker.ID = webDQReportTracker_CommentHor.ParentID
  WHERE  ( ISNULL(dbo.ttDQReportTracker.Disable, 0) = 0 ) 
GO
/****** Object:  View [dbo].[webCustomField04List]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCustomField04List]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField04
GO
/****** Object:  View [dbo].[webttDQReportTracker_CustomField04_NotInListVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webttDQReportTracker_CustomField04_NotInListVal] AS SELECT [ttDQReportTracker].[ID], [ttDQReportTracker].[CustomField04] FROM [dbo].[ttDQReportTracker] LEFT OUTER JOIN [dbo].[webCustomField04List] ON ([ttDQReportTracker].[CustomField04]=[webCustomField04List].[CustomFieldValue]) WHERE ([webCustomField04List].[CustomFieldValue] IS NULL AND [ttDQReportTracker].[CustomField04] IS NOT NULL AND [ttDQReportTracker].[CustomField04] != ' ')
GO
/****** Object:  View [dbo].[webCustomField05List]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCustomField05List]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField05
GO
/****** Object:  View [dbo].[webttDQReportTracker_CustomField05_NotInListVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webttDQReportTracker_CustomField05_NotInListVal] AS SELECT [ttDQReportTracker].[ID], [ttDQReportTracker].[CustomField05] FROM [dbo].[ttDQReportTracker] LEFT OUTER JOIN [dbo].[webCustomField05List] ON ([ttDQReportTracker].[CustomField05]=[webCustomField05List].[CustomFieldValue]) WHERE ([webCustomField05List].[CustomFieldValue] IS NULL AND [ttDQReportTracker].[CustomField05] IS NOT NULL AND [ttDQReportTracker].[CustomField05] != ' ')
GO
/****** Object:  View [dbo].[boaUsersEmailSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[boaUsersEmailSel]
AS
SELECT id, name, email, locale, active
FROM     SKP_User
WHERE  (email IS NOT NULL)

GO
/****** Object:  View [dbo].[ImportJSONFile_USERS]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[ImportJSONFile_USERS]
AS
SELECT        [ExtractID]
			  ,a.[id] 
			  ,a.[name]
			  ,a.[email] 
			  ,a.[email_notification]
			  ,a.[locale] 
			  ,a.[opt_in] 
			  ,a.[active]
			  ,a.[version_state]
			  ,a.[version]

FROM            WRKDQOPS.dbo.GETAPIRESULTS CROSS APPLY OPENJSON(GETRESULTS, N'$.data') 
WITH (
	[id] nvarchar(50)  '$.id',
	[name] nvarchar(50)  '$.name',
	[email] nvarchar(255)  '$.email',
	[email_notification] nvarchar(50)  '$.email_notification',
	[locale] nvarchar(50)  '$.locale',
	[opt_in] nvarchar(50)  '$.opt_in',
	[active] nvarchar(50)  '$.active',
	[version_state] nvarchar(50) '$.version_state',
	[version] nvarchar(50) '$.version'
) a
WHERE        URLExtension = 'users'
GO
/****** Object:  View [dbo].[webActionsHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionsHor]
AS
SELECT   ID, Date, Action, DueBy, AssignedTo, Status, Comment, MeetingName, DMOwner, BusinessOwner
FROM     dbo.ttActions


GO
/****** Object:  View [dbo].[webActionTracker#Usage#Hor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker#Usage#Hor]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.boaStatus, dbo.ttActionTracker.CategoryID, dbo.ttActionTracker.ScenarioID, dbo.ttActionTracker.WaveID, dbo.ttActionTracker.ProcessAreaID, dbo.ttActionTracker.ObjectID, dbo.ttActionTracker.Priority, dbo.ttActionTracker.Status, dbo.ttActionTracker.Title, 
                         dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.AddedOn, dbo.ttActionTracker.AddedBy, dbo.ttActionTracker.ClosedDate, dbo.ttActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS ErrorReport, NULL AS Attachment, 
                         CASE WHEN ttsynitiuser.username IS NOT NULL THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions, dbo.ztParam.Usage
FROM            dbo.ttActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.ttActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.ttActionTracker.AssignedTo = dbo.ttSynitiUser.UserName CROSS JOIN
                         dbo.ztParam
GO
/****** Object:  View [dbo].[webActionTracker_ADMArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_ADMArchiveHor]
AS
SELECT        dbo.rtActionTracker.ID, dbo.rtActionTracker.boaStatus, dbo.rtActionTracker.WaveID, dbo.rtActionTracker.ProcessAreaID, dbo.rtActionTracker.ObjectID, dbo.rtActionTracker.Priority, dbo.rtActionTracker.Status, dbo.rtActionTracker.Title, dbo.rtActionTracker.AssignedTo, dbo.rtActionTracker.AddedOn, 
                         dbo.rtActionTracker.AddedBy, dbo.rtActionTracker.ClosedDate, dbo.rtActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS ErrorReport, NULL AS Attachment, CASE WHEN ttsynitiuser.username IS NOT NULL 
                         THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions, dbo.ztParam.Usage
FROM            dbo.rtActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.rtActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.rtActionTracker.AssignedTo = dbo.ttSynitiUser.UserName CROSS JOIN
                         dbo.ztParam
GO
/****** Object:  View [dbo].[webActionTracker_ADMHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_ADMHor]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.boaStatus, dbo.ttActionTracker.WaveID, dbo.ttActionTracker.ProcessAreaID, dbo.ttActionTracker.ObjectID, dbo.ttActionTracker.Priority, dbo.ttActionTracker.Status, dbo.ttActionTracker.Title, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.AddedOn, 
                         dbo.ttActionTracker.AddedBy, dbo.ttActionTracker.ClosedDate, dbo.ttActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS ErrorReport, NULL AS Attachment, CASE WHEN ttsynitiuser.username IS NOT NULL 
                         THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions, dbo.ztParam.Usage
FROM            dbo.ttActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.ttActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.ttActionTracker.AssignedTo = dbo.ttSynitiUser.UserName CROSS JOIN
                         dbo.ztParam
GO
/****** Object:  View [dbo].[webActionTracker_AssignTo_AssignToBusinessUserSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
CREATE   VIEW [dbo].[webActionTracker_AssignTo_AssignToBusinessUserSel]
AS
SELECT   ID, AssignedTo, ISNULL(AssignToGovernance, N'') AS AssignedtoNew, 'Action assigned to: ' + AssignToGovernance AS Description
FROM     dbo.ttActionTracker
WHERE   (ISNULL(AssignToGovernance, N'') <> N'')
GO
/****** Object:  View [dbo].[webActionTracker_AssignTo_AssignToSynitiUserSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
CREATE   VIEW [dbo].[webActionTracker_AssignTo_AssignToSynitiUserSel]
AS
SELECT   ID, AssignedTo, ISNULL(AssignToDevelopment, N'') AS AssignedtoNew, 'Action assigned to: ' + AssignToDevelopment AS Description
FROM     dbo.ttActionTracker
WHERE   (ISNULL(AssignToDevelopment, N'') <> N'')
GO
/****** Object:  View [dbo].[webActionTracker_AssignTo_NoUserVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTracker_AssignTo_NoUserVal]
AS
SELECT   ID, AssignToGovernance, AssignToDevelopment
FROM     dbo.ttActionTracker
WHERE   (ISNULL(AssignToGovernance, N'') = N'') AND (ISNULL(AssignToDevelopment, N'') = N'')


GO
/****** Object:  View [dbo].[webActionTracker_ChangePriority_NoPriorityVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_ChangePriority_NoPriorityVal]
AS
SELECT   ID, NewPriority
FROM     dbo.ttActionTracker
WHERE   (ISNULL(NewPriority, N'') = N'')


GO
/****** Object:  View [dbo].[webActionTracker_Changestatus_NoStatusVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_Changestatus_NoStatusVal]
AS
SELECT   ID, NewStatus
FROM     dbo.ttActionTracker
WHERE   (ISNULL(NewStatus, N'') = N'')


GO
/****** Object:  View [dbo].[webActionTracker_CloseAction_CloseActionSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
 
 
 
CREATE   VIEW [dbo].[webActionTracker_CloseAction_CloseActionSel]
AS
SELECT   ID, 'Action Closed' AS Message, Status, 'Closed' AS StatusNew, ClosedDate, ClosedBy
FROM     dbo.ttActionTracker
GO
/****** Object:  View [dbo].[webActionTracker_DQArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[webActionTracker_DQArchiveHor]
AS
SELECT        dbo.rtActionTracker.ID, dbo.rtActionTracker.DQReportTrackerID, dbo.rtActionTracker.GroupID, dbo.rtActionTracker.DQReport, dbo.rtActionTracker.Priority, dbo.rtActionTracker.Status, dbo.rtActionTracker.Title, dbo.rtActionTracker.AssignedTo, dbo.rtActionTracker.AddedOn, dbo.rtActionTracker.AddedBy, 
                         dbo.rtActionTracker.ClosedDate, dbo.rtActionTracker.ClosedBy, NULL AS ActionDetail, NULL AS DQReports, NULL AS Attachment, CASE WHEN ttsynitiuser.username IS NOT NULL THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL 
                         THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions, dbo.ztParam.Usage
FROM            dbo.rtActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.rtActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.rtActionTracker.AssignedTo = dbo.ttSynitiUser.UserName CROSS JOIN
                         dbo.ztParam
						INNER JOIN ttDQReportTracker 
					  ON ttDQReportTracker.ID = rtActionTracker.DQReportTrackerID

GO
/****** Object:  View [dbo].[webActionTracker_DQReport_CloseActionSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE   VIEW [dbo].[webActionTracker_DQReport_CloseActionSel]
AS
SELECT   ID, 'Action Closed' AS Message, Status, 'Closed' AS StatusNew, ClosedDate, ClosedBy
FROM     dbo.ttActionTracker
WHERE Status = 'Closed'
GO
/****** Object:  View [dbo].[webActionTracker_MDMArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_MDMArchiveHor]
AS
SELECT        dbo.rtActionTracker.ID, dbo.rtActionTracker.boaStatus, dbo.rtActionTracker.CategoryID, dbo.rtActionTracker.ScenarioID, dbo.rtActionTracker.RequestID, dbo.rtActionTracker.Priority, dbo.rtActionTracker.Status, dbo.rtActionTracker.Title, dbo.rtActionTracker.AssignedTo, dbo.rtActionTracker.AddedOn, 
                         dbo.rtActionTracker.AddedBy, dbo.rtActionTracker.ClosedDate, dbo.rtActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS Attachment, CASE WHEN ttsynitiuser.username IS NOT NULL THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL 
                         THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions, dbo.ztParam.Usage
FROM            dbo.rtActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.rtActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.rtActionTracker.AssignedTo = dbo.ttSynitiUser.UserName CROSS JOIN
                         dbo.ztParam
GO
/****** Object:  View [dbo].[webActionTracker_MDMHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_MDMHor]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.boaStatus, dbo.ttActionTracker.CategoryID, dbo.ttActionTracker.ScenarioID, dbo.ttActionTracker.RequestID, dbo.ttActionTracker.Priority, dbo.ttActionTracker.Status, dbo.ttActionTracker.Title, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.AddedOn, 
                         dbo.ttActionTracker.AddedBy, dbo.ttActionTracker.ClosedDate, dbo.ttActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS Attachment, CASE WHEN ttsynitiuser.username IS NOT NULL THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL 
                         THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions, dbo.ztParam.Usage
FROM            dbo.ttActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.ttActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.ttActionTracker.AssignedTo = dbo.ttSynitiUser.UserName CROSS JOIN
                         dbo.ztParam
GO
/****** Object:  View [dbo].[webActionTracker_NewPriority_PriorityChangeSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTracker_NewPriority_PriorityChangeSel]
AS
SELECT   ID, 'Priority changed from ' + Priority + ' to ' + NewPriority AS Message, Priority, NewPriority AS PriorityNew
FROM     dbo.ttActionTracker
WHERE   (NewPriority IS NOT NULL)


GO
/****** Object:  View [dbo].[webActionTracker_NewStatus_StatusChangeSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_NewStatus_StatusChangeSel]
AS
SELECT   ID, 'Status changed from ' + Status + ' to ' + NewStatus AS Message, Status, NewStatus AS StatusNew
FROM     dbo.ttActionTracker
WHERE   (Status IS NOT NULL)


GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_ADMRequiredFieldsVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_OnValidate_ADMRequiredFieldsVal]
AS
SELECT   dbo.ttActionTracker.ID, dbo.ttActionTracker.WaveID, dbo.ttActionTracker.ProcessAreaID, dbo.ttActionTracker.ObjectID, dbo.ztParam.Usage
FROM     dbo.ttActionTracker CROSS JOIN
             dbo.ztParam
WHERE   (dbo.ztParam.Usage = N'ADM') AND (dbo.ttActionTracker.WaveID IS NULL) OR
             (dbo.ztParam.Usage = N'ADM') AND (dbo.ttActionTracker.ProcessAreaID IS NULL) OR
             (dbo.ztParam.Usage = N'ADM') AND (dbo.ttActionTracker.ObjectID IS NULL)


GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_AssignToUser_Val]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTracker_OnValidate_AssignToUser_Val]
AS
SELECT   ID, ISNULL(AssignToGovernance, N'') AS AssignToGovernance, ISNULL(AssignToDevelopment, N'') AS AssignToDevelopment
FROM     dbo.ttActionTracker
WHERE   (ISNULL(AssignToGovernance, N'') <> N'') AND (ISNULL(AssignToDevelopment, N'') <> N'')


GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_DescriptionIsNullVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_OnValidate_DescriptionIsNullVal]
AS
SELECT        ID, Title
FROM            dbo.ttActionTracker
WHERE        (Title IS NULL)

GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_DQReport_NewReportSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTracker_OnValidate_DQReport_NewReportSel]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.GroupID, dbo.ttActionTracker.DQReport, dbo.ttActionTracker.AddedBy, dbo.ttActionTracker.AddedOn
FROM            dbo.ttActionTracker LEFT OUTER JOIN
                         dbo.ttActionTrackerDQReport ON dbo.ttActionTracker.ID = dbo.ttActionTrackerDQReport.ParentID AND dbo.ttActionTracker.DQReport = dbo.ttActionTrackerDQReport.Report AND dbo.ttActionTracker.GroupID = dbo.ttActionTrackerDQReport.GroupID AND 
                         dbo.ttActionTracker.AddedOn = dbo.ttActionTrackerDQReport.AddedOn AND dbo.ttActionTracker.AddedBy = dbo.ttActionTrackerDQReport.AddedBy
WHERE        (ISNULL(dbo.ttActionTracker.DQReport, N'') <> '') AND (dbo.ttActionTrackerDQReport.ParentID IS NULL)

GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_DQRequiredfieldsVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_OnValidate_DQRequiredfieldsVal]
AS
SELECT   dbo.ttActionTracker.ID, dbo.ttActionTracker.CategoryID, dbo.ttActionTracker.ScenarioID, dbo.ttActionTracker.RequestID, dbo.ztParam.Usage
FROM     dbo.ttActionTracker CROSS JOIN
             dbo.ztParam
WHERE   (dbo.ttActionTracker.GroupID IS NULL) AND (dbo.ztParam.Usage = N'DQ') 


GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_MDMRequiredfieldsVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_OnValidate_MDMRequiredfieldsVal]
AS
SELECT   dbo.ttActionTracker.ID, dbo.ttActionTracker.CategoryID, dbo.ttActionTracker.ScenarioID, dbo.ttActionTracker.RequestID, dbo.ztParam.Usage
FROM     dbo.ttActionTracker CROSS JOIN
             dbo.ztParam
WHERE   (dbo.ttActionTracker.CategoryID IS NULL) AND (dbo.ztParam.Usage = N'MDM') OR
             (dbo.ttActionTracker.ScenarioID IS NULL) AND (dbo.ztParam.Usage = N'MDM') OR
             (dbo.ttActionTracker.RequestID IS NULL) AND (dbo.ztParam.Usage = N'MDM')


GO
/****** Object:  View [dbo].[webActionTracker_OnValidate_NewActionSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTracker_OnValidate_NewActionSel]
AS
SELECT   dbo.ttActionTracker.ID, dbo.ttActionTrackerDetail.ParentID, dbo.ttActionTracker.Status, 'Not Started' AS StatusNew, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.Priority, 'Medium' AS PriorityNew
FROM     dbo.ttActionTracker LEFT OUTER JOIN
             dbo.ttActionTrackerDetail ON dbo.ttActionTracker.ID = dbo.ttActionTrackerDetail.ParentID
WHERE   (dbo.ttActionTrackerDetail.ParentID IS NULL)


GO
/****** Object:  View [dbo].[webActionTracker_ReopenActionSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTracker_ReopenActionSel]
AS
SELECT   ID, 'Action Reopen' AS Message, Status, 'Not Started' AS StatusNew
FROM     dbo.ttActionTracker
WHERE   (Status = N'Closed')
GO
/****** Object:  View [dbo].[webActionTrackerArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerArchiveHor]
AS
SELECT        dbo.rtActionTracker.ID, dbo.rtActionTracker.boaStatus, dbo.rtActionTracker.WaveID, dbo.rtActionTracker.ProcessAreaID, dbo.rtActionTracker.ObjectID, dbo.rtActionTracker.Priority, dbo.rtActionTracker.Status, dbo.rtActionTracker.Title, dbo.rtActionTracker.AssignedTo, dbo.rtActionTracker.AddedOn, 
                         dbo.rtActionTracker.AddedBy, dbo.rtActionTracker.ClosedDate, dbo.rtActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS ErrorReport, NULL AS Attachment, CASE WHEN ttsynitiuser.username IS NOT NULL 
                         THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions
FROM            dbo.rtActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.rtActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.rtActionTracker.AssignedTo = dbo.ttSynitiUser.UserName
GO
/****** Object:  View [dbo].[webActionTrackerAttachment_OnValidate_NewAttachmentSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerAttachment_OnValidate_NewAttachmentSel]
AS
SELECT   dbo.ttActionTrackerAttachment.ParentID, dbo.ttActionTrackerAttachment.AddedBy, dbo.ttActionTrackerAttachment.AddedOn, 'Attachment added to review: ' + dbo.GetFileName(FilePath, N'\') AS Description
FROM     dbo.ttActionTrackerAttachment  LEFT OUTER JOIN
                 (SELECT   ParentID, ID, AddedOn, AddedBy, Description, AssignTo, AddedVia, ChangedBy, ChangedOn, ChangedVia, boaStatus
                 FROM     dbo.ttActionTrackerDetail
                 WHERE   (Description LIKE '%Attachment added%')) AS derivedtbl_1 ON dbo.ttActionTrackerAttachment.ParentID = derivedtbl_1.ParentID AND dbo.ttActionTrackerAttachment.AddedOn = derivedtbl_1.AddedOn AND dbo.ttActionTrackerAttachment.AddedBy = derivedtbl_1.AddedBy
WHERE   (derivedtbl_1.ParentID IS NULL)


GO
/****** Object:  View [dbo].[webActionTrackerattachmentArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerattachmentArchiveHor]
AS
SELECT   ID, ParentID, Description, dbo.GetFileName(FilePath, N'\') AS FileName, FilePath, FilePath AS Download, AddedBy, AddedOn
FROM     dbo.rtActionTrackerAttachment


GO
/****** Object:  View [dbo].[webActionTrackerAttachmentDCV]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerAttachmentDCV]
AS
SELECT   ID, ParentID, CASE WHEN filepath IS NOT NULL THEN '0' ELSE '1' END AS FilePath
FROM     dbo.ttActionTrackerAttachment


GO
/****** Object:  View [dbo].[webActionTrackerattachmentHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerattachmentHor]
AS
SELECT   row_number() over ( partition by ParentID order by ID) as zID,


ID, ParentID, Description, dbo.GetFileName(FilePath, N'\') AS FileName, FilePath, FilePath AS Download, AddedBy, AddedOn
FROM     dbo.ttActionTrackerAttachment


GO
/****** Object:  View [dbo].[webActionTrackerAttachmentPcv]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerAttachmentPcv]
AS
SELECT   ID AS ParentID, CASE 
			WHEN status = 'Complete' THEN 2 
			WHEN status = 'No Action' THEN 2 
			ELSE 1 END AS boaAdd
FROM     dbo.ttActionTracker


GO
/****** Object:  View [dbo].[webActionTrackerDcv]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerDcv]
AS
SELECT       dbo.ttActionTracker.ID, CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS AssignToBusiness, CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS AssignToSyniti, 
                         CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS NewPriority, CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS Newstatus, CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS Assign, 
                         CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS ChangeStatus, CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS ChangePriority, CASE WHEN status = 'Closed' THEN 0 ELSE 1 END AS CloseAction, 
                         CASE WHEN status = 'Closed' THEN 1 ELSE 0 END AS ReopenAction, CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS WaveID, CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS ProcessAreaID, 
                         CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS ObjectID, CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS ErrorReport, CASE WHEN Usage = 'MDM' THEN 1 ELSE 2 END AS CategoryID, 
                         CASE WHEN Usage = 'MDM' THEN 1 ELSE 2 END AS ScenarioID, CASE WHEN status = 'Closed' THEN 1 ELSE 0 END AS ArchiveActionTracker
						 ,CASE WHEN AddedVia = 'StoredProcedure' THEN 0 ELSE 1 END AS ReportStatus
FROM            dbo.ttActionTracker CROSS JOIN
                         dbo.ztParam

GO
/****** Object:  View [dbo].[webActionTrackerDetailArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerDetailArchiveHor]
AS
SELECT   ParentID, ID, Description, AddedOn, AddedBy
FROM     dbo.rtActionTrackerDetail


GO
/****** Object:  View [dbo].[webActionTrackerDetailDef]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDetailDef]
AS
SELECT        1 AS Iscomment

GO
/****** Object:  View [dbo].[webActionTrackerDetailHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerDetailHor]
AS
SELECT        row_number() OVER (partition BY ParentID
ORDER BY ID) AS zID, ParentID, ID, 
 [Description]
, AddedOn, AddedBy, iscomment
FROM            dbo.ttActionTrackerDetail

GO
/****** Object:  View [dbo].[webActionTrackerDetailPcv]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerDetailPcv]
AS
SELECT   ID AS ParentID, CASE WHEN status = 'Closed' THEN 2 ELSE 1 END AS boaAdd
FROM     dbo.ttActionTracker


GO
/****** Object:  View [dbo].[webActionTrackerDetailVer]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDetailVer]
AS
SELECT   ParentID, ID, AssignTo, NULL AS Assign
FROM     dbo.ttActionTrackerDetail
GO
/****** Object:  View [dbo].[webActionTrackerDQReport_OnValidate_NewReportSel]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDQReport_OnValidate_NewReportSel]
AS
SELECT        dbo.ttActionTrackerDQReport.ParentID, dbo.ttActionTrackerDQReport.AddedBy, dbo.ttActionTrackerDQReport.AddedOn, 'Report added to review: ' + dbo.ttActionTrackerDQReport.Report AS Description
FROM            dbo.ttActionTrackerDQReport LEFT OUTER JOIN
                             (SELECT        ParentID, ID, AddedOn, AddedBy, Description, AssignTo, AddedVia, ChangedBy, ChangedOn, ChangedVia, boaStatus
                               FROM            dbo.ttActionTrackerDetail
                               WHERE        (Description LIKE '%Report added%')) AS derivedtbl_1 ON 'Report added to review: ' + dbo.ttActionTrackerDQReport.Report = derivedtbl_1.Description AND dbo.ttActionTrackerDQReport.ParentID = derivedtbl_1.ParentID AND 
                         dbo.ttActionTrackerDQReport.AddedOn = derivedtbl_1.AddedOn AND dbo.ttActionTrackerDQReport.AddedBy = derivedtbl_1.AddedBy
WHERE        (derivedtbl_1.ParentID IS NULL)

GO
/****** Object:  View [dbo].[webActionTrackerDQReportArchiveHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDQReportArchiveHor]
AS
SELECT   ParentID, ID, GroupID, Report, AddedBy, AddedOn
FROM     dbo.rtActionTrackerDQReport


GO
/****** Object:  View [dbo].[webActionTrackerDQReportDcv]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerDQReportDcv]
AS
  SELECT  dbo.ttActionTrackerDQReport.ID,
         dbo.ttActionTrackerDQReport.ParentID,
        -- dbo.ttDQReportTracker.Disable,
		 ttActionTracker.DQReport ,
		  ttActionTrackerDQReport.Report,
         /*CASE
           WHEN disable = 1 THEN '0'
           ELSE 1
         END AS DQReportTracker,*/
		 CASE WHEN  ttActionTracker.DQReport IS NULL THEN '1'
		 ELSE  '0'
		 END as boadelete
  FROM   dbo.ttActionTrackerDQReport
         LEFT OUTER JOIN dbo.ttActionTracker
                 ON dbo.ttActionTracker.DQReport = ttActionTrackerDQReport.Report 
				 and ttActionTracker.id = ttActionTrackerDQReport.ParentID
				 and ttActionTracker.GroupID = ttActionTrackerDQReport.GroupID

GO
/****** Object:  View [dbo].[webActionTrackerDQReportPcv]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[webActionTrackerDQReportPcv]
AS
SELECT  	ParentID, 
			ttActionTrackerDQReport.ID,	
			ttActionTrackerDQReport.[GroupID]
      ,ttActionTrackerDQReport.[Report]
      ,ttActionTrackerDQReport.[ReportLink]
      ,ttActionTrackerDQReport.[AddedBy]
      ,ttActionTrackerDQReport.[AddedOn]
		,CASE 
			WHEN ttActionTracker.status = 'Complete' THEN 2 
			WHEN ttActionTracker.status = 'No Action' THEN 2 
			ELSE 1 END AS boaAdd, 
			1 AS boaDelete
FROM     dbo.ttActionTrackerDQReport
LEFT OUTER JOIN dbo.ttActionTracker ON ttActionTrackerDQReport.ParentID = ttActionTracker.ID


GO
/****** Object:  View [dbo].[webActionTrackerDQReportSummary_ActionHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerDQReportSummary_ActionHor]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.Title, dbo.ttActionTracker.Status, dbo.ttActionTracker.Priority, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.AddedOn, dbo.ttActionTracker.AddedBy, dbo.ttActionTrackerDQReport.GroupID, dbo.ttActionTrackerDQReport.Report, 
                        dbo.ttActionTrackerDQReport.Report AS DQReport
						/*REPLACE(dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTrackerDQReport.Report), 'tv', '') AS DQReport */
FROM            dbo.ttActionTrackerDQReport INNER JOIN
                         dbo.ttActionTracker ON dbo.ttActionTrackerDQReport.ParentID = dbo.ttActionTracker.ID
GROUP BY dbo.ttActionTrackerDQReport.ParentID, dbo.ttActionTrackerDQReport.GroupID, dbo.ttActionTrackerDQReport.Report, dbo.ttActionTracker.Status, dbo.ttActionTracker.AddedOn, dbo.ttActionTracker.Title, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.Priority, dbo.ttActionTracker.AddedBy, 
                         dbo.ttActionTracker.ID, dbo.ttActionTrackerDQReport.Report/* REPLACE(dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTrackerDQReport.Report), 'tv', '')*/

GO
/****** Object:  View [dbo].[webActionTrackerDQReportSummary_ActionTrackerHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[webActionTrackerDQReportSummary_ActionTrackerHor]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.Title, dbo.ttActionTracker.Status, dbo.ttActionTracker.ReportStatus, dbo.ttActionTracker.Priority, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.AddedOn, dbo.ttActionTracker.AddedBy, dbo.ttActionTrackerDQReport.GroupID, 
				ttActionTrackerDQReport.Report AS DQReport
                         /*REPLACE(dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTrackerDQReport.Report), 'tv', '') AS DQReport*/
FROM            dbo.ttActionTrackerDQReport INNER JOIN
                         dbo.ttActionTracker ON dbo.ttActionTrackerDQReport.ParentID = dbo.ttActionTracker.ID
GROUP BY dbo.ttActionTrackerDQReport.ParentID, dbo.ttActionTrackerDQReport.GroupID, dbo.ttActionTracker.Status, dbo.ttActionTracker.ReportStatus, dbo.ttActionTracker.AddedOn, dbo.ttActionTracker.Title, dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.Priority, dbo.ttActionTracker.AddedBy, 
                         dbo.ttActionTracker.ID,ttActionTrackerDQReport.Report /*REPLACE(dbo.GetFirstLettersUntilNumberEnds(dbo.ttActionTrackerDQReport.Report), 'tv', '')*/ 

GO
/****** Object:  View [dbo].[webActionTrackerHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webActionTrackerHor]
AS
SELECT        dbo.ttActionTracker.ID, dbo.ttActionTracker.boaStatus, dbo.ttActionTracker.CategoryID, dbo.ttActionTracker.ScenarioID, dbo.ttActionTracker.WaveID, dbo.ttActionTracker.ProcessAreaID, dbo.ttActionTracker.ObjectID, dbo.ttActionTracker.Priority, dbo.ttActionTracker.Status, dbo.ttActionTracker.Title, 
                         dbo.ttActionTracker.AssignedTo, dbo.ttActionTracker.AddedOn, dbo.ttActionTracker.AddedBy, dbo.ttActionTracker.ClosedDate, dbo.ttActionTracker.ClosedBy, NULL AS ActionTrackerDetail, NULL AS ErrorReport, NULL AS Attachment, 
                         CASE WHEN ttsynitiuser.username IS NOT NULL THEN 'Syniti' WHEN ttbusinessuser.username IS NOT NULL THEN 'Business' END AS Owner, NULL AS ArchiveClosedActions
FROM            dbo.ttActionTracker LEFT OUTER JOIN
                         dbo.ttBusinessUser ON dbo.ttActionTracker.AssignedTo = dbo.ttBusinessUser.UserName LEFT OUTER JOIN
                         dbo.ttSynitiUser ON dbo.ttActionTracker.AssignedTo = dbo.ttSynitiUser.UserName
GO
/****** Object:  View [dbo].[webActionTrackerPCV]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webActionTrackerPCV]
AS
SELECT   CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS WaveID, CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS ProcessAreaID, CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS ObjectID, CASE WHEN Usage = 'ADM' THEN 1 ELSE 2 END AS ErrorReport, CASE WHEN Usage = 'MDM' THEN 1 ELSE 2 END AS CategoryID, 
             CASE WHEN Usage = 'MDM' THEN 1 ELSE 2 END AS ScenarioID
FROM     dbo.ztParam


GO
/****** Object:  View [dbo].[webActionTrackerReportPcv]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[webActionTrackerReportPcv]
AS
SELECT   ID AS ParentID, 
		CASE 
			WHEN status = 'Complete' THEN 2 
			WHEN status = 'No Action' THEN 2 
			ELSE 1 END AS boaAdd, 
			1 AS boaDelete
FROM     dbo.ttActionTracker


GO
/****** Object:  View [dbo].[webActionTrackerVer]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webActionTrackerVer]
AS
SELECT        ID, NULL AS AssignTo,  AssignToGovernance,  AssignToDevelopment, NULL AS Assign, NULL AS Status, NewStatus, NULL AS ChangeStatus, NULL AS Priority, NewPriority, NULL AS ChangePriority, NULL AS [CloseActionTracker], NULL 
                         AS CloseAction, NULL AS [ReopenActionTracker], NULL AS ReopenAction, NULL AS Archive, NULL AS ArchiveActionTracker
FROM            dbo.ttActionTracker

GO
/****** Object:  View [dbo].[webBusinessUserHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webBusinessUserHor]
AS
SELECT   UserName
FROM     dbo.ttBusinessUser


GO
/****** Object:  View [dbo].[webBusinessUserList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webBusinessUserList]
AS
SELECT   dbo.ttBusinessUser.UserName, dbo.ttBusinessUser.UserName AS NameUserID
FROM     dbo.ttBusinessUser 

GO
/****** Object:  View [dbo].[webCriticalilty_ComplianceHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webCriticalilty_ComplianceHor] AS

SELECT  [ID]
      ,[RuleID]
      ,[CriticalDataElement]
      ,[Potential_GxP]
      ,[Potential_SoX]
      ,[Potential_PII]
      ,[Potential_GDPR]
  FROM [WRKDQOPS].[dbo].[ttCriticalilty_Compliance]
GO
/****** Object:  View [dbo].[webCriticalityHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCriticalityHor]
AS
SELECT   ID, Criticality, Value
FROM     dbo.ztCriticality


GO
/****** Object:  View [dbo].[webCriticalityList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webCriticalityList]
AS
SELECT   ID, Criticality
FROM     dbo.ztCriticality


GO
/****** Object:  View [dbo].[webCustomField01Hor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webCustomField01Hor]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField01
GO
/****** Object:  View [dbo].[webCustomField02Hor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webCustomField02Hor]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField02
GO
/****** Object:  View [dbo].[webCustomField03Hor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webCustomField03Hor]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField03
GO
/****** Object:  View [dbo].[webCustomField04Hor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webCustomField04Hor]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField04
GO
/****** Object:  View [dbo].[webCustomField05Hor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webCustomField05Hor]
AS
SELECT Priority, CustomFieldValue FROM ztCustomField05
GO
/****** Object:  View [dbo].[webDataAccessHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE view [dbo].[webDataAccessHor] AS
 Select ID, DataAccess from ttDataAccess
GO
/****** Object:  View [dbo].[webDataAccessList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create view [dbo].[webDataAccessList] AS
 select DataAccess from ttDataAccess
GO
/****** Object:  View [dbo].[webDecisionsHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webDecisionsHor]
AS
SELECT   ID, Date, Decision, Owner, Status, Priority, DueBy, ActualDate, Comments
FROM     dbo.ttDecisions


GO
/****** Object:  View [dbo].[webDQDimensionHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQDimensionHor] AS
SELECT DQDimensions FROM ztDQDimension
GO
/****** Object:  View [dbo].[webDQDimensionList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[webDQDimensionList] AS 
SELECT DQDimensions FROM ztDQDimension
GO
/****** Object:  View [dbo].[webDQGroups_ReportTracker_List]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webDQGroups_ReportTracker_List] AS 

SELECT	DISTINCT [GROUP] AS GroupID  FROM ttDQReportTracker
GO
/****** Object:  View [dbo].[webDQGroupsList_ReportTracker]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webDQGroupsList_ReportTracker] AS 

SELECT	DISTINCT [GROUP] AS GroupID  FROM ttDQReportTracker
GO
/****** Object:  View [dbo].[webDQReportattachmentHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webDQReportattachmentHor]  
AS  
  SELECT row_number()  
           over (  
             partition by ParentID  
             order by ID)                as zID,  
         ID,  
         ParentID,  
         SpecificationLink,  
         dbo.GetFileName(FilePath, N'\') AS FileName,  
         FilePath,  
         FilePath                        AS Download,  
         AddedBy,  
         AddedOn  
  FROM   dbo.ttDQReportAttachment   
GO
/****** Object:  View [dbo].[webDQReportList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webDQReportList]
AS
SELECT   [Group] as GroupID, ReportID
FROM     ttDQReportTracker


GO
/****** Object:  View [dbo].[webDQReportTracker_ActionTrackerActionOpenVal]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[webDQReportTracker_ActionTrackerActionOpenVal]
AS
  SELECT ttDQReportTracker.ID,
         ttDQReportTracker.[Group]  AS GroupID,
         ttDQReportTracker.ReportID AS DQReport,
         ttDQReportTracker.[State]  AS ReportStatus
         --, ttActionTracker.GroupID
         --, ttActionTracker.DQReport
         --, ttActionTracker.ReportStatus
         --, ttActionTracker.[Status]
         ,
         ttDQReportTracker.Define,
         ttDQReportTracker.Specify
  FROM   dbo.ttDQReportTracker
         INNER JOIN dbo.ttActionTracker
                 ON ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
  AND ISNULL(ttDQReportTracker.State, '') <> ISNULL(ttActionTracker.ReportStatus, '')
GO
/****** Object:  View [dbo].[webDQReportTracker_Def]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   View [dbo].[webDQReportTracker_Def]  as 
select 'DQ_'+convert(nvarchar,max(convert(int,dbo.getnumber(reportid)))+1) as ReportID, 0 as [Disable]
from ttDQReportTracker
GO
/****** Object:  View [dbo].[webDQReportTracker_DisableHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webDQReportTracker_DisableHor]
AS
SELECT        ID, Object, ReportID, Define, Specify, Build, ValidateImprove, Publish, Dimensions, Health, CatalogReportName, ReportName, ReportType, State, Priority, AssignedTo, NULL AS Comment
FROM            dbo.ttDQReportTracker
WHERE        (Disable = 1)

GO
/****** Object:  View [dbo].[webDQReportTracker_DisableVer]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webDQReportTracker_DisableVer]
AS
SELECT        ID, Startdate, Iteration, EndDate, PctComplete, Duration, Predecessors, Requestor, BusinessProcess, FunctionalArea, RuleCriticality, RuleStatement, Comment, Implication, Source, ReportLogicalStatement, Reportfields, 
                         ReportFilter, ReportRepository, OpportunityCriteria, OpportunityViewName, RulestatementPositive, Remediation, Object, [Group], QualityDimension, Thresholds, CostPerFailure, Disable
FROM            dbo.ttDQReportTracker

GO
/****** Object:  View [dbo].[webDQReportTrackerDcV]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webDQReportTrackerDcV]
AS
SELECT
ID
,CASE WHEN Specify = 1 THEN 0 ELSE 1 END AS Define
, CASE WHEN (Define = 1 OR Specify = 1) AND ISNULL(Build, 0) = 0 THEN 1 ELSE 0 END AS Specify
, CASE WHEN (Specify = 1 OR Build = 1) AND ISNULL(ValidateImprove, 0) = 0 THEN 1 ELSE 0 END AS Build
, CASE WHEN (Build = 1 OR ValidateImprove = 1) AND ISNULL(Publish, 0) = 0 THEN 1 ELSE 0 END AS ValidateImprove
, CASE WHEN (ValidateImprove = 1 OR Publish = 1) AND ISNULL(Dimensions, 0) = 0 THEN 1 ELSE 0 END AS Publish
, CASE WHEN EXISTS(SELECT 1 FROM ztCustomField01) THEN 1 ELSE 2 END AS CustomField01
, CASE WHEN EXISTS(SELECT 1 FROM ztCustomField02) THEN 1 ELSE 2 END AS CustomField02
, CASE WHEN EXISTS(SELECT 1 FROM ztCustomField03) THEN 1 ELSE 2 END AS CustomField03
, CASE WHEN EXISTS(SELECT 1 FROM ztCustomField04) THEN 1 ELSE 2 END AS CustomField04
, CASE WHEN EXISTS(SELECT 1 FROM ztCustomField05) THEN 1 ELSE 2 END AS CustomField05
FROM            dbo.ttDQReportTracker
GO
/****** Object:  View [dbo].[webDQReportTrackerVer]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webDQReportTrackerVer]
AS
SELECT        ID,/* Startdate, Iteration, EndDate, PctComplete, Duration, Predecessors, Requestor, BusinessProcess,*/ FunctionalArea, RuleCriticality, RuleStatement, Comment, Implication,/* Source, ReportLogicalStatement, Reportfields, 
                         ReportFilter, ReportRepository, OpportunityCriteria,*/ OpportunityViewName, RulestatementPositive, Remediation, Object, [Group], QualityDimension, Thresholds, CostPerFailure, Disable, FunctionalDesignSummary
FROM            dbo.ttDQReportTracker

GO
/****** Object:  View [dbo].[webFunctionalUserHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webFunctionalUserHor]
AS
SELECT   UserName
FROM     dbo.ttFunctionalUser


GO
/****** Object:  View [dbo].[webIssueshor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webIssueshor]
AS
SELECT   ID, Date, RaisedBy, Severity, Issue, Impact, ImpactType, Action, IssueResolution, Feedback, Owner, DueBy, Status, IssueType, ReqEscalation
FROM     dbo.ttIssues


GO
/****** Object:  View [dbo].[webMainTableList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 create view [dbo].[webMainTableList] AS

select name from [SAPECCDEMO].sys.all_objects
where type = 'u'
and len(name)=4
GO
/****** Object:  View [dbo].[webParamHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webParamHor]
AS
SELECT        One, Usage, EmailFrom
FROM            dbo.ztParam

GO
/****** Object:  View [dbo].[webReport_Duplicate_Val]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webReport_Duplicate_Val]
AS 
SELECT ID, COUNT(ID) AS RepCount
FROM [WRKDQOPS].[dbo].[ttDQReportTracker] 
Group BY  ID
HAVING COUNT(ID) > 1
GO
/****** Object:  View [dbo].[webReportPropertiesHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


 CREATE view [dbo].[webReportPropertiesHor] AS  
select  [ID]  
      ,[RuleID]  
      ,[StrategyDimension]  
      ,[DataAccess]  
      ,[MainTable]
	  ,[MainField]
      ,[DataModel]  
      ,[ResolutionValue]  
      ,[ResolutionEffort]  
      ,[CleanseDimension]  
 FROM [WRKDQOPS].[dbo].[ttReportProperties]
GO
/****** Object:  View [dbo].[webReportStatusList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webReportStatusList]
AS
SELECT Priority, Status 
FROM ztStatus
WHERE [Type] = 'DQ Report Tracker'
GO
/****** Object:  View [dbo].[webRisksHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webRisksHor]
AS
SELECT   ID, Date, IdentifiedBy, ProjectStage, Specification, Status, Owner, Severity, Probability, Impact, RiskMitigation, RiskMitDueDate, ReqEscalation
FROM     dbo.ttRisks


GO
/****** Object:  View [dbo].[webRuleOriginList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[webRuleOriginList] AS
Select RuleOrigin from ztRuleOrigin
GO
/****** Object:  View [dbo].[webSeverityHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webSeverityHor]
AS
SELECT   ID, Severity, Value
FROM     dbo.ztSeverity


GO
/****** Object:  View [dbo].[webSeverityList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webSeverityList]
AS
SELECT   ID, Severity
FROM     dbo.ztSeverity


GO
/****** Object:  View [dbo].[webSprintHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webSprintHor]
AS
SELECT SprintID, SprintName, CalendarWeek, StartDate, EndDate FROM ztSprint
GO
/****** Object:  View [dbo].[webSprintList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webSprintList]
AS
SELECT SprintID, SprintName, 
SprintName + CASE WHEN ISNULL(CalendarWeek, '') = '' THEN '' ELSE ' ('+ CalendarWeek +')' END AS SprintNameCalendarWeek
, SprintID + ' - ' + SprintName + CASE WHEN ISNULL(CalendarWeek, '') = '' THEN '' ELSE ' ('+ CalendarWeek +')' END
+ CASE WHEN ISNULL(convert(nvarchar(20), StartDate),'') = '' THEN '' ELSE convert(nvarchar(20), StartDate) END 
+ CASE WHEN ISNULL(convert(nvarchar(20), EndDate),'') = '' THEN '' ELSE ' - ' + convert(nvarchar(20), EndDate) END AS FriendlyName 
FROM ztSprint
GO
/****** Object:  View [dbo].[webStatusHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[webStatusHor]
AS
  SELECT [Priority],
  [Type],
  Status,
  Status_Unchecked,
  Next_Event,
  Preceding_Action
  FROM   dbo.ztStatus 
GO
/****** Object:  View [dbo].[webStatusList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webStatusList]
AS
SELECT   [Priority], [Type], [Status]
FROM     dbo.ztStatus

GO
/****** Object:  View [dbo].[webStatusTypeList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   VIEW [dbo].[webStatusTypeList]
AS
SELECT 'Action Tracker' AS [Type]
UNION
SELECT 'DQ Report Tracker' AS [Type]
GO
/****** Object:  View [dbo].[webStrategyDimensionHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE view [dbo].[webStrategyDimensionHor] AS
 Select ID, StrategyDimension from ttStrategyDimension
GO
/****** Object:  View [dbo].[webStrategyDimensionList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create view [dbo].[webStrategyDimensionList] AS
 select StrategyDimension from ttStrategyDimension
GO
/****** Object:  View [dbo].[webSynitiUserHor]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webSynitiUserHor]
AS
SELECT   UserName
FROM     dbo.ttSynitiUser


GO
/****** Object:  View [dbo].[webSynitiUserList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webSynitiUserList]
AS
SELECT   dbo.ttSynitiUser.UserName, dbo.ttSynitiUser.UserName AS NameUserID
FROM     dbo.ttSynitiUser 

GO
/****** Object:  View [dbo].[webUsageList]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[webUsageList]
AS
SELECT   'ADM' AS Usage
UNION
SELECT   'DQ' AS Usage
UNION
SELECT   'MDM' AS Usage


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_Archive_ArchiveActionsIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_Archive_ArchiveActionsIns] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[rtActionTracker]
           ([ID]
		   ,[DQReportTrackerID]
           ,[Status]
           ,[AddedOn]
           ,[AddedBy]
           ,[Title]
           ,[AssignedTo]
           ,[Priority]
           ,[ClosedDate]
           ,[ClosedBy]
           ,[AssignToBusiness]
           ,[AssignToSyniti]
           ,[NewPriority]
           ,[NewStatus]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia]
           ,[boaStatus]
           ,[WaveID]
           ,[ProcessAreaID]
           ,[ObjectID]
           ,[CategoryID]
           ,[ScenarioID]
           ,[RequestID]
           ,[GroupID]
		   ,[DQReport]
		   ,[ReportStatus])
	SELECT [ID]
		   ,[DQReportTrackerID]
           ,[Status]
           ,[AddedOn]
           ,[AddedBy]
           ,[Title]
           ,[AssignedTo]
           ,[Priority]
           ,[ClosedDate]
           ,[ClosedBy]
           ,AssignTogovernance
           ,AssignTodevelopment
           ,[NewPriority]
           ,[NewStatus]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia]
           ,[boaStatus]
           ,[WaveID]
           ,[ProcessAreaID]
           ,[ObjectID]
           ,[CategoryID]
           ,[ScenarioID]
           ,[RequestID]
           ,[GroupID]
		   ,DQReport
		   ,[ReportStatus]
		   from ttActionTracker where Status = 'Closed'


		   INSERT INTO [dbo].[rtActionTrackerAttachment]
           (ID,
		   [ParentID]
           ,[FilePath]
           ,[AddedBy]
           ,[AddedOn]
           ,[Description])

		   select ttActionTrackerAttachment.ID,
		   ttActionTrackerAttachment.[ParentID]
           ,ttActionTrackerAttachment.[FilePath]
           ,ttActionTrackerAttachment.[AddedBy]
           ,ttActionTrackerAttachment.[AddedOn]
           ,ttActionTrackerAttachment.[Description]
		   from ttActionTrackerAttachment
		   inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerAttachment.ParentID
		   where ttActionTracker.Status = 'Closed'


		   INSERT INTO [dbo].[rtActionTrackerDetail]
           (ID,[ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
           ,[AssignTo]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia]
           ,[boaStatus])
		   select ttActionTrackerDetail.ID,ttActionTrackerDetail.[ParentID]
           ,ttActionTrackerDetail.[AddedOn]
           ,ttActionTrackerDetail.[AddedBy]
           ,ttActionTrackerDetail.[Description]
           ,ttActionTrackerDetail.[AssignTo]
           ,ttActionTrackerDetail.[AddedVia]
           ,ttActionTrackerDetail.[ChangedBy]
           ,ttActionTrackerDetail.[ChangedOn]
           ,ttActionTrackerDetail.[ChangedVia]
           ,ttActionTrackerDetail.[boaStatus]
		   from ttActionTrackerDetail
		     inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerDetail.ParentID
		   where ttActionTracker.Status = 'Closed'

		   INSERT INTO [dbo].[rtActionTrackerReport]
           (ID,[ParentID]
           ,[Wave]
           ,[ProcessArea]
           ,[Object]
           ,[Report]
           ,[ReportLink]
           ,[AddedBy]
           ,[AddedOn]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia])
		   SELECT ttActionTrackerReport.ID, ttActionTrackerReport.[ParentID]
           ,ttActionTrackerReport.[Wave]
           ,ttActionTrackerReport.[ProcessArea]
           ,ttActionTrackerReport.[Object]
           ,ttActionTrackerReport.[Report]
           ,ttActionTrackerReport.[ReportLink]
           ,ttActionTrackerReport.[AddedBy]
           ,ttActionTrackerReport.[AddedOn]
           ,ttActionTrackerReport.[AddedVia]
           ,ttActionTrackerReport.[ChangedBy]
           ,ttActionTrackerReport.[ChangedOn]
           ,ttActionTrackerReport.[ChangedVia]
		   FROM
		   ttActionTrackerReport
		    inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerReport.ParentID
		   where ttActionTracker.Status = 'Closed'


		   INSERT INTO [dbo].[rtActionTrackerDQReport]
           ([ParentID]
           ,[ID]
           ,[GroupID]
           ,[Report]
           ,[ReportLink]
           ,[AddedBy]
           ,[AddedOn]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia])
		   SELECT 
		   ttActionTrackerDQReport.[ParentID]
           ,ttActionTrackerDQReport.[ID]
           ,ttActionTrackerDQReport.[GroupID]
           ,ttActionTrackerDQReport.[Report]
           ,ttActionTrackerDQReport.[ReportLink]
           ,ttActionTrackerDQReport.[AddedBy]
           ,ttActionTrackerDQReport.[AddedOn]
           ,ttActionTrackerDQReport.[AddedVia]
           ,ttActionTrackerDQReport.[ChangedBy]
           ,ttActionTrackerDQReport.[ChangedOn]
           ,ttActionTrackerDQReport.[ChangedVia]
		   FROM
		   ttActionTrackerDQReport
		    inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerDQReport.ParentID
		   where ttActionTracker.Status = 'Closed'




			 delete from ttActionTracker where Status = 'Closed'
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_Archive_ArchiveSingleActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_Archive_ArchiveSingleActionIns] 
	-- Add the parameters for the stored procedure here
	@ID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[rtActionTracker]
           ([ID]
		   ,[DQReportTrackerID]
           ,[Status]
           ,[AddedOn]
           ,[AddedBy]
           ,[Title]
           ,[AssignedTo]
           ,[Priority]
           ,[ClosedDate]
           ,[ClosedBy]
           ,[AssignToBusiness]
           ,[AssignToSyniti]
           ,[NewPriority]
           ,[NewStatus]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia]
           ,[WaveID]
           ,[ProcessAreaID]
           ,[ObjectID]
           ,[CategoryID]
           ,[ScenarioID]
           ,[RequestID]
           ,[GroupID]
		   ,[DQReport]
		   ,[ReportStatus])
	SELECT [ID]
		   ,[DQReportTrackerID]
           ,[Status]
           ,[AddedOn]
           ,[AddedBy]
           ,[Title]
           ,[AssignedTo]
           ,[Priority]
           ,[ClosedDate]
           ,[ClosedBy]
           ,[AssignToGovernance]
           ,[AssignToDevelopment]
           ,[NewPriority]
           ,[NewStatus]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia]
           ,[WaveID]
           ,[ProcessAreaID]
           ,[ObjectID]
           ,[CategoryID]
           ,[ScenarioID]
           ,[RequestID]
           ,[GroupID]
		   ,DQReport
		   ,[ReportStatus]
		   from ttActionTracker where Status = 'Closed' and ID = @ID


		   INSERT INTO [dbo].[rtActionTrackerAttachment]
           (ID,
		   [ParentID]
           ,[FilePath]
           ,[AddedBy]
           ,[AddedOn]
           ,[Description])

		   select ttActionTrackerAttachment.ID,
		   ttActionTrackerAttachment.[ParentID]
           ,ttActionTrackerAttachment.[FilePath]
           ,ttActionTrackerAttachment.[AddedBy]
           ,ttActionTrackerAttachment.[AddedOn]
           ,ttActionTrackerAttachment.[Description]
		   from ttActionTrackerAttachment
		   inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerAttachment.ParentID
		   where ttActionTracker.Status = 'Closed' and ttActionTracker.ID = @ID


		   INSERT INTO [dbo].[rtActionTrackerDetail]
           (ID,[ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
           ,[AssignTo]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia]
           ,[boaStatus])
		   select ttActionTrackerDetail.ID,ttActionTrackerDetail.[ParentID]
           ,ttActionTrackerDetail.[AddedOn]
           ,ttActionTrackerDetail.[AddedBy]
           ,ttActionTrackerDetail.[Description]
           ,ttActionTrackerDetail.[AssignTo]
           ,ttActionTrackerDetail.[AddedVia]
           ,ttActionTrackerDetail.[ChangedBy]
           ,ttActionTrackerDetail.[ChangedOn]
           ,ttActionTrackerDetail.[ChangedVia]
           ,ttActionTrackerDetail.[boaStatus]
		   from ttActionTrackerDetail
		     inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerDetail.ParentID
		   where ttActionTracker.Status = 'Closed' and ttActionTracker.ID = @ID

		   INSERT INTO [dbo].[rtActionTrackerReport]
           (ID,[ParentID]
           ,[Wave]
           ,[ProcessArea]
           ,[Object]
           ,[Report]
           ,[ReportLink]
           ,[AddedBy]
           ,[AddedOn]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia])
		   SELECT ttActionTrackerReport.ID, ttActionTrackerReport.[ParentID]
           ,ttActionTrackerReport.[Wave]
           ,ttActionTrackerReport.[ProcessArea]
           ,ttActionTrackerReport.[Object]
           ,ttActionTrackerReport.[Report]
           ,ttActionTrackerReport.[ReportLink]
           ,ttActionTrackerReport.[AddedBy]
           ,ttActionTrackerReport.[AddedOn]
           ,ttActionTrackerReport.[AddedVia]
           ,ttActionTrackerReport.[ChangedBy]
           ,ttActionTrackerReport.[ChangedOn]
           ,ttActionTrackerReport.[ChangedVia]
		   FROM
		   ttActionTrackerReport
		    inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerReport.ParentID
		   where ttActionTracker.Status = 'Closed' and ttActionTracker.ID = @ID


		   INSERT INTO [dbo].[rtActionTrackerDQReport]
           ([ParentID]
           ,[ID]
           ,[GroupID]
           ,[Report]
           ,[ReportLink]
           ,[AddedBy]
           ,[AddedOn]
           ,[AddedVia]
           ,[ChangedBy]
           ,[ChangedOn]
           ,[ChangedVia])
		   SELECT 
		   ttActionTrackerDQReport.[ParentID]
           ,ttActionTrackerDQReport.[ID]
           ,ttActionTrackerDQReport.[GroupID]
           ,ttActionTrackerDQReport.[Report]
           ,ttActionTrackerDQReport.[ReportLink]
           ,ttActionTrackerDQReport.[AddedBy]
           ,ttActionTrackerDQReport.[AddedOn]
           ,ttActionTrackerDQReport.[AddedVia]
           ,ttActionTrackerDQReport.[ChangedBy]
           ,ttActionTrackerDQReport.[ChangedOn]
           ,ttActionTrackerDQReport.[ChangedVia]
		   FROM
		   ttActionTrackerDQReport
		    inner join ttActionTracker on ttActionTracker.ID = ttActionTrackerDQReport.ParentID
		   where ttActionTracker.Status = 'Closed' and ttActionTracker.ID = @ID




			 delete from ttActionTracker where Status = 'Closed' and ttActionTracker.ID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_AssignTo_AssignToBusinessUserIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_AssignTo_AssignToBusinessUserIns] 
	-- Add the parameters for the stored procedure here
	@ID int, @boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,[Description] FROM webActionTracker_AssignTo_AssignToBusinessUserSel
		   where ID = @ID

	UPDATE webActionTracker_AssignTo_AssignToBusinessUserSel
	SET AssignedTo = AssignedtoNew
	where ID = @ID

	UPDATE ttActionTracker SET AssignToGovernance = NULL where ID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_AssignTo_AssignToSynitiUserIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_AssignTo_AssignToSynitiUserIns] 
	-- Add the parameters for the stored procedure here
	@ID int, @boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,[Description] FROM webActionTracker_AssignTo_AssignToSynitiUserSel
		   where ID = @ID

	UPDATE webActionTracker_AssignTo_AssignToSynitiUserSel
	SET AssignedTo = AssignedtoNew
	where ID = @ID

	UPDATE ttActionTracker SET AssignToDevelopment = NULL where ID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_CloseAction_CloseActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_CloseAction_CloseActionIns] 
	-- Add the parameters for the stored procedure here
	@ID int, @boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,[Message] FROM webActionTracker_CloseAction_CloseActionSel
		   where ID = @ID

	UPDATE webActionTracker_CloseAction_CloseActionSel
	SET [Status] = StatusNew,
	closedby = @boaUserEmail,
	closeddate = getdate()
	where ID = @ID

	
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_DQReport_CloseActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[webActionTracker_DQReport_CloseActionIns]
  -- Add the parameters for the stored procedure here
  @ID        int,
  @boaUserEmail nvarchar(50)
AS
  BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

      -- Insert statements for procedure here
      INSERT INTO [dbo].[ttActionTrackerDetail]
                  ([ParentID],
                   [AddedOn],
                   [AddedBy],
                   [Description])
      SELECT ID,
             Getdate(),
             @boaUserEmail,
             [Message]
      FROM   webActionTracker_DQReport_CloseActionSel
      where  ID = @ID

      UPDATE webActionTracker_DQReport_CloseActionSel
      SET    [Status] = StatusNew,
             closedby = @boaUserEmail,
             closeddate = Getdate()
      where  ID = @ID
  END 
GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_DQReport_OnValidate_NewReportIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_DQReport_OnValidate_NewReportIns] 
	-- Add the parameters for the stored procedure here
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[ttActionTrackerDQReport]
           ([ParentID]
           ,[GroupID]
           ,[Report]
           ,[AddedBy]
           ,[AddedOn]
)
SELECT
[ID]
           ,[GroupID]
           ,[DQReport]
           ,[AddedBy]
           ,[AddedOn]
		   from webActionTracker_OnValidate_DQReport_NewReportSel where  ID = @ID


    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
  )
 SELECT [ParentID]
   
      ,[AddedOn]
	     ,[AddedBy]
      ,[Description]
  FROM [dbo].[webActionTrackerDQReport_OnValidate_NewReportSel]
  where ParentID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_NewPriority_PriorityChangeIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_NewPriority_PriorityChangeIns] 
	-- Add the parameters for the stored procedure here
	@ID int, @boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,[Message] FROM webActionTracker_NewPriority_PriorityChangeSel
		   where ID = @ID

	UPDATE webActionTracker_NewPriority_PriorityChangeSel
	SET [Priority] = PriorityNew
	where ID = @ID

	UPDATE ttActionTracker SET NewPriority = NULL where ID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_NewStatus_StatusChangeIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_NewStatus_StatusChangeIns] 
	-- Add the parameters for the stored procedure here
	@ID int, @boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,[Message] FROM webActionTracker_NewStatus_StatusChangeSel
		   where ID = @ID

	UPDATE webActionTracker_NewStatus_StatusChangeSel
	SET [Status] = StatusNew
	where ID = @ID

	UPDATE ttActionTracker SET NewSTATUS = NULL where ID = @ID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_OnValidate_FillInformationFromttDQReportTrackerUpd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[webActionTracker_OnValidate_FillInformationFromttDQReportTrackerUpd] @ID int
AS

BEGIN

UPDATE ttActionTracker
SET GroupID = ttDQReportTracker.[Group]
, DQReport = ttDQReportTracker.ReportID
, ReportStatus = (CASE WHEN ISNULL(ttActionTracker.ReportStatus, '') = '' THEN ttDQReportTracker.[State] ELSE ttActionTracker.ReportStatus END)
, AssignedTo = (CASE WHEN ISNULL(ttActionTracker.AssignedTo, '') = '' THEN ttDQReportTracker.AssignedTo ELSE ttActionTracker.AssignedTo END)
FROM ttActionTracker INNER JOIN ttDQReportTracker
ON ttActionTracker.DQReportTrackerID = ttDQReportTracker.ID
WHERE ttActionTracker.ID = @ID

END
GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_OnValidate_NewActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
CREATE   PROCEDURE [dbo].[webActionTracker_OnValidate_NewActionIns] 
	-- Add the parameters for the stored procedure here
	@boaUserEmail nvarchar(50), @ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
    /*-- Insert statements for procedure here
	UPDATE webActionTracker_OnValidate_NewActionSel
	SET [Status] = StatusNew,
	AssignedTo = @boaUserEmail,
	Priority = PriorityNew
	WHERE ID = @ID
 */
 
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,'New Action Logged In' FROM webActionTracker_OnValidate_NewActionSel
		   where ID = @ID
 
	--UPDATE ttActionTracker SET NewSTATUS = NULL where ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[webActionTracker_ReopenActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTracker_ReopenActionIns] 
	-- Add the parameters for the stored procedure here
	@ID int, @boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,[Message] FROM webActionTracker_ReopenActionSel
		   where ID = @ID

	UPDATE webActionTracker_ReopenActionSel
	SET [Status] = StatusNew
	where ID = @ID

	UPDATE ttActionTracker
	SET ClosedDate = NULL,
	ClosedBy = NULL
	WHERE ID = @ID


	
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTrackerAttachment_OnValidate_NewAttachmentIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTrackerAttachment_OnValidate_NewAttachmentIns] 
	-- Add the parameters for the stored procedure here
	@ParentID int, @boaUserEmail nvarchar(50), @FilePath nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
  )
 SELECT [ParentID]
   
      ,[AddedOn]
	     ,[AddedBy]
      ,[Description]
  FROM [dbo].[webActionTrackerAttachment_OnValidate_NewAttachmentSel]
  where ParentID = @ParentID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTrackerDetail_NotifyUserIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE   PROCEDURE [dbo].[webActionTrackerDetail_NotifyUserIns] @boaUserEmail nvarchar(50), @ID int
 AS
 BEGIN
       INSERT INTO [dbo].[ttActionTrackerDetail]
                  ([ParentID],
                   [AddedOn],
                   [AddedBy],
                   [Description])
      SELECT @ID,
             Getdate(),
             @boaUserEmail,
             'Notified assigned user.'

END
GO
/****** Object:  StoredProcedure [dbo].[webActionTrackerDQReport_OnValidate_NewReportIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTrackerDQReport_OnValidate_NewReportIns] 
	-- Add the parameters for the stored procedure here
	@ParentID int, @boaUserEmail nvarchar(50), @report nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
  )
 SELECT [ParentID]
   
      ,[AddedOn]
	     ,[AddedBy]
      ,[Description]
  FROM [dbo].[webActionTrackerDQReport_OnValidate_NewReportSel]
  where ParentID = @ParentID
END


GO
/****** Object:  StoredProcedure [dbo].[webActionTrackerReport_OnValidate_NewReportIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webActionTrackerReport_OnValidate_NewReportIns] 
	-- Add the parameters for the stored procedure here
	@ParentID int, @boaUserEmail nvarchar(50), @report nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
  )
 SELECT [ParentID]
   
      ,[AddedOn]
	     ,[AddedBy]
      ,[Description]
  FROM [dbo].[webActionTrackerReport_OnValidate_NewReportSel]
  where ParentID = @ParentID
END


GO
/****** Object:  StoredProcedure [dbo].[webAssignDqOpsUpd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[webAssignDqOpsUpd] 
@RuleOrigin nvarchar(50), @ID int
AS
BEGIN


UPDATE ttDQReportTracker 
SET 
DqOpsId = t2.LastNumberUsed + 1

FROM ttDQReportTracker t1
INNER JOIN ztNumberRange t2 ON t1.RuleOrigin = t2.RuleOrigin
WHERE 
    t1.DqOpsId IS NULL  
    AND t2.LastNumberUsed < t2.ToNumber
	AND t1.ID=@ID
	AND T1.RuleOrigin=@RuleOrigin;  


UPDATE ztNumberRange 
SET LastNumberUsed = LastNumberUsed + 1
WHERE 
ztNumberRange.RuleOrigin =@RuleOrigin

END
GO
/****** Object:  StoredProcedure [dbo].[webDQReportTracker_NewActionDetailIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webDQReportTracker_NewActionDetailIns] 
	-- Add the parameters for the stored procedure here
	@boaUserEmail nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description])
		   SELECT ID,  getdate(), @boaUserEmail,'New Action Logged In' FROM webActionTracker_OnValidate_NewActionSel

END


GO
/****** Object:  StoredProcedure [dbo].[webDQReportTracker_NewActionDQReportIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webDQReportTracker_NewActionDQReportIns] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[ttActionTrackerDQReport]
           ([ParentID]
           ,[GroupID]
           ,[Report]
           ,[AddedBy]
           ,[AddedOn]
)
SELECT
[ID]
,[GroupID]
,[DQReport]
,[AddedBy]
,[AddedOn]
from webActionTracker_OnValidate_DQReport_NewReportSel


    -- Insert statements for procedure here
	INSERT INTO [dbo].[ttActionTrackerDetail]
           ([ParentID]
           ,[AddedOn]
           ,[AddedBy]
           ,[Description]
  )
 SELECT [ParentID]
      ,[AddedOn]
	  ,[AddedBy]
      ,[Description]
  FROM [dbo].[webActionTrackerDQReport_OnValidate_NewReportSel]
END


GO
/****** Object:  StoredProcedure [dbo].[webDQReportTracker_Reset_ArchiveActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[webDQReportTracker_Reset_ArchiveActionIns] @ID int, @boaUserEmail nvarchar(50)
AS
DECLARE @DQReportTrackerID int
--DECLARE @CloseID int

BEGIN

SET @DQReportTrackerID = @ID
SET @ID = 0

declare cur CURSOR LOCAL for 
	SELECT --ttDQReportTracker.ID AS DQReportTrackerID, ttActionTracker.ID AS DefectID,
	ttActionTracker.ID 
	FROM ttDQReportTracker 
	INNER JOIN ttActionTracker 
	ON ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
	WHERE DQReportTrackerID = @DQReportTrackerID
	ORDER BY ID
Open Cur;
FETCH NEXT FROM cur into @ID

While @@FETCH_STATUS = 0 
BEGIN

--print @ID

UPDATE ttActionTracker
SET [Status] = 'Closed'
, AddedVia = CASE WHEN AddedVia = 'StoredProcedure' THEN 'StoredProcedureReset' ELSE AddedVia END
WHERE ID = @ID


EXEC webActionTracker_DQReport_CloseActionIns @ID, @boaUserEmail
EXEC webActionTracker_Archive_ArchiveSingleActionIns @ID

FETCH NEXT FROM Cur into @ID
END
Close Cur;
Deallocate Cur;

UPDATE rtActionTracker
SET [Status] = 'Closed'
, AddedVia = 'StoredProcedureReset'
WHERE DQReportTrackerID = @DQReportTrackerID

UPDATE ttDQReportTracker
SET 
 Define = 0
,Specify = 0
,Build = 0
,ValidateImprove = 0
,Publish = 0
FROM ttDQReportTracker
WHERE ID = @DQReportTrackerID

END

GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerActionBuildIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[webDQReportTrackerActionBuildIns] @boaUserEmail nvarchar(50), @ID int
AS
BEGIN

UPDATE ttDQReportTracker
    SET    [State] = 'Pending validation'
    WHERE  ID = @ID 
END

BEGIN
INSERT INTO dbo.ttActionTracker (DQReportTrackerID, GroupID, DQReport, [Priority], [Status], ReportStatus, [Title], AddedOn, AddedBy, AddedVia, boaStatus, AssignedTo)
SELECT  
@ID AS DQReportTrackerID
, [Group] AS GroupID
, ReportID AS DQReport
, 'Medium' AS [Priority]
, 'Not Started' AS [Status]
, 'Pending validation' AS ReportStatus
, 'Pending validation' AS [Title] 
, getdate() AS AddedOn
, @boaUserEmail AS AddedBy
, 'StoredProcedure' AS AddedVia
, 4 as boaStatus
, @boaUserEmail AS AssignedTo
FROM     dbo.ttDQReportTracker
LEFT OUTER JOIN dbo.ttActionTracker ON 
ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
LEFT OUTER JOIN dbo.rtActionTracker ON 
ttDQReportTracker.ID = rtActionTracker.DQReportTrackerID
AND ttDQReportTracker.State = rtActionTracker.ReportStatus
AND rtActionTracker.AddedVia <> 'StoredProcedureReset'
WHERE ISNULL(ttDQReportTracker.Publish, 0) = 0 AND ttActionTracker.ID IS NULL
AND rtActionTracker.ID IS NULL
AND ttDQReportTracker.ID = @ID 
END

GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerActionDefineIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE   PROCEDURE [dbo].[webDQReportTrackerActionDefineIns] @boaUserEmail nvarchar(50), @ID int
AS
BEGIN

UPDATE ttDQReportTracker
    SET    [State] = 'Awaiting Specification'
    WHERE  ID = @ID 
END

BEGIN
INSERT INTO dbo.ttActionTracker (DQReportTrackerID, GroupID, DQReport, [Priority], [Status], ReportStatus, [Title], AddedOn, AddedBy, AddedVia, boaStatus, AssignedTo)
SELECT   
@ID AS DQReportTrackerID
, [Group] AS GroupID
, ReportID AS DQReport
, 'Medium' AS [Priority]
, 'Not Started' AS [Status]
, 'Awaiting Specification' AS ReportStatus
, 'Awaiting Specification' AS [Title] 
, getdate() AS AddedOn
, @boaUserEmail AS AddedBy
, 'StoredProcedure' AS AddedVia
, 4 as boaStatus
, @boaUserEmail AS AssignedTo
FROM     dbo.ttDQReportTracker
LEFT OUTER JOIN dbo.ttActionTracker ON 
ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
LEFT OUTER JOIN dbo.rtActionTracker ON 
ttDQReportTracker.ID = rtActionTracker.DQReportTrackerID
AND ttDQReportTracker.State = rtActionTracker.ReportStatus 
AND rtActionTracker.AddedVia <> 'StoredProcedureReset'
WHERE ISNULL(ttDQReportTracker.Publish, 0) = 0 AND ttActionTracker.ID IS NULL
AND rtActionTracker.ID IS NULL
AND ttDQReportTracker.ID = @ID 
END

GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerActionIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[webDQReportTrackerActionIns] @boaUserID nvarchar(50), @ID int
AS
BEGIN

UPDATE ttDQReportTracker
    SET    [State] = CASE
                       WHEN ISNULL(Define, 0) = 0 THEN 'Not started'
                       WHEN Define = 1
                            AND ISNULL(Specify, 0) = 0 THEN 'Awaiting Specification'
                       WHEN Specify = 1
                            AND ISNULL(Build, 0) = 0 THEN 'Build in progress'
                       WHEN Build = 1
                            AND ISNULL(ValidateImprove, 0) = 0 THEN 'Pending validation'
                       WHEN ValidateImprove = 1
                            AND ISNULL(Publish, 0) = 0 THEN 'Build/Validation Iteration'
                       WHEN Publish = 1 THEN 'Published'
                     END
    WHERE  ID = @ID 
END

BEGIN
INSERT INTO dbo.ttActionTracker (DQReportTrackerID, GroupID, DQReport, [Priority], [Status], ReportStatus, [Title], AddedOn, AddedBy, AddedVia, boaStatus, AssignedTo)
SELECT   
@ID AS DQReportTrackerID
, [Group] AS GroupID
, ReportID AS DQReport
, 'Medium' AS [Priority]
, 'Not Started' AS [Status]
, [State] AS ReportStatus
, [State] AS [Title] 
, getdate() AS AddedOn
, @boaUserID AS AddedBy
, 'StoredProcedure' AS AddedVia
, 4 as boaStatus
, @boaUserID AS AssignedTo
FROM     dbo.ttDQReportTracker
LEFT OUTER JOIN dbo.ttActionTracker ON 
ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
WHERE ISNULL(ttDQReportTracker.Publish, 0) = 0 AND ttActionTracker.ID IS NULL

END

GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerActionSpecifyIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[webDQReportTrackerActionSpecifyIns] @boaUserEmail nvarchar(50), @ID int
AS
BEGIN

UPDATE ttDQReportTracker
    SET    [State] = 'Build in progress'
    WHERE  ID = @ID 
END

BEGIN
INSERT INTO dbo.ttActionTracker (DQReportTrackerID, GroupID, DQReport, [Priority], [Status], ReportStatus, [Title], AddedOn, AddedBy, AddedVia, boaStatus, AssignedTo)
SELECT   
@ID AS DQReportTrackerID
, [Group] AS GroupID
, ReportID AS DQReport
, 'Medium' AS [Priority]
, 'Not Started' AS [Status]
, 'Build in progress' AS ReportStatus
, 'Build in progress' AS [Title] 
, getdate() AS AddedOn
, @boaUserEmail AS AddedBy
, 'StoredProcedure' AS AddedVia
, 4 as boaStatus
, @boaUserEmail AS AssignedTo
FROM     dbo.ttDQReportTracker
LEFT OUTER JOIN dbo.ttActionTracker ON 
ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
LEFT OUTER JOIN dbo.rtActionTracker ON 
ttDQReportTracker.ID = rtActionTracker.DQReportTrackerID
AND ttDQReportTracker.State = rtActionTracker.ReportStatus 
AND rtActionTracker.AddedVia <> 'StoredProcedureReset'
WHERE ISNULL(ttDQReportTracker.Publish, 0) = 0 AND ttActionTracker.ID IS NULL
AND rtActionTracker.ID IS NULL
AND ttDQReportTracker.ID = @ID 
END
GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerActionValidateImproveIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[webDQReportTrackerActionValidateImproveIns] @boaUserEmail nvarchar(50), @ID int
AS
BEGIN

UPDATE ttDQReportTracker
    SET    [State] = 'Build/Validation Iteration'
    WHERE  ID = @ID 
END

BEGIN
INSERT INTO dbo.ttActionTracker (DQReportTrackerID, GroupID, DQReport, [Priority], [Status], ReportStatus, [Title], AddedOn, AddedBy, AddedVia, boaStatus, AssignedTo)
SELECT   
@ID AS DQReportTrackerID
, [Group] AS GroupID
, ReportID AS DQReport
, 'Medium' AS [Priority]
, 'Not Started' AS [Status]
, 'Build/Validation Iteration' AS ReportStatus
, 'Build/Validation Iteration' AS [Title] 
, getdate() AS AddedOn
, @boaUserEmail AS AddedBy
, 'StoredProcedure' AS AddedVia
, 4 as boaStatus
, @boaUserEmail AS AssignedTo
FROM     dbo.ttDQReportTracker
LEFT OUTER JOIN dbo.ttActionTracker ON 
ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
LEFT OUTER JOIN dbo.rtActionTracker ON 
ttDQReportTracker.ID = rtActionTracker.DQReportTrackerID
AND ttDQReportTracker.State = rtActionTracker.ReportStatus 
AND rtActionTracker.AddedVia <> 'StoredProcedureReset'
WHERE ISNULL(ttDQReportTracker.Publish, 0) = 0 AND ttActionTracker.ID IS NULL
AND rtActionTracker.ID IS NULL
AND ttDQReportTracker.ID = @ID 
END

GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerHealthUpd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[webDQReportTrackerHealthUpd] @ID int
AS
UPDATE ttDQReportTracker
SET Health = CASE WHEN ISNULL(Health, '') = '' THEN 'CranSoft.Status.DSPLateTask'
			 WHEN ISNULL(Health, '') = 'CranSoft.Status.DSPLateTask' THEN 'CranSoft.Status.DSPYellowlight'
			 WHEN ISNULL(Health, '') = 'CranSoft.Status.DSPYellowlight' THEN 'CranSoft.Status.DSPGreenlight'
			 WHEN ISNULL(Health, '') = 'CranSoft.Status.DSPGreenlight' THEN 'CranSoft.Status.DSPLateTask'
			 END
WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerOnValidateInitialDefineIns]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE   PROCEDURE [dbo].[webDQReportTrackerOnValidateInitialDefineIns] @boaUserEmail nvarchar(50),
                                                                            @ID        int
AS
  BEGIN
      UPDATE ttDQReportTracker
      SET    [State] = 'Awaiting Specification'
      WHERE  ID = @ID
             AND Define = 1
             AND Specify = 0
  END

BEGIN
    INSERT INTO dbo.ttActionTracker
                (DQReportTrackerID,
                 GroupID,
                 DQReport,
                 [Priority],
                 [Status],
                 ReportStatus,
                 [Title],
                 AddedOn,
                 AddedBy,
                 AddedVia,
                 boaStatus,
                 AssignedTo)
    SELECT @ID                      AS DQReportTrackerID,
           [Group]                  AS GroupID,
           ReportID                 AS DQReport,
           'Medium'                 AS [Priority],
           'Not Started'            AS [Status],
           'Awaiting Specification' AS ReportStatus,
           'Awaiting Specification' AS [Title],
           Getdate()                AS AddedOn,
           @boaUserEmail               AS AddedBy,
           'StoredProcedure'        AS AddedVia,
           4                        as boaStatus,
           @boaUserEmail               AS AssignedTo
    FROM   dbo.ttDQReportTracker
           LEFT OUTER JOIN dbo.ttActionTracker
                        ON ttDQReportTracker.ID = ttActionTracker.DQReportTrackerID
           LEFT OUTER JOIN dbo.rtActionTracker
                        ON ttDQReportTracker.ID = rtActionTracker.DQReportTrackerID
                           AND ttDQReportTracker.State = rtActionTracker.ReportStatus
                           AND rtActionTracker.AddedVia <> 'StoredProcedureReset'
    WHERE  ISNULL(ttDQReportTracker.Publish, 0) = 0
           AND ttActionTracker.ID IS NULL
           AND rtActionTracker.ID IS NULL
           AND Define = 1
           AND Specify = 0
		   AND ttDQReportTracker.ID = @ID 
END

GO
/****** Object:  StoredProcedure [dbo].[webDQReportTrackerStateUpd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[webDQReportTrackerStateUpd] @ID int
AS
UPDATE ttDQReportTracker
SET [State] = 
  CASE WHEN ISNULL(Define, 0) = 0 THEN 'Not started'
       WHEN Define = 1 AND ISNULL(Specify, 0) = 0 THEN 'Awaiting Specification'
       WHEN Specify = 1 AND ISNULL(Build, 0) = 0 THEN 'Build in progress'
       WHEN Build = 1 AND ISNULL(ValidateImprove, 0) = 0 THEN 'Pending validation'
       WHEN ValidateImprove = 1 AND ISNULL(Publish, 0) = 0 THEN 'Build/Validation Iteration'
       WHEN Publish = 1 THEN 'Published' END
WHERE ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[webKnowledgeTierExtract_GETAPIRESULTS_GETRESULTS_TABLENAME_Upd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[webKnowledgeTierExtract_GETAPIRESULTS_GETRESULTS_TABLENAME_Upd] 
  @TableName nvarchar(50),
  @ExtractID nvarchar(50)
AS

DECLARE @URLInitial nvarchar(250)
DECLARE @URLExtension nvarchar(250)
DECLARE @APIUsername varchar(100)
DECLARE @APIPassword nvarchar(255);
DECLARE @RequestHeaders nvarchar(max)

IF @TableName <> 'SYSTEMSCOMPONENTS'
BEGIN

SET @URLInitial = (SELECT [URL] FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @URLExtension = (SELECT URLExtension FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @APIUsername = (SELECT APIUsername FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @APIPassword = (SELECT APIPassword FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @RequestHeaders = [dbo].[BasicAuthHeader] (@APIUsername,@APIPassword)

Exec webKnowledgeTierExtract_GETAPIRESULTS_GETRESULTS_Upd  @URLInitial,@URLExtension,@RequestHeaders,@TableName, @ExtractID

Exec webKnowledgeTierExtract_JSON_TABLES_Ins NULL, @ExtractID, @TableName

END

IF @TableName = 'SYSTEMSCOMPONENTS'

BEGIN
DECLARE @SystemID nvarchar(50)
SET @SystemID = (SELECT SystemID FROM KnowledgeTierExtract WHERE ExtractID = @ExtractID)

SET @URLInitial = (SELECT [URL] FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @URLExtension = (SELECT REPLACE(URLExtension, '{id}', @SystemID) FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @APIUsername = (SELECT APIUsername FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @APIPassword = (SELECT APIPassword FROM GETAPIRESULTS WHERE TABLENAME = @TableName AND ExtractID = @ExtractID)
SET @RequestHeaders = [dbo].[BasicAuthHeader] (@APIUsername,@APIPassword)


Exec webKnowledgeTierExtract_GETAPIRESULTS_GETRESULTS_Upd  @URLInitial,@URLExtension,@RequestHeaders,@TableName, @ExtractID

Exec webKnowledgeTierExtract_JSON_TABLES_Ins NULL, @ExtractID, @TableName

END

GO
/****** Object:  StoredProcedure [dbo].[webKnowledgeTierExtract_GETAPIRESULTS_GETRESULTS_Upd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[webKnowledgeTierExtract_GETAPIRESULTS_GETRESULTS_Upd] 
  @URLInitial nvarchar(250),
  @URLExtension nvarchar(250),
  @RequestHeaders nvarchar(max),
  @TableName nvarchar(50),
  @ExtractID nvarchar(50)

AS
SET TEXTSIZE 2147483647

DECLARE @FirstPass nvarchar(1) = ''
DECLARE @URL nvarchar(250) = CONCAT(@URLInitial,@URLExtension);
DECLARE @SQL nvarchar(max) = NULL
DECLARE @JSONString nvarchar(max) = NULL
DECLARE @CursorSQL nvarchar(max) = 'NULL '
DECLARE @XMLCursor nvarchar(max) = NULL
DECLARE @ERROR_MSG NVARCHAR(150)
DECLARE @Action nvarchar(10) = N'Get'
DECLARE @ContentType nvarchar(50) = 'application/json'
DECLARE @RequestPayload nvarchar(max)


BEGIN
--	SET @RequestHeaders = [dbo].[BasicAuthHeader] (@Username,@Password)
	WHILE  @CursorSQL <> ''
		BEGIN
--	        DECLARE @Params NVARCHAR(MAX) =  CONCAT('Action:',@Action,CHAR(10),'RequestHeaders:',@RequestHeaders,CHAR(10),'RequestPayload:',@RequestPayload,CHAR(10),'URL:',@URL,CHAR(10),'ContentYYpe:',@ContentType)
--			RAISERROR('%s',16,1, @Params) WITH NOWAIT
			SELECT @JSONString = [dbo].Syniti_API (@Action,@RequestHeaders, @RequestPayLoad,@URL,@contentType)
			Select concat('@Action ',@Action,' @RequestPayload ',@RequestPayload,' @URL ',@URL)
			SELECT @JSONString as JSONTEXT
			SET @SQL = 'SELECT @CursorSQL = (SELECT JSON_VALUE(N''' + REPLACE(@JSONString,'''','''''') + ''' ,''$.cursor''))'
			execute sp_executesql @SQL, N'@CursorSQL nvarchar(max) output',@CursorSQL=@CursorSQL  out
--			SELECT @CursorSQL as cursorsql, len(@CursorSQL)
			SET @URL = @URLInitial + @URLExtension + '?cursor=' + @CursorSQL
			IF @FirstPass <> '' SELECT @JSONString = REPLACE(@JSONSTRING,'{"data":[','')
SELECT CONCAT(@TableName,' Length= ',LEN(@JSONString))
--			IF LEN(@JSONString) > 14 
			--IF @JSONString <> '' SELECT @JSONString = LEFT(@JSONString,CHARINDEX('],"cursor":', @JSONString)-1)	
			IF @JSONString <> '' AND @JSONString like '],"cursor":' SELECT @JSONString = LEFT(@JSONString,CHARINDEX('],"cursor":', @JSONString)-1)	
			IF @JSONString = '' Select @XMLCursor =  CONCAT(@XMLCursor,@JSONString)
			ELSE  Select @XMLCursor =  CONCAT(@XMLCursor,@FirstPass,@JSONString)
			SET @FirstPass = ','
		END

		Select @XMLCursor =  CONCAT(@XMLCursor,'],"cursor":""}')
		SELECT CONCAT('Updating GETAPI ',@tableName,' JSON Record = ',@XMLCursor)
		UPDATE GETAPIRESULTS
			SET GETRESULTS = @XMLCursor
			, LastUpdate = GETDATE()
			Where @URLInitial = GETAPIRESULTS.URL and GETAPIRESULTS.URLEXTENSION = @URLExtension 
			AND ExtractID = @ExtractID
END
GO
/****** Object:  StoredProcedure [dbo].[webKnowledgeTierExtract_JSON_TABLES_Ins]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[webKnowledgeTierExtract_JSON_TABLES_Ins] 
@InitializeTranslationTables nvarchar(50) = NULL, @ExtractID nvarchar(50), @TableName nvarchar(255)
AS
BEGIN
DECLARE @TableNameGETAPI nvarchar(255)
DECLARE @SQL nvarchar(255)

set @TableNameGETAPI = @TableName

declare cur CURSOR LOCAL for 
    Select Table_Name From WRKDQOPS.INFORMATION_SCHEMA.TABLES
	Where TABLE_NAME not like '%AGENTS%'--AND TABLE_NAME <> 'JSON_AGENTS'
	AND TABLE_NAME like '%JSON[_]'+@TableName
	OR TABLE_NAME like '%JSON[_]'+@TableName+'[_]%'
	ORDER BY TABLE_NAME
Open Cur;
FETCH NEXT FROM cur into @TableName

While @@FETCH_STATUS = 0 
BEGIN
	DECLARE @ViewName nvarchar(255) 
	DECLARE @CleanTable nvarchar(255)
	SELECT @ViewName = STUFF(@TableName,1,4,'')
	--SELECT @CleanTable  = 'TRUNCATE TABLE WRKDQOPS.dbo.' + @TableName
	SELECT @CleanTable  = 'DELETE FROM WRKDQOPS.dbo.' + @TableName + ' WHERE ExtractID = ''' + @ExtractID + ''''
	SELECT @SQL = 'INSERT INTO WRKDQOPS.dbo.' + @TableName + ' SELECT * FROM WRKDQOPS.dbo.ImportJSONFILE' + @ViewName + ' WHERE ExtractID = ''' + @ExtractID + ''''
	IF Object_id('WRKDQOPS.dbo.'+@TableName,'U') IS NOT NULL
	BEGIN
	SELECT @SQL
		EXEC sp_executesql @CleanTable
		EXEC sp_executesql @SQL
		IF @InitializeTranslationTables = 'RESET'
			BEGIN 
				--SELECT @CleanTable  = 'TRUNCATE TABLE WRKDQOPS.dbo.JSON' + @ViewName +';'
				SELECT @CleanTable  = 'DELETE FROM WRKDQOPS.dbo.JSON' + @ViewName  + ' WHERE ExtractID = ''' + @ExtractID + '''' +';'
				SELECT @SQL = 'INSERT INTO WRKDQOPS.dbo.JSON' + @ViewName + ' SELECT * FROM WRKDQOPS.dbo.TRANSLATIONS_REF' + @ViewName + ' WHERE ExtractID = ''' + @ExtractID + ''''
				EXEC sp_executesql @CleanTable
				EXEC sp_executesql @SQL
			END
		ELSE
			IF @InitializeTranslationTables IS NOT NULL 
			BEGIN 
				--SELECT @CleanTable  = 'TRUNCATE TABLE WRKDQOPS.dbo.TRANSLATIONS_REF' + @ViewName +';'
				SELECT @CleanTable  = 'TRUNCATE TABLE WRKDQOPS.dbo.TRANSLATIONS_REF' + @ViewName  + ' WHERE ExtractID = ''' + @ExtractID + '''' +';'
				SELECT @SQL = 'INSERT INTO WRKDQOPS.dbo.TRANSLATIONS_REF' + @ViewName + ' SELECT * FROM WRKDQOPS.dbo.JSON' + @ViewName + ' WHERE ExtractID = ''' + @ExtractID + ''''
				EXEC sp_executesql @CleanTable
				EXEC sp_executesql @SQL
			END

	END

	/*EXEC webKnowledgeTierExtract_GETAPIRESULTS_ID_Ins @ExtractID, @TableNameGETAPI*/

	FETCH NEXT FROM Cur into @TableName
END
Close Cur;
Deallocate Cur;

/*Check what it does
EXEC WRKDQOPS.dbo.API_MIG_JSON_ENFORCEMENTS_RUL_ID_INS @ExtractID
EXEC WRKDQOPS.dbo.API_MIG_JSON_DATAQUALITYJOBS_ENF_ID_INS @ExtractID
*/
END

GO
/****** Object:  StoredProcedure [dbo].[webParam_OnValidate_UsageChangeUpd]    Script Date: 2/12/2026 3:31:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[webParam_OnValidate_UsageChangeUpd] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [dbo].[webParam_OnValidate_UsageChangeUpdSel] set HorizontalView = HorizontalViewNew

	update [dbo].[webParam_OnValidate_UsageChangeArchiveUpdSel] set HorizontalView = HorizontalViewNew
END


GO
