/* Formatted on 6/6/2018 1:08:35 PM (QP5 v5.227.12220.39754) */
SELECT CUSTOMER_CATEGORY_NAME AS cust_category,
       CUSTOMER_CATEGORY,
       SUM (PAYABLE_AMOUNT) AS total_to_pay,
       SUM (BILLED_CONSUMPTION) AS total_consumption,
       COUNT (CUSTOMER_ID) AS customer_cnt
  FROM bill_metered
 WHERE 
 area_id='01' And customer_category='02' And Bill_Month=5 and Bill_Year=2018    GROUP BY CUSTOMER_CATEGORY_NAME, CUSTOMER_CATEGORY