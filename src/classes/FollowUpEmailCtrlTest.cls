/**************************************************************************************************
Description: Test class for Controller class for FollowUpEmail LWCs
====================================================================================================
====================================================================================================
TestClass: 
Code Coverage: 
====================================================================================================
====================================================================================================
History
<Version>   	<Date>             <Author Name>                <Brief description of change > 
1.0 -      		08/28/2021		    Nikhil Kumar Srivastava		 Initial Creation    
***************************************************************************************************/
@IsTest
public with sharing class FollowUpEmailCtrlTest 
{
    public static final Integer COUNT_LIMIT = 5;
    public static List<Integer> daysDifference = new List<Integer>{1,2,3};

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

        List<inscor__Customer_Quote__c> customerQuoteToInsertList = new List<inscor__Customer_Quote__c>();
        List<inscor__Customer_Quote_Line__c> customerQuoteLineToInsertList = new List<inscor__Customer_Quote_Line__c>();
        
        inscor__Company__c companyInstance = new inscor__Company__c();
        companyInstance.inscor__Company_Name__c = 'inscor Company' ;
        companyInstance.inscor__Address_1__c = 'address';
        companyInstance.inscor__City__c = 'xyz';
        companyInstance.inscor__Zip_Code__c = '21321';
        insert companyInstance;
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Customer_Quote__c customerQuoteRec = new inscor__Customer_Quote__c();
            customerQuoteRec.inscor__Customer__c = accRec.Id;
            customerQuoteRec.inscor__Status__c = 'New';
            customerQuoteRec.inscor__Company__c = companyInstance.id;
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
        
        List<inscor__Sales_Order__c> salesOrders = new List<inscor__Sales_Order__c>();
        
        for(Integer i = 0; i < COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c();
            salesOrder.inscor__Quote_Number__c = customerQuoteToInsertList[i].Id;
            salesOrder.inscor__Customer__c = accRec.Id;
            salesOrder.inscor__Contact__c = c.Id;
            salesOrder.inscor__Company__c = companyInstance.Id;
            salesOrder.inscor__Assigned_To__c = UserInfo.getUserId();
            salesOrders.add(salesOrder);
        }
        insert salesOrders;  
        
        Product2 product = new Product2(name = '12345', inscor__Keyword__c = 'test', inscor__Description__c = 'Test Description');
        insert product;

        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
            salesOrderLine.inscor__Order__c = salesOrders[i].Id;
            salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLine.inscor__Quantity_Ordered__c = 10;
            salesOrderLine.inscor__Exchange_Type__c = 'Cost Plus';
			salesOrderLine.inscor__Product__c = product.Id;          
            salesOrderLines.add(salesOrderLine);
        }
        insert salesOrderLines;

        List<inscor__Customer_Exchange_Summary__c> cess = new List<inscor__Customer_Exchange_Summary__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Customer_Exchange_Summary__c ces = new inscor__Customer_Exchange_Summary__c();
            ces.inscor__Original_SO_ID__c = salesOrders[i].Id;
            ces.inscor__Original_SO_Line__c = salesOrderLines[i].Id;
            ces.inscor__Original_Core_Due_Date__c = Math.mod(i, 2) == 0 ? Date.today().addDays(5): Date.today().addDays(1);
            ces.inscor__Exchange_Status__c = Math.mod(i, 2) == 0 ? Constants.CUSTOMER_EXCHANGE_SUMMARY_EXCHANGE_STATUS_SHIPPED : Constants.CUSTOMER_EXCHANGE_SUMMARY_EXCHANGE_STATUS_CORE_RECEIVED;
            if (i == 4) {
                ces.inscor__Original_Core_Due_Date__c = null;
            }
            ces.inscor__Original_Product__c = product.Id;
            cess.add(ces);
        }
        insert cess;
    }  
    
    @isTest
    public static void validateGetEmailRenderedTemplate()
    {
        List<inscor__Customer_Exchange_Summary__c> cess = [SELECT Id, inscor__Original_Core_Due_Date__c FROM inscor__Customer_Exchange_Summary__c LIMIT 2];
        Test.startTest();
        for(inscor__Customer_Exchange_Summary__c ces : cess)
        {
            if(ces.inscor__Original_Core_Due_Date__c != null && ces.inscor__Original_Core_Due_Date__c == Date.today().addDays(5))
            {
                System.assert(true, FollowUpEmailCtrl.checkDueDateForNext5Day(ces.Id));
            }
            else if(ces.inscor__Original_Core_Due_Date__c != null && ces.inscor__Original_Core_Due_Date__c == Date.today().addDays(1))
            {
                System.assert(true, FollowUpEmailCtrl.checkDueDateForNext1Day(ces.Id));
            }
            List<EmailBody> emailBodyList = new List<EmailBody>();
            for (Integer day : daysDifference) {
                emailBodyList.add(FollowUpEmailCtrl.getEmailRenderedTemplate(ces.Id, day));
            }
            System.assert(emailBodyList.size() > 0);
        }
        Test.stopTest();

        try 
        {
            FollowUpEmailCtrl.getEmailRenderedTemplate(null, null);
        } 
        catch (Exception e) 
        {
            System.assert(e != null);
        }
    }

    @isTest
    public static void validateSendFollowUpEmail()
    {
        Test.startTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        Id contactId = [SELECT Id FROM Contact LIMIT 1]?.Id;
        
        List<inscor__Customer_Exchange_Summary__c> cess = [SELECT Id 
                                                            FROM inscor__Customer_Exchange_Summary__c 
                                                            WHERE inscor__Original_Core_Due_Date__c != null AND inscor__Exchange_Status__c = :Constants.CUSTOMER_EXCHANGE_SUMMARY_EXCHANGE_STATUS_SHIPPED];
        for(inscor__Customer_Exchange_Summary__c ces : cess)
        {   
            String emailBodyJSON = JSON.serialize(FollowUpEmailCtrl.getEmailRenderedTemplate(ces.Id, 1));
            String status = FollowUpEmailCtrl.sendFollowUpEmail(ces.Id, emailBodyJSON);
            System.assert(status == FollowUpEmailCtrl.SUCCESS);
            
            emailBodyJSON = JSON.serialize(FollowUpEmailCtrl.getEmailRenderedTemplate(ces.Id, 2));
            status = FollowUpEmailCtrl.sendFollowUpEmail(ces.Id, emailBodyJSON); 
            System.assert(status == FollowUpEmailCtrl.SUCCESS);
        }
        Test.stopTest();
        try 
        {   
            inscor__Customer_Exchange_Summary__c exchangeSummary = cess[0];
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(-5);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);

            String emailBodyJSON = JSON.serialize(FollowUpEmailCtrl.getEmailRenderedTemplate(cess[0].Id, 1));
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(5);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);
            String status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(5);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);
            status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(3);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);
            status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(2);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);
            status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(1);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);
            status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(0);
            update exchangeSummary;
            status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            exchangeSummary.inscor__Original_Core_Due_Date__c = System.today().addDays(-3);
            update exchangeSummary;
            FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id);
            status = FollowUpEmailCtrl.sendFollowUpEmail(exchangeSummary.Id, emailBodyJSON);
            
            System.assert(status == FollowUpEmailCtrl.SUCCESS);
            FollowUpEmailCtrl.sendFollowUpEmail(cess[0].Id, null);
        } 
        catch (Exception e) 
        {
            System.assert(e != null);
        }

        try 
        {
            FollowUpEmailCtrl.sendFollowUpEmail(null, null);
        } 
        catch (Exception e) 
        {
            System.assert(e != null);
        }
    }
    
    @isTest
    public static void testGetFollowUpWrapper(){
        Test.startTest();
        List<inscor__Customer_Exchange_Summary__c> cess = [SELECT Id FROM inscor__Customer_Exchange_Summary__c];
        for(inscor__Customer_Exchange_Summary__c ces : cess)
        {
            FollowUpEmailCtrl.FollowUpWrapper wrapper = FollowUpEmailCtrl.getFollowUpWrapper(ces.Id);
        }
        inscor__Customer_Exchange_Summary__c exchangeSummary = cess[0];
        exchangeSummary.inscor__Exchange_Status__c = Constants.CUSTOMER_EXCHANGE_SUMMARY_EXCHANGE_STATUS_CORE_RECEIVED;
        update exchangeSummary;
        FollowUpEmailCtrl.FollowUpWrapper wrapper = FollowUpEmailCtrl.getFollowUpWrapper(exchangeSummary.Id); 
        
        wrapper = FollowUpEmailCtrl.getFollowUpWrapper('');
        System.assert(!wrapper.isValid);
        Test.stopTest();
    }
}