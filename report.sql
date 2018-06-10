/* Formatted on 1/17/2018 12:01:44 PM (QP5 v5.227.12220.39754) */
SELECT TYPE_NAME_ENG,sum(TOTAL_DEPOSIT)
  FROM mst_deposit md,mst_deposit_types mdt
  where MD.DEPOSIT_PURPOSE=MDT.TYPE_ID
and substr(CUSTOMER_ID,1,2)='02'
and to_char(DEPOSIT_DATE,'mm')=11
and to_char(DEPOSIT_DATE,'yyyy')=2017
group by TYPE_NAME_ENG
order by TYPE_NAME_ENG