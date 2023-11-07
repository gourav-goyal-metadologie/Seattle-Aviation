/**************************************************************************************************
Description: Trigger class for inscor__Customer_Quote_Line__c that will handle all types of trigger events Test Methods.
====================================================================================================
====================================================================================================
Class: CustomerQuoteLineTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
public class CustomerQuoteLineTriggerHelperTest {
    public static final Integer COUNT_LIMIT = 10;
    
    @testSetup()
    private static void setup(){
        //Create a Account for Customer
        Account accRec = new Account();
        accRec.Name = 'TEST Account';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
          inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(oppList.size(), COUNT_LIMIT);
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) { 
                inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Quantity__c = 10;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        insert customerQuoteLineToInsertList;
    }
    
    @isTest
    private static void updateCustomerQuoteOnInsertTest(){ 
        Test.startTest();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToCount 
            = new List<inscor__Customer_Quote_Line__c>([SELECT Id,inscor__Quantity__c,inscor__Business_Category__c FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(customerQuoteLineToCount.size(), (COUNT_LIMIT*COUNT_LIMIT)); 
        system.assertEquals(customerQuoteLineToCount[0].inscor__Business_Category__c, 'Distribution'); 
        system.assertEquals(customerQuoteLineToCount[0].inscor__Quantity__c, 10);
        Test.stopTest();
    }
    
    @isTest
    private static void updateCustomerScoreOnUpdateTestI(){
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToUpdate 
            = new List<inscor__Customer_Quote_Line__c>([SELECT Id,inscor__Business_Category__c,inscor__Quantity__c FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(customerQuoteLineToUpdate.size(), (COUNT_LIMIT*COUNT_LIMIT)); 
        system.assertEquals(customerQuoteLineToUpdate[0].inscor__Business_Category__c, 'Distribution'); 
        system.assertEquals(customerQuoteLineToUpdate[0].inscor__Quantity__c, 10);
        //Update 
        List<inscor__Customer_Quote_Line__c> cusQuoteLineToUpdateList 
            = new List<inscor__Customer_Quote_Line__c>();
        for(inscor__Customer_Quote_Line__c qouteLineRec : customerQuoteLineToUpdate){
            qouteLineRec.inscor__Business_Category__c = 'Surplus';
            qouteLineRec.inscor__Quantity__c = 20;
            cusQuoteLineToUpdateList.add(qouteLineRec);  
        }
        test.startTest();
        update cusQuoteLineToUpdateList;
        test.stopTest();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToCount 
            = new List<inscor__Customer_Quote_Line__c>([SELECT Id,inscor__Business_Category__c,inscor__Quantity__c FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(customerQuoteLineToCount.size(), (COUNT_LIMIT*COUNT_LIMIT)); 
        system.assertEquals(customerQuoteLineToCount[0].inscor__Business_Category__c, 'Surplus'); 
        system.assertEquals(customerQuoteLineToCount[0].inscor__Quantity__c, 20);
    }
    
    @isTest
    private static void updateCustomerScoreOnUpdateTestII(){
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToUpdate 
            = new List<inscor__Customer_Quote_Line__c>([SELECT Id,inscor__Business_Category__c,inscor__Quantity__c FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(customerQuoteLineToUpdate.size(), (COUNT_LIMIT*COUNT_LIMIT)); 
        system.assertEquals(customerQuoteLineToUpdate[0].inscor__Business_Category__c, 'Distribution'); 
        system.assertEquals(customerQuoteLineToUpdate[0].inscor__Quantity__c, 10);
        test.startTest();
        //Update 
        List<inscor__Customer_Quote_Line__c> cusQuoteLineToUpdateList 
            = new List<inscor__Customer_Quote_Line__c>();
        for(inscor__Customer_Quote_Line__c qouteLineRec : customerQuoteLineToUpdate){
            qouteLineRec.inscor__Business_Category__c = 'Broker';
            qouteLineRec.inscor__Quantity__c = 20;
            cusQuoteLineToUpdateList.add(qouteLineRec);  
        }
        
        update cusQuoteLineToUpdateList;
        test.stopTest();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToCount 
            = new List<inscor__Customer_Quote_Line__c>([SELECT Id,inscor__Business_Category__c,inscor__Quantity__c FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(customerQuoteLineToCount.size(), (COUNT_LIMIT*COUNT_LIMIT)); 
        system.assertEquals(customerQuoteLineToCount[0].inscor__Business_Category__c, 'Broker'); 
        system.assertEquals(customerQuoteLineToCount[0].inscor__Quantity__c, 20);
    }
    
    @isTest
    public static void triggerMethodsTest() { 
        test.StartTest();
        List<inscor__Customer_Quote_Line__c> recList = new List<inscor__Customer_Quote_Line__c>([SELECT id FROM inscor__Customer_Quote_Line__c]);
        test.stopTest();   
        delete recList;
        List<inscor__Customer_Quote_Line__c> recListToAssert = new List<inscor__Customer_Quote_Line__c>([SELECT id FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(recListToAssert.size(), 0);
        undelete recList;  
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        test.StartTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Customer_Quote_Line_Trigger_Disable__c  = TRUE;
        insert tc;
        test.stopTest(); 
        List<inscor__Customer_Quote_Line__c> recList = new List<inscor__Customer_Quote_Line__c>([SELECT id FROM inscor__Customer_Quote_Line__c]);
        delete recList;
        List<inscor__Customer_Quote_Line__c> recListToAssert = new List<inscor__Customer_Quote_Line__c>([SELECT id FROM inscor__Customer_Quote_Line__c]);
        system.assertEquals(recListToAssert.size(), 0);
    }
}