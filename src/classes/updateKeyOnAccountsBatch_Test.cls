@isTest
private class updateKeyOnAccountsBatch_Test {
    
    static testmethod void test() {
        Account objacc = new Account();
        objacc.Name = 'Test '+Math.random();
        objacc.inscor__Account_Number__c='157893';
        objacc.inscor__Accounting_Type__c='Customer';
        insert objacc;
        
        Account objacc1 = new Account();
        objacc1.Name = 'Test '+Math.random();
        objacc1.inscor__Account_Number__c='457893';
        objacc1.inscor__Accounting_Type__c='Customer';
        insert objacc1;
        
        Account objacc2 = new Account();
        objacc2.Name = 'Test '+Math.random();
        objacc2.inscor__Account_Number__c='557893';
        objacc2.inscor__Accounting_Type__c='Vendor';
        insert objacc2;

        Test.startTest();
        updateKeyOnAccountsBatch c = new updateKeyOnAccountsBatch();
        Database.executeBatch(c);
        Test.stopTest();
        System.assert(c!=null);
    }
}