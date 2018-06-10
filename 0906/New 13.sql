  SELECT CUSTOMER_CATEGORY_NAME AS cust_category,
         CUSTOMER_CATEGORY,
         SUM (PAYABLE_AMOUNT) AS total_to_pay,
         SUM (BILLED_CONSUMPTION) AS total_consumption,
         COUNT (CUSTOMER_ID) AS customer_cnt
    FROM bill_metered
   WHERE     --status = 0
          area_id = '01'
         --AND customer_category = '02'
         AND Bill_Month = 5
         AND Bill_Year = 2018
GROUP BY CUSTOMER_CATEGORY_NAME, CUSTOMER_CATEGORY