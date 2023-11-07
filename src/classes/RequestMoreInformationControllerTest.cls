@isTest
public class RequestMoreInformationControllerTest {
    public static final Integer COUNT_LIMIT = 1;
    
    @testSetup()
    private static void setup() 
    { 
        
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

    @isTest 
    private static void validateGetCoreExchangeRecord()
    {
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        
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

        
        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        Product2 pro = [select id from Product2];
       
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
            salesOrderLine.inscor__Order__c = salesOrders[i].Id;
            salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLine.inscor__Quantity_Ordered__c = 10;
            salesOrderLine.inscor__Exchange_Type__c = 'Cost Plus';
            salesOrderLine.inscor__Product__c = pro.Id;
            salesOrderLines.add(salesOrderLine);
        }
        insert salesOrderLines;
        

        List<inscor__Customer_Exchange_Summary__c> cess = new List<inscor__Customer_Exchange_Summary__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Customer_Exchange_Summary__c ces = new inscor__Customer_Exchange_Summary__c();
            ces.inscor__Original_SO_ID__c = salesOrders[i].Id;
            ces.inscor__Original_SO_Line__c = salesOrderLines[i].Id;
            ces.inscor__Original_Core_Due_Date__c = Math.mod(i, 2) == 0 ? Date.today().addDays(5): Date.today().addDays(0);
            ces.inscor__Exchange_Status__c = FollowUpEmailCtrl.SHIPPED;
            cess.add(ces);
        }
        insert cess;
        
        Boolean isFormResponseAvailable = RequestMoreInformationController.isCustomerExchangeFormResponseAvailable(cess[0].Id);
        System.assert(!isFormResponseAvailable);

        Customer_Exchange_Summary_Form_Response__c exchangeSummaryInstance = new Customer_Exchange_Summary_Form_Response__c();
        exchangeSummaryInstance.Name__c = 'er';
        exchangeSummaryInstance.Locked__c = true;
        exchangeSummaryInstance.Customer_Exchange_Summary__c = cess[0].Id;
        insert exchangeSummaryInstance;
        
        Test.startTest();
        isFormResponseAvailable = RequestMoreInformationController.isCustomerExchangeFormResponseAvailable(cess[0].Id);
        System.assert(isFormResponseAvailable);
        
        RequestMoreInformationController.saveRequestMoreInformationMessage(cess[0].id,'df');
        Test.stopTest();
    }
    
    @isTest
    static void testGetCustomerSummary(){
        
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

        
        List<inscor__Sales_Order_Line__c> salesOrderLines = new List<inscor__Sales_Order_Line__c>();
        Product2 pro = [select id from Product2];
       
        
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Sales_Order_Line__c salesOrderLine = new inscor__Sales_Order_Line__c();
            salesOrderLine.inscor__Order__c = salesOrders[i].Id;
            salesOrderLine.inscor__Condition_Code__c = conditionCode.Id;
            salesOrderLine.inscor__Quantity_Ordered__c = 10;
            salesOrderLine.inscor__Exchange_Type__c = 'Cost Plus';
            salesOrderLine.inscor__Product__c = pro.Id;
            salesOrderLines.add(salesOrderLine);
        }
        insert salesOrderLines;
        

        List<inscor__Customer_Exchange_Summary__c> cess = new List<inscor__Customer_Exchange_Summary__c>();
        for(Integer i = 0; i< COUNT_LIMIT; i++) 
        {
            inscor__Customer_Exchange_Summary__c ces = new inscor__Customer_Exchange_Summary__c();
            ces.inscor__Original_SO_ID__c = salesOrders[i].Id;
            ces.inscor__Original_SO_Line__c = salesOrderLines[i].Id;
            ces.inscor__Original_Core_Due_Date__c = Math.mod(i, 2) == 0 ? Date.today().addDays(5): Date.today().addDays(0);
            ces.inscor__Exchange_Status__c = FollowUpEmailCtrl.SHIPPED;
            cess.add(ces);
        }
        insert cess;

        Customer_Exchange_Summary_Form_Response__c exchangeSummaryInstance = new Customer_Exchange_Summary_Form_Response__c();
        exchangeSummaryInstance.Name__c = 'er';
        exchangeSummaryInstance.Locked__c = True;
        exchangeSummaryInstance.Customer_Exchange_Summary__c = cess[0].Id;
        insert exchangeSummaryInstance;
        
		RequestMoreInformationController.getCustomerSummary(cess[0].Id);
    }
}