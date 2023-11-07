/**************************************************************************************************
Description: Used to test apex class : PartOrderController
====================================================================================================
====================================================================================================
Class: PartOrderControllerTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		09/19/2021		   Vinod Kumar Sharma				Initial Creation    
***************************************************************************************************/
@isTest
public class PartOrderControllerTest {

    public static final Integer COUNT_LIMIT = 10;
    
    @testSetup()
    private static void setup(){
        YayPay_Configuration__c config = new YayPay_Configuration__c(Is_Integration_Enable__c = false);
        insert config;
        
        Compliance_Configuration__c config1 = new Compliance_Configuration__c(Is_Integration_Enable__c = false);
        insert config1;
        
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        List<inscor__Company__c> companyInstances = [SELECT Id, inscor__Company_Name__c, inscor__Address_1__c, inscor__City__c, inscor__Zip_Code__c FROM inscor__Company__c];
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accList[0].Id;
            customerQuoteRec.inscor__Company__c = companyInstances[0].Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;

        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(name = 'test code', inscor__Show_in_Summary__c = false);
        insert conditionCode;

        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteToInsertList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = companyInstance.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;

        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test');
        insert product;
        
        
    }

    @IsTest
    static void testGetCustomerQuote(){
        Account account = [SELECT Id FROM Account LIMIT 1];
        Product2 product = [SELECT Id FROM Product2];
        inscor__Condition_Code__c conditionCode = [SELECT Id FROM inscor__Condition_Code__c];
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = [SELECT  Id FROM inscor__Customer_Quote__c];
        
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        Test.startTest();
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
        List<PartOrderController.ResponseWrapper> responseWrappers = PartOrderController.getCustomerQuotes(account.Id);
        System.assertEquals(1, responseWrappers.size());
        Test.stopTest();
        
    }

    @IsTest
    static void testGetCustomerQuotesLineItem(){
        Account account = [SELECT Id FROM Account LIMIT 1];
        Product2 product = [SELECT Id FROM Product2];
        inscor__Condition_Code__c conditionCode = [SELECT Id FROM inscor__Condition_Code__c];
        List<inscor__Customer_Quote__c> customerQuoteToInsertList = [SELECT  Id FROM inscor__Customer_Quote__c];
        
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        Test.startTest();
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
        List<PartOrderController.ResponseWrapper> responseWrappers = PartOrderController.getCustomerQuotesLineItem(account.Id);
        System.assert(responseWrappers.size() > 0);
        Test.stopTest();
        
    }

    @IsTest
    static void testGetSalesQuotesLineItem(){
        Test.startTest();
        Account account = [SELECT Id FROM Account LIMIT 1];
        Product2 product = [SELECT Id FROM Product2];
        inscor__Condition_Code__c conditionCode = [SELECT Id FROM inscor__Condition_Code__c];
        List<inscor__Sales_Order__c> salesOrderList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderList[0].Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = product.Id;
        
        insert salesOrderLineRec;
        List<PartOrderController.ResponseWrapper> responseWrappers = PartOrderController.getSalesQuotesLineItem(account.Id);
        System.assertEquals(1, responseWrappers.size());
        Test.stopTest();
        
    }

    @IsTest
    static void testGetSalesOrder(){
        Test.startTest();
        Account account = [SELECT Id FROM Account LIMIT 1];
        Product2 product = [SELECT Id FROM Product2];
        inscor__Condition_Code__c conditionCode = [SELECT Id FROM inscor__Condition_Code__c];
        List<inscor__Sales_Order__c> salesOrderList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
        salesOrderLineRec.inscor__Order__c = salesOrderList[0].Id;
        salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
        salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
        salesOrderLineRec.inscor__Product__c = product.Id;
        insert salesOrderLineRec;
        List<PartOrderController.ResponseWrapper> responseWrappers = PartOrderController.getSalesOrder(account.Id);
        System.assertEquals(1, responseWrappers.size());
        Test.stopTest();
    }
}