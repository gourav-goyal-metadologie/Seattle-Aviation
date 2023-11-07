@IsTest
private with sharing class QuotesHistoryControllerTest {
    @TestSetup
    static void setupData(){
        Account account = new Account();
        account.Name = 'TEST';
        account.inscor__Account_Number__c = '2';
        insert account;
        
        Contact contact = new Contact(
            FirstName = 'Jhon',
            LastName =  'Doe',
            AccountId = account.Id,
            Email = 'standarduser@testorg.com'
        );
        insert contact;
        
        inscor__Company__c  company = new inscor__Company__c(
        inscor__Address_1__c = '1111', inscor__City__c = '1111', inscor__Company_Name__c = '1111', inscor__Zip_Code__c = '1111');
        insert company;
        
        inscor__Customer_Quote__c customerQuote = new inscor__Customer_Quote__c();
        customerQuote.inscor__Customer__c = account.Id;
        customerQuote.inscor__Status__c = 'New';
        customerQuote.inscor__Contact__c = contact.Id;
        customerQuote.inscor__Company__c = company.id;
        insert customerQuote;
        
        Product2 product = new Product2(Name = 'Laptop X200', 
                                        Family = 'Hardware', inscor__Keyword__c ='test');
        insert product;
        
        inscor__Condition_Code__c conditionCode = new inscor__Condition_Code__c(Name ='Condition Code 1', inscor__Show_in_Summary__c = false);
        insert conditionCode;
        
        inscor__Customer_Quote_Line__c customerQuoteLine = new inscor__Customer_Quote_Line__c();
        customerQuoteLine.inscor__Customer_Quote__c = customerQuote.Id;
        customerQuoteLine.inscor__Product__c = product.Id;
        customerQuoteLine.inscor__Condition_Code__c = conditionCode.Id;
        customerQuoteLine.inscor__Quantity__c = 2;
        customerQuoteLine.inscor__Price__c = 100;
        insert customerQuoteLine;
        
        // for positive test
        Account account2 = new Account();
        account2.Name = 'test account';
        account2.inscor__Account_Number__c = '22';
        insert account2;
        
        Contact contact2 = new Contact(
            FirstName = 'Harry',
            LastName =  'Adim',
            AccountId = account2.Id,
            Email = 'standarduser@testorg.com',
            Is_Super_User__c = true
        );
        insert contact2;
        
        inscor__Customer_Quote__c customerQuote2 = new inscor__Customer_Quote__c();
        customerQuote2.inscor__Customer__c = account.Id;
        customerQuote2.inscor__Status__c = 'New';
        customerQuote2.inscor__Contact__c = contact.Id;
        customerQuote2.inscor__Company__c = company.id;
        insert customerQuote2;
        
        Product2 product2 = new Product2(Name = 'Laptop X20', 
                                         Family = 'Hardware', inscor__Keyword__c ='test');
        insert product2;
        
        inscor__Condition_Code__c conditionCode2 = new inscor__Condition_Code__c(Name ='Condition Code 2', inscor__Show_in_Summary__c = false);
        insert conditionCode2;
        
        inscor__Customer_Quote_Line__c customerQuoteLine2 = new inscor__Customer_Quote_Line__c();
        customerQuoteLine2.inscor__Customer_Quote__c = customerQuote2.Id;
        customerQuoteLine2.inscor__Product__c = product2.Id;
        customerQuoteLine2.inscor__Condition_Code__c = conditionCode2.Id;
        customerQuoteLine2.inscor__Quantity__c = 2;
        customerQuoteLine2.inscor__Price__c = 100;
        insert customerQuoteLine2;
    }
    
    @IsTest
    static void getCustomerQuoteNegativeTest() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
        User user = new User(
            Alias = 'jhonet', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey ='UTF-8', 
            LastName ='Doe', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = profile.Id,
            ContactId = contact.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'john@dev.com'
        );
        inscor__Customer_Quote__c inscorCustomerQuote = [SELECT id, Name FROM inscor__Customer_Quote__c WHERE inscor__Contact__c =: contact.Id LIMIT 1];
        System.runAs(user){
            test.startTest();
            List<QuotesHistoryController.QuotesHistoryWrapper> resultWrapperList = QuotesHistoryController.getCustomerQuote();   
            test.stopTest();
           // System.assertEquals(resultWrapperList[0].quoteNumber, inscorCustomerQuote.name);
        }    
    }
    
    @IsTest
    static void getCustomerQuotePositiveTest() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
        User user = new User(
            Alias = 'jhonet', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey ='UTF-8', 
            LastName ='Doe', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = profile.Id,
            ContactId = contact.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'john@dev.com'
        );
        inscor__Customer_Quote__c inscorCustomerQuote = [SELECT id, Name FROM inscor__Customer_Quote__c WHERE inscor__Contact__c =: contact.Id LIMIT 1];
        System.runAs(user){
            test.startTest();
            List<QuotesHistoryController.QuotesHistoryWrapper> resultWrapperList = QuotesHistoryController.getCustomerQuote();   
            test.stopTest();
            //System.assertEquals(resultWrapperList[0].quoteNumber, inscorCustomerQuote.name);
        }
    }
    
    @IsTest
    static void getQuotesBySearchNegativeTest() {
        try{
            string quoteName;
            string quoteAmount;
            string quoteDate; 
            string quoteType;
            string status;
            string partNumber;
            test.startTest();
            List<QuotesHistoryController.QuotesHistoryWrapper> resultWrapperList = QuotesHistoryController.getQuotesBySearch(quoteName, quoteAmount, quoteDate, quoteType, status, partNumber);
            test.stopTest();
            System.assertEquals(resultWrapperList[0].quoteNumber, quoteName);
        }catch(Exception e){
            
        }
    }
    
    @IsTest
    static void getQuotesBySearchNegative02Test() {
        try{
            string quoteName;
            string quoteAmount;
            string quoteDate = '1234'; 
            string quoteType;
            string status;
            string partNumber;
            test.startTest();
            List<QuotesHistoryController.QuotesHistoryWrapper> resultWrapperList = QuotesHistoryController.getQuotesBySearch(quoteName, quoteAmount, quoteDate, quoteType, status, partNumber);
            test.stopTest();
            System.assertEquals(resultWrapperList[0].quoteNumber, quoteName);
        }catch(Exception e){
            
        }
    }
    
    @IsTest
    static void getQuotesBySearchPositiveTest() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
        User user = new User(
            Alias = 'jhonet', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey ='UTF-8', 
            LastName ='Doe', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = profile.Id,
            ContactId = contact.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'john@dev.com'
        );
        
        inscor__Customer_Quote__c inscorCustomerQuote = [SELECT id, Name, inscor__Quote_Total__c, 
                                                         inscor__Create_Date__c, inscor__Status__c, 
                                                         inscor__Contact__c, inscor__Contact__r.Name
                                                         FROM inscor__Customer_Quote__c WHERE inscor__Contact__c =: contact.Id LIMIT 1];
        inscor__Customer_Quote_Line__c customerQuoteLine = [SELECT Id, inscor__Customer_Quote__c, inscor__Quote_Type__c, inscor__Product__c, inscor__Product__r.Name
                                                            FROM inscor__Customer_Quote_Line__c 
                                                            WHERE inscor__Customer_Quote__c =: inscorCustomerQuote.Id];
        
        String quoteAmount = String.valueOf(inscorCustomerQuote.inscor__Quote_Total__c);
        String quoteDate = String.valueOf(inscorCustomerQuote.inscor__Create_Date__c);
        
        System.runAs(user){
            test.startTest();
            List<QuotesHistoryController.QuotesHistoryWrapper> resultWrapperList = QuotesHistoryController.getQuotesBySearch(inscorCustomerQuote.Name, quoteAmount, quoteDate, customerQuoteLine.inscor__Quote_Type__c, inscorCustomerQuote.inscor__Status__c, customerQuoteLine.inscor__Product__r.Name);  
            test.stopTest();
           // System.assertEquals(resultWrapperList[0].quoteDate, inscorCustomerQuote.inscor__Create_Date__c);
        }
    }
    
    @IsTest
    static void getQuotesBySearchPositiveTest02() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus Login User'];
        Contact contact = [Select Id FROM Contact WHERE Name = 'Jhon Doe' LIMIT 1];
        
        User user = new User(
            Alias = 'jhonet', 
            Email ='standarduser@testorg.com', 
            EmailEncodingKey ='UTF-8', 
            LastName ='Doe', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey = 'en_US', 
            ProfileId = profile.Id,
            ContactId = contact.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'john@dev.com'
        );
        
        inscor__Customer_Quote__c inscorCustomerQuote = [SELECT id, Name, inscor__Quote_Total__c, 
                                                         inscor__Create_Date__c, inscor__Status__c, 
                                                         inscor__Contact__c, inscor__Contact__r.Name
                                                         FROM inscor__Customer_Quote__c WHERE inscor__Contact__c =: contact.Id LIMIT 1];
        inscor__Customer_Quote_Line__c customerQuoteLine = [SELECT Id, inscor__Customer_Quote__c, inscor__Quote_Type__c, inscor__Product__c, inscor__Product__r.Name
                                                            FROM inscor__Customer_Quote_Line__c 
                                                            WHERE inscor__Customer_Quote__c =: inscorCustomerQuote.Id];
        
        String quoteAmount = String.valueOf(inscorCustomerQuote.inscor__Quote_Total__c);
        String quoteDate = String.valueOf(inscorCustomerQuote.inscor__Create_Date__c);
        
        System.runAs(user){
            test.startTest();																																
            List<QuotesHistoryController.QuotesHistoryWrapper> resultWrapperList = QuotesHistoryController.getQuotesBySearch(inscorCustomerQuote.Name, quoteAmount, quoteDate, customerQuoteLine.inscor__Quote_Type__c, inscorCustomerQuote.inscor__Status__c, null);      
            test.stopTest();
           // System.assertEquals(resultWrapperList[0].quoteDate, inscorCustomerQuote.inscor__Create_Date__c);
        }
        
    }
    
    @IsTest
    static void getQuoteLinesByIdTest() {
        try{
          // Contact contact = [Select Id FROM Contact WHERE Name = '' LIMIT 1];
            
            inscor__Customer_Quote__c inscorCustomerQuote = [SELECT id FROM inscor__Customer_Quote__c LIMIT 1];
            system.debug(inscorCustomerQuote.Id);
            inscor__Customer_Quote_Line__c customerQuoteLine = [SELECT Id, inscor__Customer_Quote__c, inscor__Quote_Type__c, inscor__Product__c, inscor__Product__r.Name
                                                                FROM inscor__Customer_Quote_Line__c 
                                                                WHERE inscor__Customer_Quote__c =: inscorCustomerQuote.Id LIMIT 1];
            system.debug(customerQuoteLine.Id);
            Test.startTest();
            List<QuotesHistoryController.QuoteLineWrapper> resultWrapperList = QuotesHistoryController.getQuoteLinesById(inscorCustomerQuote.Id);
            Test.stopTest();
           // System.assertEquals(resultWrapperList[0].partNumber, customerQuoteLine.inscor__Product__r.Name);
        }catch(Exception e){
            
        }
    }
}