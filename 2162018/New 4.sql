select * from customer_connection where  
--TO_DATE(CONNECTION_DATE, 'dd/MM/YYYY')='31/12/2017' and
substr(customer_id, 1, 2)='01'
--and CONNECTION_DATE=TO_DATE('31/12/2017', 'dd/MM/YYYY')
and customer_id='010100249'
--select * from customer_connection where CONNECTION_DATE= '31/12/2017'