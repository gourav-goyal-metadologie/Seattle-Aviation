/**************************************************************************************************
Description: Trigger class for inscor__Sales_Order_Line__c that will handle all types of trigger events.
====================================================================================================
====================================================================================================
Class: SalesOrderLineItemTriggerHelperTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		05/20/2021		    Gourav Goyal				Initial Creation     
***************************************************************************************************/
@isTest
public class SalesOrderLineItemTriggerHelperTest {
    
    public static final Integer COUNT_LIMIT = 10;
    public static final Integer COUNT_LIMIT_FOR_LINE_ITEM = 5;
    
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
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        system.assertEquals(oppList.size(), COUNT_LIMIT);
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList){
            for(Integer i = 0; i< COUNT_LIMIT_FOR_LINE_ITEM; i++) { 
            	inscor__Customer_Quote_Line__c qouteLineRec = new inscor__Customer_Quote_Line__c();
                qouteLineRec.inscor__Customer_Quote__c = quoteRec.Id;
                qouteLineRec.inscor__Quantity__c = 10;
                qouteLineRec.inscor__Business_Category__c = 'Distribution';
                customerQuoteLineToInsertList.add(qouteLineRec);
            }  
        }
        insert customerQuoteLineToInsertList;
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
		insert conditionCode;
    }
    
    @isTest
    private static void updateCustomerQuoteTest(){ 
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        Test.startTest(); 
        inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        List<inscor__Sales_Order__c> salesOrderList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        system.assertEquals(salesOrderList.size(), COUNT_LIMIT);
        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        //Product2 pr = new Product2(Name ='#10',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA'); Commented by Vinod to resolve production test error
        Product2 pr = new Product2(Name = 'Laptop X200', Family = 'Hardware', inscor__Keyword__c ='test');
        insert pr;
        for(inscor__Sales_Order__c salesOrder : salesOrderList){
            for(Integer i = 0; i< COUNT_LIMIT_FOR_LINE_ITEM; i++) {
                inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
                salesOrderLineRec.inscor__Order__c = salesOrder.Id;
                salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
                salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
                salesOrderLineRec.inscor__Product__c = pr.Id;
                salesOrderLineToInsertList.add(salesOrderLineRec);
            }
        }
        insert salesOrderLineToInsertList;
        Test.stopTest();
        List<inscor__Sales_Order_Line__c> salesOrderLineToCountList = new List<inscor__Sales_Order_Line__c>([SELECT Id FROM inscor__Sales_Order_Line__c]);
        system.assertEquals(COUNT_LIMIT_FOR_LINE_ITEM * COUNT_LIMIT, salesOrderLineToCountList.size());
        for(inscor__Sales_Order_Line__c slRec : salesOrderLineToCountList) {
            slRec.inscor__Quantity_Ordered__c = 20;
        }
        system.debug('Acc Details Before Update : ' + JSON.serializePretty([select Number_of_Parts_Requested__c, Customer_Quotes_Lines_Received__c, Number_of_Parts_Ordered__c, Sales_Order_Lines_Received_Weightage__c, Customer_Score_2__c from Account limit 1 ]));
        update salesOrderLineToCountList;
        system.debug('Acc Details After Update : ' + JSON.serializePretty([select Number_of_Parts_Requested__c, Customer_Quotes_Lines_Received__c, Number_of_Parts_Ordered__c, Sales_Order_Lines_Received_Weightage__c, Customer_Score_2__c from Account limit 1 ]));
        
    }
    
    @isTest
    public static void triggerMethodsTest() { 
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        Test.startTest();
                inscor__Company__c company = [SELECT Id FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        List<inscor__Sales_Order__c> salesOrderList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        system.assertEquals(salesOrderList.size(), COUNT_LIMIT);
        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
       //Product2 pr = new Product2(Name ='#10',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA'); Commented by Vinod to resolve production test error
       Product2 pr = new Product2(Name = 'Laptop X200', Family = 'Hardware', inscor__Keyword__c ='test');
       insert pr;
       
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
            salesOrderLineRec.inscor__Order__c = salesOrderList[i].Id;
            salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
            salesOrderLineRec.inscor__Product__c = pr.Id;
            salesOrderLineToInsertList.add(salesOrderLineRec);
        }
        insert salesOrderLineToInsertList;
        delete salesOrderLineToInsertList;
        test.stopTest();   
        List<inscor__Sales_Order_Line__c> recListToAssert = new List<inscor__Sales_Order_Line__c>([SELECT id FROM inscor__Sales_Order_Line__c]);
        system.assertEquals(recListToAssert.size(), 0);
        undelete salesOrderLineToInsertList;  
    }
    
    @isTest
    public static void triggerDisabledFlagTest() { 
        Test.startTest();
        //Trigger Disabled Coverage
        Trigger_Configuration__c tc = new Trigger_Configuration__c();
        tc.Sales_Order_Line_Trigger_Disable__c  = TRUE;
        insert tc;
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrderToInsertList = new List<inscor__Sales_Order__c>();
        
        //inscor__Company__c  company = new inscor__Company__c(
          //  inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        //insert company;
        
        inscor__Company__c company = [SELECT ID FROM inscor__Company__c];
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order__c salesOrderRec = new inscor__Sales_Order__c();
            salesOrderRec.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrderRec.inscor__Customer__c = accList[0].Id;
            salesOrderRec.inscor__Company__c = company.Id;
            salesOrderToInsertList.add(salesOrderRec);
        }
        insert salesOrderToInsertList;  
        List<inscor__Sales_Order__c> salesOrderList = new List<inscor__Sales_Order__c>([SELECT Id FROM inscor__Sales_Order__c]);
        system.assertEquals(salesOrderList.size(), COUNT_LIMIT);
        List<inscor__Sales_Order_Line__c> salesOrderLineToInsertList = new List<inscor__Sales_Order_Line__c>();
        
        //Product2 pr = new Product2(Name ='#10',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA'); Commented by Vinod to resolve production test error
        Product2 pr = new Product2(Name = 'Laptop X200', Family = 'Hardware', inscor__Keyword__c ='test');
        insert pr;
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) {
            inscor__Sales_Order_Line__c salesOrderLineRec = new inscor__Sales_Order_Line__c();
            salesOrderLineRec.inscor__Order__c = salesOrderList[i].Id;
            salesOrderLineRec.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLineRec.inscor__Quantity_Ordered__c = 10;
            salesOrderLineRec.inscor__Product__c = pr.Id;
            salesOrderLineToInsertList.add(salesOrderLineRec);
        }
        insert salesOrderLineToInsertList;
        test.stopTest(); 
        delete salesOrderLineToInsertList;
        List<inscor__Sales_Order_Line__c> recListToAssert = new List<inscor__Sales_Order_Line__c>([SELECT id FROM inscor__Sales_Order_Line__c]);
        system.assertEquals(recListToAssert.size(), 0);
    }
}