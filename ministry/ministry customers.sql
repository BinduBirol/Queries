SELECT cc.customer_id,
       BM.CUSTOMER_CATEGORY_NAME,
       cc.MINISTRY_ID,
       MM.MINISTRY_NAME,
       BM.PAYABLE_AMOUNT,
       (BM.COLLECTED_AMOUNT + BM.COLLECTED_SURCHARGE) AS collected_amount
  FROM customer_connection cc, mst_ministry mm, bill_metered bm
 WHERE     cc.ministry_id IS NOT NULL
       AND CC.MINISTRY_ID = MM.MINISTRY_ID
       AND BM.CUSTOMER_ID = CC.CUSTOMER_ID
       AND BM.BILL_MONTH = 2
       AND BM.BILL_YEAR = 2017
UNION
SELECT cc.customer_id,
       BM.CUSTOMER_CATEGORY_NAME,
       cc.MINISTRY_ID,
       MM.MINISTRY_NAME,
       BM.ACTUAL_PAYABLE_AMOUNT,
       (BM.COLLECTED_PAYABLE_AMOUNT + BM.COLLECTED_SURCHARGE)
          AS collected_amount
  FROM customer_connection cc, mst_ministry mm, bill_non_metered bm
 WHERE     cc.ministry_id IS NOT NULL
       AND CC.MINISTRY_ID = MM.MINISTRY_ID
       AND BM.CUSTOMER_ID = CC.CUSTOMER_ID
       AND BM.BILL_MONTH = 2
       AND BM.BILL_YEAR = 2017