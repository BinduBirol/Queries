/* Formatted on 4/17/2018 1:20:11 PM (QP5 v5.227.12220.39754) */
  SELECT cc.customer_id, cc.status, bc.NEW_APPLIANCE_QNT
    FROM customer_connection cc, burner_qnt_change bc
   WHERE     CC.CUSTOMER_ID = BC.CUSTOMER_ID
         AND BC.NEW_APPLIANCE_QNT = 0
         AND CC.STATUS = 1
         AND SUBSTR (CC.CUSTOMER_ID, 1, 2) = '01'
GROUP BY bc.customer_id
ORDER BY CC.CUSTOMER_ID ASC



select * from customer_connection where CUSTOMER_ID in(
select distinct CUSTOMER_ID from burner_qnt_change
minus
select distinct CUSTOMER_ID from burner_qnt_change where pid in(
select max(pid) from burner_qnt_change
group by CUSTOMER_ID,APPLIANCE_TYPE_CODE)
and NEW_APPLIANCE_QNT >0)
and status=1


update customer_connection set status=0 where CUSTOMER_ID in(
select distinct CUSTOMER_ID from burner_qnt_change
minus
select distinct CUSTOMER_ID from burner_qnt_change where pid in(
select max(pid) from burner_qnt_change
group by CUSTOMER_ID,APPLIANCE_TYPE_CODE)
and NEW_APPLIANCE_QNT >0)
and status=1