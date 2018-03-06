/* Formatted on 3/5/2018 6:49:41 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM (SELECT ROWNUM serial, tmp1.*
          FROM (  SELECT bill_id,
                         customer_id,
                         customer_name,
                         ACTUAL_PAYABLE_AMOUNT,
                         COLLECTED_PAYABLE_AMOUNT,
                         status
                    FROM BILL_NON_METERED
                   WHERE (    bill_month = '3'
                          AND bill_year = '2018'
                          AND Area_Id = '01')
                ORDER BY actual_payable_amount - nvl(collected_payable_amount,0) DESC) tmp1) tmp2
 WHERE serial BETWEEN 1 AND 1000