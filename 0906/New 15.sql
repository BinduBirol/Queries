/* Formatted on 6/9/2018 11:29:01 AM (QP5 v5.227.12220.39754) */
SELECT status
  FROM bill_metered
 WHERE bill_id = '201803030105759'
UNION
SELECT status
  FROM bill_non_metered
 WHERE bill_id = '201803030105759'