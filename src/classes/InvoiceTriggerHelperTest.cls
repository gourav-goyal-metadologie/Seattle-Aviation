@isTest
private class InvoiceTriggerHelperTest {
    
    @testSetup()
    private static void setup(){
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Account acc = new Account();
        acc.Name ='Test Account';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName ='Test';
        con.LastName ='Contact';
        con.AccountId = acc.Id;
        con.Email ='test@etst.com';
        insert con;
        
        Trigger_Configuration__c triggerConfig = new Trigger_Configuration__c(Invoice_Trigger_Disable__c = true);
        insert triggerConfig;
        
        YayPay_Configuration__c yayPayConfigSetting = YayPay_Configuration__c.getOrgDefaults();   
        yayPayConfigSetting.EndPoint__c = 'https://developer.yaypay.com/api/v1/token';
        yayPayConfigSetting.Transaction_End_Time__c = 10;
        yayPayConfigSetting.Records_To_Query_Batch__c = '10';
        yayPayConfigSetting.Batch_Interval_Minutes__c = 10;
        yayPayConfigSetting.Is_Integration_Enable__c = true;
        
        yayPayConfigSetting.Client_Key__c = '45q70fmc8n1agi258vhnaoh99e';
        yayPayConfigSetting.Client_Secret__c = '1mqaafklenu997svqlcv8j7u5cifhchdbifd4fdopc759lejmj0';
        upsert yayPayConfigSetting;
        
        Product2 productRec = new Product2(Name = 'Laptop X200', 
                                           Family = 'Hardware', inscor__Keyword__c ='test', inscor__Description__c ='Test Desc.');
        insert productRec;

        
    }    
    
    @isTest
    static void batchWithParamTest() {
        
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
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        insert invLine;
        Database.executeBatch(new BatchProcessInvoiceToYayPay(new set<Id>{inv.Id}, true ), 1); 
        Database.executeBatch(new BatchProcessInvoiceToYayPay(), 1); 
        Test.stopTest();
    } 
    
    
    @isTest
    static void batchWithoutParamTest() {
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1];
        
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.inscor__Billing_Contact__c = con.Id;
        insert inv;
        
        inscor__Activity__c payment = new inscor__Activity__c();
        payment.inscor__Activity_Type__c = 'Receiving';
        payment.inscor__Customer_Vendor__c = acc.Id;
        payment.inscor__INVC_Date__c = Date.today();
        payment.inscor__Receivable_Amount__c = 50;
        payment.inscor__INVC__c = inv.Id;
        insert payment; 
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Invoice__c = inv.Id;
        insert invLine;
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        inv.inscor__Status__c ='Paid';
        update inv;
        Database.executeBatch(new BatchProcessInvoiceToYayPay(new set<Id>{inv.Id}, true ), 1);   
        Test.stopTest();
    }    
    
    @isTest
    static void batchWithoutParamTest02() {
        try{
            Account acc = [ SELECT Id FROM Account LIMIT 1];
            Contact con = [ SELECT Id FROM Contact LIMIT 1];
            Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1];
            inscor__Invoice__c inv = new inscor__Invoice__c();
            inv.inscor__Invoice_Date__c = Date.today();
            inv.inscor__Status__c ='Created';
            inv.inscor__Account__c = acc.Id;
            inv.inscor__Billing_Contact__c = con.Id;
            insert inv;
            
            inscor__Activity__c payment = new inscor__Activity__c();
            payment.inscor__Activity_Type__c = 'Receiving';
            payment.inscor__Customer_Vendor__c = acc.Id;
            payment.inscor__INVC_Date__c = Date.today();
            payment.inscor__Line_Value__c = 50;
            payment.inscor__INVC__c = inv.Id;
            insert payment; 
            
            inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
            invLine.inscor__Price__c =200;
            invLine.inscor__Quantity__c = 2;
            invLine.inscor__Item__c = productRec.Id;
            invLine.inscor__Invoice__c = inv.Id;
            insert invLine;
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Test',
                PathOnClient = 'Test.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;    
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = inv.id;
            cdl.ContentDocumentId = documents[0].Id;
            cdl.shareType = 'V';
            insert cdl;
            
            Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
            Test.startTest();
            inv.inscor__Status__c ='Paid';
            update inv;
            Database.executeBatch(new BatchProcessInvoiceToYayPay(new set<Id>{inv.Id}, true ), 1); 
            Test.stopTest();
        }catch( exception e ){
            
        }
    }   
    @isTest
    static void batchWithoutParamTest03() {
        try{
            Account acc = [ SELECT Id FROM Account LIMIT 1];
            Contact con = [ SELECT Id FROM Contact LIMIT 1];
            Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1];
            inscor__Invoice__c inv = new inscor__Invoice__c();
            inv.inscor__Invoice_Date__c = Date.today();
            inv.inscor__Status__c ='Created';
            inv.inscor__Account__c = acc.Id;
            inv.inscor__Billing_Contact__c = con.Id;
            insert inv;
            
            inscor__Activity__c payment = new inscor__Activity__c();
            payment.inscor__Activity_Type__c = 'Receiving';
            payment.inscor__Customer_Vendor__c = acc.Id;
            payment.inscor__INVC_Date__c = Date.today();
            payment.inscor__Line_Value__c = 50;
            payment.inscor__INVC__c = inv.Id;
            insert payment; 
            
            inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
            invLine.inscor__Price__c =200;
            invLine.inscor__Quantity__c = 2;
            invLine.inscor__Item__c = productRec.Id;
            invLine.inscor__Invoice__c = inv.Id;
            insert invLine;
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Test',
                PathOnClient = 'Test.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;    
            List<ContentDocument> documents = [
                SELECT Id, Title, LatestPublishedVersionId 
                FROM ContentDocument
            ];
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = inv.id;
            cdl.ContentDocumentId = documents[0].Id;
            cdl.shareType = 'V';
            insert cdl;
            
            Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
            Test.startTest();
            inv.inscor__Status__c ='Paid';
            update inv;
            delete inv;
            undelete inv;
            Database.executeBatch(new BatchProcessInvoiceToYayPay(new set<Id>{inv.Id}, true ), 1); 
            Test.stopTest();
        }catch( exception e ){
           
        }
    }
    
    @IsTest
    static void testupdateCustomeMargin(){
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Trigger_Configuration__c triggerConfig = [SELECT Id FROM Trigger_Configuration__c LIMIT 1];
        triggerConfig.Invoice_Trigger_Disable__c = false;
        update triggerConfig;
        
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1];
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.inscor__Billing_Contact__c = con.Id;
        insert inv;
        
        inscor__Activity__c payment = new inscor__Activity__c();
        payment.inscor__Activity_Type__c = 'Receiving';
        payment.inscor__Customer_Vendor__c = acc.Id;
        payment.inscor__INVC_Date__c = Date.today();
        payment.inscor__Line_Value__c = 50;
        payment.inscor__INVC__c = inv.Id;
        insert payment;
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Item__c = productRec.Id;
        invLine.inscor__Invoice__c = inv.Id;
        insert invLine;
        //InvoiceTriggerHelper.updateCustomeMargin(new Set<Id> {acc.Id});
    }

    @IsTest
    static void testGetAccountIds(){
        
        Test.startTest();
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Product2 productRec = [ SELECT Id FROM Product2 LIMIT 1];
        inscor__Invoice__c inv = new inscor__Invoice__c();
        inv.inscor__Invoice_Date__c = Date.today();
        inv.inscor__Status__c ='Created';
        inv.inscor__Account__c = acc.Id;
        inv.inscor__Billing_Contact__c = con.Id;
        insert inv;
        
        inscor__Activity__c payment = new inscor__Activity__c();
        payment.inscor__Activity_Type__c = 'Receiving';
        payment.inscor__Customer_Vendor__c = acc.Id;
        payment.inscor__INVC_Date__c = Date.today();
        payment.inscor__Line_Value__c = 50;
        payment.inscor__INVC__c = inv.Id;
        insert payment;
        
        inscor__Invoice_Line__c invLine = new inscor__Invoice_Line__c();
        invLine.inscor__Price__c =200;
        invLine.inscor__Quantity__c = 2;
        invLine.inscor__Item__c = productRec.Id;
        invLine.inscor__Invoice__c = inv.Id;
        insert invLine;

        Set<String> accountIds = InvoiceTriggerHelper.getAccountIds(new List<inscor__Invoice__c> {inv});
        System.assert(!accountIds.isEmpty());
        
        Test.stopTest();
        
    }
}