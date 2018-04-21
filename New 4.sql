/* Formatted on 4/4/2018 3:09:13 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM (  SELECT bi.CUSTOMER_ID,
                 CUSTOMER_CATEGORY,
                 bi.AREA_ID,
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
                    totalamount,
                 NUMBER_SPELLOUT_FUNC (
                    TO_NUMBER (
                       SUM (
                            BILLED_AMOUNT
                          + CALCUALTESURCHARGE (
                               BILL_ID,
                               TO_CHAR (SYSDATE, 'dd-mm-YYYY'))),
                       '99999999999999.99'))
                    inwords,
                 COUNT (*) cnt
            FROM BILL_METERED bi, CUSTOMER_CONNECTION cc
           WHERE     BI.CUSTOMER_ID = CC.CUSTOMER_ID
                 AND CC.STATUS = 1
                 AND bi.STATUS = 1
                 AND bi.area_id = '02'
                 --AND BI.CUSTOMER_ID = '020600001'
                 AND BI.CUSTOMER_CATEGORY='06'
                 AND BILL_YEAR || LPAD (BILL_MONTH, 2, 0) <= '201712'
        GROUP BY BI.CUSTOMER_ID, CUSTOMER_CATEGORY, bi.AREA_ID
          HAVING COUNT (*) >= 1) tmp1,
       (SELECT AA.CUSTOMER_ID,
               BB.FULL_NAME,
               BB.MOBILE,
               AA.ADDRESS_LINE1,
               AA.ADDRESS_LINE2
          FROM CUSTOMER_ADDRESS aa, CUSTOMER_PERSONAL_INFO bb
         WHERE AA.CUSTOMER_ID = BB.CUSTOMER_ID) tmp2
 WHERE tmp1.CUSTOMER_ID = tmp2.CUSTOMER_ID