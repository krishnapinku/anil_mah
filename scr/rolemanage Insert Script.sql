begin

declare
@l_ts_user_contactid1 int,
@l_ts_user_contactid2 int,
@l_ts_user_contactid3 int,
@l_ts_user_contactid4 int,
@l_ts_user_contactid5 int,
@l_ts_user_contactid6 int,
@l_ts_user_contactid7 int,
@l_ts_entitle_moduleid1 int,
@l_ts_entitle_moduleid2 int,
@l_ts_entitle_moduleid3 int,
@l_ts_entitle_moduleid4 int,
@l_ts_entitle_moduleid5 int,
@l_ts_entitle_moduleid6 int,
@l_ts_entitle_teamid2 int,
@l_ts_entitle_teamid3 int,
@l_ts_entitle_teamid4 int,
@l_ts_entitle_teamid5 int,
@l_ts_members_teamid1 int,
@l_ts_members_teamid2 int,
@l_ts_members_teamid3 int,
@l_ts_members_teamid4 int,
@l_ts_members_teamid5 int,
@l_ts_members_teamid6 int,
@l_ts_members_teamid7 int,
@l_ts_members_teamid8 int,
@l_ts_members_teamid9 int,
@l_ts_members_teamid10 int,
@l_ts_members_teamid11 int,
@l_ts_members_teamid12 int,
@l_ts_members_teamid13 int,
@l_ts_members_teamid14 int,
@l_ts_members_teamid15 int,
@l_ts_members_teamid16 int,
@l_ts_members_teamid17 int,
@l_ts_members_userid1 int,
@l_ts_members_userid2 int,
@l_ts_members_userid3 int,
@l_ts_members_userid4 int,
@l_ts_members_userid5 int,
@l_ts_members_userid6 int,
@l_ts_members_userid7 int,



insert into dbo.fund_ts(fundname,launchdt,lastdt,expdt,renewalopt,targetsize,purpose,maxsizpvt,maxsizpub,maxsizfrgn,currencyid,fundtypeid,ispooled,currstatusid,feeaffcmt,limitsrinpct,maxgppct,comtlmtpct,mininstcomt,maxinstcomt,minindvcomt,maxindvcomt,mininstpct,maxinstpct,minindvpct,maxindvpct,mininstpct,maxinstpct,minindvpct.maxindvpct,funddirectorg,funddirectdeal,regrating,le_code_01,le_code_02,isgp,isparticipant,isdoubleentry,regk,regy,fhc,entitytypeid,useendyearclose,fiscalyearend,contactid,changedby,changeddate,targetstatusid,usedbypreview,accountnumber,costallocationid,createdby,createddate,reviewstatusid,domainid,isliquid,fundnamealias,paymentinstructionid,version)values('PCAL LE','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',14,'NULL',0,'NULL',0,0,0,'NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL','NULL',1,0,1,0,0,0,0,0,'NULL',7839,'IFC\ugudise',GETDATE(),'NULL',0,'NULL','NULL','IFC\ugudise',GETDATE(),-1,-1,0,'NULL','NULL',1)

insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL View Adjustment Transaction','PCAL View Adjustment Transaction',NEWID(),4,0)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Run Report','PCAL Run Report',NEWID(),4,0)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Authorize Adjustment Transaction','PCAL Authorize Adjustment Transaction',NEWID(),4,0)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Process Adjustment Transaction','PCAL Process Adjustment Transaction',NEWID(),4,0)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Dashboard','PCAL Dashboard',NEWID(),0,2)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Details View','PCAL Details View',NEWID(),0,0)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Search','PCAL Search',NEWID(),4,0)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Reports','PCAL Reports',NEWID(),0,2)
insert into [dbo].[TS_Modules](modulename,moduledescription,moduleuniqueidentifier,availablerights,dataoractionmodule) values ('PCAL Settings','PCAL Settings',NEWID(),4,0)


select @l_ts_user_contactid1 = contactid from dbo.CM_Contact_TS where name = 'IFC\VHassan'
select @l_ts_user_contactid2 = contactid from dbo.CM_Contact_TS where name = 'IFC\ugudise'
select @l_ts_user_contactid3 = contactid from dbo.CM_Contact_TS where name ='ifc\kvinothkumar'
select @l_ts_user_contactid4 = contactid from dbo.CM_Contact_TS where  FileAs ='IFC\AGATTAMANENI'
select @l_ts_user_contactid5 = contactid from dbo.CM_Contact_TS where  FileAs = 'IFC\OBIRANGAL'
select @l_ts_user_contactid6 = contactid from dbo.CM_Contact_TS where  FileAs = 'IFC\FALUKKA'
select @l_ts_user_contactid7 = contactid from dbo.CM_Contact_TS where  FileAs = 'IFC\DSARAVANAN'


insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid2','IFC\ugudise','NULL',GETDATE(),'IFC\DKulkarni1',GETDATE(),'IFC\DKulkarni1',0,'NULL','NULL')
insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid1','IFC\VHassan','NULL',GETDATE(),'IFC\DKulkarni1',GETDATE(),'IFC\DKulkarni1',0,'NULL','NULL')
insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid5','IFC\OBIRANGAL','NULL',GETDATE(),'IFC\ugudise',GETDATE(),'IFC\ugudise',0,'NULL','NULL')
insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid6','IFC\FALUKKA','NULL',GETDATE(),'IFC\ugudise',GETDATE(),'IFC\ugudise',0,'NULL','NULL')
insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid7','IFC\DSARAVANAN','NULL',GETDATE(),'IFC\ugudise',GETDATE(),'IFC\ugudise',0,'NULL','NULL')
insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid3','ifc\kvinothkumar','NULL',GETDATE(),'IFC\skalpande',GETDATE(),'IFC\skalpande',0,'NULL','NULL')
insert into [dbo].[TS_User](contactid,username,federatedid,createddate,createdby,changeddate,changedby,disabled,dxcredentialusername,dxcredentialpass) values ('@l_ts_user_contactid4','ifc\agattamaneni','NULL',GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,'NULL','NULL')


insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('BEM-PCAL-Admin','PCAL Application Admin',GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Authorizer_Inv_ASL','PCAL_Authorizer_Inv_ASL',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Processor_Inv_ASL','PCAL_Processor_Inv_ASL',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Admin_Inv_ASL','PCAL_Admin_Inv_ASL',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_GeneralUsers_Inv_ASL','PCAL_GeneralUsers_Inv_ASL',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_GeneralUsers_FTS','PCAL_GeneralUsers_FTS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Authorizer_FTS','PCAL_Authorizer_FTS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Processor_FTS','PCAL_Processor_FTS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Admin_FTS','PCAL_Admin_FTS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_GeneralUsers_IPAR','PCAL_GeneralUsers_IPAR',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Authorizer_IPAR','PCAL_Authorizer_IPAR',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Processor_IPAR','PCAL_Processor_IPAR',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Admin_IPAR','PCAL_Admin_IPAR',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_GeneralUsers_ACBS','PCAL_GeneralUsers_ACBS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Authorizer_ACBS','PCAL_Authorizer_ACBS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Processor_ACBS','PCAL_Processor_ACBS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')
insert into [dbo].[TS_Teams](teamname,teamdescription,createddate,createdby,changeddate,changedby) values ('PCAL_Admin_ACBS','PCAL_Admin_ACBS',GETDATE(),'ifc\vhassan',GETDATE(),'ifc\vhassan')

select * from [dbo].[TS_Entitlements]
select @l_ts_entitle_moduleid1 = moduleid from dbo.TS_Modules where modulename = 'PCAL View Adjustment Transaction' 
select @l_ts_entitle_moduleid2 = moduleid from dbo.TS_Modules where modulename = 'PCAL Run Report' 
select @l_ts_entitle_moduleid3 = moduleid from dbo.TS_Modules where modulename = 'PCAL Authorize Adjustment Transaction' 
select @l_ts_entitle_moduleid4 = moduleid from dbo.TS_Modules where modulename = 'PCAL Process Adjustment Transaction' 
select @l_ts_entitle_moduleid5 = moduleid from dbo.TS_Modules where modulename = 'PCAL Dashboard' 
select @l_ts_entitle_moduleid6 = moduleid from dbo.TS_Modules where modulename = 'PCAL Search' 

select @l_ts_entitle_teamid2 = teamid from dbo.TS_Teams where teamname = 'PCAL_Authorizer_Inv_ASL' 
select @l_ts_entitle_teamid3 = teamid from dbo.TS_Teams where teamname = 'PCAL_Processor_Inv_ASL'
select @l_ts_entitle_teamid4 = teamid from dbo.TS_Teams where teamname = 'PCAL_Admin_Inv_ASL' 
select @l_ts_entitle_teamid5 = teamid from dbo.TS_Teams where teamname = 'PCAL_GeneralUsers_Inv_ASL' 



insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',0,0,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid1',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,-1,'@l_ts_entitle_moduleid1',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',0,0,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid2',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid2',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',0,0,1,0,0,0,0,0,GETDATE(),'ifc\kvinothkumar',GETDATE(),'ifc\kvinothkumar',0,-1,'@l_ts_entitle_moduleid3',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid3',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',0,0,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid4',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',0,0,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid5',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid2',0,0,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid6',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid3',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,-1,'@l_ts_entitle_moduleid1',0)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid3',1,1,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid1',2)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid3',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid2',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid3',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid2',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid3',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid3',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid3',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid4',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid4',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,-1,'@l_ts_entitle_moduleid1',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid4',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid2',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid4',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid3',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid4',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid4',1)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid5',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,-1,'@l_ts_entitle_moduleid1',2)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid5',1,1,1,1,1,1,1,1,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem',1,6,'@l_ts_entitle_moduleid2',2)
insert into [dbo].[TS_Entitlements](teamid,readaccess,addaccess,updateaccess,deleteaccess,postaccess,unpostaccess,executeaccess,rollbackaccess,createddate,createdby,changeddate,changedby,importaccess,domainid,securitymoduleid,entitlementtype) values ('@l_ts_entitle_teamid5',0,0,1,0,0,0,0,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan',0,-1,'@l_ts_entitle_moduleid3',0)



select @l_ts_members_teamid1 = teamid from dbo.TS_Teams where teamname = 'BEM-PCAL-Admin' 
select @l_ts_members_teamid2 = teamid from dbo.TS_Teams where teamname = 'PCAL_Authorizer_Inv_ASL'
select @l_ts_members_teamid3 = teamid from dbo.TS_Teams where teamname = 'PCAL_Processor_Inv_ASL' 
select @l_ts_members_teamid4 = teamid from dbo.TS_Teams where teamname = 'PCAL_Admin_Inv_ASL'
select @l_ts_members_teamid5 = teamid from dbo.TS_Teams where teamname = 'PCAL_GeneralUsers_Inv_ASL'
select @l_ts_members_teamid6 = teamid from dbo.TS_Teams where teamname = 'PCAL_GeneralUsers_FTS' 
select @l_ts_members_teamid7 = teamid from dbo.TS_Teams where teamname = 'PCAL_Authorizer_FTS' 
select @l_ts_members_teamid8 = teamid from dbo.TS_Teams where teamname = 'PCAL_Processor_FTS' 
select @l_ts_members_teamid9 = teamid from dbo.TS_Teams where teamname = 'PCAL_Admin_FTS' 
select @l_ts_members_teamid10 = teamid from dbo.TS_Teams where teamname = 'PCAL_GeneralUsers_IPAR' 
select @l_ts_members_teamid11 = teamid from dbo.TS_Teams where teamname = 'PCAL_Authorizer_IPAR' 
select @l_ts_members_teamid12 = teamid from dbo.TS_Teams where teamname = 'PCAL_Processor_IPAR' 
select @l_ts_members_teamid13 = teamid from dbo.TS_Teams where teamname = 'PCAL_Admin_IPAR' 
select @l_ts_members_teamid14 = teamid from dbo.TS_Teams where teamname = 'PCAL_GeneralUsers_ACBS' 
select @l_ts_members_teamid15 = teamid from dbo.TS_Teams where teamname = 'PCAL_Authorizer_ACBS' 
select @l_ts_members_teamid16 = teamid from dbo.TS_Teams where teamname = 'PCAL_Processor_ACBS'
select @l_ts_members_teamid17 = teamid from dbo.TS_Teams where teamname = 'PCAL_Admin_ACBS' 



select @l_ts_members_userid1 = userid from dbo.TS_User  where username = 'IFC\ugudise' 
select @l_ts_members_userid2 = userid from dbo.TS_User  where username = 'IFC\VHassan' 
select @l_ts_members_userid3 = userid from dbo.TS_User  where username = 'IFC\OBIRANGAL' 
select @l_ts_members_userid4 = userid from dbo.TS_User  where username = 'IFC\FALUKKA' 
select @l_ts_members_userid5 = userid from dbo.TS_User  where username = 'IFC\DSARAVANAN' 
select @l_ts_members_userid6 = userid from dbo.TS_User  where username = 'ifc\kvinothkumar' 
select @l_ts_members_userid7 = userid from dbo.TS_User  where username = 'ifc\agattamaneni' 

insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid1,@l_ts_members_userid6,0,GETDATE(),'IFC\skalpande',GETDATE(),'IFC\skalpande')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid1,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid1,@l_ts_members_userid7,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid2,@l_ts_members_userid1,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid2,@l_ts_members_userid3,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid2,@l_ts_members_userid4,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid2,@l_ts_members_userid2,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid3,@l_ts_members_userid1,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid3,@l_ts_members_userid2,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid3,@l_ts_members_userid3,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid3,@l_ts_members_userid4,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid4,@l_ts_members_userid1,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid4,@l_ts_members_userid2,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid4,@l_ts_members_userid3,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid4,@l_ts_members_userid4,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid5,@l_ts_members_userid1,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid5,@l_ts_members_userid2,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid5,@l_ts_members_userid3,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid5,@l_ts_members_userid4,0,GETDATE(),'IFC\PCALSystem',GETDATE(),'IFC\PCALSystem')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid2,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid3,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid4,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid5,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid6,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid7,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid8,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid9,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid10,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid11,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid12,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid13,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid14,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid15,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid16,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')
insert into dbo.TS_Membership(teamid,userid,status,createddate,createdby,changeddate,changedby) values(@l_ts_members_teamid17,@l_ts_members_userid5,0,GETDATE(),'IFC\VHassan',GETDATE(),'IFC\VHassan')

insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid1,4)
insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid2,4)
insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid3,4)
insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid4,4)
insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid5,4)
insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid6,4)
insert into dbo.TS_User_AuthenticationType(userid,authenticationtypeid) values ( @l_ts_members_userid7,1)



end;




































