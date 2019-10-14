BEGIN

  DECLARE @l_bus_eve_spec_type_id1 int,
          @l_bus_eve_spec_type_id2 int,
          @l_bus_eve_spec_type_id3 int,
          @l_bus_eve_spec_type_id4 int,
          @l_bus_eve_spec_type_id5 int,
          @l_bus_eve_spec_type_id6 int,
          @l_bus_eve_sub_type_cat_id int,
          @l_bus_eve_sub_type_id1 int,
          @l_bus_eve_sub_type_id2 int,
          @l_bus_eve_sub_type_id3 int,
          @l_bus_eve_type_cat_id int,
          @l_bus_eve_type_id1 int,
          @l_bus_eve_type_id2 int;


  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('not read', 'already read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Authorizer Read', 'PCAL Authorizer Read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Processor Read', 'PCAL Processor Read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Admin Read', 'PCAL Admin Read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Posted to ODS', 'PCAL Posted to ODS', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Posted to SAP', 'PCAL Posted to SAP', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Posted to ODS&SAP', 'PCAL Posted to ODS&SAP', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO bem.business_event_status (name,description,visible,created_by,created_date,changed_by,changed_date)
    VALUES ('Auto Processed', 'PCAL Auto Processed in case of Pass Thru', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
 

  INSERT INTO bem.business_event_type_category (name,description,event_handler_id,event_data_provider_id,created_by,created_date,changed_by,changed_date)
    VALUES ('PCAL Category', 'PCAL Category', 27, 26, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
 

  SELECT
    @l_bus_eve_type_cat_id = business_event_type_category_id
  FROM bem.business_event_type_category
  WHERE name = 'PCAL Category'
  
  INSERT INTO bem.business_event_type (name,code,description,category_id,active,manual_creation_supported,settlement_option_id,asset_class_id,changed_by,changed_date,created_by,created_date,extra_qualifier,investoronlyflag)
    VALUES ('Manual', 'PMAN', 'PCAL Adj Type Manual', @l_bus_eve_type_cat_id, 1, 1, 1, 3, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), NULL, 0)
  INSERT INTO bem.business_event_type (name,code,description,category_id,active,manual_creation_supported,settlement_option_id,asset_class_id,changed_by,changed_date,created_by,created_date,extra_qualifier,investoronlyflag)
    VALUES ('Adjustment', 'ADJ', 'PCAL Adjustment', @l_bus_eve_type_cat_id, 1, 1, 1, 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), NULL, 0)
  INSERT INTO [BEM].[Business_Event_Sub_Type_Category] 
    VALUES ('PCAL Sub Category', 'PCAL Sub Category', 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_sub_type_cat_id = business_event_sub_type_category_id
  FROM bem.business_event_sub_type_category
  WHERE name = 'PCAL Sub Category'


  INSERT INTO [BEM].[Business_Event_Sub_Type] (name,description,business_event_sub_type_category_id,changed_by,changed_date,created_by,created_date)
    VALUES ('Share', 'PCAL Adj Sub Type Share Qty', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Sub_Type] (name,description,business_event_sub_type_category_id,changed_by,changed_date,created_by,created_date)
    VALUES ('Permanent', 'PCAL Adj Sub Type Permanent', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Sub_Type] (name,description,business_event_sub_type_category_id,changed_by,changed_date,created_by,created_date)
    VALUES ('Month End', 'PCAL Adj Sub Type Month End', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_sub_type_id1 = business_event_sub_type_id
  FROM bem.business_event_sub_type
  WHERE name = 'Share'
  SELECT
    @l_bus_eve_sub_type_id2 = business_event_sub_type_id
  FROM bem.business_event_sub_type
  WHERE name = 'Permanent'
  SELECT
    @l_bus_eve_sub_type_id3 = business_event_sub_type_id
  FROM bem.business_event_sub_type
  WHERE name = 'Month End'

  SELECT
    @l_bus_eve_type_id1 = business_event_type_id
  FROM bem.business_event_type
  WHERE name = 'Manual'
  SELECT
    @l_bus_eve_type_id2 = business_event_type_id
  FROM bem.business_event_type
  WHERE name = 'Adjustment'
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_I,business_Event_Sub_Type_Id,Use_In_FX_Changes,Use_In_Misc_Expenses,Created_By,Created_Date,Changed_By,Changed_Date)
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_I,business_Event_Sub_Type_Id,Use_In_FX_Changes,Use_In_Misc_Expenses,Created_By,Created_Date,Changed_By,Changed_Date)
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id2, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_I,business_Event_Sub_Type_Id,Use_In_FX_Changes,Use_In_Misc_Expenses,Created_By,Created_Date,Changed_By,Changed_Date)
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id3, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_I,business_Event_Sub_Type_Id,Use_In_FX_Changes,Use_In_Misc_Expenses,Created_By,Created_Date,Changed_By,Changed_Date)
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_I,business_Event_Sub_Type_Id,Use_In_FX_Changes,Use_In_Misc_Expenses,Created_By,Created_Date,Changed_By,Changed_Date) 
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id2, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_I,business_Event_Sub_Type_Id,Use_In_FX_Changes,Use_In_Misc_Expenses,Created_By,Created_Date,Changed_By,Changed_Date)
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id3, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_spec_type_id1 = business_event_specific_type_id
  FROM bem.Business_Event_Specific_Type
  WHERE business_event_type_id = @l_bus_eve_type_id1
  AND business_event_sub_type_id = @l_bus_eve_sub_type_id1
  SELECT
    @l_bus_eve_spec_type_id2 = business_event_specific_type_id
  FROM bem.Business_Event_Specific_Type
  WHERE business_event_type_id = @l_bus_eve_type_id1
  AND business_event_sub_type_id = @l_bus_eve_sub_type_id2
  SELECT
    @l_bus_eve_spec_type_id3 = business_event_specific_type_id
  FROM bem.Business_Event_Specific_Type
  WHERE business_event_type_id = @l_bus_eve_type_id1
  AND business_event_sub_type_id = @l_bus_eve_sub_type_id3
  SELECT
    @l_bus_eve_spec_type_id4 = business_event_specific_type_id
  FROM bem.Business_Event_Specific_Type
  WHERE business_event_type_id = @l_bus_eve_type_id2
  AND business_event_sub_type_id = @l_bus_eve_sub_type_id1
  SELECT
    @l_bus_eve_spec_type_id5 = business_event_specific_type_id
  FROM bem.Business_Event_Specific_Type
  WHERE business_event_type_id = @l_bus_eve_type_id2
  AND business_event_sub_type_id = @l_bus_eve_sub_type_id2
  SELECT
    @l_bus_eve_spec_type_id6 = business_event_specific_type_id
  FROM bem.Business_Event_Specific_Type
  WHERE business_event_type_id = @l_bus_eve_type_id2
  AND business_event_sub_type_id = @l_bus_eve_sub_type_id3

  INSERT INTO [BEM].Business_Event_Type_Configuration (Business_Event_Specific_Type_Id,Business_Event_Instrument_Type_Id,Proration_Method_Id,Calculate_Cost_Of_Sale,Enforce_Maker_Checker,Include_Swift_Data,RevolvingCommitment,Created_By,Created_Date,Changed_By,Changed_Date,Calculate_Cost_Of_Sale_Cash_Basis,Include_Trans_With_Zero_Amounts)
    VALUES (@l_bus_eve_spec_type_id1, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration (Business_Event_Specific_Type_Id,Business_Event_Instrument_Type_Id,Proration_Method_Id,Calculate_Cost_Of_Sale,Enforce_Maker_Checker,Include_Swift_Data,RevolvingCommitment,Created_By,Created_Date,Changed_By,Changed_Date,Calculate_Cost_Of_Sale_Cash_Basis,Include_Trans_With_Zero_Amounts)
    VALUES (@l_bus_eve_spec_type_id2, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration (Business_Event_Specific_Type_Id,Business_Event_Instrument_Type_Id,Proration_Method_Id,Calculate_Cost_Of_Sale,Enforce_Maker_Checker,Include_Swift_Data,RevolvingCommitment,Created_By,Created_Date,Changed_By,Changed_Date,Calculate_Cost_Of_Sale_Cash_Basis,Include_Trans_With_Zero_Amounts)
    VALUES (@l_bus_eve_spec_type_id3, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration (Business_Event_Specific_Type_Id,Business_Event_Instrument_Type_Id,Proration_Method_Id,Calculate_Cost_Of_Sale,Enforce_Maker_Checker,Include_Swift_Data,RevolvingCommitment,Created_By,Created_Date,Changed_By,Changed_Date,Calculate_Cost_Of_Sale_Cash_Basis,Include_Trans_With_Zero_Amounts)
    VALUES (@l_bus_eve_spec_type_id4, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration (Business_Event_Specific_Type_Id,Business_Event_Instrument_Type_Id,Proration_Method_Id,Calculate_Cost_Of_Sale,Enforce_Maker_Checker,Include_Swift_Data,RevolvingCommitment,Created_By,Created_Date,Changed_By,Changed_Date,Calculate_Cost_Of_Sale_Cash_Basis,Include_Trans_With_Zero_Amounts)
    VALUES (@l_bus_eve_spec_type_id5, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration (Business_Event_Specific_Type_Id,Business_Event_Instrument_Type_Id,Proration_Method_Id,Calculate_Cost_Of_Sale,Enforce_Maker_Checker,Include_Swift_Data,RevolvingCommitment,Created_By,Created_Date,Changed_By,Changed_Date,Calculate_Cost_Of_Sale_Cash_Basis,Include_Trans_With_Zero_Amounts)
    VALUES (@l_bus_eve_spec_type_id6, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)


  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (9, 'Investran')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (10, 'FTS')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (11, 'ASL')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (12, 'IPAR')

INSERT INTO [INBOUND].[Business_Event_Mapper] ([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type] ,[ClassHandler],[ExternalKeyFields] ,[CreateEntities],[System_Id])
     VALUES ('Adjustment_Header','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Header_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,1)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type] ,[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,1)


INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,1)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data_Line','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_Line_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,1)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Header','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Header_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,9)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,9)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,9)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data_Line','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_Line_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,9)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Header','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Header_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,10)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,10)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,10)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data_Line','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_Line_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,10)


INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Header','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Header_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,11)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,11)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,11)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data_Line','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_Line_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,11)


INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Header','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Header_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,12)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,12)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,12)

INSERT INTO [INBOUND].[Business_Event_Mapper]([Event_Type],[Description],[Unified_Object_Name],[Unified_Object_Type],[ClassHandler],[ExternalKeyFields],[CreateEntities],[System_Id])
     VALUES('Adjustment_Event_Data_Line','PCAL Adjustment Imported Event','INBOUND.IFC_Vw_PCAL_Event_Data_Line_wfw','View','IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessor,BemInterfaceServices','Object_Id',0,12)



END;



