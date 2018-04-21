/* Formatted on 4/5/2018 4:26:04 PM (QP5 v5.227.12220.39754) */
  SELECT bi.CUSTOMER_ID, BI.CUSTOMER_NAME, COUNT (*) cnt
    FROM BILL_NON_METERED bi, CUSTOMER_CONNECTION cc
   WHERE     BI.CUSTOMER_ID = CC.CUSTOMER_ID
         AND CC.STATUS = 1
         AND bi.area_id = '01'
         AND BI.CUSTOMER_CATEGORY = '01'
         AND BILL_YEAR || LPAD (BILL_MONTH, 2, 0) <= '201812'
GROUP BY BI.CUSTOMER_ID,BI.CUSTOMER_NAME, CUSTOMER_CATEGORY, bi.AREA_ID
  HAVING COUNT (*) >= 1 