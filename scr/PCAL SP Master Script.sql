USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_AdvancedSearchGetAllBasedOnSearchCriteria]    Script Date: 9/26/2017 6:54:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_AdvancedSearchGetAllBasedOnSearchCriteria (@i_src_sys_id varchar(50), @i_src_sys_name varchar(10), @i_cmpny_num int, @i_cmpny_name varchar(100), @i_prj_id int, @i_tranche int, @i_obl_num int, @i_part_id int, @i_part_name varchar(100), @i_fee_code varchar(10), @i_fee_type varchar(50), @i_src_sys_accnt int, @i_src_sub_accnt int, @i_src_sys_desc varchar(50), @i_sap_accnt int, @i_sap_accnt_desc varchar(50), @i_fin_state varchar(10), @i_crrncy_code varchar(10), @i_crrncy_amt decimal, @i_usd_amt decimal, @i_share_qty decimal, @i_post_date datetime, @i_value_date datetime, @i_auth_by varchar(50), @i_proc_by varchar(50))
AS

  /*
  ----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_AdvancedSearchGetAllBasedOnSearchCriteria 
  Purpose: To display data for PCAL Advance Search 
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------
  */


  SELECT distinct
    source_system_transaction_id,
    Source_System_Name,
    Company_Name,
    Company_Code,
    Project_ID,
    Tranche_ID,
    Obligation_Nbr,
    Participant_id,
    Participant_name,
    fee_code,
    fee_type,
    source_system_account,
    source_system_sub_account,
    source_system_account_description,
    SAP_GL_Account_Nbr,
    SAP_Account_Description,
    Fin_Statement_Class,
    Currency_code,
    Amount,
    usd_amount,
    Share_Qty,

    Posting_Date,
    Value_Date,
    ODS_Posting_Date,
    ODS_Reversal_Date,
    sap_Posting_Date,
    SAP_Reversal_Date,
    Document_Number,
    convert(nvarchar(50),Document_Number)+ '_rev'  Reversal_Document_Nbr,
    Voucher_Nbr,
    convert(nvarchar(50),Voucher_Nbr)+ '_rev' Reversal_Voucher_Nbr,
    PCAL_Status,
    SAP_Acknowledgement_Status,
    ODS_Acknowledgement_Status,

    Adjustment_Type,

    authorized_by,
    processed_by,

    Remarks


  FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
  WHERE ISNULL(source_system_transaction_id,0) = ISNULL(@i_src_sys_id, ISNULL(source_system_transaction_id,0))
  AND isnull(Source_System_Name,0) = ISNULL(@i_src_sys_name, isnull(Source_System_Name,0))
  AND isnull(Company_Name,0) = ISNULL(@i_cmpny_name, isnull(Company_Name,0))
  AND isnull(Company_Code,0) = ISNULL(@i_cmpny_num, isnull(Company_Code,0))
  AND isnull(Project_ID,0) = ISNULL(@i_prj_id, isnull(Project_ID,0))
  AND isnull(Tranche_ID,0) = ISNULL(@i_tranche, isnull(Tranche_ID,0))
  AND isnull(obligation_nbr,0) = ISNULL(@i_obl_num, isnull(obligation_nbr,0))
  AND isnull(fee_code,0) = ISNULL(@i_fee_code, isnull(fee_code,0))
  AND isnull(Participant_id,0) = ISNULL(@i_part_id, isnull(Participant_id,0))
  AND isnull(participant_name,0) = ISNULL(@i_part_name, isnull(participant_name,0))
  AND isnull(fee_type,0) = ISNULL(@i_fee_type, isnull(fee_type,0))
  AND isnull(source_system_account,0) = ISNULL(@i_src_sys_accnt, isnull(source_system_account,0))
  AND isnull(source_system_sub_account,0) = ISNULL(@i_src_sub_accnt, isnull(source_system_sub_account,0))
  AND isnull(source_system_account_description,0) = ISNULL(@i_src_sys_desc, isnull(source_system_account_description,0))
  AND isnull(SAP_GL_Account_Nbr,0) = ISNULL(@i_sap_accnt, isnull(SAP_GL_Account_Nbr,0))
  AND isnull(SAP_Account_Description,0) = ISNULL(@i_sap_accnt_desc, isnull(SAP_Account_Description,0))
  AND isnull(Fin_Statement_Class,0) = ISNULL(@i_fin_state, isnull(Fin_Statement_Class,0))
  AND isnull(Currency_code,0) = ISNULL(@i_crrncy_code, isnull(Currency_code,0))
  AND isnull(Amount,0) = ISNULL(@i_crrncy_amt, isnull(Amount,0))
  AND isnull(usd_amount,0) = ISNULL(@i_usd_amt, isnull(usd_amount,0))
  AND isnull(Share_Qty,0) = ISNULL(@i_share_qty, isnull(Share_Qty,0))
  AND isnull(Posting_Date,'01-01-1900') = ISNULL(@i_post_date, isnull(Posting_Date,'01-01-1900'))
  AND isnull(Value_Date,'01-01-1900') = ISNULL(@i_value_date, isnull(Value_Date,'01-01-1900'))
  AND isnull(authorized_by,0) = ISNULL(@i_auth_by, isnull(authorized_by,0))
  AND isnull(processed_by,0) = ISNULL(@i_proc_by, isnull(processed_by,0))

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_AdvancedSearchGetAllInputs]    Script Date: 9/26/2017 6:56:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_AdvancedSearchGetAllInputs] (@i_id int)
AS

/*
----------------------------------------------------------------
Program Name: BEM.PCAL_spIFC_AdvancedSearchGetAllInputs
Purpose: To display the input lookup data for all PCAL Advanced
         Search Screen fields  
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------------
*/

BEGIN

  IF @i_id = 1

  BEGIN
    SELECT DISTINCT
      source_system_transaction_id
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 2

  BEGIN

    SELECT DISTINCT
      Source_System_Name
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END


  IF @i_id = 3

  BEGIN
    SELECT DISTINCT
      Company_Code
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 4

  BEGIN
    SELECT DISTINCT
      Company_Name
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 5

  BEGIN
    SELECT DISTINCT
      Project_ID
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;

  END

  IF @i_id = 6

  BEGIN
    SELECT DISTINCT
      Tranche_ID
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 7

  BEGIN
    SELECT DISTINCT
      Obligation_Nbr
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 8

  BEGIN
    SELECT DISTINCT
      Participant_id
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 9

  BEGIN
    SELECT DISTINCT
      Participant_name
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 10

  BEGIN
    SELECT DISTINCT
      fee_code
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 11

  BEGIN
    SELECT DISTINCT
      fee_type
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END


  IF @i_id = 12

  BEGIN
    SELECT DISTINCT
      source_system_account
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 13

  BEGIN

    SELECT DISTINCT
      source_system_sub_account
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 14

  BEGIN
    SELECT DISTINCT
      source_system_account_description
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 15

  BEGIN
    SELECT DISTINCT
      SAP_GL_Account_Nbr
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 16

  BEGIN
    SELECT DISTINCT
      SAP_Account_Description
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 17

  BEGIN
    SELECT DISTINCT
      Fin_Statement_Class
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 18

  BEGIN
    SELECT DISTINCT
      Currency_Code
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 19

  BEGIN
    SELECT DISTINCT
      Amount
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 20

  BEGIN
    SELECT DISTINCT
      usd_amount
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 21

  BEGIN
    SELECT DISTINCT
      Share_Qty
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 22

  BEGIN
    SELECT DISTINCT
      posting_date
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 23

  BEGIN
    SELECT DISTINCT
      Value_Date
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 24

  BEGIN
    SELECT DISTINCT
      pcal_status
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 25

  BEGIN
    SELECT DISTINCT
      authorized_by
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END

  IF @i_id = 26

  BEGIN
    SELECT DISTINCT
      processed_by
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;
  END


  IF @i_id = 27

  BEGIN
    SELECT DISTINCT
      created_date
    FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll;

  END

END
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_BusinessEventHeaderUpdateStatus]    Script Date: 9/26/2017 6:57:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_BusinessEventHeaderUpdateStatus] (@i_BusinessEventStatusId int,

@i_ChangedBy varchar(128),

@i_Id int)

AS

BEGIN



  -- Update the status

  UPDATE BEM.Business_Event_Header

  SET Business_Event_Status_Id = @i_BusinessEventStatusId,

      Changed_By = @i_ChangedBy,

      Changed_Date = GETDATE()

  WHERE Business_Event_Id = @i_Id

END

  IF @@error <> 0

  BEGIN

    RAISERROR ('Error executing [BEM].[PCAL_sp_Business_Event_Status_Update]', 16, 3)

    RETURN (@@ERROR)

  END

  RETURN (0)
GO


USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_CheckPassThru]    Script Date: 9/26/2017 6:58:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_CheckPassThru
AS

/*
----------------------------------------------------------
Program Name: BEM.PCAL_spIFC_CheckPassThru
Purpose: To Check Pass Thru and update status of records
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

BEGIN

  DECLARE @l_pass_thru date,
          @l_pass_thru_count int,
          @l_post_date date,
          @l_trans_id varchar(50),
          @l_err_mssg varchar(1000),
          @l_err_no int,
          @l_last_day date,
          @l_mssg varchar(500),
          @l_status_id int,
          @l_bus_eve_id int;



  --Get the latest pass thru date for the current quarter and year      

  SELECT
    @l_pass_thru_count = COUNT(Passthru_End_Date)
  FROM bem.ifc_pcal_passthru_workflow_setup
  WHERE CAST(DATEPART(QUARTER, Passthru_End_Date) AS int) = DATEPART(QUARTER, GETDATE())
  AND CAST(YEAR(Passthru_End_Date) AS int) = DATEPART(YEAR, GETDATE())


  --Check in case of Manual Change in Pass Thru

  IF @l_pass_thru_count >= 2

  BEGIN

    DECLARE l_pass_thru2_cur CURSOR FOR
    SELECT DISTINCT
      data.gl_date,
      header.external_system_key
    FROM BEM.Business_Event_Header header
    JOIN bem.business_event_type type
      ON type.business_event_type_id = header.business_event_type_id
      AND type.name IN ('PCAL Original', 'PCAL Manual')
    JOIN BEM.Business_Event_Status status
      ON status.business_event_status_id = header.business_event_status_id
    JOIN BEM.IFC_SuspenseAccount_Event event
      ON event.Business_Event_Id = header.Business_Event_Id
    JOIN BEM.IFC_SuspenseAccount_Event_data data
      ON data.Business_Event_Id = event.Business_Event_Id
    JOIN BEM.CA_TRANS TRA
      ON TRA.BEMTRANSID = data.IFC_SuspenseAccount_Event_Data_Id
    JOIN bem.business_event_sub_type sub_type
      ON sub_type.business_event_sub_type_id = tra.LotID
    WHERE status.name IN ('New')
    AND sub_type.name IN ('PCAL Month End', 'PCAL Share')
    AND (CAST(DATEPART(QUARTER, data.gl_date) AS int) <> CAST(DATEPART(QUARTER, data.effective_date) AS int)
    OR CAST(YEAR(data.gl_date) AS int) <> CAST(YEAR(data.effective_date) AS int))
    ;
  END
  ELSE
  BEGIN


    DECLARE l_pass_thru2_cur CURSOR FOR
    SELECT DISTINCT
      data.gl_date,
      header.external_system_key
    FROM BEM.Business_Event_Header header
    JOIN bem.business_event_type type
      ON type.business_event_type_id = header.business_event_type_id
      AND type.name IN ('PCAL Original', 'PCAL Manual')
    JOIN BEM.Business_Event_Status status
      ON status.business_event_status_id = header.business_event_status_id
    JOIN BEM.IFC_SuspenseAccount_Event event
      ON event.Business_Event_Id = header.Business_Event_Id
    JOIN BEM.IFC_SuspenseAccount_Event_data data
      ON data.Business_Event_Id = event.Business_Event_Id
    JOIN BEM.CA_TRANS TRA
      ON TRA.BEMTRANSID = data.IFC_SuspenseAccount_Event_Data_Id
    JOIN bem.business_event_sub_type sub_type
      ON sub_type.business_event_sub_type_id = tra.LotID
    WHERE status.name = 'New'
    AND sub_type.name IN ('PCAL Month End', 'PCAL Share')
    AND (CAST(DATEPART(QUARTER, data.gl_date) AS int) <> CAST(DATEPART(QUARTER, data.effective_date) AS int)
    OR CAST(YEAR(data.gl_date) AS int) <> CAST(YEAR(data.effective_date) AS int))

    ;
  END

  OPEN l_pass_thru2_cur;
  FETCH NEXT FROM l_pass_thru2_cur INTO @l_post_date, @l_trans_id;

  SELECT
    @l_pass_thru = MAX(Passthru_End_Date)
  FROM bem.ifc_pcal_passthru_workflow_setup
  WHERE CAST(DATEPART(QUARTER, Passthru_End_Date) AS int) = DATEPART(QUARTER, GETDATE())
  AND CAST(YEAR(Passthru_End_Date) AS int) = DATEPART(YEAR, GETDATE())


  WHILE @@FETCH_STATUS = 0
  BEGIN

    IF @l_post_date <= @l_pass_thru
    BEGIN
    BEGIN TRY

      --Change status to auto submit

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Auto Processed';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id--'Auto Process' 
      WHERE External_System_Key = @l_trans_id;

      SELECT
        @l_bus_eve_id = business_event_id
      FROM BEM.Business_Event_Header
      WHERE External_System_Key = @l_trans_id;

      UPDATE BEM.ifc_suspenseaccount_event_data
      SET pcal_target_system = 'Both'--'Post to both ODS and SAP'
      WHERE business_event_id = @l_bus_eve_id;

    --PRINT 'Pass Through Transaction: Auto Process';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                     @description = 'SMTP Account.',
                                     @email_address = 'jojin127@gmail.com',
                                     @display_name = 'Mail Account',
                                     @mailserver_name = 'smtp.gmail.com';*/

    END TRY
    BEGIN CATCH

      --Change status in case of update error

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Error';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id--'Error' --in Auto Submitted,
      WHERE External_System_Key = @l_trans_id;

      --Creating error log for the current transaction

      SET @l_err_mssg = 'PCAL ' + ERROR_MESSAGE();

      SET @l_err_no = ERROR_NUMBER();

      SET @l_mssg = @l_trans_id;

      EXEC LOG.LOG_spProcessLogInsert @l_mssg,
                                      'Error:Auto Posting',
                                      @l_err_mssg,
                                      @l_err_no;

    --PRINT 'Pass Through Transaction: Error in Auto Posting';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

    END CATCH;
    END
    ELSE
    BEGIN

    BEGIN TRY

      --Change status for manual processing

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'New';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id --'New' --Available for Authorize
      WHERE External_System_Key = @l_trans_id;

    --PRINT 'Manual Authorization Required for the Transaction';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

    END TRY
    BEGIN CATCH

      --Change status in case of update error 

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Error';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id --'Error' -- in Manual Authorization
      WHERE External_System_Key = @l_trans_id;

      --Creating error log for the current transaction

      SET @l_err_mssg = 'PCAL ' + ERROR_MESSAGE();

      SET @l_err_no = ERROR_NUMBER();

      SET @l_mssg = @l_trans_id;

      EXEC LOG.LOG_spProcessLogInsert @l_mssg,
                                      'Error:Manual Authorize',
                                      @l_err_mssg,
                                      @l_err_no;


    --PRINT 'Pass Through Transaction: Error in Auto Posting';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

    END CATCH;
    END

    FETCH NEXT FROM l_pass_thru2_cur INTO @l_post_date, @l_trans_id;


  END;

  CLOSE l_pass_thru2_cur;
  DEALLOCATE l_pass_thru2_cur;

  SELECT

  DISTINCT

    header.External_System_Key,
    header.cash_voucher_number,
    header.Business_Event_Status_Id,
    header.Imported,
    header.Exported,
    header.Business_Event_Type_Id,
    header.Business_Event_Type_Category_Id,
    header.Created_By header_created_by,
    header.Created_Date header_created_date,
    header.comments

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
  JOIN BEM.CA_TRANS TRA
    ON TRA.BEMTRANSID = data.IFC_SuspenseAccount_Event_Data_Id;

  SET @l_last_day = CAST(DATEADD(D, -1, DATEADD(m, DATEDIFF(m, 0, GETDATE()) + 1, 0)) AS date)

  --Auto Archive Transactions in case of last day of the month  

  IF CAST(GETDATE() AS date) = @l_last_day

  BEGIN

    DECLARE l_pass_thru1_cur CURSOR FOR
    SELECT DISTINCT
      data.gl_date,
      header.external_system_key
    FROM BEM.Business_Event_Header header
    JOIN bem.business_event_type type
      ON type.business_event_type_id = header.business_event_type_id
      AND type.name IN ('PCAL Original', 'PCAL Manual')
    JOIN BEM.Business_Event_Status status
      ON status.business_event_status_id = header.business_event_status_id
    JOIN BEM.IFC_SuspenseAccount_Event event
      ON event.Business_Event_Id = header.Business_Event_Id
    JOIN BEM.IFC_SuspenseAccount_Event_data data
      ON data.Business_Event_Id = event.Business_Event_Id
    JOIN BEM.CA_TRANS TRA
      ON TRA.BEMTRANSID = data.IFC_SuspenseAccount_Event_Data_Id
    JOIN bem.business_event_sub_type sub_type
      ON sub_type.business_event_sub_type_id = tra.LotID
    WHERE status.name IN ('New', 'Reviewed', 'Unread', 'Authorizer Read', 'Processor Read', 'Admin Read', 'Edited')
    --AND sub_type.name IN ('Month End', 'Share')

    OPEN l_pass_thru1_cur;
    FETCH NEXT FROM l_pass_thru1_cur INTO @l_post_date, @l_trans_id;

    --PRINT 'First Transaction';
    --PRINT 'Transaction ID = ' + @l_trans_id;

    WHILE @@FETCH_STATUS = 0
    BEGIN
    BEGIN TRY

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'No Action';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id--'No Action' --Auto Archived
      WHERE External_System_Key = @l_trans_id;
    --PRINT 'Transaction ' + @l_trans_id + ' Auto Archived';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                     @description = 'SMTP Account.',
                                     @email_address = 'jojin127@gmail.com',
                                     @display_name = 'Mail Account',
                                     @mailserver_name = 'smtp.gmail.com';*/

    END TRY
    BEGIN CATCH
      --Change status in case of update error

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Error';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id--'Error' --in Auto Archiving,
      WHERE External_System_Key = @l_trans_id;

      --Creating error log for the current transaction

      SET @l_err_mssg = 'PCAL ' + ERROR_MESSAGE();

      SET @l_err_no = ERROR_NUMBER();

      SET @l_mssg = @l_trans_id;

      EXEC LOG.LOG_spProcessLogInsert @l_mssg,
                                      'Error:Auto Archive',
                                      @l_err_mssg,
                                      @l_trans_id;

    --PRINT 'Pass Through Transaction: Error in Auto Archiving';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                     @description = 'SMTP Account.',
                                     @email_address = 'jojin127@gmail.com',
                                     @display_name = 'Mail Account',
                                     @mailserver_name = 'smtp.gmail.com';*/

    END CATCH

      FETCH NEXT FROM l_pass_thru1_cur INTO @l_post_date, @l_trans_id;

    --PRINT 'Next Transaction';
    --PRINT 'Transaction ID = ' + @l_trans_id;

    END;

    CLOSE l_pass_thru1_cur;
    DEALLOCATE l_pass_thru1_cur;

  END
END;
GO



USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardAllNotificationsByGetEmailId]    Script Date: 9/26/2017 7:03:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardAllNotificationsByGetEmailId] (@i_emailid varchar(100))

AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardAllNotificationsByGetEmailId
  Purpose: To display all the notifications of PCAL user based on email id
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */

  SELECT
    id AS ID,
    SUBJECT,
    SENT_TO,
    SENT_DATE
  FROM BEM.IFC_Message
  WHERE sent_to LIKE '%' + @i_emailid + '%'
  ORDER BY SENT_DATE DESC
GO


USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardClosingStatusGetAll]    Script Date: 9/26/2017 7:03:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardClosingStatusGetAll]
AS

/*
------------------------------------------------------------------------
Program Name: BEM.PCAL_spIFC_DashboardClosingStatusGetAll
Purpose: To display the closing status of PCAL source systems  
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         -----------------------------------------
03/08/2017  Akshay Agnihotri   Creation
------------------------------------------------------------------------
*/

BEGIN

  --Getting the records for the source system closing status for the current start period

  SELECT
  DISTINCT
    ROW_NUMBER() OVER (ORDER BY System_Nme ASC) AS Id,
    CASE
      WHEN System_Nme = 'ACBS_MONTHLY' THEN 'ACBS'
      WHEN System_Nme = 'ASL_MONTHLY' THEN 'ASL-INVESTRAN'
      WHEN System_Nme = 'FTS_MONTHLY' THEN 'FTS'
      WHEN System_Nme = 'Investran_MONTHLY' THEN 'EQUITY-INVESTRAN'
      WHEN System_Nme = 'IPAR_MONTHLY' THEN 'IPAR'
      ELSE System_Nme
    END AS Source_System,
    CASE
      WHEN Closing_Date >= GETDATE() THEN 'Open'
      WHEN Closing_Date < GETDATE() THEN 'Closed'
    END Current_Status,
    Closing_Date

  FROM INBOUND.SOURCE_SYSTEM_CLOSING_STATUS src
  WHERE YEAR(GETDATE()) = YEAR(Closing_Date)
  AND Closing_Date = (SELECT
    MAX(closing_date)
  FROM INBOUND.SOURCE_SYSTEM_CLOSING_STATUS src1
  WHERE src1.System_Nme = src.System_Nme)
  AND src.System_Nme IN ('ACBS_MONTHLY', 'ASL_MONTHLY', 'FTS_MONTHLY', 'Investran_Monthly', 'IPAR_Monthly')
  ;

END
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardErrorGetAll]    Script Date: 9/26/2017 7:17:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardErrorGetAll] (@i_src_name varchar(50), @i_err_type varchar(50))



AS



  /*

  --------------------------------------------------------------

  Program Name: BEM.PCAL_spIFC_DashboardErrorGetAll

  Purpose: To display data for PCAL dashboard Error transactions

  Date Created: 03/08/2017

  Author:      Akshay Agnihotri     

  Modification History:

  Date        Name               Revision Summary

  ----------  ----------         -------------------------------

  03/08/2017  Akshay Agnihotri   Creation

  --------------------------------------------------------------

  */



  SELECT

  DISTINCT

    log.id,

    log.exception_type,

    src.Source_System_Transaction_Ref_id,

    src.source_system_name source_system_id,

    src.Project_ID,

    log.logged_Datetime,

    log.Exception_Message

  FROM inbound.ifc_PCAL_SOURCE_DATA src

  JOIN LOG.Process_Log log

    ON log.Process_Name = src.Source_System_Transaction_Ref_id

  WHERE log.exception_type = ISNULL(@i_err_type, log.exception_type)

  AND src.source_system_name = ISNULL(@i_src_name, src.source_system_name)
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardGetAuthorizationCount]    Script Date: 9/26/2017 7:18:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardGetAuthorizationCount]

AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardGetAuthorizationCount
  Purpose: To display the count for PCAL Authorization records
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */

  SELECT
    COUNT(*)
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderMakerChecker
  WHERE pcal_status = 'New'
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardGetDistinctErrorType]    Script Date: 9/26/2017 7:19:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardGetDistinctErrorType]

AS

  /*
  --------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardGetDistinctErrorType
  Purpose: To display different types of PCAL dashboard Errors
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  --------------------------------------------------------------
  */

  SELECT

  DISTINCT
    log.exception_type

  FROM inbound.ifc_PCAL_SOURCE_DATA src
  JOIN LOG.Process_Log log
    ON log.Exception_Message LIKE '%' + src.Source_System_Transaction_Ref_id + '%'
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardGetErrorCount]    Script Date: 9/26/2017 7:19:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardGetErrorCount]
AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardGetErrorCount
  Purpose: To display the count for PCAL error records
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */


  SELECT
    COUNT(*) err_count
  FROM (SELECT
  DISTINCT
    log.id,
    log.exception_type,
    src.Source_System_Transaction_Ref_id,
    src.source_system_name,
    src.Project_ID,
    log.logged_Datetime,
    log.Exception_Message

  FROM inbound.ifc_PCAL_SOURCE_DATA src

  JOIN LOG.Process_Log log

    ON log.Process_Name = src.Source_System_Transaction_Ref_id) Err
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardGetPostedCount]    Script Date: 9/27/2017 3:04:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardGetPostedCount]
AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardGetPostedCount
  Purpose: To display the count for PCAL Posted records
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */

  SELECT
    COUNT(*)
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderProcessedPosted
  WHERE pcal_status IN ('Posted to Both', 'Posted to SAP Only', 'Posted to ODS Only')


GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardGetProcessedCount]    Script Date: 9/27/2017 3:05:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardGetProcessedCount]
AS
  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardGetProcessedCount
  Purpose: To display the count for PCAL Processed records
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */
  SELECT
    COUNT(*)
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderProcessedPosted
  WHERE pcal_status = 'Completed'
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardGetProcessingCount]    Script Date: 9/27/2017 3:05:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardGetProcessingCount]

AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardGetProcessingCount
  Purpose: To display the count for PCAL Processing records
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */

  SELECT
    COUNT(*)
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderMakerChecker
  WHERE pcal_status = 'Reviewed'
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetDetailChecker]    Script Date: 9/27/2017 3:05:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetDetailChecker]
AS

  /*
  -----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardMainGetDetailChecker
  Purpose: Master program to call dashboard detail
           procedures for loading transactions pending with 
  		 Checker(Processor)
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ----------------------------
  03/08/2017  Akshay Agnihotri   Creation
  -----------------------------------------------------------
  */



  --Getting the records for transactions on PCAL dashboard

  SELECT
    src_sys_ref_id,
    ProjectID,
    TrancheID,
    Obligation_Nbr,
    participant_id,
    Remarks
  FROM BEM.IFC_Vw_PCAL_DashboardDetail
  WHERE pcal_status = 'Reviewed'
  ;
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetDetailMaker]    Script Date: 9/27/2017 3:06:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetDetailMaker]
AS

  /*
  -----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardMainGetDetailMaker
  Purpose: Master program to call dashboard detail
           procedures for loading transactions pending with 
  		 Maker(Authorizer)
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ----------------------------
  03/08/2017  Akshay Agnihotri   Creation
  -----------------------------------------------------------
  */

  --Getting the records for transactions on PCAL dashboard

  SELECT
    src_sys_ref_id,
    ProjectID,
    TrancheID,
    Obligation_Nbr,
    participant_id,
    Remarks
  FROM BEM.IFC_Vw_PCAL_DashboardDetail
  WHERE pcal_status = 'New'
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetDetailPosted]    Script Date: 9/27/2017 3:06:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetDetailPosted]
AS

  /*  
  -----------------------------------------------------------  
  Program Name: BEM.PCAL_spIFC_DashboardMainGetDetailPosted  
  Purpose: Master program to call dashboard detail  
           procedures for loading transactions which are   
     Posted  
  Date Created: 03/08/2017  
  Author:      Akshay Agnihotri      
  Modification History:  
  Date        Name               Revision Summary  
  ----------  ----------         ----------------------------  
  03/08/2017  Akshay Agnihotri   Creation  
  -----------------------------------------------------------  
  */



  --Getting the records for transactions on PCAL dashboard  

  SELECT

    src_sys_ref_id,
    ProjectID,
    TrancheID,
    Obligation_Nbr,
    participant_id, 
    Remarks
  FROM BEM.IFC_Vw_PCAL_DashboardDetail
  WHERE pcal_status IN ('Posted to Both', 'Posted to SAP Only', 'Posted to ODS Only')
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetDetailProcessed]    Script Date: 9/27/2017 3:06:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetDetailProcessed]
AS

  /*
  ------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardMainGetDetailProcessed
  Purpose: Master program to call dashboard detail
           procedures for loading transactions which are
  		 Processed
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------
  */


  --Getting the records for transactions on PCAL dashboard

  SELECT

    src_sys_ref_id,
    ProjectID,
    TrancheID,
    Obligation_Nbr,
    participant_id,
    Remarks
  FROM BEM.IFC_Vw_PCAL_DashboardDetail
  WHERE pcal_status = 'Completed'
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetHeaderChecker]    Script Date: 9/27/2017 3:06:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetHeaderChecker]
AS

  /*
  -----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardMainGetHeaderChecker
  Purpose: Master program to call dashboard header 
           procedures for loading transactions pending with 
           Processor(Checker)
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ----------------------------
  03/08/2017  Akshay Agnihotri   Creation
  -----------------------------------------------------------
  */



  --Getting the records for header on PCAL dashboard

  SELECT
    src_sys_ref_id,
    InstitutionNumber,
    institution_legal_nme,
    System_Name,
    posting_date,
    value_date,
    CASE
      WHEN pcal_status = 'Reviewed' THEN 'Pending for Processing'
    END AS pcal_status,
    Read_Flag
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderMakerChecker
  WHERE pcal_status = 'Reviewed';
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetHeaderMaker]    Script Date: 9/27/2017 3:07:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetHeaderMaker]
AS

  /*
  -----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardMainGetHeaderMaker
  Purpose: Master program to call dashboard header 
           procedures for loading transactions pending with 
           Authorizer(Maker) 
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ----------------------------
  03/08/2017  Akshay Agnihotri   Creation
  -----------------------------------------------------------
  */

  --Getting the records for header on PCAL dashboard

  SELECT
    src_sys_ref_id,
    InstitutionNumber,
    institution_legal_nme,
    System_Name,
    posting_date,
    value_date,
    CASE
      WHEN pcal_status = 'New' THEN 'Pending for Authorizing'
    END AS pcal_status,
    Read_Flag
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderMakerChecker
  WHERE pcal_status = 'New';
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetHeaderPosted]    Script Date: 9/27/2017 3:07:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetHeaderPosted]
AS

  /*  
  -----------------------------------------------------------  
  Program Name: BEM.PCAL_spIFC_DashboardMainGetHeaderPosted  
  Purpose: Master program to call dashboard header   
           procedures for loading transactions which are   
           either Posted  
  Date Created: 03/08/2017  
  Author:    Akshay Agnihotri     
  Modification History:  
  Date        Name               Revision Summary  
  ----------  ----------         ----------------------------  
  03/08/2017  Akshay Agnihotri   Creation  
  -----------------------------------------------------------  
  */



  --Getting the records for header on PCAL dashboard  

  SELECT

    src_sys_ref_id,
    InstitutionNumber, 
    institution_legal_nme,
    System_Name,
    posting_date,
    value_date,
    ODS_Posting_Date,
    SAP_Posting_Date,
    authorized_by,
    processed_by,
    pcal_status,
    Read_Flag
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderProcessedPosted
  WHERE pcal_status IN ('Posted to Both', 'Posted to SAP Only', 'Posted to ODS Only')
  ;
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardMainGetHeaderProcessed]    Script Date: 9/27/2017 3:07:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardMainGetHeaderProcessed]
AS

  /*
  -----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardMainGetHeaderProcessed
  Purpose: Master program to call dashboard header 
           procedures for loading transactions which are 
           either Processed 
  Date Created: 03/08/2017
  Author:		  Akshay Agnihotri		 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ----------------------------
  03/08/2017  Akshay Agnihotri   Creation
  -----------------------------------------------------------
  */


  --Getting the records for header on PCAL dashboard

  SELECT

    src_sys_ref_id,
    InstitutionNumber,
    institution_legal_nme,
    System_Name,
    posting_date,
    value_date,
    ODS_Posting_Date,
    SAP_Posting_Date,
    authorized_by,
    processed_by,
    CASE
      WHEN pcal_status = 'Completed' THEN 'Processed'
    END AS pcal_status,
    Read_Flag
  FROM BEM.IFC_Vw_PCAL_DashboardHeaderProcessedPosted
  WHERE pcal_status = 'Completed'
  ;
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DashboardTop5NotificationsGetByEmailId]    Script Date: 9/27/2017 3:07:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DashboardTop5NotificationsGetByEmailId] (@i_emailid varchar(100))

AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DashboardTop5NotificationsGetByEmailId
  Purpose: To display top 5 notifications of PCAL user based on email id
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */

  SELECT TOP 5
    id AS ID,
    SUBJECT,
    CASE
      WHEN (2 < DATEDIFF(HOUR, SENT_DATE, GETDATE()) AND
        DATEDIFF(HOUR, SENT_DATE, GETDATE()) < 24) THEN 'Today'
      WHEN DATEDIFF(HOUR, SENT_DATE, GETDATE()) < 2 THEN '1 hr'
      WHEN (24 < DATEDIFF(HOUR, SENT_DATE, GETDATE()) AND
        DATEDIFF(HOUR, SENT_DATE, GETDATE()) < 48) THEN 'Yesterday'
      WHEN DATEDIFF(HOUR, SENT_DATE, GETDATE()) > 48 THEN CAST(SENT_DATE AS date)
    END AS Timeline
  FROM BEM.IFC_Message
  WHERE sent_to LIKE '%' + @i_emailid + '%'
  ORDER BY SENT_DATE DESC
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailDetailsGetById]    Script Date: 9/27/2017 3:08:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [BEM].[PCAL_spIFC_DetailDetailsGetById] (@i_src_sys_id varchar(255))

AS


  /*
  ----------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DetailDetailsGetById
  Purpose: To display detail screen Transactions details data
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------------
  */

  SELECT
    src_sys_ref_id,
    Project_ID,
    Tranche_ID,
    Obligation_Nbr,
    participant_id,
    Currency_Code,
    source_system_account,
    posting_date,
    value_date,
    SAP_GL_Account_Nbr,
    SAP_Account_Description,
    Fin_Statement_Class,
    adjustment_sub_type,
    share_Qty,
    feecode,
    Amount,
    usd_amount,
    CASE
      WHEN pcal_status = 'New' THEN 'Pending for Authorizing'
      WHEN pcal_status = 'Reviewed' THEN 'Pending for Processing'
      WHEN pcal_status = 'Completed' THEN 'Processed'
      ELSE pcal_status
    END AS pcal_status,
    sap_gl_posting,
    ods_posting_status
  FROM BEM.IFC_Vw_PCAL_DetailDetails
  WHERE src_sys_ref_id = @i_src_sys_id
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailGetSummaryByAccount]    Script Date: 9/27/2017 3:09:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_DetailGetSummaryByAccount (@i_src_sys_id varchar(50))
AS

  /*
  ----------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DetailGetSummaryByAccount
  Purpose: To display detail screen summary by account
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------------
  */

  SELECT

    refr.SAP_Account_Nbr SAP_GL_Account_Nbr,
    refr.SAP_Account_Description SAP_Account_Description,
    SUM(tra.LeAmount)


  FROM BEM.Business_Event_Header header
  JOIN BEM.Business_Event_Status status
    ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
  JOIN BEM.IFC_SuspenseAccount_Event event
    ON event.Business_Event_Id = header.Business_Event_Id
  JOIN BEM.IFC_SuspenseAccount_Event_Data data
    ON data.Business_Event_Id = event.Business_Event_Id
  JOIN BEM.business_event_type type
    ON type.business_event_type_id = header.business_event_type_id
    AND type.name IN ('PCAL Original', 'PCAL Manual')
  JOIN BEM.IFC_SuspenseAccount_Event_Data_Line_Item line
    ON line.IFC_SuspenseAccount_Event_Data_Id = data.IFC_SuspenseAccount_Event_Data_Id
  JOIN BEM.BEM_CA_BATCH batch
    ON batch.businesseventid = header.business_event_id
  JOIN BEM.BEM_CA_TRANS TRA
    ON batch.BEMBATCHID = tra.BEMBATCHID
  JOIN master.currency curr
    ON curr.currencyID = tra.CurrencyId
  JOIN master.cax_account cax
    ON cax.accountid = tra.accountid
  LEFT OUTER JOIN outbound.ifc_sap_agg_balance refr
    ON CONVERT(nvarchar(50), REFR.GL_Account_Nbr) = cax.code
    AND refr.Source_System_Transaction_Ref_Id = header.External_System_Key
  WHERE header.External_System_Key = @i_src_sys_id
  GROUP BY refr.SAP_Account_Nbr,
           refr.SAP_Account_Description
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailGetSummaryByCurrency]    Script Date: 9/27/2017 3:09:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_DetailGetSummaryByCurrency (@i_src_sys_id varchar(50))
AS

  /*
  ----------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DetailGetSummaryByCurrency
  Purpose: To display detail screen summary by account
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------------
  */


  SELECT

    curr.CurrencyISO currency_code,
    refr.SAP_Account_Nbr SAP_GL_Account_Nbr,
    refr.sap_Account_Description SAP_Account_Description,
    SUM(tra.Amount) local_amt_sum,
    SUM(tra.LeAmount) usd_amt_sum


  FROM BEM.Business_Event_Header header
  JOIN BEM.Business_Event_Status status
    ON status.Business_Event_Status_Id = header.Business_Event_Status_Id
  JOIN BEM.IFC_SuspenseAccount_Event event
    ON event.Business_Event_Id = header.Business_Event_Id
  JOIN BEM.IFC_SuspenseAccount_Event_Data data
    ON data.Business_Event_Id = event.Business_Event_Id
  JOIN bem.business_event_type type
    ON type.business_event_type_id = header.business_event_type_id
    AND type.name IN ('PCAL Original', 'PCAL Manual')
  JOIN BEM.BEM_CA_BATCH batch
    ON batch.businesseventid = header.business_event_id
  JOIN BEM.BEM_CA_TRANS TRA
    ON batch.BEMBATCHID = tra.BEMBATCHID
  JOIN master.currency curr
    ON curr.currencyID = tra.CurrencyId
  JOIN master.cax_account cax
    ON cax.accountid = tra.accountid
  LEFT OUTER JOIN outbound.ifc_sap_agg_balance refr
    ON CONVERT(nvarchar(50), REFR.GL_Account_Nbr) = cax.code
    AND refr.Source_System_Transaction_Ref_Id = header.External_System_Key
  WHERE header.External_System_Key = @i_src_sys_id
  GROUP BY curr.CurrencyISO,
           refr.SAP_Account_Nbr,
           refr.sap_Account_Description

GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailHeaderGetById]    Script Date: 9/27/2017 5:46:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [BEM].[PCAL_spIFC_DetailHeaderGetById] (@i_src_sys_id varchar(255))

AS

  /*
  ----------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_DetailHeaderGetById
  Purpose: To display detail screen Header details data
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------------
  */

  SELECT DISTINCT
    src_sys_ref_id,
    system_name,
    posting_date,
    value_date,
    authorized_by,
    processed_by,
    adjustment_type,
    ODS_Posting_Date,
    sap_Posting_Date,
    SAP_Acknowledgement_Status,
    ODS_Acknowledgement_Status,
    ODS_Reversal_Date,
    SAP_Reversal_Date,
    Read_Flag,
    PCAL_Reversal_Flag,
    Remarks,
    CASE
      WHEN pcal_status = 'New' THEN 'Pending for Authorizing'
      WHEN pcal_status = 'Reviewed' THEN 'Pending for Processing'
      WHEN pcal_status = 'Completed' THEN 'Processed'
      ELSE pcal_status
    END AS pcal_status,
    business_event_status_id
  FROM BEM.IFC_Vw_PCAL_DetailHeader
  WHERE src_sys_ref_id = @i_src_sys_id
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailUpdateByChecker]    Script Date: 9/27/2017 5:47:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_DetailUpdateByChecker (@i_src_sys_ref_id varchar(50), @i_tar_sys_flag varchar(10), @i_user varchar(100))

AS

/*
----------------------------------------------------------
Program Name: BEM.PCAL_spIFC_DetailUpdateByChecker
Purpose: To update status for PCAL Detail Screen
         when authorizer sends for processing
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

BEGIN

  DECLARE @l_err_mssg varchar(1000),
          @l_err_no varchar(50),
          @l_bus_eve_id int,
		  @l_status_id int;

  DECLARE l_user_input_cur CURSOR FOR
  SELECT
    business_event_id
  FROM bem.business_event_header
  WHERE External_System_Key = @i_src_sys_ref_id;

  OPEN l_user_input_cur;
  FETCH NEXT FROM l_user_input_cur INTO @l_bus_eve_id;

  WHILE @@FETCH_STATUS = 0
  BEGIN

  BEGIN TRY

    --Updating the status when processor sends for posting

    IF @i_tar_sys_flag = 'ODS'

    BEGIN
      UPDATE BEM.ifc_suspenseaccount_event_data
      SET pcal_target_system = 'ODS',
          changed_by = @i_user--'Post to both ODS and SAP'
      WHERE business_event_id = @l_bus_eve_id;
    END

    IF @i_tar_sys_flag = 'SAP'
    BEGIN

      UPDATE BEM.ifc_suspenseaccount_event_data
      SET pcal_target_system = 'SAP',
          changed_by = @i_user--'Post to both ODS and SAP'
      WHERE business_event_id = @l_bus_eve_id;
    END
    IF @i_tar_sys_flag = 'Both'

    BEGIN

      UPDATE BEM.ifc_suspenseaccount_event_data
      SET pcal_target_system = 'Both',
          changed_by = @i_user--'Post to both ODS and SAP'
      WHERE business_event_id = @l_bus_eve_id;
    END
  END TRY
  BEGIN CATCH

    --Change status in case of update error 

	  	      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Error';
	  
    UPDATE BEM.Business_Event_Header
    SET business_event_status_id = @l_status_id ,
        changed_by = @i_user,
        changed_date = GETDATE() --'Error' -- in Processing
    WHERE business_event_id = @l_bus_eve_id;

    --Creating error log for the current transaction

    SET @l_err_mssg = ERROR_MESSAGE();

    SET @l_err_no = @i_src_sys_ref_id

    EXEC LOG.LOG_spProcessLogInsert 'Error in Updating Target System',
                                    'ERROR',
                                    @l_err_mssg,
                                    @l_err_no;

    PRINT 'Error in Updating Target System';

  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END CATCH

  BEGIN TRY
  
  	      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Completed';
	  
    UPDATE BEM.Business_Event_Header
    SET business_event_status_id = @l_status_id,
        changed_by = @i_user,
        changed_date = GETDATE() --'Completed' 
    WHERE business_event_id = @l_bus_eve_id;
    PRINT 'Transaction ' + @i_src_sys_ref_id + ' Verified';

  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END TRY
  BEGIN CATCH

    --Change status in case of update error 
	
		  	      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Error';

    UPDATE BEM.Business_Event_Header
    SET business_event_status_id = @l_status_id,
        changed_by = @i_user,
        changed_date = GETDATE() --'Error' -- in Processing
    WHERE External_System_Key = @i_src_sys_ref_id;

    --Creating error log for the current transaction

    SET @l_err_mssg = ERROR_MESSAGE();

    SET @l_err_no = @i_src_sys_ref_id

    EXEC LOG.LOG_spProcessLogInsert 'Error in Processing',
                                    'ERROR',
                                    @l_err_mssg,
                                    @l_err_no;

    PRINT 'Error in Processing';

  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END CATCH
  END
END
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailUpdateByMaker]    Script Date: 9/27/2017 5:47:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_DetailUpdateByMaker (@i_src_sys_ref_id varchar(50), @i_user varchar(100))

AS

/*
----------------------------------------------------------
Program Name: BEM.PCAL_spIFC_DetailUpdateByMaker
Purpose: To update status for PCAL Detail Screen
         when authorizer sends for processing
Date Created: 03/08/2017
Author:  	  Akshay Agnihotri		 
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

BEGIN

  DECLARE @l_err_mssg varchar(1000),
		  @l_err_no varchar(50),
		  @l_status_id int;

  BEGIN TRY

    --Updating the status when authorizer sends for processing
	
	      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Reviewed';

      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id,changed_by=@i_user,changed_date=GetDate() --'Reviewed' --Available for Processing
      WHERE External_System_Key = @i_src_sys_ref_id;
      PRINT 'Transaction ' + @i_src_sys_ref_id + ' Reviewed';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                         @description = 'SMTP Account.',
                                         @email_address = 'jojin127@gmail.com',
                                         @display_name = 'Mail Account',
                                         @mailserver_name = 'smtp.gmail.com';*/	
	
  END TRY
  BEGIN CATCH

      --Change status in case of update error 

	  	      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Error';
	  
      UPDATE BEM.Business_Event_Header
      SET business_event_status_id = @l_status_id,changed_by=@i_user,changed_date=GetDate() --'Error' -- in Sending for Processing
      WHERE External_System_Key = @i_src_sys_ref_id;

      --Creating error log for the current transaction

      SET @l_err_mssg = ERROR_MESSAGE();

      SET @l_err_no = @i_src_sys_ref_id

      EXEC LOG.LOG_spProcessLogInsert 'Error in Sending for Processing',
                                      'ERROR',
                                      @l_err_mssg,
                                      @l_err_no;

      PRINT 'Error in Sending for Processing';

    /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                         @description = 'SMTP Account.',
                                         @email_address = 'jojin127@gmail.com',
                                         @display_name = 'Mail Account',
                                         @mailserver_name = 'smtp.gmail.com';*/	
	
  END CATCH
END
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_DetailUpdateByUserInputs]    Script Date: 9/27/2017 5:49:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_DetailUpdateByUserInputs (@i_src_sys_ref_id varchar(50), @i_ods_post_date datetime, @i_sap_post_date datetime, @i_remarks varchar(1000), @i_rev_flag varchar(2), @i_adj_sub_type varchar(10), @i_user varchar(100))

AS

/*
----------------------------------------------------------
Program Name: BEM.PCAL_spIFC_DetailUpdateByUserInputs
Purpose: To update data for PCAL Detail Screen
         based on user inputs
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

BEGIN

  DECLARE @l_bus_eve_id int,
          @l_bus_eve_type_id int,
          @l_adj_sub_type_id int,
          @l_err_mssg varchar(1000),
          @l_err_no varchar(50),
          @l_ifc_suspenseaccount_event_data_id int,
          @l_ifc_suspenseaccount_event_data_line_item_id int,
          @l_status_id int;

  DECLARE l_user_input_cur CURSOR FOR
  SELECT
    business_event_id,
    business_event_type_id
  FROM BEM.Business_Event_Header header
  WHERE External_System_Key = @i_src_sys_ref_id;

  OPEN l_user_input_cur;
  FETCH NEXT FROM l_user_input_cur INTO @l_bus_eve_id, @l_bus_eve_type_id;

  WHILE @@FETCH_STATUS = 0
  BEGIN
    --check whether adjustment sub type can be updated or not based on the reversal flag 





    SELECT
      @l_ifc_suspenseaccount_event_data_id = ifc_suspenseaccount_event_data_id
    FROM BEM.ifc_suspenseaccount_event_data
    WHERE business_event_id = @l_bus_eve_id;

    DECLARE l_susp_acc_cur1 CURSOR FOR
    SELECT
      ifc_suspenseaccount_event_data_line_item_id
    FROM BEM.ifc_suspenseaccount_event_data_line_item
    WHERE IFC_SuspenseAccount_Event_Data_Id = @l_ifc_suspenseaccount_event_data_id;

    OPEN l_susp_acc_cur1;
    FETCH NEXT FROM l_susp_acc_cur1 INTO @l_ifc_suspenseaccount_event_data_line_item_id;

    WHILE @@FETCH_STATUS = 0
    BEGIN

      SELECT
        @l_adj_sub_type_id = business_event_sub_type_id
      FROM bem.business_event_sub_type
      WHERE name = @i_adj_sub_type;

      UPDATE bem.ca_trans
      SET lotID = @l_adj_sub_type_id  --business_event_sub_type_id
      WHERE BEMTransID = @l_ifc_suspenseaccount_event_data_line_item_id;

      FETCH NEXT FROM l_susp_acc_cur1 INTO @l_ifc_suspenseaccount_event_data_line_item_id;

    END

    CLOSE l_susp_acc_cur1;
    DEALLOCATE l_susp_acc_cur1;

  BEGIN TRY

    --Updating the reversal flag, ods posting date, sap posting date

    UPDATE bem.IFC_SuspenseAccount_Event_Data
    SET pcal_reversal_flag = @i_rev_flag,
        changed_by = @i_user,
        changed_date = GETDATE(),
        pcal_ods_posting_date = @i_ods_post_date,
        pcal_sap_posting_date = @i_sap_post_date
    WHERE business_event_id = @l_bus_eve_id;

    IF @i_rev_flag IS NOT NULL
      OR @i_ods_post_date IS NOT NULL
      OR @i_sap_post_date IS NOT NULL

    BEGIN

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Edited';

      UPDATE bem.Business_Event_Header
      SET business_event_status_id = @l_status_id,
          changed_by = @i_user,
          changed_date = GETDATE() -- Edited
      WHERE business_event_id = @l_bus_eve_id;

    END

  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END TRY
  BEGIN CATCH

    --Creating error log for the inability to update reversal flag or ods posting date or sap posting date

    SET @l_err_mssg = ERROR_MESSAGE();

    SET @l_err_no = @i_src_sys_ref_id

    EXEC LOG.LOG_spProcessLogInsert 'Error in Updating reversal flag or ods posting date or sap posting date',
                                    'ERROR',
                                    @l_err_mssg,
                                    @l_err_no;

    PRINT 'Error in Updating reversal flag or ods posting date or sap posting date';

  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END CATCH

  BEGIN TRY

    --Updating the remarks, adjustment sub type

    UPDATE bem.Business_Event_Header
    SET comments = @i_remarks,
        changed_by = @i_user,
        changed_date = GETDATE()
    WHERE business_event_id = @l_bus_eve_id;

    IF @i_remarks IS NOT NULL
      OR @i_adj_sub_type IS NOT NULL

    BEGIN

      SELECT
        @l_status_id = business_event_status_id
      FROM bem.business_event_status
      WHERE name = 'Edited';

      UPDATE bem.Business_Event_Header
      SET business_event_status_id = @l_status_id,
          changed_by = @i_user,
          changed_date = GETDATE() -- Edited
      WHERE business_event_id = @l_bus_eve_id;


    END



  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END TRY
  BEGIN CATCH

    --Creating error log for the inability to update remarks or adjustment sub type

    SET @l_err_mssg = ERROR_MESSAGE();

    SET @l_err_no = @i_src_sys_ref_id

    EXEC LOG.LOG_spProcessLogInsert 'Error in Updating remarks or adjustment sub type',
                                    'ERROR',
                                    @l_err_mssg,
                                    @l_err_no;

    PRINT 'Error in Updating remarks or adjustment sub type';

  /*EXEC msdb.dbo.sysmail_add_account_sp @account_name = 'MailAcct1',
                                       @description = 'SMTP Account.',
                                       @email_address = 'jojin127@gmail.com',
                                       @display_name = 'Mail Account',
                                       @mailserver_name = 'smtp.gmail.com';*/

  END CATCH
    FETCH NEXT FROM l_user_input_cur INTO @l_bus_eve_id, @l_bus_eve_type_id;
  END
  CLOSE l_user_input_cur;
  DEALLOCATE l_user_input_cur;
END
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_ReportEodGetByCreatedDate]    Script Date: 9/27/2017 5:49:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_ReportEodGetByCreatedDate (@i_cre_date date)

AS

  /*
  ----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_ReportEodGetByCreatedDate
  Purpose: To display data for PCAL EOD Report 
  Date Created: 03/08/2017
  Author:  	  Akshay Agnihotri		 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------
  */

  SELECT
    source_system_transaction_id,
    Source_System_Name,
    Company_Name,
    Company_Code,
    Project_ID,
    Tranche_ID,
    Obligation_Nbr,
    Participant_id,
    Participant_name,
    fee_code,
    fee_type,
    source_system_account,
    source_system_sub_account,
    source_system_account_description,
    SAP_GL_Account_Nbr,
    SAP_Account_Description,
    Fin_Statement_Class,
    Currency_code,
    Amount,
    usd_amount,
    Share_Qty,

    Posting_Date,
    Value_Date,
    ODS_Posting_Date,
    ODS_Reversal_Date,
    sap_Posting_Date,
    SAP_Reversal_Date,
    Document_Number,
    convert(nvarchar(50),Document_Number)+ '_rev'  Reversal_Document_Nbr,
    Voucher_Nbr,
    convert(nvarchar(50),Voucher_Nbr)+ '_rev' Reversal_Voucher_Nbr,
    PCAL_Status,
    SAP_Acknowledgement_Status,
    ODS_Acknowledgement_Status,

    Adjustment_Type,

    authorized_by,
    processed_by,

    Remarks


  FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
  WHERE cast(created_date as date) = @i_cre_date
  Go

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_ReportEodInputGetDistinctCreatedDate]    Script Date: 9/27/2017 5:49:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_ReportEodInputGetDistinctCreatedDate
AS

  /*
  ----------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_ReportEodInputGetDistinctCreatedDate
  Purpose: To display the input lookup data for PCAL Report Eod  
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------------
  */


  SELECT DISTINCT
    CAST(data.created_date AS date) created_date
  FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_ReportMonthEndGetByCreatedDate]    Script Date: 9/27/2017 5:50:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_ReportMonthEndGetByCreatedDate (@i_cre_date varchar(20))

AS

  /*
  ----------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_ReportMonthEndGetByCreatedDate
  Purpose: To display data for PCAL Month End Report 
  Date Created: 03/08/2017
  Author:  	  Akshay Agnihotri		 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ---------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ----------------------------------------------------------
  */

  SELECT
    source_system_transaction_id,
    Source_System_Name,
    Company_Name,
    Company_Code,
    Project_ID,
    Tranche_ID,
    Obligation_Nbr,
    Participant_id,
    Participant_name,
    fee_code,
    fee_type,
    source_system_account,
    source_system_sub_account,
    source_system_account_description,
    SAP_GL_Account_Nbr,
    SAP_Account_Description,
    Fin_Statement_Class,
    Currency_code,
    Amount,
    usd_amount,
    Share_Qty,

    Posting_Date,
    Value_Date,
    ODS_Posting_Date,
    ODS_Reversal_Date,
    sap_Posting_Date,
    SAP_Reversal_Date,
    Document_Number,
    convert(nvarchar(50),Document_Number)+ '_rev'  Reversal_Document_Nbr,
    Voucher_Nbr,
    convert(nvarchar(50),Voucher_Nbr)+ '_rev' Reversal_Voucher_Nbr,
    PCAL_Status,
    SAP_Acknowledgement_Status,
    ODS_Acknowledgement_Status,

    Adjustment_Type,

    authorized_by,
    processed_by,

    Remarks


  FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
  WHERE DATENAME(m, created_date) + ' ' + CAST(DATEPART(yyyy, created_date) AS varchar) = @i_cre_date
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_ReportMonthEndInputGetDistinctCreatedMonthYear]    Script Date: 9/27/2017 5:50:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_ReportMonthEndInputGetDistinctCreatedMonthYear
AS

  /*
  -------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_ReportMonthEndInputGetDistinctCreatedMonthYear
  Purpose: To display the input lookup data for PCAL Report Month End  
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         ------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  -------------------------------------------------------------------
  */


  SELECT distinct

    DATENAME(m, created_date) + ' ' + CAST(DATEPART(yyyy, created_date) AS varchar) created_date

 FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_ReportReconciliationInputGetDistinctCreatedMonth]    Script Date: 9/27/2017 5:50:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE BEM.PCAL_spIFC_ReportReconciliationInputGetDistinctCreatedMonth
AS

  /*
  ------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_ReportReconciliationInputGetDistinctCreatedMonth
  Purpose: To display the input lookup data for PCAL Reconciliation Report 
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri     
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -----------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  ------------------------------------------------------------------------
  */


  SELECT DISTINCT
    DATENAME(m, created_date) month
   FROM BEM.IFC_Vw_PCAL_ReportAndAdvancedSearchGetAll
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_ReportReconciliationInputGetDistinctSourceName]    Script Date: 9/27/2017 5:50:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE BEM.PCAL_spIFC_ReportReconciliationInputGetDistinctSourceName

AS

  /*
  --------------------------------------------------------------------------------------
  Program Name: BEM.PCAL_spIFC_ReportReconciliationInputGetDistinctSourceName
  Purpose: To display the input source system lookup data for PCAL Reconciliation Report 
  Date Created: 03/08/2017
  Author:      Akshay Agnihotri  	 
  Modification History:
  Date        Name               Revision Summary
  ----------  ----------         -------------------------------------------------------
  03/08/2017  Akshay Agnihotri   Creation
  --------------------------------------------------------------------------------------
  */
  
  SELECT
    -100 System_id,'All' System_Name
  UNION
  SELECT DISTINCT
    System_id,System_Name
  FROM INBOUND.SYSTEM_DEFINITION 
  where system_Name in ('ACBS','ASL-INVESTRAN','EQUITY-INVESTRAN','IPAR','FTS')
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure [BEM].[PCAL_spIFC_BusinessEventHeaderUpdateExternalSystemKey]    Script Date: 10/24/2017 12:33:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_BusinessEventHeaderUpdateExternalSystemKey (@i_Id int)

AS

  /*
-----------------------------------------------------------------------
Program Name: BEM.PCAL_spIFC_BusinessEventHeaderUpdateExternalSystemKey
Purpose: To update data for PCAL Source Transaction Ref Id and Status
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ----------------------------------------
03/08/2017  Akshay Agnihotri   Creation
-----------------------------------------------------------------------
*/

  UPDATE BEM.Business_Event_Header

  SET External_System_Key = @i_Id,
      business_event_status_id = -1
  WHERE Business_Event_Id = @i_Id
GO

USE [EQUITY7PCAL_STG]
GO

/****** Object:  StoredProcedure BEM.PCAL_spIFC_DashboardGetClosedMonth    Script Date: 9/26/2017 7:00:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE BEM.PCAL_spIFC_DashboardGetClosedMonth (@i_sys_name varchar(50))
AS

/*
------------------------------------------------------------------------
Program Name: INBOUND.PCAL_spIFC_DashboardGetClosedMonth
Purpose: To display the closed month of PCAL source systems  
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         -----------------------------------------
03/08/2017  Akshay Agnihotri   Creation
------------------------------------------------------------------------
*/

BEGIN
  DECLARE @l_src_name varchar(50);
  SET @l_src_name =
                   CASE
                     WHEN @i_sys_name = 'ACBS' THEN 'ACBS_MONTHLY'
                     WHEN @i_sys_name = 'FTS' THEN 'FTS_MONTHLY'
                     WHEN @i_sys_name = 'ASL-INVESTRAN' THEN 'ASL_MONTHLY'
                     WHEN @i_sys_name = 'EQUITY-INVESTRAN' THEN 'Investran_MONTHLY'
                     WHEN @i_sys_name = 'IPAR' THEN 'IPAR_MONTHLY'
                   END;
  SELECT

    DATENAME(m, MAX(Period_End_Date)) + ' ' + CAST(DATEPART(yyyy, MAX(Period_End_Date)) AS varchar) Closed_Month

  FROM INBOUND.SOURCE_SYSTEM_CLOSING_STATUS
  WHERE System_Nme = @l_src_name;
END

GO
