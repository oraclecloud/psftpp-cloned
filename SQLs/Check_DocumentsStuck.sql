--Req's Stuck in Batch
SELECT A.BUSINESS_UNIT, A.REQ_ID, A.REQUESTOR_ID, A.OPRID_ENTERED_BY, A.OPRID_MODIFIED_BY, B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM FROM PS_REQ_HDR A, PSPRCSRQST B, PSXLATITEM C WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE (+) AND C.FIELDNAME = 'RUNSTATUS' AND C.FIELDVALUE = RUNSTATUS AND A.IN_PROCESS_FLG = 'Y' AND A.BUSINESS_UNIT LIKE '6%';
--PO's Stuck in Batch
SELECT 'POs_Stuck_in_Batch', A.BUSINESS_UNIT, A.PO_ID, A.VENDOR_ID, A.BUYER_ID, B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM FROM PS_PO_HDR A, PSPRCSRQST B, PSXLATITEM C WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) AND C.FIELDNAME = 'RUNSTATUS' AND C.FIELDVALUE = RUNSTATUS AND A.IN_PROCESS_FLG = 'Y' AND A.BUSINESS_UNIT LIKE '6%';
--Vouchers Stuck in Batch
SELECT 'Vouchers_Stuck_in_Batch', A.BUSINESS_UNIT, A.VOUCHER_ID, A.VENDOR_ID, B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM FROM PS_VOUCHER A, PSPRCSRQST B, PSXLATITEM C WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) AND C.FIELDNAME = 'RUNSTATUS' AND C.FIELDVALUE = RUNSTATUS AND A.IN_PROCESS_FLG = 'Y' AND A.BUSINESS_UNIT LIKE '6%';
--UN Mass Approved and Budget Check
SELECT * FROM PS_UN_APPBCHK_RUN A WHERE BUSINESS_UNIT LIKE '6%' AND EXISTS (SELECT 'X' FROM PS_VOUCHER V WHERE V.BUSINESS_UNIT = A.BUSINESS_UNIT AND A.VOUCHER_ID = V.VOUCHER_ID AND V.BUSINESS_UNIT LIKE '6%' AND APPR_STATUS <> 'A');
--Payments Stuck in Batch
SELECT A.BANK_SETID, A.BANK_CD, A.PYMNT_ID, A.PYMNT_ID_REF, A.REMIT_VENDOR, NAME1, A.PYMNT_DT, A.PAY_CYCLE, B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM FROM PS_PAYMENT_TBL A, PSPRCSRQST B, PSXLATITEM C WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE (+) AND C.FIELDNAME = 'RUNSTATUS' AND C.FIELDVALUE = RUNSTATUS AND A.IN_PROCESS_FLG = 'Y' AND A.REMIT_SETID = 'UNUNI';
--Documents Stuck in KK
SELECT 'Documents_Stuck_in_KK', BUSINESS_UNIT, KK_PROCESS_STATUS, DEPOSIT_ID, INTFC_ID, INVOICE, JOURNAL_ID, PO_ID, REQ_ID, VOUCHER_ID, RECEIVER_ID, KK_PROC_INSTANCE, COUNT (1) FROM PS_KK_SOURCE_HDR WHERE  (BUSINESS_UNIT LIKE '6%' OR BUSINESS_UNIT = 'UNUNI') AND KK_PROCESS_STATUS = 'I' AND TO_CHAR (KK_TRAN_DT, 'YYYY') > '2009' GROUP BY BUSINESS_UNIT, KK_PROCESS_STATUS, DEPOSIT_ID, INTFC_ID, INVOICE, JOURNAL_ID, PO_ID, REQ_ID, VOUCHER_ID, RECEIVER_ID, KK_PROC_INSTANCE ORDER BY 1, 2;
--UN Budget Unlock
SELECT H.KK_TRAN_ID, H.KK_TRAN_DT, H.KK_SOURCE_TRAN, H.SEQUENCE_NBR_9, H.KK_PROCESS_STATUS, H.KK_PROC_INSTANCE, H.BUSINESS_UNIT, H.KEYLIST FROM PS_KK_SOURCE_HDR H WHERE (BUSINESS_UNIT LIKE '6%' OR BUSINESS_UNIT = 'UNUNI') AND H.KK_PROCESS_STATUS = 'I' AND H.KK_PROC_INSTANCE IN ( SELECT /*+ FULL(B) PARALLEL(20) */ B.PRCSINSTANCE FROM PSPRCSRQST B WHERE B.RUNSTATUS <> '7');
--Receipts Stuck in Batch
--For receipts need to check both (MATCH_PROCESS_FLG = I) and (IN_PROCESS_FLG = Y)
SELECT 'Receipts_Stuck_in_Batch', A.BUSINESS_UNIT, A.RECEIVER_ID, A.INVOICE_ID, A.MATCH_PROCESS_FLG, A.IN_PROCESS_FLG, A.OPRID, A.RECEIPT_DT, A.SETID, A.VENDOR_ID, B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM FROM PS_RECV_HDR A, PSPRCSRQST B, PSXLATITEM C WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) AND C.FIELDNAME = 'RUNSTATUS' AND C.FIELDVALUE = RUNSTATUS AND (A.IN_PROCESS_FLG = 'Y' OR A.MATCH_PROCESS_FLG = 'I') AND A.BUSINESS_UNIT LIKE '6%';
--UNU PO sourcing status    
SELECT A.PROCESS_INSTANCE, A.STAGE_STATUS, A.BUSINESS_UNIT, A.PO_STG_TYPE, A.PO_STG_ID, A.LINE_NBR, A.SCHED_NBR, A.BUYER_ID, A.CNTRCT_ID, 
            A.CNTRCT_LINE_NBR, A.CNTRCT_SETID, A.CURRENCY_CD, A.CURRENCY_CD_BASE, 
            TO_CHAR(CAST((A.DATETIME_MODIFIED) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF'), TO_CHAR(A.DUE_DT,'YYYY-MM-DD'), 
            A.ITM_ID_VNDR, A.ITM_SETID, A.OPRID, A.PO_ID, A.PO_LINE_NBR, A.PO_PROCESS_ID, A.VENDOR_ID, A.VENDOR_SETID, 
            A.MERCHANDISE_AMT, A.MESSAGE_SET_NBR, A.MESSAGE_NBR, B.MESSAGE_TEXT, B.DESCRLONG
FROM PS_PO_ITM_STG A, PSMSGCATDEFN B
WHERE A.BUSINESS_UNIT LIKE '6%'
    AND A.MESSAGE_SET_NBR = B.MESSAGE_SET_NBR (+)
    AND A.MESSAGE_NBR = B.MESSAGE_NBR (+)
    --AND A.STAGE_STATUS IN ('B','E','I','N','P','S','V')
    AND A.STAGE_STATUS <> 'C'
ORDER BY 1 DESC;
--Budget Journals Stuck in Batch
SELECT 'Budget_Journals_Stuck', A.BUSINESS_UNIT, A.JOURNAL_ID, A.JOURNAL_DATE, A.LEDGER_GROUP, 
             B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM 
FROM PS_KK_BUDGET_HDR A, PSPRCSRQST B, PSXLATITEM C 
WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) 
    AND C.FIELDNAME = 'RUNSTATUS' 
    AND C.FIELDVALUE = RUNSTATUS 
    AND A.BUSINESS_UNIT = 'UNUNI'
    AND A.IN_PROCESS_FLG = 'Y'
ORDER BY 2,3;
--AR Items Stuck in Batch
SELECT 'AR_ITEMS_Stuck', A.BUSINESS_UNIT, A.CUST_ID, A.ITEM, A.LEDGER_GROUP, 
             B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM 
FROM PS_ITEM_DST A, PSPRCSRQST B, PSXLATITEM C 
WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) 
    AND C.FIELDNAME = 'RUNSTATUS' 
    AND C.FIELDVALUE = RUNSTATUS 
    AND A.BUSINESS_UNIT LIKE '6%' 
    AND A.IN_PROCESS_FLG = 'Y'
ORDER BY 2,3;
--Contract Releases Stuck in Batch
SELECT 'CNTRCT_RELEASE_Stuck', A.SETID, A.CNTRCT_ID, A.RELEASE_STATUS, A.BUYER_ID, 
             B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM 
FROM PS_CNTRCT_RLS_HDR A, PSPRCSRQST B, PSXLATITEM C 
WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) 
  AND C.FIELDNAME = 'RUNSTATUS' 
  AND C.FIELDVALUE = RUNSTATUS 
  AND A.SETID LIKE '6%' 
  AND (A.IN_PROCESS_FLG = 'Y' OR RELEASE_STATUS <> 'C')
ORDER BY 2,3;
--DEPOSIT IDs Stuck in Batch
SELECT 'DEPOSITIDs_Stuck', A.DEPOSIT_BU, A.DEPOSIT_ID, A.PAYMENT_SEQ_NUM, A.DST_SEQ_NUM, 
             B.PRCSNAME, B.PRCSINSTANCE, B.OPRID, B.RUNCNTLID, C.XLATLONGNAME AS RUNSTATUS_DESC, B.RUNDTTM 
FROM PS_PAY_MISC_DST A, PSPRCSRQST B, PSXLATITEM C 
WHERE A.PROCESS_INSTANCE = B.PRCSINSTANCE(+) 
  AND C.FIELDNAME = 'RUNSTATUS' 
  AND C.FIELDVALUE = RUNSTATUS 
  AND A.DEPOSIT_BU LIKE '6%' 
  AND A.IN_PROCESS_FLG = 'Y'
ORDER BY 2,3;