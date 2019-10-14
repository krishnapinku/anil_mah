BEGIN
  DELETE FROM [BEM].[Business_Event_Status]
  WHERE Name IN ('Unread', 'Processor Read', 'Admin Read', 'Posted to ODS', 'Posted to SAP', 'Posted to Both', 'Authorizer Read', 'Auto Processed')

  DELETE FROM [BEM].[Business_Event_Specific_Type]
  WHERE created_by LIKE '%IFC\PCAL%'

  DELETE FROM [BEM].[Business_Event_Sub_Type]
  WHERE name IN ('PCAL ADJUSTMENT', 'PCAL', 'Share', 'Permanent', 'Month End')

  DELETE FROM [BEM].[Business_Event_Sub_Type_Category]
  WHERE name = 'PCAL Sub Category'

  DELETE FROM bem.business_event_type
  WHERE name IN ('Adjustment', 'Original', 'Manual')

  DELETE FROM bem.business_event_type_category
  WHERE name IN ('PCAL  Configuration', 'PCAL Configuration')

  DELETE FROM [BEM].Business_Event_Type_Configuration
  WHERE created_by LIKE '%IFC\PCAL%'

  DELETE FROM [INBOUND].[System_Definition]
  WHERE System_name IN ('EQUITY-INVESTRAN', 'FTS', 'ASL-INVESTRAN', 'IPAR')

  DELETE FROM [INBOUND].[Business_Event_Mapper]
  WHERE description LIKE '%PCAL%'
END