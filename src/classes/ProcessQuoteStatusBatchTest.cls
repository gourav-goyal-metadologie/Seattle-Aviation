@isTest
public class ProcessQuoteStatusBatchTest {
    
    public static final Integer COUNT_LIMIT = 10;
    
    @testSetup()
    private static void setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(oppList.size(), COUNT_LIMIT);
    }
    
    @isTest
    private static void ProcessQuoteStatusRunBatchTest(){
        List<inscor__Customer_Quote__c> customerQuoteQryList = 
            new List<inscor__Customer_Quote__c>([SELECT Id, Lost_Reason__c, inscor__Status__c 
                                                 FROM inscor__Customer_Quote__c]);
        for(inscor__Customer_Quote__c cQ : customerQuoteQryList){
            Test.setCreatedDate(cQ.Id, DateTime.newInstance(2012,12,12));
        }
        Test.startTest();
        ProcessQuoteStatusBatch batchRec = new ProcessQuoteStatusBatch();
        SchedulableContext sc = NULL;
        //Database.executeBatch(batchRec, COUNT_LIMIT);
        batchRec.execute(sc);
        
        Test.stopTest();
        List<inscor__Customer_Quote__c> customerQuoteList = 
            new List<inscor__Customer_Quote__c>([SELECT Id, Lost_Reason__c, inscor__Status__c 
                                                 FROM inscor__Customer_Quote__c 
                                                 WHERE LastModifiedDate = Today]);
        for(inscor__Customer_Quote__c cRec: customerQuoteList){
            system.assertEquals(cRec.Lost_Reason__c, 'High Price');
            system.assertEquals(cRec.inscor__Status__c, 'Closed - Lost');
        }
    }
}