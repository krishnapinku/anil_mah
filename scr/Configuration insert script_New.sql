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


 
  INSERT INTO [BEM].[Business_Event_Status] (name, description, visible, created_by, created_date, changed_by, changed_date)
    VALUES ('Posted to ODS Only', 'PCAL Posted to ODS', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name, description, visible, created_by, created_date, changed_by, changed_date)
    VALUES ('Posted to SAP Only', 'PCAL Posted to SAP', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status] (name, description, visible, created_by, created_date, changed_by, changed_date)
    VALUES ('Posted to ODS&SAP', 'PCAL Posted to ODS&SAP', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO bem.business_event_status (name, description, visible, created_by, created_date, changed_by, changed_date)
    VALUES ('Auto Processed', 'PCAL Auto Processed in case of Pass Thru', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())


  INSERT INTO bem.business_event_type_category (name, description, event_handler_id, event_data_provider_id, created_by, created_date, changed_by, changed_date)
    VALUES ('Post Closing Adjustment Ledger', 'Post Closing Adjustment Ledger', 27, 26, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())


  SELECT
    @l_bus_eve_type_cat_id = business_event_type_category_id
  FROM bem.business_event_type_category
  WHERE name = 'Post Closing Adjustment Ledger'

  INSERT INTO bem.business_event_type (name, code, description, category_id, active, manual_creation_supported, settlement_option_id, asset_class_id, changed_by, changed_date, created_by, created_date, extra_qualifier, investoronlyflag)
    VALUES ('PCAL Manual', 'PMAN', 'PCAL Adj Type Manual', @l_bus_eve_type_cat_id, 1, 1, 1, 3, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), NULL, 0)
  INSERT INTO bem.business_event_type (name, code, description, category_id, active, manual_creation_supported, settlement_option_id, asset_class_id, changed_by, changed_date, created_by, created_date, extra_qualifier, investoronlyflag)
    VALUES ('PCAL Original', 'ADJ', 'PCAL Adjustment', @l_bus_eve_type_cat_id, 1, 1, 1, 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), NULL, 0)
  INSERT INTO [BEM].[Business_Event_Sub_Type_Category]
    VALUES ('Post Closing Adjustment Ledger', 'Post Closing Adjustment Ledger', 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_sub_type_cat_id = business_event_sub_type_category_id
  FROM bem.business_event_sub_type_category
  WHERE name = 'Post Closing Adjustment Ledger'


  INSERT INTO [BEM].[Business_Event_Sub_Type] (name, description, business_event_sub_type_category_id, changed_by, changed_date, created_by, created_date)
    VALUES ('PCAL Share', 'PCAL Adj Sub Type Share Qty', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Sub_Type] (name, description, business_event_sub_type_category_id, changed_by, changed_date, created_by, created_date)
    VALUES ('PCAL Permanent', 'PCAL Adj Sub Type Permanent', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Sub_Type] (name, description, business_event_sub_type_category_id, changed_by, changed_date, created_by, created_date)
    VALUES ('PCAL Month End', 'PCAL Adj Sub Type Month End', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_sub_type_id1 = business_event_sub_type_id
  FROM bem.business_event_sub_type
  WHERE name = 'PCAL Share'
  SELECT
    @l_bus_eve_sub_type_id2 = business_event_sub_type_id
  FROM bem.business_event_sub_type
  WHERE name = 'PCAL Permanent'
  SELECT
    @l_bus_eve_sub_type_id3 = business_event_sub_type_id
  FROM bem.business_event_sub_type
  WHERE name = 'PCAL Month End'

  SELECT
    @l_bus_eve_type_id1 = business_event_type_id
  FROM bem.business_event_type
  WHERE name = 'PCAL Manual'
  SELECT
    @l_bus_eve_type_id2 = business_event_type_id
  FROM bem.business_event_type
  WHERE name = 'PCAL Original'
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_Id, business_Event_Sub_Type_Id, Use_In_FX_Changes, Use_In_Misc_Expenses, Created_By, Created_Date, Changed_By, Changed_Date)
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_Id, business_Event_Sub_Type_Id, Use_In_FX_Changes, Use_In_Misc_Expenses, Created_By, Created_Date, Changed_By, Changed_Date)
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id2, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_Id, business_Event_Sub_Type_Id, Use_In_FX_Changes, Use_In_Misc_Expenses, Created_By, Created_Date, Changed_By, Changed_Date)
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id3, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_Id, business_Event_Sub_Type_Id, Use_In_FX_Changes, Use_In_Misc_Expenses, Created_By, Created_Date, Changed_By, Changed_Date)
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_Id, business_Event_Sub_Type_Id, Use_In_FX_Changes, Use_In_Misc_Expenses, Created_By, Created_Date, Changed_By, Changed_Date)
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id2, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type] (Business_Event_Type_Id, business_Event_Sub_Type_Id, Use_In_FX_Changes, Use_In_Misc_Expenses, Created_By, Created_Date, Changed_By, Changed_Date)
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


  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (9, 'EQUITY-INVESTRAN')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (10, 'FTS')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (11, 'ASL-INVESTRAN')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (12, 'IPAR')

  INSERT INTO [INBOUND].[Business_Event_Mapper] ([Event_Type], [Description], [Unified_Object_Name], [Unified_Object_Type], [ClassHandler], [ExternalKeyFields], [CreateEntities], [System_Id])
    VALUES ('PCAL Original', 'PCAL Adjustment Imported Event for ACBS', 'INBOUND.IFC_Vw_PCAL_Adjustment_wfw', 'View', 'IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessorPCAL,BemInterfaceServices', 'Object_Id', 0, 1)

  INSERT INTO [INBOUND].[Business_Event_Mapper] ([Event_Type], [Description], [Unified_Object_Name], [Unified_Object_Type], [ClassHandler], [ExternalKeyFields], [CreateEntities], [System_Id])
    VALUES ('PCAL Original', 'PCAL Adjustment Imported Event for EQUITY-INVESTRAN', 'INBOUND.IFC_Vw_PCAL_Adjustment_wfw', 'View', 'IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessorPCAL,BemInterfaceServices', 'Object_Id', 0, 9)

  INSERT INTO [INBOUND].[Business_Event_Mapper] ([Event_Type], [Description], [Unified_Object_Name], [Unified_Object_Type], [ClassHandler], [ExternalKeyFields], [CreateEntities], [System_Id])
    VALUES ('PCAL Original', 'PCAL Adjustment Imported Event for FTS', 'INBOUND.IFC_Vw_PCAL_Adjustment_wfw', 'View', 'IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessorPCAL,BemInterfaceServices', 'Object_Id', 0, 10)

  INSERT INTO [INBOUND].[Business_Event_Mapper] ([Event_Type], [Description], [Unified_Object_Name], [Unified_Object_Type], [ClassHandler], [ExternalKeyFields], [CreateEntities], [System_Id])
    VALUES ('PCAL Original', 'PCAL Adjustment Imported Event for ASL-INVESTRAN', 'INBOUND.IFC_Vw_PCAL_Adjustment_wfw', 'View', 'IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessorPCAL,BemInterfaceServices', 'Object_Id', 0, 11)

  INSERT INTO [INBOUND].[Business_Event_Mapper] ([Event_Type], [Description], [Unified_Object_Name], [Unified_Object_Type], [ClassHandler], [ExternalKeyFields], [CreateEntities], [System_Id])
    VALUES ('PCAL Original', 'PCAL Adjustment Imported Event for IPAR', 'INBOUND.IFC_Vw_PCAL_Adjustment_wfw', 'View', 'IFC.BEM.Solutions.BemInterfaceServices.SuspenseAccountEventProcessorPCAL,BemInterfaceServices', 'Object_Id', 0, 12)



END;