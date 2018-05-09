/* Formatted on 5/9/2018 4:39:19 PM (QP5 v5.227.12220.39754) */
SELECT cc.customer_id
  FROM customer_connection cc
 WHERE     cc.customer_id NOT IN (SELECT DISTINCT customer_id
                                    FROM bill_non_metered
                                   WHERE area_id = '01')
       AND CC.STATUS = 2
       AND SUBSTR (CC.CUSTOMER_ID, 1, 2) = '01'