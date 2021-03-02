CREATE OR REPLACE PROCEDURE PGCL.mpg_create_bank(iBankName in varchar2, iIPaddress in varchar2 )
IS
tUserCount number;
tbank_idCount number;
tNewBankId varchar(3);
tNewBranchId varchar(3);
oRespMsg varchar2(1000);

     
  
BEGIN

select count(*) into tUserCount from MPG_USERINFO where FULLNAME=iBankName;
select count(*) into tbank_idCount from mst_bank_info where bank_name=iBankName;

if(tUserCount<>1 and tbank_idCount<>0)
    then
    --oRespMsg:= 'Bank user has not created yet';
    return;
else
select max(substr(BANK_ID,1,3))+1 into tNewBankId from mst_bank_info ;
select max(substr(branch_id,1,3))+1 into tNewBranchId  from MST_BRANCH_INFO;


INSERT INTO MST_BANK_INFO (BANK_ID, BANK_NAME, ADDRESS, PHONE, FAX, EMAIL,URL, DESCRIPTION, STATUS) 
                          ( SELECT tNewBankId, iBankName, iIPaddress, PHONE, FAX, EMAIL,URL, DESCRIPTION, STATUS FROM MST_BANK_INFO where BANK_NAME='GP');
 

--tNewBranchId:= tNewBankId||AREA_ID;

INSERT INTO MST_BRANCH_INFO (
   AREA_ID, BANK_ID, BRANCH_ID, 
   BRANCH_NAME, ADDRESS, CPERSON, 
   PHONE, MOBILE, FAX, 
   EMAIL, DESCRIPTION, STATUS) 
 ( SELECT AREA_ID, tNewBankId,tNewBankId||AREA_ID BRANCH_ID, 
   iBankName as BRANCH_NAME, ADDRESS, CPERSON, 
   PHONE, MOBILE, FAX, 
   EMAIL, DESCRIPTION, STATUS
FROM MST_BRANCH_INFO where  bank_id=10);



end if;

commit;

EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      oRespMsg:='Exception Occured : '|| 'Error Code : '||SQLCODE|| ', Error Message : ' || SUBSTR(SQLERRM, 1, 400)||DBMS_UTILITY.format_error_backtrace;   
      
END mpg_create_bank;
/
