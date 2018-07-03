/* Formatted on 6/19/2018 12:16:40 PM (QP5 v5.227.12220.39754) */
SELECT *
  FROM bill_metered
 WHERE     customer_id = '101000938'
       AND TO_NUMBER (bill_year || LPAD (bill_month, 2, 0)) BETWEEN '201503'
                                                                AND '201805'
       AND Area_Id = '10'
       AND status <> 2