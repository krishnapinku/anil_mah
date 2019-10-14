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

SELECT 
  header.External_System_Key source_system_transaction_id,
  CASE
    WHEN header.cash_voucher_number = 'Invest' THEN 'EQUITY-INVESTRAN'
    WHEN header.cash_voucher_number = 'ASL' THEN 'ASL-INVESTRAN'
    ELSE header.cash_voucher_number
  END Source_System_Name,
  master_v.InstitutionNumber Company_Code,--,
  master_v.IssuerName Company_Name,
  tra.dealID Project_ID,-- 
  tra.positionID Tranche_ID,--
  tra.poolID Obligation_Nbr,--
  event.issuer_id Participant_id,
  master_v.IssuerName Participant_name,
  sub.code fee_code,
  sub.name fee_type,
  cax.code source_system_account,
 REFR.GL_Sub_Account_Nbr source_system_sub_account,-- src.Sub_Account_Number source_system_sub_account,
  cax.description source_system_account_description,--,
  refr.SAP_GL_Account_Nbr SAP_GL_Account_Nbr,--,
  refr.SAP_Account_Description SAP_Account_Description,--,
  CASE
    WHEN SUBSTRING(CAST(refr.SAP_GL_Account_Nbr AS varchar), 1, 1) = 1 THEN 'Asset'
    WHEN SUBSTRING(CAST(refr.SAP_GL_Account_Nbr AS varchar), 1, 1) = 2 THEN 'Liability'
    WHEN SUBSTRING(CAST(refr.SAP_GL_Account_Nbr AS varchar), 1, 1) = 4 THEN 'Income Statement'
    WHEN SUBSTRING(CAST(refr.SAP_GL_Account_Nbr AS varchar), 1, 1) = 8 THEN 'Memo'
    ELSE 'No Mapping'
  END
  AS Fin_Statement_Class,
  curr.CurrencyISO Currency_Code,
  tra.Amount,
  tra.LeAmount usd_amount,
  tra.quantity Share_Qty,

  CAST(data.GL_Date AS DATE) Posting_Date,
  CAST(data.Effective_Date AS DATE) Value_Date,
  CAST(data.PCAL_ODS_POSTING_DATE AS DATE) ODS_Posting_Date,--BAT.Rollup_Date
  CAST(data.GL_Date AS DATE) ODS_Reversal_Date,--BAT.reversal_Date
  CAST(data.PCAL_SAP_POSTING_DATE AS DATE) sap_Posting_Date,--BAT.SAP_Rollup_Date
  CAST(data.GL_Date AS DATE) SAP_Reversal_Date,-- BAT.SAP_Reversal_Date
  NULL Document_Type,--BAT.Document_Type
  BAT.SAP_Document_Number Document_Number, --,
  BAT.BATCH_SYS_ID voucher_nbr,-- ,
  CASE
    WHEN status.name = 'New' THEN 'Pending for Authorizing'
    WHEN status.name = 'Reviewed' THEN 'Pending for Processing'
    WHEN status.name = 'Completed' THEN 'Processed'
    ELSE status.name
  END AS pcal_status,
  BAT.SAP_Acknowledgement_Status SAP_Acknowledgement_Status,--BAT.SAP_Acknowledgement_Status,
  BAT.ODS_Acknowledgement_Status ODS_Acknowledgement_Status,--BAT.ODS_Acknowledgement_Status,

  sub_type.name Adjustment_Type,-- type.Adjustment_sub_Type
  data.created_by authorized_by,
  CAST(data.created_date AS DATE) as created_date,
  data.changed_by processed_by,

  header.Comments Remarks

FROM BEM.Business_Event_Header header
JOIN BEM.Business_Event_Type TYPE
  ON type.business_event_type_id = header.business_event_type_id
  AND type.name IN ('Adjustment', 'Manual')
JOIN BEM.Business_Event_Status status
  ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
JOIN BEM.IFC_SuspenseAccount_Event event
  ON event.Business_Event_Id = header.Business_Event_Id
JOIN BEM.IFC_SuspenseAccount_Event_Data data
  ON data.Business_Event_Id = event.Business_Event_Id
JOIN BEM.CA_TRANS TRA
  ON TRA.BEMTRANSID = data.IFC_SuspenseAccount_Event_Data_Id
JOIN dbo.x_currency curr
  ON curr.CurrencyID = tra.currencyid
/*LEFT OUTER JOIN BEM.AllPositionsAndUDFDetails_View udf_tranche
  ON udf_tranche.project_id = tra.dealid
  AND udf_tranche.tranche_nbr = tra.positionID
AND udf_tranche.LE_ID=tra.LEID
  AND (udf_tranche.is_obligation_tranche = 0	or udf_tranche.is_obligation_tranche is null)
LEFT OUTER JOIN BEM.AllPositionsAndUDFDetails_View udf_obl
  ON udf_obl.project_id = tra.dealid
  AND udf_obl.tranche_nbr = tra.positionID
AND udf_obl.LE_ID=tra.LEID
  AND udf_obl.is_obligation_tranche = 1  */
JOIN bem.business_event_sub_type sub_type
  ON sub_type.business_event_sub_type_id = tra.LotID
LEFT OUTER JOIN BEM.IFC_Business_Event_Addendum_Sub_Type sub
  ON sub.IFC_Business_Event_Addendum_Sub_Type_Id = event.misc_expenses_type_id
LEFT OUTER JOIN bem.security_master_view master_v
  ON master_v.IssuerId = event.issuer_id
LEFT OUTER JOIN dbo.CAX_Account cax
  ON cax.accountid = tra.accountid
LEFT OUTER JOIN outbound.ifc_inv_ledger_activity led
  ON led.trans_nbr = event.trade_batch_id
LEFT OUTER JOIN INBOUND.ifc_sap_refresh refr
  ON convert(nvarchar(50),REFR.GL_Account_Nbr)+convert(nvarchar(50),REFR.GL_Sub_Account_Nbr) = cax.code
LEFT OUTER JOIN OUTBOUND.IFC_BATCH_STATUS BAT
  ON BAT.EXEC_ID = LED.EXEC_ID