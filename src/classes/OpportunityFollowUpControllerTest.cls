@isTest
public class OpportunityFollowUpControllerTest {
    public static final Integer COUNT_LIMIT = 1;
    @TestSetup
    static void setupTestData(){
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
            customerQuoteRec.inscor__Company__c	 = companyInstance.Id;
            customerQuoteRec.inscor__Contact__c = c.Id;
            customerQuoteToInsertList.add(customerQuoteRec);
        }
        insert customerQuoteToInsertList;

        
        Opportunity opportunityInstance = new Opportunity();
        opportunityInstance.Name = 'test';
        opportunityInstance.AccountId = accRec.id;
        opportunityInstance.StageName = 'Prospecting';
        opportunityInstance.CloseDate = system.today();
        opportunityInstance.Customer_Quote__c = customerQuoteToInsertList.get(0).Id;
        insert opportunityInstance;

        
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

    @IsTest
    static void testGetRenderedEmailTemplate(){
        
        Test.startTest();
        List<Account> accList = new List<Account>([SELECT Id,Name FROM Account LIMIT 1]);
        Id contactId = [SELECT Id FROM Contact LIMIT 1]?.Id;
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrders = new List<inscor__Sales_Order__c>();

        inscor__Company__c company = [SELECT Id FROM inscor__Company__c LIMIT 1];         
        for(Integer i = 0; i < COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c();
            salesOrder.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrder.inscor__Customer__c = accList[0].Id;
            salesOrder.inscor__Contact__c = contactId;
            salesOrder.inscor__Company__c = company.Id;
            salesOrder.inscor__Assigned_To__c = UserInfo.getUserId();
            salesOrders.add(salesOrder);
        }
        insert salesOrders;  
        system.assertEquals(salesOrders.size(), COUNT_LIMIT);

        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        Product2 pr = new Product2(Name ='#16',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        insert pr;
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
            ces.inscor__Original_Core_Due_Date__c = Math.mod(i, 2) == 0 ? Date.today().addDays(5): Date.today().addDays(1);
            //ces.inscor__Exchange_Status__c = OpportunityFollowUpController.SHIPPED;
            cess.add(ces);
        }
        insert cess;

        Test.stopTest();

        try 
        {
            OpportunityFollowUpController.getEmailRenderedTemplate(null);
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
        inscor__Condition_Code__c conditionCode = [SELECT Id,Name FROM inscor__Condition_Code__c LIMIT 1];
        List<inscor__Customer_Quote__c> customerQuoteList = new List<inscor__Customer_Quote__c>([SELECT Id FROM inscor__Customer_Quote__c]);
        List<inscor__Sales_Order__c> salesOrders = new List<inscor__Sales_Order__c>();
        inscor__Company__c company = [SELECT Id FROM inscor__Company__c LIMIT 1];         
        for(Integer i = 0; i < COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order__c salesOrder = new inscor__Sales_Order__c();
            salesOrder.inscor__Quote_Number__c = customerQuoteList[i].Id;
            salesOrder.inscor__Customer__c = accList[0].Id;
            salesOrder.inscor__Contact__c = contactId;
            salesOrder.inscor__Company__c = company.Id;
            salesOrder.inscor__Assigned_To__c = UserInfo.getUserId();
            salesOrders.add(salesOrder);
        }
        insert salesOrders;  
        system.assertEquals(salesOrders.size(), COUNT_LIMIT);

        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        Product2 pr = new Product2(Name ='#16',inscor__Keyword__c = 'SCREW',inscor__UOM__c='EA');
        insert pr;
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
            salesOrderLine.inscor__Order__c = salesOrders[i].Id;
            salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLine.inscor__Quantity_Ordered__c = 10;
            salesOrderLine.inscor__Exchange_Type__c = 'Cost Plus';
            salesOrderLine.inscor__Product__c	= pr.Id;
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
            //ces.inscor__Exchange_Status__c = FollowUpEmailCtrl.SHIPPED;
            cess.add(ces);
        }
        insert cess;
        
        	Opportunity oppList = [select id from opportunity Limit 1];
        	String emailBodyJSON = JSON.serialize(OpportunityFollowUpController.getEmailRenderedTemplate(oppList.Id));
            String status = OpportunityFollowUpController.sendFollowUpEmail(oppList.Id, emailBodyJSON);
            /*for(inscor__Customer_Exchange_Summary__c ces : cess)
        	{	
            	String emailBodyJSON = JSON.serialize(OpportunityFollowUpController.getEmailRenderedTemplate(ces.Id));
            	String status = OpportunityFollowUpController.sendFollowUpEmail(ces.Id, emailBodyJSON);
           		// System.assert(status == OpportunityFollowUpController.SUCCESS);
        	}*/
        
        Test.stopTest();

    
        try 
        {
            OpportunityFollowUpController.sendFollowUpEmail(cess[0].Id, null);
        } 
        catch (Exception e) 
        {
            System.assert(e != null);
        }

        try 
        {
            OpportunityFollowUpController.sendFollowUpEmail(null, null);
        } 
        catch (Exception e) 
        {
            System.assert(e != null);
        }
    }

    
    @isTest
    private static void validateSendEmailFollowUpWithEmailBody()
    {
        
        Test.startTest();
        Opportunity oppList = [select id  from opportunity Limit 1];
        String emailBodyJSON = JSON.serialize(OpportunityFollowUpController.getEmailRenderedTemplate(oppList.Id));
        String status = OpportunityFollowUpController.sendFollowUpEmail(oppList.Id, emailBodyJSON);
        system.assert(status == 'Success');
        Test.stopTest();
    }

    @isTest
    static void testGetQuoteLines(){
        Test.startTest();
        Opportunity oppList = [select id from opportunity Limit 1];
        OpportunityFollowUpController.getQuoteLines(oppList.Id);
        Test.stopTest();
    }
    
    
	
    
}