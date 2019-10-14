BEGIN

  DECLARE @l_teamid1 int,
          @l_moduleid1 int,
          @l_teamid2 int,
          @l_userid1 int,
          @l_userid2 int;

  DELETE FROM dbo.fund_ts
  WHERE fundname = 'PCAL LE'

  DELETE FROM [dbo].[TS_Modules]
  WHERE modulename IN ('PCAL View Adjustment Transaction', 'PCAL Run Report', 'PCAL Process Adjustment Transaction', 'PCAL Dashboard', 'PCAL Details View', 'PCAL Search', 'PCAL Reports', 'PCAL Settings')

  DELETE FROM [dbo].[TS_User]
  WHERE username IN ('IFC\ugudise', 'IFC\VHassan', 'IFC\OBIRANGAL', 'IFC\FALUKKA', 'IFC\DSARAVANAN', 'ifc\kvinothkumar''ifc\agattamaneni')

  DELETE FROM [dbo].[TS_Teams]
  WHERE teamname IN ('BEM-PCAL-Admin', 'PCAL_Authorizer_Inv_ASL', 'PCAL_Processor_Inv_ASL', 'PCAL_Admin_Inv_ASL', 'PCAL_GeneralUsers_Inv_ASL', 'PCAL_GeneralUsers_FTS', 'PCAL_Authorizer_FTS', 'PCAL_Processor_FTS', 'PCAL_Admin_FTS', 'PCAL_GeneralUsers_IPAR', 'PCAL_Authorizer_IPAR', 'PCAL_Processor_IPAR', 'PCAL_Admin_IPAR', 'PCAL_GeneralUsers_ACBS', 'PCAL_Authorizer_ACBS', 'PCAL_Processor_ACBS', 'PCAL_Admin_ACBS')


  DECLARE l_team_cur CURSOR FOR
  SELECT distinct
    Team.teamid,
    Module.moduleid
  FROM [dbo].[TS_teams] Team
  JOIN [dbo].[TS_Entitlements] Entitle
    ON Team.teamid = Entitle.teamid
  JOIN [dbo].[TS_Modules] Module
    ON Entitle.securitymoduleid = Module.moduleid
  WHERE Module.modulename IN ('PCAL View Adjustment Transaction', 'PCAL Run Report', 'PCAL Authorize Adjustment Transaction', 'PCAL Process Adjustment Transaction', 'PCAL Dashboard', 'PCAL Search')
  AND T.teamname IN ('PCAL_Authorizer_Inv_ASL', 'PCAL_Processor_Inv_ASL', 'PCAL_Admin_Inv_ASL', 'PCAL_GeneralUsers_Inv_ASL')
  OPEN l_team_cur;
  FETCH NEXT FROM l_team_cur INTO @l_teamid1, @l_moduleid1;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    DELETE FROM [dbo].[TS_Entitlements]
    WHERE Team.teamid = @l_teamid1
      AND Module.moduleid = @l_moduleid1;
	    FETCH NEXT FROM l_team_cur INTO @l_teamid1, @l_moduleid1;
  END;
  CLOSE l_team_cur;
  DEALLOCATE l_team_cur;


  DECLARE l_user_cur CURSOR FOR
  SELECT distinct
    Team1.teamid,
    User1.userid
  FROM [dbo].[TS_teams] Team1
  JOIN dbo.TS_Membership Mem
    ON Team1.teamid = Mem.teamid
  JOIN dbo.TS_User User1
    ON User1.userid = Mem.userid
  WHERE Team1.teamname IN ('BEM-PCAL-Admin', 'PCAL_Authorizer_Inv_ASL', 'PCAL_Processor_Inv_ASL', 'PCAL_Admin_Inv_ASL', 'PCAL_GeneralUsers_Inv_ASL', 'PCAL_GeneralUsers_FTS', 'PCAL_Authorizer_FTS', 'PCAL_Processor_FTS', 'PCAL_Admin_FTS', 'PCAL_GeneralUsers_IPAR', 'PCAL_Authorizer_IPAR', 'PCAL_Processor_IPAR', 'PCAL_Admin_IPAR', 'PCAL_GeneralUsers_ACBS', 'PCAL_Authorizer_ACBS', 'PCAL_Processor_ACBS''PCAL_Admin_ACBS')
  AND U.username IN ('IFC\ugudise', 'IFC\VHassan', 'IFC\OBIRANGAL', 'IFC\FALUKKA', 'IFC\DSARAVANAN', 'ifc\kvinothkumar', 'ifc\agattamaneni')
  OPEN l_user_cur;
  FETCH NEXT FROM l_user_cur INTO @l_teamid2, @l_userid1;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    DELETE FROM dbo.TS_Membership
    WHERE Team1.teamid = @l_teamid2
      AND User1.userid = @l_userid1;
	    FETCH NEXT FROM l_user_cur INTO @l_teamid2, @l_userid1;
  END;
  CLOSE l_user_cur;
  DEALLOCATE l_user_cur;



  DECLARE l_authen_cur CURSOR FOR
  SELECT distinct
    User1.userid
  FROM dbo.TS_User U
  JOIN dbo.TS_User_AuthenticationType Authent
    ON User2.userid = Authent.userid
  WHERE User2.username IN ('IFC\ugudise', 'IFC\VHassan', 'IFC\OBIRANGAL', 'IFC\FALUKKA', 'IFC\DSARAVANAN', 'ifc\kvinothkumar', 'ifc\agattamaneni')
  OPEN l_authen_cur;
  FETCH NEXT FROM l_authen_cur INTO @l_userid2;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    DELETE FROM dbo.TS_Membership
    WHERE User2.userid = @l_userid2;
	  FETCH NEXT FROM l_authen_cur INTO @l_userid2;
  END;
  CLOSE l_authen_cur;
  DEALLOCATE l_authen_cur;


END