USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [BEM].[IFC_Vw_PCAL_DashboardDetail]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW BEM.IFC_Vw_PCAL_DashboardDetail

AS

/*
----------------------------------------------------------
Program Name: BEM.IFC_Vw_PCAL_DashboardDetail
Purpose: To display data for PCAL dashboard transactions
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

SELECT
DISTINCT
  header.External_System_Key src_sys_ref_id,
  sys.System_Name System_Name,
  SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1)) ProjectID,
  CASE
    WHEN udf_obl.is_obligation_tranche = 1 THEN udf_obl.underlying_tranche
    WHEN (udf_tranche.is_obligation_tranche = 0 OR
      udf_tranche.is_obligation_tranche IS NULL) THEN udf_tranche.tranche_nbr
  END TrancheID,
  udf_obl.tranche_nbr Obligation_Nbr,
  event.Issuer_Id participant_id,
  master_v.InstitutionNumber InstitutionNumber,
  master_v.IssuerName institution_legal_nme,
  header.Comments Remarks,
  CAST(data.GL_Date AS date) posting_date,
  status.Name pcal_status


FROM BEM.Business_Event_Header header
LEFT OUTER JOIN BEM.ifc_batch_traceability trace
  ON trace.Source_System_Transaction_Ref_Id = header.External_System_Key
LEFT OUTER JOIN inbound.System_Definition sys
  ON sys.System_Id = trace.Source_System_Id
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_ID
JOIN BEM.IFC_SuspenseAccount_Event_Data data
  ON data.Business_Event_Id = event.Business_Event_Id
JOIN BEM.Business_Event_Status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
JOIN bem.business_event_type type
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('PCAL Original', 'PCAL Manual')
JOIN BEM.BEM_CA_BATCH batch
  ON batch.businesseventid = header.business_event_id
JOIN BEM.BEM_CA_TRANS TRA
  ON batch.BEMBATCHID = tra.BEMBATCHID
LEFT OUTER JOIN master.deal deal
  ON deal.dealID = tra.dealID
LEFT OUTER JOIN master.Security_Master_View master_v
  ON master_v.IssuerId = event.issuer_id
LEFT OUTER JOIN master.AllPositionsAndUDFDetails_View udf_tranche
  ON udf_tranche.project_id = SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1))
  AND udf_tranche.position_id = tra.positionID
  AND udf_tranche.LE_ID = tra.LEID
  AND (udf_tranche.is_obligation_tranche = 0
  OR udf_tranche.is_obligation_tranche IS NULL)
LEFT OUTER JOIN master.AllPositionsAndUDFDetails_View udf_obl
  ON udf_obl.project_id = SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1))
  AND udf_obl.position_id = tra.positionID
  AND udf_obl.LE_ID = tra.LEID
  AND udf_obl.is_obligation_tranche = 1

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [BEM].[IFC_Vw_PCAL_DashboardHeaderMakerChecker]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW BEM.IFC_Vw_PCAL_DashboardHeaderMakerChecker

AS

/*
-------------------------------------------------------------------
Program Name: BEM.IFC_Vw_PCAL_DashboardHeaderMakerChecker
Purpose: To display data for PCAL dashboard Header for transactions
         pending with Authorizer(Maker) and Processor(Checker)
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ------------------------------------
03/08/2017  Akshay Agnihotri   Creation
-------------------------------------------------------------------
*/

SELECT
DISTINCT
  header.External_System_Key src_sys_ref_id,
  master_v.InstitutionNumber InstitutionNumber,
  master_v.IssuerName institution_legal_nme,
  sys.System_Name System_Name,
  CAST(data.GL_Date AS date) posting_date,
  CAST(data.Effective_Date AS date) value_date,
  status.Name pcal_status,
  CASE
    WHEN status.Name = 'Authorizer Read' THEN 'Already Read'
    WHEN status.Name = 'Processor Read' THEN 'Already Read'
    WHEN status.Name = 'Admin Read' THEN 'Already Read'
    ELSE 'Not Read'
  END Read_Flag
FROM BEM.Business_Event_Header header
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_Id
JOIN BEM.IFC_SuspenseAccount_Event_data data
  ON data.Business_Event_Id = event.Business_Event_Id
JOIN BEM.Business_Event_Status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
LEFT OUTER JOIN BEM.ifc_batch_traceability trace
  ON trace.Source_System_Transaction_Ref_Id = header.External_System_Key
LEFT OUTER JOIN inbound.System_Definition sys
  ON sys.System_Id = trace.Source_System_Id
LEFT OUTER JOIN master.Security_Master_View master_v
  ON master_v.IssuerId = event.issuer_id
JOIN bem.business_event_type type
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('PCAL Original', 'PCAL Manual')

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [BEM].[IFC_Vw_PCAL_DashboardHeaderProcessedPosted]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW BEM.IFC_Vw_PCAL_DashboardHeaderProcessedPosted

AS

/*
-------------------------------------------------------------------
Program Name: BEM.IFC_Vw_PCAL_DashboardHeaderProcessedPosted
Purpose: To display data for PCAL dashboard Header for transactions
         which are either Processed or Posted
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ------------------------------------
03/08/2017  Akshay Agnihotri   Creation
-------------------------------------------------------------------
*/

SELECT DISTINCT


  header.External_System_Key src_sys_ref_id,
  master_v.InstitutionNumber InstitutionNumber,
  master_v.IssuerName institution_legal_nme,
  sys.System_Name System_Name,
  CAST(data.GL_Date AS date) posting_date,
  CAST(data.Effective_Date AS date) value_date,
  CAST(data.PCAL_ODS_POSTING_DATE AS date) ODS_Posting_Date,
  CAST(data.PCAL_SAP_POSTING_DATE AS date) sap_Posting_Date,
  data.created_by authorized_by,
  data.changed_by processed_by,
  status.Name pcal_status,
  CASE
    WHEN status.Name = 'Authorizer Read' THEN 'Already Read'
    WHEN status.Name = 'Processor Read' THEN 'Already Read'
    WHEN status.Name = 'Admin Read' THEN 'Already Read'
    ELSE 'Not Read'
  END Read_Flag
FROM BEM.Business_Event_Header header
JOIN BEM.Business_Event_Status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_Id
JOIN BEM.IFC_SuspenseAccount_Event_Data data
  ON data.Business_Event_Id = event.Business_Event_Id
LEFT OUTER JOIN master.Security_Master_View master_v
  ON master_v.IssuerId = event.issuer_id
JOIN bem.business_event_type type
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('PCAL Original', 'PCAL Manual')
LEFT OUTER JOIN BEM.ifc_batch_traceability trace
  ON trace.Source_System_Transaction_Ref_Id = header.External_System_Key
LEFT OUTER JOIN inbound.System_Definition sys
  ON sys.System_Id = trace.Source_System_Id

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [BEM].[IFC_Vw_PCAL_DetailDetails]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW BEM.IFC_Vw_PCAL_DetailDetails
AS

/*
----------------------------------------------------------
Program Name: BEM.IFC_Vw_PCAL_DetailDetails
Purpose: To get data for PCAL detail Screen
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/


SELECT DISTINCT

  header.External_System_Key src_sys_ref_id,
  SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1)) Project_ID,
  CASE
    WHEN udf_obl.is_obligation_tranche = 1 THEN udf_obl.underlying_tranche
    WHEN (udf_tranche.is_obligation_tranche = 0 OR
      udf_tranche.is_obligation_tranche IS NULL) THEN udf_tranche.tranche_nbr
  END Tranche_ID,--
  udf_obl.tranche_nbr Obligation_Nbr,
  event.issuer_id participant_id,
  curr.CurrencyISO Currency_Code,
  cax.code source_system_account,
  CAST(data.GL_Date AS date) posting_date,
  CAST(data.Effective_Date AS date) value_date,
  refr.SAP_Account_Nbr SAP_GL_Account_Nbr,
  refr.SAP_Account_Description,
  CASE
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 1 THEN 'Asset'
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 2 THEN 'Liability'
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 4 THEN 'Income Statement'
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 8 THEN 'Memo'
    ELSE 'No Mapping'
  END AS Fin_Statement_Class,
  sub_type.name adjustment_sub_type,
  tra.Quantity share_Qty,
  adden.code feecode,
  tra.Amount,
  tra.LeAmount usd_amount,
  status.name pcal_status,
  CASE
    WHEN status.name IN ('Posted to Both', 'Posted to SAP Only') THEN 'Posted'
    ELSE 'Not Posted'
  END sap_gl_posting,
  CASE
    WHEN status.name IN ('Posted to Both', 'Posted to ODS Only') THEN 'Posted'
    ELSE 'Not Posted'
  END ods_posting_status
FROM BEM.Business_Event_Header header
JOIN bem.business_event_type type
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('PCAL Original', 'PCAL Manual')
JOIN bem.business_event_status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_Id
JOIN BEM.IFC_SuspenseAccount_Event_Data data
  ON data.Business_Event_Id = event.Business_Event_Id
JOIN BEM.BEM_CA_BATCH batch
  ON batch.businesseventid = header.business_event_id
JOIN BEM.BEM_CA_TRANS TRA
  ON batch.BEMBATCHID = tra.BEMBATCHID
LEFT OUTER JOIN master.deal deal
  ON deal.dealID = tra.dealID
JOIN master.currency curr
  ON curr.currencyId = tra.currencyId
LEFT OUTER JOIN master.CAX_Account cax
  ON cax.accountid = tra.accountid
LEFT OUTER JOIN master.AllPositionsAndUDFDetails_View udf_tranche
  ON udf_tranche.project_id = SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1))
  AND udf_tranche.position_id = tra.positionID
  AND udf_tranche.LE_ID = tra.LEID
  AND (udf_tranche.is_obligation_tranche = 0
  OR udf_tranche.is_obligation_tranche IS NULL)
LEFT OUTER JOIN master.AllPositionsAndUDFDetails_View udf_obl
  ON udf_obl.project_id = SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1))
  AND udf_obl.position_id = tra.positionID
  AND udf_obl.LE_ID = tra.LEID
  AND udf_obl.is_obligation_tranche = 1
LEFT OUTER JOIN bem.business_event_sub_type sub_type
  ON sub_type.business_event_sub_type_id = tra.LotID
LEFT OUTER JOIN bem.IFC_Business_Event_Addendum_Sub_Type adden
  ON adden.IFC_Business_Event_Addendum_Sub_Type_Id = event.misc_expenses_type_id
LEFT OUTER JOIN outbound.ifc_sap_agg_balance refr
  ON CONVERT(nvarchar(50), REFR.GL_Account_Nbr) = cax.code
  AND refr.Source_System_Transaction_Ref_Id = header.External_System_Key
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [BEM].[IFC_Vw_PCAL_DetailHeader]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW BEM.IFC_Vw_PCAL_DetailHeader
AS

/*
----------------------------------------------------------
Program Name: BEM.IFC_Vw_PCAL_DetailHeader
Purpose: To get data for PCAL detail Screen
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/


SELECT DISTINCT
  header.External_System_Key src_sys_ref_id,
  sys.System_Name System_Name,
  CAST(data.GL_Date AS date) posting_date,
  CAST(data.Effective_Date AS date) value_date,
  data.Created_By authorized_by,
  data.Changed_By processed_by,
  type.name adjustment_type,
  CAST(data.PCAL_ODS_POSTING_DATE AS date) ODS_Posting_Date,
  CAST(data.PCAL_SAP_POSTING_DATE AS date) sap_Posting_Date,
  trace.SAP_Delivery_Status SAP_Acknowledgement_Status,
  trace.ODS_Delivery_Status ODS_Acknowledgement_Status,
  CAST(data.GL_Date AS date) ODS_Reversal_Date,
  CAST(data.GL_Date AS date) SAP_Reversal_Date,
  CASE
    WHEN status.Name = 'Authorizer Read' THEN 'Already Read'
    WHEN status.Name = 'Processor Read' THEN 'Already Read'
    WHEN status.Name = 'Admin Read' THEN 'Already Read'
    ELSE 'Not Read'
  END Read_Flag,
  DATA.PCAL_Reversal_Flag,
  Comments Remarks,
  status.Name pcal_status,
  status.business_event_status_id
FROM BEM.Business_Event_Header header
LEFT OUTER JOIN BEM.ifc_batch_traceability trace
  ON trace.Source_System_Transaction_Ref_Id = header.External_System_Key
LEFT OUTER JOIN inbound.System_Definition sys
  ON sys.System_Id = trace.Source_System_Id
JOIN bem.business_event_type type
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('PCAL Original', 'PCAL Manual')
JOIN bem.business_event_status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_Id
JOIN BEM.IFC_SuspenseAccount_Event_Data data
  ON data.Business_Event_Id = event.Business_Event_Id
LEFT OUTER JOIN outbound.ifc_inv_ledger_activity led
  ON led.trans_nbr = event.trade_batch_id

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [BEM].[IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
AS

/*
----------------------------------------------------------
Program Name: BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
Purpose: To get data for PCAL report and advance search
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

SELECT DISTINCT
  header.External_System_Key source_system_transaction_id,
  sys.System_Name Source_System_Name,
  master_v.InstitutionNumber Company_Code,
  master_v.IssuerName Company_Name,
  SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1)) Project_ID,
  CASE
    WHEN udf_obl.is_obligation_tranche = 1 THEN udf_obl.underlying_tranche
    WHEN (udf_tranche.is_obligation_tranche = 0 OR
      udf_tranche.is_obligation_tranche IS NULL) THEN udf_tranche.tranche_nbr
  END Tranche_ID,
  udf_obl.tranche_nbr Obligation_Nbr,
  event.issuer_id Participant_id,
  master_v.IssuerName Participant_name,
  sub.code fee_code,
  sub.name fee_type,
  cax.code source_system_account,
  NULL source_system_sub_account,
  cax.description source_system_account_description,
  refr.SAP_Account_Nbr SAP_GL_Account_Nbr,
  refr.SAP_Account_Description SAP_Account_Description,
  CASE
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 1 THEN 'Asset'
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 2 THEN 'Liability'
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 4 THEN 'Income Statement'
    WHEN SUBSTRING(CAST(refr.SAP_Account_Nbr AS varchar), 1, 1) = 8 THEN 'Memo'
    ELSE 'No Mapping'
  END
  AS Fin_Statement_Class,
  curr.CurrencyISO Currency_Code,
  tra.Amount,
  tra.LeAmount usd_amount,
  tra.quantity Share_Qty,

  CAST(data.GL_Date AS date) Posting_Date,
  CAST(data.Effective_Date AS date) Value_Date,
  CAST(data.PCAL_ODS_POSTING_DATE AS date) ODS_Posting_Date,
  CAST(data.GL_Date AS date) ODS_Reversal_Date,
  CAST(data.PCAL_SAP_POSTING_DATE AS date) sap_Posting_Date,
  CAST(data.GL_Date AS date) SAP_Reversal_Date,
  trace.SAP_Feedback_Id Document_Number,
  trace.BEMBatchId voucher_nbr,
  CASE
    WHEN status.name = 'New' THEN 'Pending for Authorizing'
    WHEN status.name = 'Reviewed' THEN 'Pending for Processing'
    WHEN status.name = 'Completed' THEN 'Processed'
    ELSE status.name
  END AS pcal_status,
  trace.SAP_Delivery_Status SAP_Acknowledgement_Status,
  trace.ODS_Delivery_Status ODS_Acknowledgement_Status,

  sub_type.name Adjustment_Type,
  data.created_by authorized_by,
  CAST(data.created_date AS date) AS created_date,
  data.changed_by processed_by,
  header.Comments Remarks

FROM BEM.Business_Event_Header header
JOIN BEM.Business_Event_Type TYPE
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('PCAL Original', 'PCAL Manual')
JOIN BEM.Business_Event_Status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_Id
JOIN BEM.IFC_SuspenseAccount_Event_Data data
  ON data.Business_Event_Id = event.Business_Event_Id
JOIN BEM.BEM_CA_BATCH batch
  ON batch.businesseventid = header.business_event_id
JOIN BEM.BEM_CA_TRANS TRA
  ON batch.BEMBATCHID = tra.BEMBATCHID
LEFT OUTER JOIN dbo.deal_TS deal
  ON deal.dealID = tra.dealID
LEFT OUTER JOIN BEM.ifc_batch_traceability trace
  ON trace.Source_System_Transaction_Ref_Id = header.External_System_Key
--AND batch.BEMBATCHID = trace.BEMBatchId
LEFT OUTER JOIN inbound.System_Definition sys
  ON sys.System_Id = trace.Source_System_Id
JOIN dbo.x_currency curr
  ON curr.CurrencyID = tra.currencyid
LEFT OUTER JOIN BEM.AllPositionsAndUDFDetails_View udf_tranche
  ON udf_tranche.project_id = SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1))
  AND udf_tranche.position_id = tra.positionID
  AND udf_tranche.LE_ID = tra.LEID
  AND (udf_tranche.is_obligation_tranche = 0
  OR udf_tranche.is_obligation_tranche IS NULL)
LEFT OUTER JOIN BEM.AllPositionsAndUDFDetails_View udf_obl
  ON udf_obl.project_id = SUBSTRING(deal.dealName, 0, CHARINDEX('-', deal.dealName, 1))
  AND udf_obl.position_id = tra.positionID
  AND udf_obl.LE_ID = tra.LEID
  AND udf_obl.is_obligation_tranche = 1
LEFT OUTER JOIN bem.business_event_sub_type sub_type
  ON sub_type.business_event_sub_type_id = tra.LotID
LEFT OUTER JOIN BEM.IFC_Business_Event_Addendum_Sub_Type sub
  ON sub.IFC_Business_Event_Addendum_Sub_Type_Id = tra.transid
LEFT OUTER JOIN bem.security_master_view master_v
  ON master_v.IssuerId = event.issuer_id
LEFT OUTER JOIN dbo.CAX_Account cax
  ON cax.accountid = tra.accountid
LEFT OUTER JOIN outbound.ifc_inv_ledger_activity led
  ON led.trans_nbr = event.trade_batch_id
LEFT OUTER JOIN outbound.ifc_sap_agg_balance refr
  ON CONVERT(nvarchar(50), REFR.GL_Account_Nbr) = cax.code
  AND refr.Source_System_Transaction_Ref_Id = header.External_System_Key
LEFT OUTER JOIN OUTBOUND.IFC_BATCH_STATUS BAT
  ON BAT.EXEC_ID = LED.EXEC_ID

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  View INBOUND.IFC_Vw_PCAL_Adjustment_wfw   Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [INBOUND].[IFC_Vw_PCAL_Adjustment_wfw]

AS

SELECT
  [Source_Data_Id],

  [Source_System_Transaction_Ref_id],

  [Getpush_Id],

  [Project_Id],

  [Tranche_Number],

  (SELECT
    accountid
  FROM master.cax_account
  WHERE Code = Account_number)
  AS [Account_Number],

  [Sub_Account_Number],

  [Posting_Date],

  [Value_Date],

  (SELECT TOP 1
    currencyid
  FROM master.currency
  WHERE currencyISO = [Currency_Code]
  AND currencyid IS NOT NULL
  AND currencyISO IS NOT NULL)
  AS Currency_Id,

  [Account_Usd_Amount],

  [Local_Amount],

  [Participant_ID],

  (SELECT
    [IFC_Business_Event_Addendum_Sub_Type_Id]
  FROM [BEM].[IFC_Business_Event_Addendum_Sub_Type]
  WHERE CODE = [Fee_Code])
  AS [Fee_Code],

  [Share_Quantity],

  [Obligation_Number],

  [Product_Id],

  (SELECT
    system_id
  FROM inbound.system_definition
  WHERE system_name = [Source_System_Name])
  Source_System_Id,

  [Object_Id],

  [Remarks]

FROM [INBOUND].[IFC_PCAL_SOURCE_DATA]
GO


USE [EQUITY7PCAL_STG]
GO

/****** Object:  View [INBOUND].[IFC_Vw_PassThru_wfw]    Script Date: 9/11/2017 2:51:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [INBOUND].[IFC_Vw_PassThru_wfw]

AS

SELECT
  [Source_Data_Id],

  [Source_System_Transaction_Ref_id],

  [Getpush_Id],

  [Project_Id],

  [Tranche_Number],

  [Account_Number],

  [Sub_Account_Number],

  [Posting_Date],

  [Value_Date],

  Currency_Id,

  [Account_Usd_Amount],

  [Local_Amount],

  [Participant_ID],

  [Fee_Code],

  [Share_Quantity],

  [Obligation_Number],

  [Product_Id],

  [Source_System_Id],

  [Object_Id],

  [Remarks]

FROM [INBOUND].[IFC_Vw_PCAL_Adjustment_wfw]

WHERE (DATEPART(QUARTER, Posting_Date) <> DATEPART(QUARTER, Value_Date)
OR YEAR(Posting_Date) <> YEAR(Value_Date))
GO