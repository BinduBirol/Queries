  SELECT distinct(bi.CUSTOMER_ID), 
         getBurner (bi.CUSTOMER_ID) BURNER, 
         BI.Full_name 
    FROM MVIEW_CUSTOMER_INFO bi, CUSTOMER_CONNECTION cc 
   WHERE BI.CUSTOMER_ID = CC.CUSTOMER_ID 
         AND CC.STATUS = 1
         and BI.CATEGORY_ID='01' 
         AND bi.area_id = '01' 
         order by BI.CUSTOMER_ID asc 