@isTest
private class TransactionActivityTriggerHelperTest {
	
    @testSetup()
    private static void setup(){
		Account acc = new Account();
        acc.Name ='Test Account';
        insert acc;
        
        Contact con = new Contact();
        con.FirstName ='Test';
        con.LastName ='Contact';
        con.AccountId = acc.Id;
        con.Email ='test@etst.com';
        insert con;
        
        YayPay_Configuration__c yayPayConfigSetting = YayPay_Configuration__c.getOrgDefaults();   
        yayPayConfigSetting.EndPoint__c = 'https://developer.yaypay.com/api/v1/token';
        yayPayConfigSetting.Transaction_End_Time__c = 10;
        yayPayConfigSetting.Records_To_Query_Batch__c = '10';
        yayPayConfigSetting.Batch_Interval_Minutes__c = 10;
        yayPayConfigSetting.Client_Key__c = '45q70fmc8n1agi258vhnaoh99e';
        yayPayConfigSetting.Client_Secret__c = '1mqaafklenu997svqlcv8j7u5cifhchdbifd4fdopc759lejmj0';
        upsert yayPayConfigSetting;
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
        Test.stopTest();
    } 
    
    
    @isTest
    static void batchWithoutParamTest() {
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
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
        
        inv.inscor__Status__c ='Paid';
        update inv;
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        payment.inscor__Line_Value__c = 300;
        update payment;
       
        Test.stopTest();
    }    
}