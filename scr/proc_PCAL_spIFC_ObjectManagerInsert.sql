CREATE PROCEDURE INBOUND.PCAL_spIFC_ObjectManagerInsert
AS

/*
----------------------------------------------------------
Program Name: INBOUND.PCAL_spIFC_ObjectManagerInsert
Purpose: To insert data into Object Manager for 
         BEM Interface
Date Created: 03/08/2017
Author:      Akshay Agnihotri     
Modification History:
Date        Name               Revision Summary
----------  ----------         ---------------------------
03/08/2017  Akshay Agnihotri   Creation
----------------------------------------------------------
*/

BEGIN

  DECLARE @l_value_date date,
          @l_post_date date,
          @l_trans_id varchar(50),
          @l_mssg varchar(500),
          @l_src_sys_name varchar(20),
          @l_src_sys_id int,
          @l_part_id int,
          @l_feecode int,
          @l_obj_id int,
          @l_prj_id int,
          @l_tran_nbr int,
          @l_acc_nbr int,
          @l_sub_acc_nbr int,
          @l_curr_id int,
          @l_usd_amt decimal,
          @l_amt decimal,
          @l_share_qty decimal,
          @l_obl_nbr int,
          @l_prod_id int,
          @l_feecode_id varchar(20);

  DECLARE l_header_view_cur CURSOR FOR
  SELECT

    [Source_System_Transaction_Ref_id],
    source_system_name,
    remarks

  FROM [INBOUND].[IFC_Vw_PCAL_Header_wfw]

  OPEN l_header_view_cur;
  FETCH NEXT FROM l_header_view_cur INTO @l_trans_id, @l_src_sys_name, @l_mssg;

  WHILE @@FETCH_STATUS = 0
  BEGIN

    EXEC USP_Return_Seq_Nbr NULL,
                            @Value = @l_obj_id OUTPUT;

    SELECT
      @l_src_sys_id = system_id
    FROM inbound.system_definition
    WHERE system_name = @l_src_sys_name;

    INSERT INTO inbound.object_manager (Object_Type,
    Object_Status_Name,
    Object_Received_Datetime,
    WM_Process_Status,
    WM_Processed_Datetime,
    Unified_Object_Name,
    Unified_Object_Type,
    Failed_Counter,
    Last_Update_Datetime,
    Object_ID,
    Import_Error_Id,
    Remarks,
    System_Id)
      VALUES ('Adjustment_Header', 'New', GETDATE(), 'UnProcessed', NULL, 'INBOUND.IFC_Vw_PCAL_Header_wfw', 'View', 0, GETDATE(), @l_obj_id, NULL, @l_mssg, @l_src_sys_id)

    UPDATE inbound.ifc_pcal_header
    SET object_id = @l_obj_id
    WHERE ISNULL([Source_System_Transaction_Ref_id], 0) = ISNULL(@l_trans_id, 0)
    AND source_system_name = @l_src_sys_name
    AND ISNULL(remarks, 0) = ISNULL(@l_mssg, 0);

    FETCH NEXT FROM l_header_view_cur INTO @l_trans_id, @l_src_sys_name, @l_mssg;

  END
  CLOSE l_header_view_cur;
  DEALLOCATE l_header_view_cur;

  DECLARE l_event_view_cur CURSOR FOR
  SELECT

    [Source_System_Transaction_Ref_id],

    [Participant_ID],
    fee_code,
    source_system_name,
    remarks

  FROM [INBOUND].[IFC_Vw_PCAL_Event_wfw]

  OPEN l_event_view_cur;
  FETCH NEXT FROM l_event_view_cur INTO @l_trans_id, @l_part_id, @l_feecode, @l_src_sys_name, @l_mssg;

  WHILE @@FETCH_STATUS = 0
  BEGIN

    EXEC USP_Return_Seq_Nbr NULL,
                            @Value = @l_obj_id OUTPUT;

    SELECT
      @l_src_sys_id = system_id
    FROM inbound.system_definition
    WHERE system_name = @l_src_sys_name;

    INSERT INTO inbound.object_manager (Object_Type,
    Object_Status_Name,
    Object_Received_Datetime,
    WM_Process_Status,
    WM_Processed_Datetime,
    Unified_Object_Name,
    Unified_Object_Type,
    Failed_Counter,
    Last_Update_Datetime,
    Object_ID,
    Import_Error_Id,
    Remarks,
    System_Id)
      VALUES ('Adjustment_Event', 'New', GETDATE(), 'UnProcessed', NULL, 'INBOUND.IFC_Vw_PCAL_Event_wfw', 'View', 0, GETDATE(), @l_obj_id, NULL, @l_mssg, @l_src_sys_id)

    SELECT
      @l_feecode_id = [code]
    FROM [BEM].[IFC_Business_Event_Addendum_Sub_Type]
    WHERE IFC_Business_Event_Addendum_Sub_Type_Id = @l_feecode


    UPDATE inbound.ifc_pcal_event
    SET object_id = @l_obj_id
    WHERE ISNULL([Source_System_Transaction_Ref_id], 0) = ISNULL(@l_trans_id, 0)
    AND source_system_name = @l_src_sys_name
    AND ISNULL([Participant_ID], 0) = ISNULL(@l_part_id, 0)
    AND ISNULL(fee_code, 0) = ISNULL(@l_feecode_id, 0)
    AND ISNULL(remarks, 0) = ISNULL(@l_mssg, 0);

    FETCH NEXT FROM l_event_view_cur INTO @l_trans_id, @l_part_id, @l_feecode, @l_src_sys_name, @l_mssg;

  END
  CLOSE l_event_view_cur;
  DEALLOCATE l_event_view_cur;

  DECLARE l_event_data_view_cur CURSOR FOR
  SELECT

    [Source_System_Transaction_Ref_id],

    [Posting_Date],

    [Value_Date],

    [Participant_ID],
    fee_code,
    source_system_name,
    remarks

  FROM [INBOUND].[IFC_Vw_PCAL_Event_Data_wfw]

  OPEN l_event_data_view_cur;
  FETCH NEXT FROM l_event_data_view_cur INTO @l_trans_id, @l_post_date, @l_value_date, @l_part_id, @l_feecode, @l_src_sys_name, @l_mssg;

  WHILE @@FETCH_STATUS = 0
  BEGIN

    EXEC USP_Return_Seq_Nbr NULL,
                            @Value = @l_obj_id OUTPUT;

    SELECT
      @l_src_sys_id = system_id
    FROM inbound.system_definition
    WHERE system_name = @l_src_sys_name;

    INSERT INTO inbound.object_manager (Object_Type,
    Object_Status_Name,
    Object_Received_Datetime,
    WM_Process_Status,
    WM_Processed_Datetime,
    Unified_Object_Name,
    Unified_Object_Type,
    Failed_Counter,
    Last_Update_Datetime,
    Object_ID,
    Import_Error_Id,
    Remarks,
    System_Id)
      VALUES ('Adjustment_Event_Data', 'New', GETDATE(), 'UnProcessed', NULL, 'INBOUND.IFC_Vw_PCAL_Event_Data_wfw', 'View', 0, GETDATE(), @l_obj_id, NULL, @l_mssg, @l_src_sys_id)


    SELECT
      @l_feecode_id = [code]
    FROM [BEM].[IFC_Business_Event_Addendum_Sub_Type]
    WHERE IFC_Business_Event_Addendum_Sub_Type_Id = @l_feecode


    UPDATE inbound.ifc_pcal_event_data
    SET object_id = @l_obj_id
    WHERE ISNULL([Source_System_Transaction_Ref_id], 0) = ISNULL(@l_trans_id, 0)
    AND source_system_name = @l_src_sys_name
    AND [Posting_Date] = @l_post_date
    AND [Value_Date] = @l_value_date
    AND ISNULL([Participant_ID], 0) = ISNULL(@l_part_id, 0)
    AND ISNULL(fee_code, 0) = ISNULL(@l_feecode_id, 0)
    AND ISNULL(remarks, 0) = ISNULL(@l_mssg, 0);

    FETCH NEXT FROM l_event_data_view_cur INTO @l_trans_id, @l_post_date, @l_value_date, @l_part_id, @l_feecode, @l_src_sys_name, @l_mssg;

  END
  CLOSE l_event_data_view_cur;
  DEALLOCATE l_event_data_view_cur;

  DECLARE l_event_data_line_item_view_cur CURSOR FOR
  SELECT


    [Source_System_Transaction_Ref_id],

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

    [Source_System_name],

    [Remarks]

  FROM [INBOUND].[IFC_Vw_PCAL_Event_Data_Line_wfw]

  OPEN l_event_data_line_item_view_cur;
  FETCH NEXT FROM l_event_data_line_item_view_cur INTO @l_trans_id, @l_prj_id, @l_tran_nbr, @l_acc_nbr, @l_sub_acc_nbr, @l_post_date, @l_value_date, @l_curr_id, @l_usd_amt, @l_amt, @l_part_id, @l_feecode, @l_share_qty, @l_obl_nbr, @l_prod_id, @l_src_sys_name, @l_mssg;

  WHILE @@FETCH_STATUS = 0
  BEGIN

    EXEC USP_Return_Seq_Nbr NULL,
                            @Value = @l_obj_id OUTPUT;

    SELECT
      @l_src_sys_id = system_id
    FROM inbound.system_definition
    WHERE system_name = @l_src_sys_name;

    INSERT INTO inbound.object_manager (Object_Type,
    Object_Status_Name,
    Object_Received_Datetime,
    WM_Process_Status,
    WM_Processed_Datetime,
    Unified_Object_Name,
    Unified_Object_Type,
    Failed_Counter,
    Last_Update_Datetime,
    Object_ID,
    Import_Error_Id,
    Remarks,
    System_Id)
      VALUES ('Adjustment_Event_Data_Line', 'New', GETDATE(), 'UnProcessed', NULL, 'INBOUND.IFC_Vw_PCAL_Event_Data_Line_wfw', 'View', 0, GETDATE(), @l_obj_id, NULL, @l_mssg, @l_src_sys_id)

    SELECT
      @l_feecode_id = [code]
    FROM [BEM].[IFC_Business_Event_Addendum_Sub_Type]
    WHERE IFC_Business_Event_Addendum_Sub_Type_Id = @l_feecode


    UPDATE inbound.ifc_pcal_event_data_line
    SET object_id = @l_obj_id
    WHERE ISNULL([Source_System_Transaction_Ref_id], 0) = ISNULL(@l_trans_id, 0)
    AND source_system_name = @l_src_sys_name
    AND [Posting_Date] = @l_post_date
    AND [Value_Date] = @l_value_date
    AND ISNULL([Project_Id], 0) = ISNULL(@l_prj_id, 0)
    AND ISNULL([Tranche_Number], 0) = ISNULL(@l_tran_nbr, 0)
    AND ISNULL([Account_Number], 0) = ISNULL(@l_acc_nbr, 0)
    AND ISNULL([Sub_Account_Number], 0) = ISNULL(@l_sub_acc_nbr, 0)
    AND ISNULL([Account_Usd_Amount], 0) = ISNULL(@l_usd_amt, 0)
    AND ISNULL([Local_Amount], 0) = ISNULL(@l_amt, 0)
    AND ISNULL([Share_Quantity], 0) = ISNULL(@l_share_qty, 0)
    AND ISNULL([Obligation_Number], 0) = ISNULL(@l_obl_nbr, 0)
    AND ISNULL([Product_Id], 0) = ISNULL(@l_prod_id, 0)
    AND ISNULL([Participant_ID], 0) = ISNULL(@l_part_id, 0)
    AND ISNULL(fee_code, 0) = ISNULL(@l_feecode_id, 0)
    AND ISNULL(remarks, 0) = ISNULL(@l_mssg, 0);

    FETCH NEXT FROM l_event_data_line_item_view_cur INTO @l_trans_id, @l_prj_id, @l_tran_nbr, @l_acc_nbr, @l_sub_acc_nbr, @l_post_date, @l_value_date, @l_curr_id, @l_usd_amt, @l_amt, @l_part_id, @l_feecode, @l_share_qty, @l_obl_nbr, @l_prod_id, @l_src_sys_name, @l_mssg;

  END
  CLOSE l_event_data_line_item_view_cur;
  DEALLOCATE l_event_data_line_item_view_cur;

END