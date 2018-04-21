/* Formatted on 4/5/2018 6:16:28 PM (QP5 v5.227.12220.39754) */
  SELECT tmp1.CUSTOMER_ID,
         TMP1.BURNER,
         tmp1.CATEGORY_ID,
         tmp2.CATEGORY_NAME,
         tmp1.STATUS,
         TMP2.FULL_NAME,
         tmp2.ADDRESS,
         tmp2.CONTACT_NO,
         TMP3.MIN_LOAD,
         TMP3.MAX_LOAD,
         tmp1.DUEMONTH,
         tmp1.TOTAL_AMOUNT,
         tmp1.TOTAL_MONTH
    FROM (  SELECT bi.CUSTOMER_ID,
                   getBurner (bi.CUSTOMER_ID) BURNER,
                   CUSTOMER_CATEGORY CATEGORY_ID,
                   bi.AREA_ID,
                   cc.STATUS,
                   LISTAGG (
                         TO_CHAR (TO_DATE (BILL_MONTH, 'MM'), 'MON')
                      || ' '
                      || SUBSTR (BILL_YEAR, 3),
                      ',')
                   WITHIN GROUP (ORDER BY BILL_YEAR ASC, BILL_MONTH ASC)
                      AS DUEMONTH,
                   SUM (
                        BILLED_AMOUNT
                      + CALCUALTESURCHARGE (BILL_ID,
                                            TO_CHAR (SYSDATE, 'dd-mm-YYYY')))
                      TOTAL_AMOUNT,
                   COUNT (*) TOTAL_MONTH
              FROM BILL_NON_METERED bi, CUSTOMER_CONNECTION cc
             WHERE     BI.CUSTOMER_ID = CC.CUSTOMER_ID
                   AND CC.STATUS = 1
                   AND bi.STATUS = 1
                   AND area_id = '01'
                   AND CUSTOMER_CATEGORY = '09'
                   AND BILL_YEAR || LPAD (BILL_MONTH, 2, 0) <= 2017012
          GROUP BY BI.CUSTOMER_ID,
                   CUSTOMER_CATEGORY,
                   bi.AREA_ID,
                   cc.STATUS
            HAVING COUNT (*) > 12) tmp1,
         (SELECT AA.CUSTOMER_ID,
                 BB.FULL_NAME,
                 BB.MOBILE CONTACT_NO,
                 AA.ADDRESS_LINE1 ADDRESS,
                 AA.ADDRESS_LINE2,
                 MCC.CATEGORY_NAME
            FROM CUSTOMER_ADDRESS aa,
                 CUSTOMER_PERSONAL_INFO bb,
                 MST_CUSTOMER_CATEGORY mcc
           WHERE     AA.CUSTOMER_ID = BB.CUSTOMER_ID
                 AND MCC.CATEGORY_ID = SUBSTR (AA.CUSTOMER_ID, 3, 2)) tmp2,
         CUSTOMER_CONNECTION tmp3
   WHERE     tmp1.TOTAL_AMOUNT > 0
         AND tmp1.CUSTOMER_ID = tmp2.CUSTOMER_ID
         AND tmp1.CUSTOMER_ID = TMP3.CUSTOMER_ID
ORDER BY tmp1.CATEGORY_ID, tmp1.CUSTOMER_ID ASC