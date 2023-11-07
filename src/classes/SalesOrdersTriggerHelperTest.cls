/**************************************************************************************************
Description: Trigger Helper class for inscor__Sales_Order__c that will handle all types of 
trigger events Test Methods
====================================================================================================
====================================================================================================
Class: SalesOrdersTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/21/2021		    Gourav Goyal				Initial Creation    
***************************************************************************************************/
@isTest
public class SalesOrdersTriggerHelperTest {
    
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
        
        inscor__Company__c  company = new inscor__Company__c(
            inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = company.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;
        
        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test');
        insert product;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(name = 'test code', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(oppList.size(), COUNT_LIMIT);
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT; i++) { 
                inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Quote_Type__c = 'Outright';
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Price__c = 122;
                qouteLineRec.inscor__Product__c = product.id;
                qouteLineRec.inscor__Quantity__c = 12;
                qouteLineRec.inscor__Condition_Code__c = conditionCode.id;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        insert customerQuoteLineToInsertList;
    }    
    
    @isTest
    private static void isInsertTest(){
        Test.startTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
       	inscor__Company__c company = [SELECT ID FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        List<inscor__Sales_Order__c> salesOrderToCountList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        system.assertEquals(salesOrderToCountList.size(), COUNT_LIMIT);
        Test.stopTest();
    }
    
     @isTest
    public static void triggerMethodsTest() { 
        test.StartTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        inscor__Company__c company = [SELECT ID FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.ID;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        List<inscor__Sales_Order__c> recList = new List<inscor__Sales_Order__c>([SELECT id FROM inscor__Sales_Order__c]);
        test.stopTest();   
        delete recList;
        List<inscor__Sales_Order__c> recListToAssert = new List<inscor__Sales_Order__c>([SELECT id FROM inscor__Sales_Order__c]);
        system.assertEquals(recListToAssert.size(), 0);
        undelete recList;  
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        test.StartTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Sales_Order_Trigger_Disable__c  = TRUE;
        insert tc;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
                inscor__Company__c company = [SELECT ID FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList; 
        test.stopTest(); 
        List<inscor__Sales_Order__c> recList = new List<inscor__Sales_Order__c>([SELECT id FROM inscor__Sales_Order__c]);
        delete recList;
        List<inscor__Sales_Order__c> recListToAssert = new List<inscor__Sales_Order__c>([SELECT id FROM inscor__Sales_Order__c]);
        system.assertEquals(recListToAssert.size(), 0);
    }
}