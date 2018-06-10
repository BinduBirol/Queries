/* Formatted on 6/6/2018 10:53:16 AM (QP5 v5.227.12220.39754) */
  SELECT *
    FROM bill_metered
   WHERE    
    customer_id  = '011005545' AND  TO_NUMBER (bill_year || LPAD (bill_month, 2, 0)) BETWEEN  '20182' AND   '20191' And Area_Id='01'
                                                                  
--customer_id  = '020300095' AND fromMonthYear  = '20162' AND toMonthYear  = '20191' And Area_Id='01'
--and PAYABLE_AMOUNT=0


ORDER BY bill_id