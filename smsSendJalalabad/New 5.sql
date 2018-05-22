   select CUSTOMER_ID,MOBILE_NO,TEXT from TEMP_SMS_LOCAL where length(MOBILE_NO)=11 
   
   
   
   update TEMP_SMS_LOCAL set status='Y' where length(MOBILE_NO)=11 and  status='N'
   
   
   select CUSTOMER_ID,MOBILE_NO,TEXT from TEMP_SMS_LOCAL where length(MOBILE_NO)=11 and  status='N'