BEGIN
  DELETE FROM [BEM].[Business_Event_Status]
  WHERE Name IN ('Unread', 'Processor Read', 'Admin Read', 'Posted to ODS Only', 'Posted to SAP Only', 'Posted to ODS&SAP', 'Authorizer Read', 'Auto Processed')

  DELETE FROM [BEM].[Business_Event_Specific_Type]
  WHERE created_by LIKE '%IFC\PCAL%'

  DELETE FROM [BEM].[Business_Event_Sub_Type]
  WHERE name IN ('PCAL Share', 'PCAL Permanent', 'PCAL Month End')

  DELETE FROM [BEM].[Business_Event_Sub_Type_Category]
  WHERE name = 'Post Closing Adjustment Ledger'

  DELETE FROM bem.business_event_type
  WHERE name IN ('PCAL Original', 'PCAL Manual')

  DELETE FROM bem.business_event_type_category
  WHERE name IN ('Post Closing Adjustment Ledger', 'PCAL Configuration')

  DELETE FROM [BEM].Business_Event_Type_Configuration
  WHERE created_by LIKE '%IFC\PCAL%'

  DELETE FROM [INBOUND].[System_Definition]
  WHERE System_name IN ('EQUITY-INVESTRAN', 'FTS', 'ASL-INVESTRAN', 'IPAR')

  DELETE FROM [INBOUND].[Business_Event_Mapper]
  WHERE description LIKE '%PCAL%'
END