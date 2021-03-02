CREATE OR REPLACE PROCEDURE PGCL.Save_Ipg_Collection(
   iCustomerId          In VARCHAR2,--1
   iBankId              In VARCHAR2,--2
   iBranchId            In VARCHAR2,--3
   iCategoryId          In VARCHAR2,--4
   iIsMeter             In VARCHAR2,--5
   iTransationId        In VARCHAR2,--6
   iCollectionDate      In VARCHAR2,--7
   iInsertBy            In VARCHAR2,--8   
   oResponse            OUT  NUMBER,--9
   oRespMsg             OUT  VARCHAR2)--10
IS
    tAcNo VARCHAR2(20);
    tAcName VARCHAR2(20);
    tmpCollectionId number;
    vPaymnet_method VARCHAR2(20);
    vTransAmount number;
    vTransId VARCHAR2(20);
  
BEGIN

      oResponse :=0;
      
      if(iCategoryId in('01','02')) then
            tAcName:='DOMESTIC%';
      elsif(iCategoryId in('03','04')) then      
            tAcName:='COMMERCIAL%';
      else
            tAcName:='INDUSTRIAL%';    
      end if;  
      
      select ACCOUNT_NO into tAcNo from MST_ACCOUNT_INFO where BANK_ID=iBankId and BRANCH_ID=iBranchId and ACCOUNT_NAME like tAcName; 
      select TRANS_ID,CARD_NAME, TRANS_AMOUNT into vTransId, vPaymnet_method, vTransAmount from init_ipg where IPG_TXN_ID= iTransationId;
      
      
      
      
           FOR rec  IN (select * from (select bill_id,BILLED_AMOUNT,CALCUALTESURCHARGE_METER(bill_id,sysdate) as ACTUAL_SURCHARGE, PAYABLE_AMOUNT, BILL_MONTH,BILL_YEAR from bill_metered where customer_id=iCustomerId and status=1
                        union
                        select bill_id,BILLED_AMOUNT, CALCUALTESURCHARGE(bill_id,sysdate)ACTUAL_SURCHARGE, ACTUAL_PAYABLE_AMOUNT, BILL_MONTH,BILL_YEAR from bill_non_metered where customer_id=iCustomerId and status=1))
          
      
       LOOP
                            
              if(iIsMeter=0) then
                            UPDATE BILL_NON_METERED set COLLECTED_BILLED_AMOUNT=nvl(COLLECTED_BILLED_AMOUNT,0)+rec.bill_id,
                                                COLLECTED_PAYABLE_AMOUNT=nvl(COLLECTED_PAYABLE_AMOUNT,0)+rec.PAYABLE_AMOUNT,STATUS=2
                            where Customer_Id=iCustomerId and BILL_ID=rec.bill_id; 
                             
                             Select SQN_COLLECTION_NM.NEXTVAL Into tmpCollectionId from dual;
                                                    
                            Insert Into BILL_COLLECTION_NON_METERED(COLLECTION_ID,BILL_ID,CUSTOMER_ID,BANK_ID,BRANCH_ID,ACCOUNT_NO,COLLECTION_DATE,COLLECTED_BILL_AMOUNT,COLLECTED_SURCHARGE_AMOUNT,TOTAL_COLLECTED_AMOUNT,REMARKS,COLLECED_BY,INSERTED_ON,SURCHARGE_PER_COLL) 
                            Values(tmpCollectionId,rec.bill_id,iCustomerId,iBankId,iBranchId,tAcNo,to_date(iCollectionDate,'dd-MM-YYYY'),rec.BILLED_AMOUNT,rec.ACTUAL_SURCHARGE,rec.PAYABLE_AMOUNT,'ByIPG',iInsertBy,SYSDATE,to_number(rec.ACTUAL_SURCHARGE));                             
                            
              else  
        
     
                        UPDATE BILL_METERED set COLLECTED_AMOUNT=nvl(COLLECTED_AMOUNT,0)+rec.PAYABLE_AMOUNT,
                                                STATUS=2
                                        where Customer_Id=iCustomerId and BILL_ID=rec.bill_id; 
                                     
                        Select SQN_COLLECTION_M.NEXTVAL Into tmpCollectionId from dual;
                                                            
                        Insert Into BILL_COLLECTION_METERED(COLLECTION_ID,BILL_ID,CUSTOMER_ID,BANK_ID,BRANCH_ID,ACCOUNT_NO,COLLECTION_DATE,COLLECTION_AMOUNT,REMARKS,COLLECED_BY,INSERTED_ON) 
                                    Values(tmpCollectionId,rec.bill_id,iCustomerId,iBankId,iBranchId,tAcNo,to_date(iCollectionDate,'dd-MM-YYYY'),rec.PAYABLE_AMOUNT,'ByBank',iInsertBy,SYSDATE); 
               end if;   
              
               
               INSERT INTO CUSTOMER_LEDGER (TRANS_ID, TRANS_DATE, PARTICULARS,DEBIT, CREDIT,  BILL_ID, COLLECTION_ID, INSERTED_BY,INSERTED_ON, CUSTOMER_ID, STATUS) 
               VALUES (SQN_CL.nextval,to_date(iCollectionDate,'dd-MM-YYYY'),'By IPG '||rec.BILL_MONTH||' '||rec.BILL_YEAR, rec.PAYABLE_AMOUNT,0,rec.BILL_ID,tmpCollectionId,'IPG',SYSDATE,iCustomerId,0);           
        
                
                INSERT INTO BANK_ACCOUNT_LEDGER (TRANS_ID, TRANS_DATE, TRANS_TYPE,PARTICULARS, BANK_ID, BRANCH_ID, ACCOUNT_NO, DEBIT, CREDIT, REF_ID, INSERTED_ON, 
                                                      INSERTED_BY, CUSTOMER_ID, STATUS,METER_RENT, SURCHARGE, ACTUAL_REVENUE, MISCELLANEOUS, DEMAND_CHARGE) 
                VALUES (SQN_BAL.nextval,to_date(iCollectionDate,'dd-MM-YYYY'),1,'By IPG '||rec.BILL_MONTH||' '||rec.BILL_YEAR,iBankId,iBranchId,tAcNo,rec.PAYABLE_AMOUNT,0,vTransId,sysdate,
                'IPG',iCustomerId,0,0,rec.ACTUAL_SURCHARGE,rec.BILLED_AMOUNT,0,0 );
                
                
                INSERT INTO IPG_BILL_DETAIL (TRA_ID, CUSTOMER_ID, BILL_ID) 
                VALUES (iTransationId,iCustomerId,rec.BILL_ID );
       
                
            END LOOP;
            
     
        
     INSERT INTO IPG_MST (TRANSACTION_ID, CUSTOMER_ID, PAYMENT_METHOD,TOTAL_AMOUNT, STATUS, INSERT_TIME) 
     VALUES (iTransationId,iCustomerId,vPaymnet_method,vTransAmount,1,sysdate  );
      
       
       oResponse:=1;
       oRespMsg:='Successfully Saved Collecton for '||iCustomerId;           
        
   EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      oResponse:=500;
      IF SQLCODE=-1 THEN
      oRespMsg:='One of the Bills is Already Collected';
      ELSE
      oRespMsg:='Error Code : '||SQLCODE|| ', Error Message : ' || SUBSTR(SQLERRM, 1, 400) || DBMS_UTILITY.format_error_backtrace;
       --tErrorLog:=tErrorLog||' : Exception Occured : '|| 'Error Code : '||SQLCODE|| ', Error Message : ' || SUBSTR(SQLERRM, 1, 400) || '<br/>'||DBMS_UTILITY.format_error_backtrace;
      --oRespMsg:='error';
      END IF;
      
      
END Save_Ipg_Collection;
/
