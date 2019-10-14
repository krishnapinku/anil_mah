SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [INBOUND].[IFC_PCAL_SOURCE_DATA];
CREATE TABLE [INBOUND].[IFC_PCAL_SOURCE_DATA] (
  [Source_Data_Id] [int] IDENTITY (1, 1) NOT NULL,
  [Source_System_Transaction_Ref_id] [varchar](30) NOT NULL,
  [Project_Id] [int] NULL,
  [Tranche_Number] [int] NULL,
  [Account_Number] [int] NULL,
  [Sub_Account_Number] [int] NULL,
  [Posting_Date] [datetime] NULL,
  [Value_Date] [datetime] NULL,
  [Currency_Code] [char](10) NULL,
  [Account_Usd_Amount] [decimal](28, 12) NULL,
  [Local_Amount] [decimal](28, 12) NULL,
  [Participant_ID] [int] NULL,
  [Fee_Code] [varchar](3) NULL,
  [Share_Quantity] [decimal](28, 12) NULL,
  [Obligation_Number] [int] NULL,
  [Product_Id] [int] NULL,
  [Source_System_Name] [varchar](20) NULL,
  [Object_Id] [int] NULL,
  [Remarks] [varchar](200) NULL,
  [Created_By] [varchar](30) NULL,
  [Created_Date] [datetime] NULL
) ON [PRIMARY]
GO

-----------------------------------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [INBOUND].[IFC_SAP_REFRESH];
CREATE TABLE [INBOUND].[IFC_SAP_REFRESH] (
  Source_System_Account_Nbr int,
  Source_System_Sub_Account_Nbr int,
  Currency_Cd varchar(50),
  Fee_Code varchar(50),
  SAP_GL_Account_Nbr int,
  SAP_Account_Description varchar(100),
  Source_System_Name varchar(100),
  Created_By varchar(50),
  Created_Date datetime
) ON [PRIMARY]
GO

--------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [BEM].[IFC_Batch_Traceability];
CREATE TABLE [BEM].[IFC_Batch_Traceability] (
  [Trace_Id] [int] IDENTITY (1, 1) NOT NULL,
  [Source_System_Id] [int] NOT NULL,
  [Source_System_Transaction_Ref_Id] [varchar](50) NOT NULL,
  [BEMBatchId] [int] NULL,
  [Reversal_BEMBatchId] [int] NULL,
  [ODS_Feedback_Id] [varchar](50) NULL,
  [SAP_Feedback_Id] [varchar](50) NULL,
  [ODS_Delivery_Status] [varchar](50) NULL,
  [SAP_Delivery_Status] [varchar](50) NULL,
  [Created_By] [varchar](50) NULL,
  [Created_Date] [datetime] NULL
) ON [PRIMARY]
GO


--------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [BEM].[IFC_SuspenseAccount_Event_Data]
ADD PCAL_Reversal_Flag varchar(2);

ALTER TABLE [BEM].[IFC_SuspenseAccount_Event_Data]
ADD PCAL_ODS_Posting_Date datetime;

ALTER TABLE [BEM].[IFC_SuspenseAccount_Event_Data]
ADD PCAL_SAP_Posting_DATE datetime;

ALTER TABLE [BEM].[IFC_SuspenseAccount_Event_Data]
ADD PCAL_Target_System varchar(20);
GO

--------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [AUDIT].[IFC_SuspenseAccount_Event_Data_Audit]
ADD PCAL_Reversal_Flag varchar(2);

ALTER TABLE [AUDIT].[IFC_SuspenseAccount_Event_Data_Audit]
ADD PCAL_ODS_Posting_Date datetime;

ALTER TABLE [AUDIT].[IFC_SuspenseAccount_Event_Data_Audit]
ADD PCAL_SAP_Posting_DATE datetime;


ALTER TABLE [AUDIT].[IFC_SuspenseAccount_Event_Data_Audit]
ADD PCAL_Target_System varchar(20);
GO
--------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [BEM].[IFC_PCAL_Passthru_Workflow_Setup];
CREATE TABLE [BEM].[IFC_PCAL_Passthru_Workflow_Setup] (
  [Passthru_Id] [int] IDENTITY (1, 1) NOT NULL,
  [Source_System_Id] [int] NULL,
  [Passthru_Start_Date] [date] NULL,
  [Passthru_End_Date] [date] NULL,
  [Created_By] [varchar](20) NULL,
  [Created_Date] [datetime] NULL,
  PRIMARY KEY CLUSTERED
  (
  [Passthru_Id] ASC
  ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

--------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----DROP TABLE [BEM].[IFC_Notification_Template];
CREATE TABLE [BEM].[IFC_Notification_Template] (
  Notification_Template_Id [Int] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
  System_Id int,
  Event_Name varchar(100),
  Subject varchar(100),
  Msg_Body xml,
  Template_Status varchar(20),
  Created_By varchar(50),
  Created_Date datetime
) ON [PRIMARY]
GO

--------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----DROP TABLE [BEM].[IFC_Notification_Dist_List_Config];
CREATE TABLE [BEM].[IFC_Notification_Dist_List_Config] (
  Dl_Config_Id int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
  Notification_Template_Id int,
  Address_To varchar(100),
  Address_Cc varchar(100),
  Created_By varchar(50),
  Created_Date datetime
) ON [PRIMARY]
GO

GO
ALTER TABLE [BEM].[IFC_Notification_Dist_List_Config] WITH CHECK ADD CONSTRAINT [FK1_IFC_Notification_Dist_List_Config] FOREIGN KEY ([Notification_Template_Id])
REFERENCES [Bem].[Ifc_Notification_Template] ([Notification_Template_Id])
GO
--------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----DROP TABLE [BEM].[IFC_Notification_Event_Data];
CREATE TABLE [BEM].[IFC_Notification_Event_Data] (
  Notification_Event_Data_Id int IDENTITY (1, 1) NOT NULL PRIMARY KEY,
  Dl_Config_Id int,
  Mail_Body_Txt xml,
  Msg_Delivery_Status varchar(100),
  Mail_Read_Status varchar(10),
  Created_By varchar(50),
  Created_Date datetime
) ON [PRIMARY]
GO

GO
ALTER TABLE [BEM].[IFC_Notification_Event_Data] WITH CHECK ADD CONSTRAINT [FK1_IFC_Notification_Event_Data] FOREIGN KEY ([Dl_Config_Id])
REFERENCES [BEM].[IFC_Notification_Dist_List_Config] ([Dl_Config_Id])
GO

-------------------------------------------------------------------------



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [OUTBOUND].[IFC_SAP_AGG_BALANCE] (
  [EXEC_ID] [int] NOT NULL,
  [PROCESS_DATE] [datetime] NOT NULL,
  [GL_ACCOUNT_NBR] [int] NOT NULL,
  [SAP_ACCOUNT_NBR] [int] NOT NULL,
  [SAP_Account_Description] [varchar](100) NULL,
  [Source_System_Transaction_Ref_Id] [varchar](30) NULL,
  [CURRENCY_CODE] [varchar](3) NOT NULL,
  [POSTING_DATE] [datetime] NULL,
  [VALUE_DATE] [datetime] NULL,
  [AGG_CRNCY_AMT] [decimal](20, 4) NULL,
  [AGG_USD_AMT] [decimal](20, 4) NULL,
  [TRANS_NBR] [int] NOT NULL,
  [LEID] [int] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING ON
GO

/***ALTER TABLE [OUTBOUND].[IFC_SAP_AGG_BALANCE]  WITH CHECK ADD  CONSTRAINT [FK1_IFC_SAP_AGG_BALANCE] FOREIGN KEY([EXEC_ID])
REFERENCES [OUTBOUND].[IFC_Batch_Status] ([Exec_ID])

GO

ALTER TABLE [OUTBOUND].[IFC_SAP_AGG_BALANCE] CHECK CONSTRAINT [FK1_IFC_SAP_AGG_BALANCE]
***/
GO
----------------------------------------------