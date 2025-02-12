-----------------GL
--Check Journal Status for fiscal years 2013 and beyond
SELECT JRNL_HDR_STATUS, SOURCE, TO_CHAR(JOURNAL_DATE, 'YYYY') AS JRNL_DT, COUNT(1) 
FROM PS_JRNL_HEADER 
WHERE BUSINESS_UNIT = 'UNUNI' 
    AND TO_CHAR(JOURNAL_DATE, 'YYYY') > 2012
GROUP BY JRNL_HDR_STATUS, SOURCE, TO_CHAR(JOURNAL_DATE, 'YYYY') ORDER BY 1,2;
--UNU_GL_PAYROLL_JOURNAL_STATUS     
SELECT A.BUSINESS_UNIT_IU, A.JOURNAL_ID, TO_CHAR(A.JOURNAL_DATE,'YYYY-MM-DD') AS JOURNAL_DT, A.UNPOST_SEQ, A.BUSINESS_UNIT, A.TRANS_REF_NUM, A.JRNL_HDR_STATUS, A.BUDGET_HDR_STATUS, A.DESCR254, 
            TO_CHAR(CAST((A.JRNL_CREATE_DTTM) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') AS JRNL_CREATE_DTTM, 
            TO_CHAR(CAST((A.DTTM_STAMP_SEC) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') AS DTTM_STAMP, 
            TO_CHAR(A.POSTED_DATE,'YYYY-MM-DD') AS POSTED_DT, A.PROCESS_INSTANCE
FROM PS_JRNL_HEADER A
WHERE A.BUSINESS_UNIT = 'UNUNI'
    AND A.SOURCE = 'GP'
    AND TO_CHAR(A.JOURNAL_DATE,'YYYY') > 2012
ORDER BY 1, 2, 3, 4, 5;
--Locked Journals
SELECT * FROM PS_JRNL_EDIT_LOG;
--LOCKED_JOURNAL flag in PS_JRNL_HEADER for UNUNI
SELECT 'LOCKED_JOURNALS', A.* FROM PS_JRNL_HEADER A WHERE BUSINESS_UNIT = 'UNUNI' AND JOURNAL_LOCKED = 'Y';
--Check locked journal across all journal sources
SELECT JOURNAL_LOCKED, SOURCE, COUNT(1) FROM PS_JRNL_HEADER A WHERE BUSINESS_UNIT = 'UNUNI' GROUP BY JOURNAL_LOCKED, SOURCE ORDER BY 1,2;
--Reversal entries
SELECT FISCAL_YEAR, ACCOUNTING_PERIOD, SOURCE, COUNT(1) FROM PS_JRNL_HEADER 
WHERE BUSINESS_UNIT = 'UNUNI' 
    AND REVERSAL_CD <> 'N'
GROUP BY FISCAL_YEAR, ACCOUNTING_PERIOD, SOURCE
ORDER BY 1,2,3;
--Journals with Status N, E & V
SELECT DISTINCT JOURNAL_ID, BUSINESS_UNIT_IU, JOURNAL_DATE, LEDGER_GROUP, SOURCE, SYSTEM_SOURCE, OPRID, PROC_PART_ID, 
       JRNL_HDR_STATUS, DESCR, PROCESS_INSTANCE, KK_AMOUNT_TYPE, DTTM_STAMP_SEC 
FROM PS_JRNL_HEADER
WHERE BUSINESS_UNIT = 'UNUNI'    
  AND JRNL_HDR_STATUS IN ('N','E','V')
ORDER BY JOURNAL_DATE DESC;
--TSE Journal Header Field Log
SELECT 'TSE_JRNL_HDR_LOG', A.* FROM PS_TSE_JHDR_FLD A WHERE BUSINESS_UNIT = 'UNUNI' ORDER BY TSE_PROC_INSTANCE DESC;
--TSE Journal Line Field Log
SELECT 'TSE_JRNL_LINE_LOG', A.* FROM PS_TSE_JLNE_FLD A WHERE BUSINESS_UNIT = 'UNUNI' ORDER BY TSE_PROC_INSTANCE DESC;
--GL Non Shared Table Maintenance
SELECT TRUNC((CAST(Q.BEGINDTTM AS DATE) - CAST(Q.ENDDTTM AS DATE))*24*60) || ' minutes' AS DURATION_MINUTES,
       A.*, Q.PRCSTYPE, Q.PRCSNAME , Q.RUNDTTM, Q.RQSTDTTM, 
       Q.LASTUPDDTTM, Q.BEGINDTTM, Q.ENDDTTM, Q.ORIGPRCSINSTANCE, Q.OPRID
FROM PS_TEMP_TBL_ASGNM A, PSPRCSRQST Q 
WHERE A.PROCESS_INSTANCE = Q.PRCSINSTANCE (+)
    AND A.IN_USE_SW <> 'N';
--Find active processes which are using GL Non Shared Tables
SELECT * FROM PSPRCSRQST WHERE PRCSINSTANCE IN (SELECT PROCESS_INSTANCE FROM PS_TEMP_TBL_ASGNM WHERE PROCESS_INSTANCE <> 0);
--Number of times each base working table was shared by GL processes due to unavailability of non-shared instances YEAR wise
--Version 2
SELECT STS.TEMP_TBL_NAME "Shared Table", REC.RECDESCR, TO_CHAR(STS.DATE_ASSIGNED ,'YYYY') "YEAR", COUNT(1) "Shared Table Count" 
FROM PS_TEMP_TBL_STATS STS, PSRECDEFN REC
WHERE STS.TEMP_TBL_NAME = REC.RECNAME (+)
GROUP BY STS.TEMP_TBL_NAME, REC.RECDESCR, TO_CHAR(STS.DATE_ASSIGNED ,'YYYY')
ORDER BY  TO_CHAR(STS.DATE_ASSIGNED ,'YYYY'), STS.TEMP_TBL_NAME;
--Version 1
--WITHOUT PSRECDEFN
SELECT TEMP_TBL_NAME "Shared Table", TO_CHAR(DATE_ASSIGNED ,'YYYY') "YEAR", COUNT(1) "Shared Table Count" 
FROM PS_TEMP_TBL_STATS 
GROUP BY TEMP_TBL_NAME, TO_CHAR(DATE_ASSIGNED ,'YYYY')
ORDER BY  TO_CHAR(DATE_ASSIGNED ,'YYYY');
--OPEN PERIOD DETAILS for UNU BUs
--Need to ensure that GL is also listed
SELECT OPN.PSFT_PRODUCT, OPN.BUSINESS_UNIT, OPN.LEDGER_GROUP, OPN.TRANSACTION_TYPE, TRAN.DESCR, OPN.LEDGER_CODE, OPN.GL_ADJUST_TYPE, OPN.CALENDAR_ID, 
            OPN.OPEN_YEAR_FROM, OPN.OPEN_PERIOD_FROM, OPN.BEGIN_LAG_DAYS, OPN.OPEN_FROM_DATE, OPN.OPEN_YEAR_TO, OPN.OPEN_PERIOD_TO, OPN.END_LAG_DAYS, OPN.OPEN_TO_DATE 
FROM PS_TRANS_TYPE_TBL TRAN, (PS_FIN_OPEN_PERIOD OPN LEFT OUTER JOIN PS_FIN_BU_MAPPING MAP ON OPN.PSFT_PRODUCT = MAP.PSFT_PRODUCT 
                                                                                             AND OPN.BUSINESS_UNIT = MAP.BUSINESS_UNIT
                                                                                             AND MAP.BUSINESS_UNIT_GL = 'UNUNI')
WHERE OPN.PSFT_PRODUCT = TRAN.PSFT_PRODUCT
    AND OPN.TRANSACTION_TYPE = TRAN.TRANSACTION_TYPE
    AND OPN.LEDGER_GROUP = 'ACTUALS'
    AND (OPN.BUSINESS_UNIT LIKE '6%' OR OPN.BUSINESS_UNIT = 'UNUNI')
ORDER BY OPN.PSFT_PRODUCT, OPN.BUSINESS_UNIT, OPN.LEDGER_GROUP, OPN.TRANSACTION_TYPE;
--Journals other than POSTED for FY greater than and equal to 2014
SELECT JOURNAL_ID, BUSINESS_UNIT_IU, JOURNAL_DATE, LEDGER_GROUP, SOURCE, SYSTEM_SOURCE, OPRID, PROC_PART_ID, 
       JRNL_HDR_STATUS, DESCR, PROCESS_INSTANCE, KK_AMOUNT_TYPE, DTTM_STAMP_SEC 
FROM PS_JRNL_HEADER
WHERE BUSINESS_UNIT = 'UNUNI'    
  --AND JRNL_HDR_STATUS IN ('N','E','V')
  AND JRNL_HDR_STATUS <> 'P'
  AND TO_CHAR(JOURNAL_DATE, 'YYYY') >= '2014'
ORDER BY JOURNAL_DATE DESC;
