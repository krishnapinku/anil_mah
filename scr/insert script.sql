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

  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Unread', 'Not Read by any PCAL User', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Authorizer Read', 'PCAL Authorizer Read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Processor Read', 'PCAL Processor Read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Admin Read', 'PCAL Admin Read', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Posted to ODS', 'PCAL Posted to ODS', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Posted to SAP', 'PCAL Posted to SAP', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Status]
    VALUES ('Posted to Both', 'PCAL Posted to Both', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO bem.business_event_status
    VALUES ('Auto Processed', 'PCAL Auto Processed in case of Pass Thru', 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  INSERT INTO bem.business_event_type_category
    VALUES ('PCAL Category', 'PCAL Category', 27, 26, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO bem.business_event_type_category
    VALUES ('PCAL Category', 'PCAL Category', 27, 26, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_type_cat_id = business_event_type_category_id
  FROM bem.business_event_type_category
  WHERE name = 'PCAL Category'

  INSERT INTO bem.business_event_type
    VALUES ('Manual', 'PMAN', 'PCAL Adj Type Manual', @l_bus_eve_type_cat_id, 1, 1, 1, 3, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), NULL, 0)
  INSERT INTO bem.business_event_type
    VALUES ('Adjustment', 'ADJ', 'PCAL Adjustment', @l_bus_eve_type_cat_id, 1, 1, 1, 1, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), NULL, 0)
  INSERT INTO [BEM].[Business_Event_Sub_Type_Category]
    VALUES ('PCAL Sub Category', 'PCAL Sub Category', 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())

  SELECT
    @l_bus_eve_sub_type_cat_id = business_event_sub_type_category_id
  FROM bem.business_event_sub_type_category
  WHERE name = 'PCAL Sub Category'

  INSERT INTO [BEM].[Business_Event_Sub_Type]
    VALUES ('Share', 'PCAL Adj Sub Type Share Qty', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Sub_Type]
    VALUES ('Permanent', 'PCAL Adj Sub Type Permanent', @l_bus_eve_sub_type_cat_id, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Sub_Type]
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

  INSERT INTO [BEM].[Business_Event_Specific_Type]
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type]
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id2, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type]
    VALUES (@l_bus_eve_type_id1, @l_bus_eve_sub_type_id3, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type]
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type]
    VALUES (@l_bus_eve_type_id2, @l_bus_eve_sub_type_id2, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE())
  INSERT INTO [BEM].[Business_Event_Specific_Type]
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

  INSERT INTO [BEM].Business_Event_Type_Configuration
    VALUES (@l_bus_eve_spec_type_id1, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration
    VALUES (@l_bus_eve_spec_type_id2, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration
    VALUES (@l_bus_eve_spec_type_id3, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystemr', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration
    VALUES (@l_bus_eve_spec_type_id4, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration
    VALUES (@l_bus_eve_spec_type_id5, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)
  INSERT INTO [BEM].Business_Event_Type_Configuration
    VALUES (@l_bus_eve_spec_type_id6, 1000, 5, 0, 1, 0, 0, 'IFC\PCALSystem', GETDATE(), 'IFC\PCALSystem', GETDATE(), 0, 0)

  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (9, 'Investran')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (10, 'FTS')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (11, 'ASL')
  INSERT INTO [INBOUND].[System_Definition] (System_id, System_Name)
    VALUES (12, 'IPAR')
END;