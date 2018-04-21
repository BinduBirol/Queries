select * from customer_connection where CUSTOMER_ID in(
select distinct CUSTOMER_ID from burner_qnt_change
minus
select distinct CUSTOMER_ID from burner_qnt_change where pid in(
select max(pid) from burner_qnt_change
group by CUSTOMER_ID,APPLIANCE_TYPE_CODE)
and NEW_APPLIANCE_QNT >0)
and status=1
