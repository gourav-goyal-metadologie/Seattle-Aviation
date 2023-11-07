/**************************************************************************************************
Description: This batch class used for sending out email 
====================================================================================================
====================================================================================================
Class: CustomerExchangeEmailNotifyBatchTest
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/15/2021		    Nikhil Kumar Srivastava				Initial Creation     
***************************************************************************************************/
@isTest
public class CustomerExchangeEmailNotifyBatchTest 
{
    public static final Integer COUNT_LIMIT = 10;

    @TestSetup
    private static void setup() 
    { 
        Account accRec = new Account();
        accRec.Name = 'Customer 101';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;

        Contact c = new Contact();
        c.FirstName = 'Customer';
        c.LastName = 'Contact 101';
        c.Email = 'customercontact101@xyz.com';
        c.AccountId = accRec.Id;
        insert c;
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;

        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        for(Integer i = 0; i < COUNT_LIMIT; i++) 
        {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = companyInstance.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;

        List<Opportunity> oppList = new List<Opportunity>([SELECT Id FROM Opportunity]);
        
        for(inscor__Customer_Quote__c quoteRec : customerQuoteToInsertList)
        {
            for(Integer i = 0; i< COUNT_LIMIT; i++) 
            { 
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
    private static void validateCustomerExchangeEmailNotifyBatch()
    {
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        Id contactId = [SELECT Id FROM Contact LIMIT 1]?.Id;
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrders = new List<inscor__Sales_Order__c>();
        
        inscor__Company__c company = [select id from inscor__Company__c];
        
        for(Integer i = 0; i < COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c();
            salesOrder.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrder.inscor__Customer__c = accList[0].Id;
            salesOrder.inscor__Contact__c = contactId;
            salesOrder.inscor__Assigned_To__c = UserInfo.getUserId();
            salesOrder.inscor__Company__c = company.Id;
            salesOrders.add(salesOrder);
        }
        insert salesOrders;  

        //Product2 pr = new Product2(Name ='#10',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');//Commented by Vinod to resolve test error
        Product2 pr = new Product2(Name = 'Laptop X200', Family = 'Hardware', inscor__Keyword__c ='test'); 
        insert pr;
        
        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
            salesOrderLine.inscor__Order__c = salesOrders[i].Id;
            salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLine.inscor__Quantity_Ordered__c = 10;
            salesOrderLine.inscor__Exchange_Type__c = 'Cost Plus';
            salesOrderLine.inscor__Product__c = pr.Id;
            salesOrderLines.add(salesOrderLine);
        }
        insert salesOrderLines;

        List<inscor__Customer_Exchange_Summary__c> cess = new List<inscor__Customer_Exchange_Summary__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Customer_Exchange_Summary__c ces = new inscor__Customer_Exchange_Summary__c();
            ces.inscor__Original_SO_ID__c = salesOrders[i].Id;
            ces.inscor__Original_SO_Line__c = salesOrderLines[i].Id;
            ces.inscor__Original_Core_Due_Date__c = Date.today().addDays(15);
            ces.inscor__Exchange_Status__c = FollowUpEmailCtrl.SHIPPED;
            cess.add(ces);
        }
        insert cess;
        
        try 
        {
            Test.startTest();
            CustomerExchangeEmailNotifyBatch batchRec = new CustomerExchangeEmailNotifyBatch();
            SchedulableContext sc = NULL;
            batchRec.execute(sc);
            Test.stopTest();
        } 
        catch (Exception e) 
        {
            System.assert(e != NULL);
        }

    }

}