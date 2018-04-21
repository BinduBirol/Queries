/* Formatted on 4/18/2018 5:03:58 PM (QP5 v5.227.12220.39754) */
SELECT DISTINCT (bi.CUSTOMER_ID)
  FROM MVIEW_CUSTOMER_INFO bi, CUSTOMER_CONNECTION cc
 WHERE     BI.CUSTOMER_ID = CC.CUSTOMER_ID
       AND CC.STATUS = 1
       AND bi.area_id = '01'
       AND BI.CATEGORY_ID = '01'
MINUS
SELECT SR.customer_id CODE
  FROM SALES_REPORT SR,
       CUSTOMER_CONNECTION conn,
       MST_CUSTOMER_CATEGORY mcc,
       CUSTOMER_PERSONAL_INFO cpi
 WHERE     SR.customer_id = conn.customer_id
       AND SR.customer_id = cpi.customer_id
       AND BILLING_MONTH = 3
       AND BILLING_YEAR = 2018
       AND SUBSTR (SR.customer_id, 3, 2) = MCC.CATEGORY_ID
       AND SUBSTR (SR.customer_id, 1, 2) = '01'
       AND SUBSTR (SR.customer_id, 3, 2) = '01'