/* Formatted on 11/11/2019 1:35:59 PM (QP5 v5.227.12220.39754) */
SELECT BILL_ID,
       COLLECTION_DATE,
       PAYABLE_AMOUNT,
       COLLECTED_AMOUNT,
         PAYABLE_AMOUNT
       - CASE
            WHEN NVL (COLLECTION_DATE, SYSDATE) >=
                    TO_DATE ('30/12/2018', 'dd/mm/rrrr')
            THEN
               0
            ELSE
               COLLECTED_AMOUNT
         END
          diff
  FROM bill_metered
 WHERE CUSTOMER_ID = '010400030'