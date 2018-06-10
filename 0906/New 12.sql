/* Formatted on 6/6/2018 1:11:10 PM (QP5 v5.227.12220.39754) */
  SELECT CUSTOMER_CATEGORY_NAME AS cust_category,
         CUSTOMER_CATEGORY,
         SUM (PAYABLE_AMOUNT) AS total_to_pay,
         SUM (BILLED_CONSUMPTION) AS total_consumption,
         COUNT (CUSTOMER_ID) AS customer_cnt
    FROM bill_metered
   WHERE status = 0 AND area_id = '01' AND Bill_Month = 5 AND Bill_Year = 2018
GROUP BY CUSTOMER_CATEGORY_NAME, CUSTOMER_CATEGORY