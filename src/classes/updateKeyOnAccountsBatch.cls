public class updateKeyOnAccountsBatch implements Database.Batchable<sObject>,Database.Stateful {
    public static Integer uniqueKeyCustomer = 100001; 
    public static Integer uniqueKeyVendor = 200001; 
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of account records where account number doesnot starts with 1 or 2
        Set<String> numsToExclude = new Set<String>{'1%','2%'};
        String query = 'select id,name,inscor__Account_Number__c,inscor__Accounting_Type__c from account where (not inscor__Account_Number__c like:numsToExclude) and inscor__Accounting_Type__c!=null';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Account> accList) {
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
        //*************END ************
        for(Account acc : accList){
            if(acc.inscor__Accounting_Type__c == 'Customer'){
                uniqueKeyCustomer++;
                acc.inscor__Account_Number__c = string.valueof(uniqueKeyCustomer);
            }else if(acc.inscor__Accounting_Type__c == 'Vendor'){
                uniqueKeyVendor++;
                acc.inscor__Account_Number__c = string.valueof(uniqueKeyVendor);
            }
        }
        try {
            // Update the Account Record
            update accList;
        } catch(Exception e) {
            System.debug(e);
        }
    }   
    public void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
    }
}