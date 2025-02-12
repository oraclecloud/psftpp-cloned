--Query References
--Version 1
SELECT QRYF.OPRID "User ID", QRYF.QRYNAME "Query Name", QRYF.QRYFLDNAME "Source Field", QRYF.SELNUM "Select Num", QRYF.FLDNUM "Field Num", QRYF.RECNAME "Record Name",
       QRYF.FIELDNAME "Field Name", QRYF.FLDRCDNUM "Field Rec Num", QRYF.FLDEXPNUM "Field Exp Num", QRYF.HEADING "Field Heading", QRYD.DESCR "Query Descr",
       CASE(NVL(QRYD.QRYTYPE, 99))
          WHEN 1 THEN '1 - UserQuery' WHEN 2 THEN '2 - Search' WHEN 3 THEN '3 - View' WHEN 4 THEN '4 - Role' WHEN 5 THEN '5 - DBAgent' WHEN 6 THEN '6 - Active' WHEN 7 THEN '7 - Archive'
       ELSE 'Other Query' END AS "Query Type",
       CASE(NVL(RECD.RECTYPE, 99))
          WHEN 0 THEN '0 - SQL Table' WHEN 1 THEN '1 - SQL View' WHEN 2 THEN '2 - Work Record' WHEN 3 THEN '3 - Sub Record' WHEN 5 THEN '5 - Dynamic View' WHEN 6 THEN '6 - Query View'
          WHEN 7 THEN '7 - Temporary Table'
       ELSE 'Other Record or Deleted' END AS "Record Type",
       DBF.OBJECTOWNERID || ' - ' || X1.XLATLONGNAME AS "DBField Object Ident", RECD.OBJECTOWNERID || ' - ' || X2.XLATLONGNAME AS "Record Object Ident"      
FROM ((((((((PSQRYFIELD QRYF LEFT OUTER JOIN PSDBFIELD DBF ON DBF.FIELDNAME = QRYF.FIELDNAME AND DBF.LENGTH > 4)
       LEFT OUTER JOIN PSQRYDEFN QRYD ON QRYD.OPRID = QRYF.OPRID AND QRYD.QRYNAME = QRYF.QRYNAME)
       LEFT OUTER JOIN PSQRYCRITERIA QRYCL ON QRYCL.OPRID = QRYF.OPRID AND QRYCL.QRYNAME = QRYF.QRYNAME AND QRYCL.LCRTSELNUM = QRYF.SELNUM AND QRYCL.LCRTFLDNUM = QRYF.FLDNUM)
       LEFT OUTER JOIN PSQRYCRITERIA QRYCR ON QRYCR.OPRID = QRYF.OPRID AND QRYCR.QRYNAME = QRYF.QRYNAME AND QRYCR.R1CRTSELNUM = QRYF.SELNUM AND QRYCL.R1CRTFLDNUM = QRYF.FLDNUM
                                          AND QRYCR.SELNUM = QRYCL.SELNUM AND QRYCR.CRTNUM = QRYCL.CRTNUM)
       LEFT OUTER JOIN PSRECFIELDDB RECFLD ON RECFLD.RECNAME = QRYF.RECNAME AND RECFLD.FIELDNAME = QRYF.FIELDNAME)
       LEFT OUTER JOIN PSRECDEFN RECD ON RECD.RECNAME = QRYF.RECNAME)
       LEFT OUTER JOIN PSXLATITEM X1 ON X1.FIELDNAME = 'OBJECTOWNERID' AND X1.FIELDVALUE = DBF.OBJECTOWNERID AND X1.EFF_STATUS = 'A')
       LEFT OUTER JOIN PSXLATITEM X2 ON X2.FIELDNAME = 'OBJECTOWNERID' AND X2.FIELDVALUE = RECD.OBJECTOWNERID AND X2.EFF_STATUS = 'A')
WHERE 1 = 1
  AND ((QRYF.FIELDNAME LIKE '%EMPL%ID' OR QRYF.FIELDNAME LIKE '%EMPL%' OR QRYF.FIELDNAME LIKE '%PERSON%' OR QRYF.FIELDNAME LIKE '%APPLICANT%' OR QRYF.FIELDNAME = 'TEAM_MEMBER'
     OR QRYF.FIELDNAME LIKE '%APPLID%') AND QRYF.FIELDNAME NOT LIKE '%TEMPLATE%' AND QRYF.FIELDNAME <> 'AE_APPLID' AND QRYF.FIELDNAME <> 'AE_DO_APPLID')
--  AND QRYF.QRYNAME = 'AM_IT_ASSET_SW_LICENSE_DEVICES'
ORDER BY QRYF.QRYNAME, QRYF.QRYFLDNAME;
