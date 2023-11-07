@isTest
public class ProcessObsoleteLeadBatchTest {
    public static final Integer COUNT_LIMIT = 100;
    
    @TestSetup
    private static void Setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST Account';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
    }
    
    @isTest
    private static void ProcessObsoleteLeadRunBatchTest(){
        Account acc = [SELECT Id,ownerId FROM Account];
        Map<String,Lead_Managment__mdt> leadManagmentSettings = new Map<String,Lead_Managment__mdt>();
        leadManagmentSettings = Lead_Managment__mdt.getall();
        Test.startTest();
        ProcessObsoleteLeadBatch batchRec = new ProcessObsoleteLeadBatch();
        SchedulableContext sc = NULL;
        //Database.executeBatch(batchRec, COUNT_LIMIT);
        batchRec.execute(sc);
        Test.stopTest();
        List<Lead> leadList = new List<Lead>([SELECT Id,Status,ownerId FROM Lead]);
        for(Lead leadRec : leadList){
            system.assertEquals(leadRec.Status,leadManagmentSettings.containsKey('Lead_Status') ? 
                leadManagmentSettings.get('Lead_Status').Value__C : 'New');
            system.assertEquals(leadRec.ownerId, leadManagmentSettings.containsKey('Lead_OwnerId') ? 
                ( leadManagmentSettings.get('Lead_OwnerId').Value__c != null ? 
                 leadManagmentSettings.get('Lead_OwnerId').Value__c : acc.ownerId) : acc.ownerId);
        }
    }
    
}