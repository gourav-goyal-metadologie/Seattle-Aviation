@isTest
private class BatchProcessCustomerToYayPayTest {
	
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
        
        YayPay_Configuration__c yayPayConfigSetting = YayPay_Configuration__c.getOrgDefaults();   
        yayPayConfigSetting.EndPoint__c = 'https://developer.yaypay.com/api/v1/token';
        yayPayConfigSetting.Transaction_End_Time__c = 10;
        yayPayConfigSetting.Client_Key__c = '45q70fmc8n1agi258vhnaoh99e';
        yayPayConfigSetting.Client_Secret__c = '1mqaafklenu997svqlcv8j7u5cifhchdbifd4fdopc759lejmj0';
        upsert yayPayConfigSetting;
        
    }    
    
    @isTest
    static void batchWithoutParamTest() {
       
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
       
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        BatchProcessCustomerToYayPay  batchObj = new BatchProcessCustomerToYayPay();
        Database.executeBatch( batchObj );
        Test.stopTest();
    } 
    
    @isTest
    static void batchWithParamTest() {
        
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Contact con = [ SELECT Id FROM Contact LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new YayPayMockResponseGenerator());
        Test.startTest();
        BatchProcessCustomerToYayPay  batchObj = new BatchProcessCustomerToYayPay(  new set<Id>{ acc.Id });
        Database.executeBatch( batchObj );
        Test.stopTest();
    } 
}