

SELECT * FROM MST_BRANCH_INFO BR, MST_BANK_INFO BK WHERE BR.AREA_ID='01' 
AND BRANCH_ID NOT IN( SELECT BRANCH_ID FROM MST_BRANCH_INFO WHERE AREA_ID<>'01')
AND BR.BANK_ID=BK.BANK_ID