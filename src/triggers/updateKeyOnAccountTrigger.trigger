trigger updateKeyOnAccountTrigger on Account (before insert,before Update) {
    public Integer uniqueKeyCustomer = 100001; 
    public Integer uniqueKeyVendor = 200001; 
    //Get the last updated highest unique key from account
    for(Account acc:[select id, inscor__Account_Number__c from account where inscor__Account_Number__c like '1%' order by inscor__Account_Number__c desc]){
        if(acc.inscor__Account_Number__c.isNumeric()){
            uniqueKeyCustomer = Integer.valueof(acc.inscor__Account_Number__c);
            break;
        }
    }
    for(Account acc:[select id, inscor__Account_Number__c from account where inscor__Account_Number__c like '2%' order by inscor__Account_Number__c desc]){
        if(acc.inscor__Account_Number__c.isNumeric()){
            uniqueKeyVendor = Integer.valueof(acc.inscor__Account_Number__c);
            break;
        }
    }
    for(Account acc : trigger.new){
        if(acc.inscor__Account_Number__c.substring(0,1)!='1' || acc.inscor__Account_Number__c.substring(0,1)!='2'){
            if(acc.inscor__Accounting_Type__c == 'Customer'){
                uniqueKeyCustomer++;
                acc.inscor__Account_Number__c = string.valueof(uniqueKeyCustomer);
            }else if(acc.inscor__Accounting_Type__c == 'Vendor'){
                uniqueKeyVendor++;
                acc.inscor__Account_Number__c = string.valueof(uniqueKeyVendor);
            }
        }
    }
}