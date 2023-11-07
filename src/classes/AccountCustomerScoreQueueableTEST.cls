@IsTest
public class AccountCustomerScoreQueueableTEST {

    public static final Integer COUNT_LIMIT = 2;
    @TestSetup
    static void setupTestData(){
        Account accRec = new Account();
        accRec.Name = 'TEST';
        accRec.inscor__Account_Number__c = '2';  
        insert accRec;

        Contact contact = new Contact(Phone='test', AccountId=accRec.Id, LastName='last name', Email='abc@yopmail.com');
        insert contact;
            

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

    @IsTest
    static void testCustomerScoreForInvoice(){
        
        Test.startTest();
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.inscor__Billing_Contact__c = con.Id;
        insert inv;
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Invoice__c = inv.Id;
        
        insert invLine;
        Set<String> accountIds = new Set<String>();
        accountIds.add(acc.Id);
        System.enqueueJob(new AccountCustomerScoreQueueable(accountIds, 'invoice'));
        Test.stopTest();   
    }

    @IsTest
    static void testCustomerScoreForCustomerQuote(){
        
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

        Set<String> accountIds = new Set<String>();
        accountIds.add(accList.get(0).Id);
        System.enqueueJob(new AccountCustomerScoreQueueable(accountIds, 'customer quote'));
        Test.stopTest();
        
    }

    @IsTest
    static void testCustomerScoreForSalesOrder(){
        
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

        Set<String> accountIds = new Set<String>();
        accountIds.add(accList.get(0).Id);
        System.enqueueJob(new AccountCustomerScoreQueueable(accountIds, 'sales order'));
        Test.stopTest();
    }
}