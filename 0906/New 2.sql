
  SELECT *
    FROM bill_non_metered
   WHERE     customer_id = '010114230'
         AND TO_NUMBER (bill_year || LPAD (bill_month, 2, 0)) BETWEEN 201704
                                                                  AND 201804
ORDER BY bill_id