/* Formatted on 4/4/2018 4:25:57 PM (QP5 v5.227.12220.39754) */
  SELECT CUSTOMER_ID, SUM (actual_payable_amount)
    FROM bill_non_metered
   WHERE status = 1 AND customer_id = '010100016'
GROUP BY CUSTOMER_ID
  --HAVING SUM (actual_payable_amount) < 1000