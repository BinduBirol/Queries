select * from bill_non_metered 
where bill_id in (select bill_id from MPG_BILL_DETAIL 
where TRA_ID in(  select TRA_ID from mpg_bill where TRANSACTION_ID in(select TRANSACTION_ID from MPG_BILL_GP )));





select * from BANK_ACCOUNT_LEDGER where REF_ID in (select 'M-'||TRA_ID from mpg_bill where TRANSACTION_ID in(select TRANSACTION_ID from MPG_BILL_GP ));

select * from BILL_COLLECTION_NON_METERED where bill_id in (select bill_id from MPG_BILL_DETAIL where TRA_ID in(  select TRA_ID from mpg_bill where TRANSACTION_ID='6HE0IBDRD8'));
