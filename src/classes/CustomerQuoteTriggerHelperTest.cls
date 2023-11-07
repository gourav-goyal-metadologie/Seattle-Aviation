/**************************************************************************************************
Description: Trigger class for inscor__Customer_Quote__c that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: LeadTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
public class CustomerQuoteTriggerHelperTest {
    public static final Integer COUNT_LIMIT = 10;
    
    @testSetup()
    private static void setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec; 
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
    }
    
    @isTest
    private static void convertQuoteToOpportunityTest(){
        Test.startTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
          inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        Test.stopTest();
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(COUNT_LIMIT, oppList.size());
    } 
    
    @isTest
    public static void triggerMethodsTest() { 
        test.StartTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
         inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        List<inscor__Customer_Quote__c> recList = new List<inscor__Customer_Quote__c>([SELECT id FROM inscor__Customer_Quote__c]);
        test.stopTest();   
        delete recList;
        List<inscor__Customer_Quote__c> recListToAssert = new List<inscor__Customer_Quote__c>([SELECT id FROM inscor__Customer_Quote__c]);
        system.assertEquals(recListToAssert.size(), 0);
        undelete recList;  
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        test.StartTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Customer_Quote_Trigger_Disable__c = TRUE;
        insert tc;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        test.stopTest(); 
        List<inscor__Customer_Quote__c> recList = new List<inscor__Customer_Quote__c>([SELECT id FROM inscor__Customer_Quote__c]);
        delete recList;
        List<inscor__Customer_Quote__c> recListToAssert = new List<inscor__Customer_Quote__c>([SELECT id FROM inscor__Customer_Quote__c]);
        system.assertEquals(recListToAssert.size(), 0);
    }
    
    /*
    * Deleted method
    @isTest
    static void testupdateCustomerQuoteOrderLineCount(){
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        CustomerQuoteTriggerHelper.updateCustomerQuoteOrderLineCount(customerQuoteToInsertList);
    }*/
}