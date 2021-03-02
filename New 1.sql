CREATE OR REPLACE PROCEDURE JALALABAD_TEST.ADVANCED_COLLECTION_DELETE(
   iScrollNo          In VARCHAR2,     
   oResponse            OUT  NUMBER,
   oRespMsg             OUT  VARCHAR2
)
is
vDCollectAmount number;
vDCollectSur number;
vTotalCollAmount number;
vTotalCollSur number;
vTotalRemainAmount number;
vTotalRemainSur number;
vCustomerId VARCHAR2(50);



BEGIN   


    select COLLECTED_AMOUNT,COLLECTED_SURCHARGE,CUSTOMER_ID into vDCollectAmount, vDCollectSur, vCustomerId
    from DAILY_COLLECTION_GRID where SCROLL_NO=iScrollNo;
     
     vTotalCollAmount :=0;
     vTotalCollSur :=0;       
       
     FOR rec in (select BILL_ID,DEDUCT_AMOUNT,DEDUCT_SURCHARGE,BANK_ID,BRANCH_ID,ACCOUNT_NO,TRANS_DATE 
                from BILL_COLL_ADVANCED where COLLECTED_BY='G-'||iScrollNo and BILL_ID is not null order by BILL_ID)
     loop
        
            update bill_non_metered set COLLECTED_BILLED_AMOUNT=COLLECTED_BILLED_AMOUNT-rec.DEDUCT_AMOUNT,
                                        COLLECTED_SURCHARGE=COLLECTED_SURCHARGE-rec.DEDUCT_SURCHARGE,
                                        COLLECTED_PAYABLE_AMOUNT=COLLECTED_PAYABLE_AMOUNT-rec.DEDUCT_AMOUNT-rec.DEDUCT_SURCHARGE,
                                        STATUS=1
            where BILL_ID=rec.BILL_ID;
            
            delete from BILL_COLLECTION_NON_METERED
            where BILL_ID=rec.BILL_ID
            and BANK_ID=rec.BANK_ID
            and BRANCH_ID=rec.BRANCH_ID
            and ACCOUNT_NO=rec.ACCOUNT_NO
            and COLLECTION_DATE=rec.TRANS_DATE;
                                        
            vTotalCollAmount :=vTotalCollAmount+rec.DEDUCT_AMOUNT;
            vTotalCollSur :=vTotalCollSur+rec.DEDUCT_SURCHARGE;
            
            delete from BILL_COLL_ADVANCED where COLLECTED_BY='G-'||iScrollNo and STATUS=2 and BILL_ID=rec.BILL_ID;
    
     end loop;   
     
     vTotalRemainAmount:= vDCollectAmount- vTotalCollAmount;
     vTotalRemainSur :=  vDCollectSur- vTotalCollSur;
     
    
    
    update BILL_COLL_ADVANCED set ADVANCED_AMOUNT=ADVANCED_AMOUNT-vTotalRemainAmount,
                                  ADVANCED_SURCHARGE=ADVANCED_SURCHARGE-vTotalRemainSur  
    where CUSTOMER_ID=vCustomerId and STATUS=1; 
    
    delete from BANK_ACCOUNT_LEDGER where REF_ID='G-'||iScrollNo;

   delete from DAILY_COLLECTION_GRID where SCROLL_NO=iScrollNo;
    oResponse:=1;
    oRespMsg:='Successfully Delete Collecton Information';
    COMMIT; 
    
    EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      oResponse:=500;
      IF SQLCODE=-1 THEN
      oRespMsg:='Exception Occured';
      ELSE
      oRespMsg:='Exception Occured : '|| 'Error Code : '||SQLCODE|| ', Error Message : ' || SUBSTR(SQLERRM, 1, 400);
      END IF;
     


END ADVANCED_COLLECTION_DELETE;
/
