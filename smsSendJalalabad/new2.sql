


INSERT INTO JALALABAD.TEMP_SMS_LOCAL (
   CUSTOMER_ID, MOBILE_NO, TEXT, 
    STATUS)
SELECT tmp1.CUSTOMER_ID, trim(MOBILE), 
'Dear Customer(ID-'||tmp1.CUSTOMER_ID||'), You have no pending gas bills except '||DUEMONTH||'. Ignore if paid. Helpline-16511.' text,
'N'
  FROM (  SELECT bi.CUSTOMER_ID,
                 CUSTOMER_CATEGORY,
                 bi.AREA_ID,
                 --getBurner (bi.customer_id) burner,
                 LISTAGG (
                       TO_CHAR (TO_DATE (BILL_MONTH, 'MM'), 'MON')
                    || ' '
                    || SUBSTR (BILL_YEAR, 3),
                    ',')
                 WITHIN GROUP (ORDER BY BILL_YEAR ASC, BILL_MONTH ASC)
                    AS DUEMONTH,
                 COUNT (*) cnt
            FROM BILL_NON_METERED bi, CUSTOMER_CONNECTION cc
           WHERE     BI.CUSTOMER_ID = CC.CUSTOMER_ID
                 AND CC.STATUS = 1
                 AND bi.STATUS = 1                 
                 AND BI.CUSTOMER_CATEGORY <> '01'
                 AND BILL_YEAR || LPAD (BILL_MONTH, 2, 0) <= '201804'
        GROUP BY BI.CUSTOMER_ID, CUSTOMER_CATEGORY, bi.AREA_ID
          HAVING COUNT (*) >= 1) tmp1,
       (SELECT AA.CUSTOMER_ID, BB.FULL_NAME, BB.MOBILE
          FROM CUSTOMER_ADDRESS aa, CUSTOMER_PERSONAL_INFO bb
         WHERE AA.CUSTOMER_ID = BB.CUSTOMER_ID) tmp2
 WHERE tmp1.CUSTOMER_ID = tmp2.CUSTOMER_ID
 and tmp1.CUSTOMER_ID in (select CUSTOMER_ID from TEMP_SMS_LOCAL where STATUS='Y' )