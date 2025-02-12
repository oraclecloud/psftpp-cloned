--Find All Records which contain OBJECTOWNERID
SELECT DISTINCT R.RECNAME, RECD.RECDESCR, RECD.SQLTABLENAME, RECD.OBJECTOWNERID,
      CASE(NVL(RECD.RECTYPE, 99)) WHEN 0 THEN '0 - SQL Table' WHEN 1 THEN '1 - SQL View' WHEN 2 THEN '2 - Work Record' WHEN 3 THEN '3 - Sub Record' WHEN 5 THEN '5 - Dynamic View'
                                  WHEN 6 THEN '6 - Query View' WHEN 7 THEN '7 - Temporary Table'
      ELSE 'Excluded Record or Deleted' END AS "Record Type"
FROM PSRECFIELDDB R, PSRECDEFN RECD
WHERE R.RECNAME = RECD.RECNAME
  AND R.FIELDNAME = 'OBJECTOWNERID'
ORDER BY R.RECNAME;
 
--Record list has been arrived at as follows
--1. Filter on OBJECTOWNERIDs (PPT and C%), then
--2. Filter on SQL Table and Views
 
--Drop Table
--DROP TABLE PS_FSCM_OBJOWN_BY_OBJECTTYPE;
 
--Create Table
CREATE TABLE PS_FSCM_OBJOWN_BY_OBJECTTYPE
AS
SELECT CAST(' ' AS VARCHAR2(2000)) "OBJECTTYPE", CAST(' ' AS VARCHAR2(10)) "OBJECTOWNERID" FROM DUAL WHERE 1 = 2;
 
--Verify
SELECT * FROM PS_FSCM_OBJOWN_BY_OBJECTTYPE;
 
--INSERT
INSERT INTO PS_FSCM_OBJOWN_BY_OBJECTTYPE (OBJECTTYPE, OBJECTOWNERID)
WITH NEW_TABLE AS (
SELECT DISTINCT 'Approval Rule Defn Hdr' AS OBJECTTYPE, OBJECTOWNERID FROM PS_APPR_RULE_HDR UNION ALL
SELECT DISTINCT 'Approval Transaction Registry' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOAW_TXN UNION ALL
SELECT DISTINCT 'Component OwnerID View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOCP_OWNERID_VW UNION ALL
SELECT DISTINCT 'Component OwnerID View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOCP_OWNRID_LVW UNION ALL
SELECT DISTINCT 'Classic Plus component list' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOCP_PNLGRP UNION ALL
SELECT DISTINCT 'Classic Plus component list' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOCP_PNLGRP_AET UNION ALL
SELECT DISTINCT 'Appointment Registration' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODI_APT_REG UNION ALL
SELECT DISTINCT 'Address Book Registration' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODI_CON_REG UNION ALL
SELECT DISTINCT 'Dynamic Display Info' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODI_DYN UNION ALL
SELECT DISTINCT 'Task Registration Header' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODI_TSK_REG UNION ALL
SELECT DISTINCT 'Task Reg Queue View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODI_TSK_REG_VW UNION ALL
SELECT DISTINCT 'File Transfer Registration' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODI_XFR_REG UNION ALL
SELECT DISTINCT 'Sample Data Application Group' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODU_APPLICATN UNION ALL
SELECT DISTINCT 'View SQL Table Records' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EODU_REC_TBL_VW UNION ALL
SELECT DISTINCT 'Emb Help View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOEC_EMB_HELPVW UNION ALL
SELECT DISTINCT 'Embedded help view' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOEC_EMH_PGVW UNION ALL
SELECT DISTINCT 'ETL Map run time copy' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOEW_EXE_MAP UNION ALL
SELECT DISTINCT 'Prompt on DBFIELDs.' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOEW_PSFIELD_VW UNION ALL
SELECT DISTINCT 'Page Composer Section AET' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCMAINDSTMP UNION ALL
SELECT DISTINCT 'Page Composer Section' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCMAIN_DISP UNION ALL
SELECT DISTINCT 'EOPCMAIN_DISPVW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCMAIN_DISPVW UNION ALL
SELECT DISTINCT 'EOPCMAIN_DSP1VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCMAIN_DSP1VW UNION ALL
SELECT DISTINCT 'EOPCMAIN_DPS2VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCMAIN_DSP2VW UNION ALL
SELECT DISTINCT 'Data Mover Temporary' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCMIG_MD_TMP UNION ALL
SELECT DISTINCT 'EOPCR_MNDISP_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCR_MNDISP2VW UNION ALL
SELECT DISTINCT 'EOPCR_MNDISP_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPCR_MNDISP_VW UNION ALL
SELECT DISTINCT 'PUM Scrty Automation Tool main' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPM_SUPD_TBL UNION ALL
SELECT DISTINCT 'EOPP_CPPROJ_AET' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPP_CPPROJ_AET UNION ALL
SELECT DISTINCT 'Installation Options' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOPP_OPTIONS UNION ALL
SELECT DISTINCT 'Message Set Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_MSGCAT_WRK UNION ALL
SELECT DISTINCT 'Job Definition Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_JOBDFN UNION ALL
SELECT DISTINCT 'Process Definition Object Own.' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_MODALS UNION ALL
SELECT DISTINCT 'Message Set Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_MSGCAT UNION ALL
SELECT DISTINCT 'Message Set Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_MSGSET UNION ALL
SELECT DISTINCT 'Job Definition Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_PRCSDF UNION ALL
SELECT DISTINCT 'Query Definintion Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_QRY UNION ALL
SELECT DISTINCT 'Process Definition Object Own.' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_RECUR UNION ALL
SELECT DISTINCT 'String Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_ROLE UNION ALL
SELECT DISTINCT 'String Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_STRING UNION ALL
SELECT DISTINCT 'Message Set Object Owner' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_OWN_TREE UNION ALL
SELECT DISTINCT 'Product Object Owners' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_PROD_OWN UNION ALL
SELECT DISTINCT 'Product Object Owners' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_PROD_OWNNT UNION ALL
SELECT DISTINCT 'System Data Rec Where Clause' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EOTR_PT_RECWHER UNION ALL
SELECT DISTINCT 'EO  AE Application View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EO_AE_APPL_VW UNION ALL
SELECT DISTINCT 'Comp Interfaces OwnerID View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EO_BCOWNRID_VW UNION ALL
SELECT DISTINCT 'Comp Interfaces OwnerID View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EO_BIOWNRID_VW UNION ALL
SELECT DISTINCT 'PSFT Table Relationships' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EO_ERD_TBL UNION ALL
SELECT DISTINCT 'Messages by OwnerID View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_EO_MSGOWNRID_VW UNION ALL
SELECT DISTINCT 'Sys Delivered My Work Links' AS OBJECTTYPE, OBJECTOWNERID FROM PS_FSPC_SYS_MYWORK UNION ALL
SELECT DISTINCT 'View on Owner for Sys Links' AS OBJECTTYPE, OBJECTOWNERID FROM PS_FSPC_SYS_OWR_VW UNION ALL
SELECT DISTINCT 'IB Upgrade Chanel migration' AS OBJECTTYPE, OBJECTOWNERID FROM PS_IB_CHANNEL_AET UNION ALL
SELECT DISTINCT 'AE Application Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PS_IB_XSLTBLD_VW UNION ALL
SELECT DISTINCT 'System Data Rec Where Clause' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PM_PS_REC_WHERE UNION ALL
SELECT DISTINCT 'PSACEMDLDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSACEMDLDEFN UNION ALL
SELECT DISTINCT 'Activity Description' AS OBJECTTYPE, OBJECTOWNERID FROM PSACTIVITYDEFN UNION ALL
SELECT DISTINCT 'ADS Data Set Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSADSDEFN UNION ALL
SELECT DISTINCT 'Data Set Properties' AS OBJECTTYPE, OBJECTOWNERID FROM PSADSPROPERTY UNION ALL
SELECT DISTINCT 'AE Application Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSAEAPPLDEFN UNION ALL
SELECT DISTINCT 'Archiving Object Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSARCHOBJDEFN UNION ALL
SELECT DISTINCT 'Archive Template Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSARCHTEMPLATE UNION ALL
SELECT DISTINCT 'Comp Intfc Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSBCDEFN UNION ALL
SELECT DISTINCT 'IB View of CIs' AS OBJECTTYPE, OBJECTOWNERID FROM PSBCDEFN_VW3 UNION ALL
SELECT DISTINCT 'Business Process Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSBUSPROCDEFN UNION ALL
SELECT DISTINCT 'Certificates' AS OBJECTTYPE, OBJECTOWNERID FROM PSCERTDEFN UNION ALL
SELECT DISTINCT 'Channel Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSCHNLDEFN UNION ALL
SELECT DISTINCT 'Connected Queries Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSCONQRSDEFN UNION ALL
SELECT DISTINCT 'PSCONTDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSCONTDEFN UNION ALL
SELECT DISTINCT 'CPQDM definition table' AS OBJECTTYPE, OBJECTOWNERID FROM PSCPQDEFN UNION ALL
SELECT DISTINCT 'Cube connection definitions.' AS OBJECTTYPE, OBJECTOWNERID FROM PSCUBCONNECTID UNION ALL
SELECT DISTINCT 'Cube Dimensions' AS OBJECTTYPE, OBJECTOWNERID FROM PSCUBDIMENSION UNION ALL
SELECT DISTINCT 'Cube Outline' AS OBJECTTYPE, OBJECTOWNERID FROM PSCUBOUTLINE UNION ALL
SELECT DISTINCT 'Cube templates.' AS OBJECTTYPE, OBJECTOWNERID FROM PSCUBTEMPL UNION ALL
SELECT DISTINCT 'Database Field' AS OBJECTTYPE, OBJECTOWNERID FROM PSDBFIELD UNION ALL
SELECT DISTINCT 'Diagnostic Framework' AS OBJECTTYPE, OBJECTOWNERID FROM PSDIAGREG UNION ALL
SELECT DISTINCT 'Document Layout Manager' AS OBJECTTYPE, OBJECTOWNERID FROM PSDOCLODEFN UNION ALL
SELECT DISTINCT 'Document PC  Managed Object' AS OBJECTTYPE, OBJECTOWNERID FROM PSDOCPCDFN UNION ALL
SELECT DISTINCT 'Document Schema Managed Object' AS OBJECTTYPE, OBJECTOWNERID FROM PSDOCSCMADFN UNION ALL
SELECT DISTINCT 'Document Template Defintion' AS OBJECTTYPE, OBJECTOWNERID FROM PSDOCTPLDEFN UNION ALL
SELECT DISTINCT 'PSFILEDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSFILEDEFN UNION ALL
SELECT DISTINCT 'PSFILEREDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSFILEREDEFN UNION ALL
SELECT DISTINCT 'Feed Category' AS OBJECTTYPE, OBJECTOWNERID FROM PSFP_CATEGORY UNION ALL
SELECT DISTINCT 'Feed Data Type' AS OBJECTTYPE, OBJECTOWNERID FROM PSFP_DATATYPE UNION ALL
SELECT DISTINCT 'Feed Definitions' AS OBJECTTYPE, OBJECTOWNERID FROM PSFP_FEED UNION ALL
SELECT DISTINCT 'Integration Group Manager' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBGROUPDEFN UNION ALL
SELECT DISTINCT 'IB WSDL Managed Object' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBRESTDFN UNION ALL
SELECT DISTINCT 'IB Routing Definitions' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBRTNGDEFN UNION ALL
SELECT DISTINCT 'IB Schemas.' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBSCHEMAS_VW UNION ALL
SELECT DISTINCT 'IB Schema Managed Object' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBSCMADFN UNION ALL
SELECT DISTINCT 'Message Definition View' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBVWMSGVW1 UNION ALL
SELECT DISTINCT 'View for Default WSDL' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PSIBWADLSVCVW UNION ALL
SELECT DISTINCT 'Message Definition View' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBWMSGDEFNVW UNION ALL
SELECT DISTINCT 'IB WSDL Managed Object' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBWSDLDFN UNION ALL
SELECT DISTINCT 'View for Default WSDL' AS OBJECTTYPE, OBJECTOWNERID FROM PSIBWSDLSVCVW UNION ALL
SELECT DISTINCT 'PSIODEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSIODEFN UNION ALL
SELECT DISTINCT 'PSKEYDB' AS OBJECTTYPE, OBJECTOWNERID FROM PSKEYDB UNION ALL
SELECT DISTINCT 'PSLSDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSLSDEFN UNION ALL
SELECT DISTINCT 'IB Logical Schema View' AS OBJECTTYPE, OBJECTOWNERID FROM PSLSDEFN_VW UNION ALL
SELECT DISTINCT 'PSLSDEPDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSLSDEPDEFN UNION ALL
SELECT DISTINCT 'Branding Macro Set' AS OBJECTTYPE, OBJECTOWNERID FROM PSMACROSET UNION ALL
SELECT DISTINCT 'MAP Administator Defintion' AS OBJECTTYPE, OBJECTOWNERID FROM PSMAPMDEFN UNION ALL
SELECT DISTINCT 'MAP Store Defintion' AS OBJECTTYPE, OBJECTOWNERID FROM PSMAPSDEFN UNION ALL
SELECT DISTINCT 'Menu Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSMENUDEFN UNION ALL
SELECT DISTINCT 'PSMERCHANTID' AS OBJECTTYPE, OBJECTOWNERID FROM PSMERCHANTID UNION ALL
SELECT DISTINCT 'PSMPDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSMPDEFN UNION ALL
SELECT DISTINCT 'Application Message Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSMSGDEFN UNION ALL
SELECT DISTINCT 'Message Definition View' AS OBJECTTYPE, OBJECTOWNERID FROM PSMSGDEFNVW UNION ALL
SELECT DISTINCT 'Message Definition View' AS OBJECTTYPE, OBJECTOWNERID FROM PSMSGDEFNVW1 UNION ALL
SELECT DISTINCT 'Message Parts' AS OBJECTTYPE, OBJECTOWNERID FROM PSMSGPARTS_VW UNION ALL
SELECT DISTINCT 'IB Services' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPERATION UNION ALL
SELECT DISTINCT 'IB Server Handlers' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPRHDLR UNION ALL
SELECT DISTINCT 'IB Service Versions' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPRVERDFN UNION ALL
SELECT DISTINCT 'IB Service Versions' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPRVERDFN_VW UNION ALL
SELECT DISTINCT 'PSOPTMODEL' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPTMODEL UNION ALL
SELECT DISTINCT 'Personalizations Category Grp' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPTNCATGRPTBL UNION ALL
SELECT DISTINCT 'Personalization Category table' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPTNCATTBL UNION ALL
SELECT DISTINCT 'Optimization Problem Types' AS OBJECTTYPE, OBJECTOWNERID FROM PSOPTPRBTYPE UNION ALL
SELECT DISTINCT 'Application Package Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSPACKAGEDEFN UNION ALL
SELECT DISTINCT 'Core Pivot Grid Record' AS OBJECTTYPE, OBJECTOWNERID FROM PSPGCORE UNION ALL
SELECT DISTINCT 'Pivot Grid Datat Type Table' AS OBJECTTYPE, OBJECTOWNERID FROM PSPGDTYPE UNION ALL
SELECT DISTINCT 'PSPHYSSCHDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSPHYSSCHDEFN UNION ALL
SELECT DISTINCT 'Panel Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSPNLDEFN UNION ALL
SELECT DISTINCT 'Panel Group Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSPNLGRPDEFN UNION ALL
SELECT DISTINCT 'Portal Definition Table' AS OBJECTTYPE, OBJECTOWNERID FROM PSPRDMDEFN UNION ALL
SELECT DISTINCT 'PSPROJECTDEFN Table' AS OBJECTTYPE, OBJECTOWNERID FROM PSPRJDEFN_VW UNION ALL
SELECT DISTINCT 'PSPROJECTDEFN Table' AS OBJECTTYPE, OBJECTOWNERID FROM PSPRJDEFN_VWL UNION ALL
SELECT DISTINCT 'Project Definition Table' AS OBJECTTYPE, OBJECTOWNERID FROM PSPROJECTDEFN UNION ALL
SELECT DISTINCT 'Portal Structure Defn Tbl' AS OBJECTTYPE, OBJECTOWNERID FROM PSPRSMDEFN UNION ALL
SELECT DISTINCT 'Portal Structure Defn Tbl' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PSPRSMDEFN_VW UNION ALL
SELECT DISTINCT 'Portal Registry Favorites Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSPRUFDEFN UNION ALL
SELECT DISTINCT 'Portal User Homepage Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSPRUHDEFN UNION ALL
SELECT DISTINCT 'PSPTCSSRVCONF' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTCSSRVCONF UNION ALL
SELECT DISTINCT 'Define Related Content Service' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTCSSRVDEFN UNION ALL
SELECT DISTINCT 'PSPTCS_MENU_TBL' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTCS_MENU_TBL UNION ALL
SELECT DISTINCT 'PSPTCS_SRVCFG' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTCS_SRVCFG UNION ALL
SELECT DISTINCT 'Related ContentPersonalization' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTCS_USRPRSNL UNION ALL
SELECT DISTINCT 'Definition Groups' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTDEFSEC_GRPS UNION ALL
SELECT DISTINCT 'IB view of service operations.' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTIBOPERAT_VW UNION ALL
SELECT DISTINCT 'IB rel. language view.' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTIBOPERT_LVW UNION ALL
SELECT DISTINCT 'PSPTIODEFN_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTIODEFN_VW UNION ALL
SELECT DISTINCT 'Application Package Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTPACKAGEDEFV UNION ALL
SELECT DISTINCT 'PSPTSF_ATTRS' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTSF_ATTRS UNION ALL
SELECT DISTINCT 'PSPTSF_SD' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTSF_SD UNION ALL
SELECT DISTINCT 'Search Categories' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTSF_SRCCAT UNION ALL
SELECT DISTINCT 'SQL Object Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTSQLDEFN_VW UNION ALL
SELECT DISTINCT 'PsTestFw Test Case Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTTSTCASE UNION ALL
SELECT DISTINCT 'PsTestFw Test Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTTSTDEFN UNION ALL
SELECT DISTINCT 'PsTestFw Test Tree' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTTSTDEFNTREE UNION ALL
SELECT DISTINCT 'PSPTUS_CTX' AS OBJECTTYPE, OBJECTOWNERID FROM PSPTUS_CTX UNION ALL
SELECT DISTINCT 'Services with ANY routing' AS OBJECTTYPE, OBJECTOWNERID FROM PSPUBLSVC_VW UNION ALL
SELECT DISTINCT 'QUEUE MANAGER' AS OBJECTTYPE, OBJECTOWNERID FROM PSQUEUEDEFN UNION ALL
SELECT DISTINCT 'Record Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSRECDEFN UNION ALL
SELECT DISTINCT 'IB Services' AS OBJECTTYPE, OBJECTOWNERID FROM PSSERVICE UNION ALL
SELECT DISTINCT 'SQL Object Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PSSQLDEFN UNION ALL
SELECT DISTINCT 'PSSRVSRCH_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PSSRVSRCH_VW UNION ALL
SELECT DISTINCT 'PSSTYLSHEETDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSSTYLSHEETDEFN UNION ALL
SELECT DISTINCT 'PSTYPECODEDEFN' AS OBJECTTYPE, OBJECTOWNERID FROM PSTYPECODEDEFN UNION ALL
SELECT DISTINCT 'URL Table' AS OBJECTTYPE, OBJECTOWNERID FROM PSURLDEFN UNION ALL
SELECT DISTINCT 'PSWSDSERVICE_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PSWSDSERVICE_VW UNION ALL
SELECT DISTINCT 'BIP Data Source Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPDATASRC UNION ALL
SELECT DISTINCT 'PSXPDSSRCH_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPDSSRCH_VW UNION ALL
SELECT DISTINCT 'BIP Report Category' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPRPTCAT UNION ALL
SELECT DISTINCT 'BIP Report Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPRPTDEFN UNION ALL
SELECT DISTINCT 'PSXPRPTSRCH_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPRPTSRCH_VW UNION ALL
SELECT DISTINCT 'PSXPSTMPSRCH_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPSTMPSRCH_VW UNION ALL
SELECT DISTINCT 'BIP Template Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PSXPTMPLDEFN UNION ALL
SELECT DISTINCT 'Approval Transaction Registry' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTAFAW_TXN UNION ALL
SELECT DISTINCT 'DatasourceType' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTAI_GP_DSTYPE UNION ALL
SELECT DISTINCT 'Action Items Lists' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTAI_LIST UNION ALL
SELECT DISTINCT 'Action Items Lists lang view' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTAI_LISTID_LVW UNION ALL
SELECT DISTINCT 'Action Items Lists' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTAI_LISTID_VW UNION ALL
SELECT DISTINCT 'Element Type' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTBR_ETYPE UNION ALL
SELECT DISTINCT 'Layout' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTBR_LAYOUT UNION ALL
SELECT DISTINCT 'Theme' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTBR_THEME UNION ALL
SELECT DISTINCT 'Theme Style Sheet Mapping' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTBR_THEME_CSS UNION ALL
SELECT DISTINCT 'Registry Theme' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTBR_THM_REG UNION ALL
SELECT DISTINCT 'User Attribute Type' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTBR_UATYPE UNION ALL
SELECT DISTINCT 'Centralised Auth Conf record' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCAC_AUTHCONF UNION ALL
SELECT DISTINCT 'Centralised Auth Conf record' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCAC_AUTHORIZE UNION ALL
SELECT DISTINCT 'PTCSEV_CMP_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCSEV_CMP_VW UNION ALL
SELECT DISTINCT 'PTCSEV_REC_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCSEV_REC_VW UNION ALL
SELECT DISTINCT 'PTCSML_SVC_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCSML_SVC_VW UNION ALL
SELECT DISTINCT 'PTCSPG_SVC_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCSPG_SVC_VW UNION ALL
SELECT DISTINCT 'PTCSVCCONFRCF_V' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCSVCCONFRCF_V UNION ALL
SELECT DISTINCT 'PTCS_SVCCRA_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCS_SVCCRA_VW UNION ALL
SELECT DISTINCT 'PTCS_SVCCRC_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCS_SVCCRC_VW UNION ALL
SELECT DISTINCT 'PTCS_SVCFEV_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCS_SVCFEV_VW UNION ALL
SELECT DISTINCT 'PTCS_SVCPEV_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCS_SVCPEV_VW UNION ALL
SELECT DISTINCT 'PTCS_SVCPRA_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCS_SVCPRA_VW UNION ALL
SELECT DISTINCT 'PTCS_SVCPRC_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTCS_SVCPRC_VW UNION ALL
SELECT DISTINCT 'Feed Definitions' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTFP_FEED UNION ALL
SELECT DISTINCT 'PTGP_TILEOWN_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTGP_TILEOWN_VW UNION ALL
SELECT DISTINCT 'Product to Feature Mapping' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_ASSGN_FEAT UNION ALL
SELECT DISTINCT 'BP to Product Feature Join' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_ASSGN_PRFT UNION ALL
SELECT DISTINCT 'Product Suite - Product Rel' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_ASSGN_PROD UNION ALL
SELECT DISTINCT 'Feature to Task Mapping' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_ASSGN_TASK UNION ALL
SELECT DISTINCT 'Business Process - Detail' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_BP_DTL_VW UNION ALL
SELECT DISTINCT 'Business Process - Detail' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_BP_VW UNION ALL
SELECT DISTINCT 'Business Process Definitions' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_BUSPRC UNION ALL
SELECT DISTINCT 'Business Process - Detail' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_BUSPRC_DTL UNION ALL
SELECT DISTINCT 'PTLT_CMPTASK_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_CMPTASK_VW UNION ALL
SELECT DISTINCT 'Define Features' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_FEATURE UNION ALL
SELECT DISTINCT 'Setup Manager - Installation' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_INSTALL UNION ALL
SELECT DISTINCT 'PTLT_ORGTASK_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_ORGTASK_VW UNION ALL
SELECT DISTINCT 'Product Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_PRODUCT UNION ALL
SELECT DISTINCT 'Product Suite Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_PROD_SUITE UNION ALL
SELECT DISTINCT 'PTLT_TASK' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASK UNION ALL
SELECT DISTINCT 'PTLT_TASKCMP_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASKCMP_VW UNION ALL
SELECT DISTINCT 'PTLT_TASKLD_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASKLD_VW UNION ALL
SELECT DISTINCT 'PTLT_TASKOTH_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASKOTH_VW UNION ALL
SELECT DISTINCT 'PTLT_TASK_LOAD' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASK_LOAD UNION ALL
SELECT DISTINCT 'PTLT_TASK_SEQ' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASK_SEQ UNION ALL
SELECT DISTINCT 'Task Sequence Upgrade Table' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTLT_TASK_SEQ_U UNION ALL
SELECT DISTINCT 'TBE Object Owner Table' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPN_PDT_OWNER1 UNION ALL
SELECT DISTINCT 'TBE Object Owner View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPN_PDT_OWNERV UNION ALL
SELECT DISTINCT 'TBE Configuration View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPN_TBE_CFG_1 UNION ALL
SELECT DISTINCT 'TBE Configuration Table' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPN_TBE_CFG_2 UNION ALL
SELECT DISTINCT 'Grouplet Wizard Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPPB_GROUPLET UNION ALL
SELECT DISTINCT 'Message Definition View' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPPB_IBMSG_VW UNION ALL
SELECT DISTINCT 'Pagelet Wizard Definition' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPPB_PAGELET UNION ALL
SELECT DISTINCT 'PTPP_CPPROJ_AET' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPP_CPPROJ_AET UNION ALL
SELECT DISTINCT 'Installation Options' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTPP_OPTIONS UNION ALL
SELECT DISTINCT 'PTSF_SBO' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTSF_SBO UNION ALL
SELECT DISTINCT 'Table to store DDDAudit Report' AS OBJECTTYPE, OBJECTOWNERID FROM PS_PTUPGDDDOUTPUT UNION ALL
SELECT DISTINCT 'AE Application Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PS_T_AEAPPLDEFN UNION ALL
SELECT DISTINCT 'SQL Object Defn' AS OBJECTTYPE, OBJECTOWNERID FROM PS_T_SQLDEFN UNION ALL
SELECT DISTINCT 'URL Table' AS OBJECTTYPE, OBJECTOWNERID FROM PS_URLDEFN_UPG UNION ALL
SELECT DISTINCT 'XPQRYRPTDEFN_VW' AS OBJECTTYPE, OBJECTOWNERID FROM PS_XPQRYRPTDEFN_VW
 
)
SELECT * FROM NEW_TABLE ORDER BY 1 ,2;
