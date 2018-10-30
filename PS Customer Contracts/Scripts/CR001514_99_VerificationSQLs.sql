--Verification  
SELECT ORA_DATABASE_NAME, SYSDATE FROM DUAL;
SELECT 'PROD_COMPTTRS' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_PROD_COMPTTRS WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE');
SELECT 'PROD_COMPTTRS' AS TABLE_NAME, A.* FROM PS_PROD_COMPTTRS A WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE') ORDER BY 1, 2;
SELECT 'PROD_ITEM' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_PROD_ITEM WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE');
SELECT 'PROD_ITEM' AS TABLE_NAME, A.* FROM PS_PROD_ITEM A WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE') ORDER BY 1, 2;
SELECT 'PROD_PHOTO' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_PROD_PHOTO WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE');
SELECT 'PROD_PHOTO' AS TABLE_NAME, A.* FROM PS_PROD_PHOTO A WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE') ORDER BY 1, 2;
SELECT 'PROD_ITEM_CURR' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_PROD_ITEM_CURR WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE') AND CURRENCY_CD LIKE '%';
SELECT 'PROD_ITEM_CURR' AS TABLE_NAME, A.* FROM PS_PROD_ITEM_CURR A WHERE SETID = 'UNUNI' AND PRODUCT_ID IN ('CORE', 'NON_CORE_EC', 'NON_CORE_NON_STD', 'NON_CORE') AND CURRENCY_CD LIKE '%' ORDER BY 1, 2;
SELECT 'PROD_GROUP_TBL' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_PROD_GROUP_TBL WHERE SETID = 'UNUNI' AND PROD_GRP_TYPE LIKE '%' AND PRODUCT_GROUP LIKE '%';
SELECT 'PROD_GROUP_TBL' AS TABLE_NAME, A.* FROM PS_PROD_GROUP_TBL A WHERE SETID = 'UNUNI' AND PROD_GRP_TYPE LIKE '%' AND PRODUCT_GROUP LIKE '%' ORDER BY 1, 2;
SELECT 'PROD_PGRP_LNK' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_PROD_PGRP_LNK WHERE SETID = 'UNUNI' AND PRODUCT_ID LIKE '%' AND PROD_GRP_TYPE LIKE '%' AND PRODUCT_GROUP LIKE '%';
SELECT 'PROD_PGRP_LNK' AS TABLE_NAME, A.* FROM PS_PROD_PGRP_LNK A WHERE SETID = 'UNUNI' AND PRODUCT_ID LIKE '%' AND PROD_GRP_TYPE LIKE '%' AND PRODUCT_GROUP LIKE '%' ORDER BY 1, 2;
SELECT 'CA_PROD_GRP_TBL' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_CA_PROD_GRP_TBL WHERE SETID = 'UNUNI' AND PRODUCT_GROUP LIKE '%';
SELECT 'CA_PROD_GRP_TBL' AS TABLE_NAME, A.* FROM PS_CA_PROD_GRP_TBL A WHERE SETID = 'UNUNI' AND PRODUCT_GROUP LIKE '%' ORDER BY 1, 2;
SELECT 'DST_CODE_TBL' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_DST_CODE_TBL WHERE SETID = 'UNUNI' AND DST_ID IN ('AR', 'DFR_REV') AND EFFDT LIKE '%';
SELECT 'DST_CODE_TBL' AS TABLE_NAME, A.* FROM PS_DST_CODE_TBL A WHERE SETID = 'UNUNI' AND DST_ID IN ('AR', 'DFR_REV') AND EFFDT LIKE '%' ORDER BY 1, 2;
SELECT 'BI_TYPE' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_BI_TYPE WHERE SETID = 'UNUNI' AND BILL_TYPE_ID LIKE '%' AND EFFDT LIKE '%';
SELECT 'BI_TYPE' AS TABLE_NAME, A.* FROM PS_BI_TYPE A WHERE SETID = 'UNUNI' AND BILL_TYPE_ID LIKE '%' AND EFFDT LIKE '%' ORDER BY 1, 2;
SELECT 'BI_SRC' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_BI_SRC WHERE SETID = 'UNUNI' AND BILL_SOURCE_ID LIKE '%' AND EFFDT LIKE '%';
SELECT 'BI_SRC' AS TABLE_NAME, A.* FROM PS_BI_SRC A WHERE SETID = 'UNUNI' AND BILL_SOURCE_ID LIKE '%' AND EFFDT LIKE '%' ORDER BY 1, 2;
SELECT 'BI_IVC_NUM' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_BI_IVC_NUM WHERE IVC_NUM_ID = 'UNUNI';
SELECT 'BI_IVC_NUM' AS TABLE_NAME, A.* FROM PS_BI_IVC_NUM A WHERE IVC_NUM_ID = 'UNUNI' ORDER BY 1, 2;
SELECT 'CA_PLAN_TMPL' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_CA_PLAN_TMPL WHERE SETID = 'SHARE' AND PLAN_TMPL_ID LIKE '%UNU%';
SELECT 'CA_PLAN_TMPL' AS TABLE_NAME, A.* FROM PS_CA_PLAN_TMPL A WHERE SETID = 'SHARE' AND PLAN_TMPL_ID LIKE '%UNU%' ORDER BY 1, 2;
SELECT 'CA_PLAN_TMPL_EV' AS TABLE_NAME, COUNT(1) AS ROW_COUNT FROM PS_CA_PLAN_TMPL_EV WHERE SETID = 'SHARE' AND PLAN_TMPL_ID LIKE '%UNU%';
SELECT 'CA_PLAN_TMPL_EV' AS TABLE_NAME, A.* FROM PS_CA_PLAN_TMPL_EV A WHERE SETID = 'SHARE' AND PLAN_TMPL_ID LIKE '%UNU%' ORDER BY 1, 2;


